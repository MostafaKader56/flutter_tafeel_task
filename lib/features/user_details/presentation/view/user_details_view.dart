import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../generated/l10n.dart';
import 'widget/user_details_view_body.dart';

class UserDetailsView extends StatelessWidget {
  const UserDetailsView({super.key, required this.userId});
  final int userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: Text(
          S.of(context).userProfile,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: UserDetailsViewBody(userId: userId),
    );
  }
}
