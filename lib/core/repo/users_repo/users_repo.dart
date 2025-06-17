import 'package:dartz/dartz.dart';
import 'package:task/features/user_details/data/model/user_details.dart';

import '../../../features/home/data/model/user.dart';
import '../../error_handle/app_exception.dart';
import '../../model/pagination_response.dart/paginated_response.dart';

abstract class UsersRepo {
  Future<Either<AppException, PaginatedResponse<User>>> getUsersPage({
    int page = 1,
  });

  Future<Either<AppException, UserDetails>> getSingleUserDetails({
    required int userId,
  });
}
