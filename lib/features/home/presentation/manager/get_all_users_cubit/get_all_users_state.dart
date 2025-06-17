part of 'get_all_users_cubit.dart';

@immutable
sealed class GetAllUsersState {}

final class GetAllUsersInitial extends GetAllUsersState {}

class GetAllUsersLoading extends GetAllUsersState {
  final List<User>? users;
  final int? currentPage;
  final int? totalPages;
  final int? total;
  final bool isFirstPage;

  GetAllUsersLoading({
    required this.isFirstPage,
    this.users,
    this.currentPage,
    this.totalPages,
    this.total,
  });
}

class GetAllUsersSuccess extends GetAllUsersState {
  final List<User> users;
  final int currentPage;
  final int totalPages;
  final int total;
  final bool hasReachedMax;
  final bool isLoadingMore;

  GetAllUsersSuccess({
    required this.users,
    required this.currentPage,
    required this.totalPages,
    required this.total,
    required this.hasReachedMax,
    this.isLoadingMore = false,
  });

  GetAllUsersSuccess copyWith({
    List<User>? users,
    int? currentPage,
    int? totalPages,
    int? total,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return GetAllUsersSuccess(
      users: users ?? this.users,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      total: total ?? this.total,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class GetAllUsersFailure extends GetAllUsersState {
  final AppException exception;
  final List<User>? users;
  final int? currentPage;
  final int? totalPages;
  final int? total;
  final bool isFirstPage;

  GetAllUsersFailure({
    required this.isFirstPage,
    required this.exception,
    this.users,
    this.currentPage,
    this.totalPages,
    this.total,
  });
}
