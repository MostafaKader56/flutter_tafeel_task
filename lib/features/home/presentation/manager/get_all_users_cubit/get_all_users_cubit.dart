import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error_handle/app_exception.dart';
import '../../../../../core/repo/users_repo/users_repo.dart';
import '../../../../../core/utils/git_it.dart';
import '../../../data/model/user.dart';

part 'get_all_users_state.dart';

class GetAllUsersCubit extends Cubit<GetAllUsersState> {
  GetAllUsersCubit() : super(GetAllUsersInitial());

  final UsersRepo _usersRepo = getIt<UsersRepo>();

  Future<void> loadUsers({bool refresh = false}) async {
    if (state is GetAllUsersLoading) {
      return;
    }

    final currentState = state;
    List<User>? existingUsers;
    int? currentPage;
    int? totalPages;
    int? total;

    if (refresh || state is GetAllUsersInitial) {
      emit(
        GetAllUsersLoading(
          isFirstPage: true,
          users: null,
          currentPage: null,
          totalPages: null,
          total: null,
        ),
      );
    } else {
      if (currentState is GetAllUsersSuccess) {
        existingUsers = currentState.users;
        currentPage = currentState.currentPage;
        totalPages = currentState.totalPages;
        total = currentState.total;
      } else if (currentState is GetAllUsersFailure) {
        existingUsers = currentState.users;
        currentPage = currentState.currentPage;
        totalPages = currentState.totalPages;
        total = currentState.total;
        emit(
          GetAllUsersLoading(
            isFirstPage: existingUsers == null || existingUsers.isEmpty,
            users: existingUsers,
            currentPage: currentPage,
            totalPages: totalPages,
            total: total,
          ),
        );
      }
    }

    final response = await _usersRepo.getUsersPage(page: 1);

    response.fold(
      (failure) => emit(
        GetAllUsersFailure(
          isFirstPage: existingUsers == null || existingUsers.isEmpty,
          users: existingUsers,
          currentPage: currentPage,
          totalPages: totalPages,
          total: total,
          exception: failure,
        ),
      ),
      (success) => emit(
        GetAllUsersSuccess(
          users: success.data,
          currentPage: success.page,
          totalPages: success.totalPages,
          total: success.total,
          hasReachedMax: success.page >= success.totalPages,
        ),
      ),
    );
  }

  Future<void> loadMoreUsers() async {
    final currentState = state;

    if (currentState is! GetAllUsersSuccess ||
        currentState.isLoadingMore ||
        currentState.hasReachedMax) {
      return;
    }

    emit(currentState.copyWith(isLoadingMore: true));

    final nextPage = currentState.currentPage + 1;
    final response = await _usersRepo.getUsersPage(page: nextPage);

    response.fold(
      (failure) => emit(
        GetAllUsersFailure(
          isFirstPage: false,
          users: currentState.users,
          currentPage: currentState.currentPage,
          totalPages: currentState.totalPages,
          total: currentState.total,
          exception: failure,
        ),
      ),
      (success) => emit(
        currentState.copyWith(
          users: [...currentState.users, ...success.data],
          currentPage: success.page,
          totalPages: success.totalPages,
          total: success.total,
          hasReachedMax: success.page >= success.totalPages,
          isLoadingMore: false,
        ),
      ),
    );
  }

  Future<void> refreshUsers() async {
    await loadUsers(refresh: true);
  }

  Future<void> loadPage(int page) async {
    if (page < 1) return;

    final currentState = state;
    List<User>? existingUsers;
    int? currentPage;
    int? totalPages;
    int? total;

    if (currentState is GetAllUsersSuccess) {
      existingUsers = currentState.users;
      currentPage = currentState.currentPage;
      totalPages = currentState.totalPages;
      total = currentState.total;
    } else if (currentState is GetAllUsersFailure) {
      existingUsers = currentState.users;
      currentPage = currentState.currentPage;
      totalPages = currentState.totalPages;
      total = currentState.total;
    }

    emit(
      GetAllUsersLoading(
        isFirstPage: existingUsers == null || existingUsers.isEmpty,
        users: existingUsers,
        currentPage: currentPage,
        totalPages: totalPages,
        total: total,
      ),
    );

    final response = await _usersRepo.getUsersPage(page: page);

    response.fold(
      (failure) => emit(
        GetAllUsersFailure(
          isFirstPage: existingUsers == null || existingUsers.isEmpty,
          users: existingUsers,
          currentPage: currentPage,
          totalPages: totalPages,
          total: total,
          exception: failure,
        ),
      ),
      (success) => emit(
        GetAllUsersSuccess(
          users: success.data,
          currentPage: success.page,
          totalPages: success.totalPages,
          total: success.total,
          hasReachedMax: success.page >= success.totalPages,
        ),
      ),
    );
  }

  List<User> getCurrentUsers() {
    final currentState = state;
    if (currentState is GetAllUsersSuccess) {
      return currentState.users;
    } else if (currentState is GetAllUsersLoading) {
      return currentState.users ?? [];
    } else if (currentState is GetAllUsersFailure) {
      return currentState.users ?? [];
    }
    return [];
  }

  bool hasUsers() {
    return getCurrentUsers().isNotEmpty;
  }
}
