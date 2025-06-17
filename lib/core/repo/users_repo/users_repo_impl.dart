import 'package:dartz/dartz.dart';
import 'package:task/core/repo/users_repo/users_repo.dart';
import 'package:task/features/user_details/data/model/user_details.dart';

import '../../../features/home/data/model/user.dart';
import '../../error_handle/app_exception.dart';
import '../../error_handle/error_type.dart';
import '../../model/pagination_response.dart/paginated_response.dart';
import '../../utils/api_service.dart';
import '../../utils/git_it.dart';

class UsersRepoImpl implements UsersRepo {
  final ApiService _apiService = getIt<ApiService>();

  @override
  Future<Either<AppException, PaginatedResponse<User>>> getUsersPage({
    int page = 1,
  }) async {
    try {
      final response = await _apiService.get(endPoint: 'users?page=$page');
      return Right(
        PaginatedResponse.fromJson(response, (json) => User.fromJson(json)),
      );

      // await Future.delayed(const Duration(seconds: 2));

      // return Right(
      //   PaginatedResponse(
      //     data: [
      //       User(
      //         id: 1,
      //         firstName: 'John',
      //         lastName: 'Doe',
      //         email: 'john.doe@example.com',
      //         avatarUrl: 'https://via.placeholder.com/150',
      //       ),
      //       User(
      //         id: 2,
      //         firstName: 'Jane',
      //         lastName: 'Smith',
      //         email: 'jane.smith@example.com',
      //         avatarUrl: 'https://via.placeholder.com/150',
      //       ),
      //       User(
      //         id: 3,
      //         firstName: 'Jim',
      //         lastName: 'Beam',
      //         email: 'jim.beam@example.com',
      //         avatarUrl: 'https://via.placeholder.com/150',
      //       ),
      //       User(
      //         id: 4,
      //         firstName: 'Jill',
      //         lastName: 'Johnson',
      //         email: 'jill.johnson@example.com',
      //         avatarUrl: 'https://via.placeholder.com/150',
      //       ),
      //       User(
      //         id: 5,
      //         firstName: 'Jack',
      //         lastName: 'Daniels',
      //         email: 'jack.daniels@example.com',
      //         avatarUrl: 'https://via.placeholder.com/150',
      //       ),
      //       User(
      //         id: 6,
      //         firstName: 'Jill',
      //         lastName: 'Johnson',
      //         email: 'jill.johnson@example.com',
      //         avatarUrl: 'https://via.placeholder.com/150',
      //       ),
      //     ],
      //     page: page,
      //     perPage: 6,
      //     total: 12,
      //     totalPages: 2,
      //   ),
      // );
    } catch (e) {
      return Left(AppException(ErrorType.unexpectedError, originalError: e));
    }
  }

  @override
  Future<Either<AppException, UserDetails>> getSingleUserDetails({
    required int userId,
  }) async {
    try {
      final response = await _apiService.get(endPoint: 'users/$userId');
      return Right(UserDetails.fromJson(response['data']));
      // return Right(
      //   UserDetails(
      //     id: userId,
      //     firstName: 'John',
      //     lastName: 'Doe',
      //     email: 'john.doe@example.com',
      //     avatarUrl: 'https://via.placeholder.com/150',
      //   ),
      // );
    } catch (e) {
      return Left(AppException(ErrorType.unexpectedError, originalError: e));
    }
  }
}
