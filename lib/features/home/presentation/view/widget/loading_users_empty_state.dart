import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/size_config.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/get_all_users_cubit/get_all_users_cubit.dart';

class LoadingUsersEmptyState extends StatelessWidget {
  const LoadingUsersEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: SizeConfig.defaultSize! * 6,
            color: Colors.grey,
          ),
          SizedBox(height: SizeConfig.defaultSize! * 2),
          Text(
            S.of(context).noUsersFound,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: SizeConfig.defaultSize!),
          Text(
            S.of(context).noUsersFoundDescription,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: SizeConfig.defaultSize! * 2),
          ElevatedButton(
            onPressed: () =>
                BlocProvider.of<GetAllUsersCubit>(context).loadUsers(),
            child: Text(S.of(context).refresh),
          ),
        ],
      ),
    );
  }
}
