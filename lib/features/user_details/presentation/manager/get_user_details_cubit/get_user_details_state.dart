part of 'get_user_details_cubit.dart';

@immutable
sealed class GetUserDetailsState {}

final class GetUserDetailsInitial extends GetUserDetailsState {}

final class GetUserDetailsLoading extends GetUserDetailsState {}

final class GetUserDetailsSuccess extends GetUserDetailsState {
  final UserDetails userDetails;

  GetUserDetailsSuccess({required this.userDetails});
}

final class GetUserDetailsFailure extends GetUserDetailsState {
  final AppException exception;

  GetUserDetailsFailure({required this.exception});
}
