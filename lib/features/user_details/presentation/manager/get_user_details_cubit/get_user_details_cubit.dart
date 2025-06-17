import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error_handle/app_exception.dart';
import '../../../../../core/repo/users_repo/users_repo.dart';
import '../../../../../core/utils/git_it.dart';
import '../../../data/model/user_details.dart';

part 'get_user_details_state.dart';

class GetUserDetailsCubit extends Cubit<GetUserDetailsState> {
  GetUserDetailsCubit() : super(GetUserDetailsInitial());

  final UsersRepo _usersRepo = getIt<UsersRepo>();

  Future<void> getUserDetails(int userId) async {
    emit(GetUserDetailsLoading());
    final result = await _usersRepo.getSingleUserDetails(userId: userId);
    result.fold(
      (failure) => emit(GetUserDetailsFailure(exception: failure)),
      (success) => emit(GetUserDetailsSuccess(userDetails: success)),
    );
  }
}
