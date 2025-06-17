import 'package:flutter/material.dart';

import 'user_item_shimmer_widget.dart';

class FirstUsersLoadingShimmer extends StatelessWidget {
  const FirstUsersLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      separatorBuilder: (context, index) =>
          const Divider(height: 1, thickness: 0.5, color: Colors.grey),
      itemBuilder: (context, index) => UserItemShimmerWidget(),
    );
  }
}
