import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error_handle/app_exception.dart';
import '../../../../../core/error_handle/ui_error_handler.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/get_all_users_cubit/get_all_users_cubit.dart';

class ErrorLoadingUsers extends StatelessWidget {
  const ErrorLoadingUsers({
    super.key,
    required this.exception,
    required this.isFirstPage,
  });

  final AppException exception;
  final bool isFirstPage;

  @override
  Widget build(BuildContext context) {
    if (isFirstPage) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: SizeConfig.defaultSize! * 6,
              color: Colors.red,
            ),
            SizedBox(height: SizeConfig.defaultSize! * 2),
            Text(
              S.of(context).failedToLoadUsers,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: SizeConfig.defaultSize!),
            Text(
              UIErrorHandler.getLocalizedMessage(exception, context),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConfig.defaultSize! * 2),
            ElevatedButton(
              onPressed: () =>
                  BlocProvider.of<GetAllUsersCubit>(context).loadUsers(),
              child: Text(S.of(context).retry),
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.all(SizeConfig.defaultSize! * 2),
        padding: EdgeInsets.all(SizeConfig.defaultSize! * 2),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red.shade200),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: SizeConfig.defaultSize! * 2,
                ),
                SizedBox(width: SizeConfig.defaultSize!),
                Expanded(
                  child: Text(
                    S.of(context).failedToLoadMoreUsers,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.red.shade700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeConfig.defaultSize!),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () =>
                    BlocProvider.of<GetAllUsersCubit>(context).loadUsers(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: Text(S.of(context).retry),
              ),
            ),
          ],
        ),
      );
    }
  }
}
