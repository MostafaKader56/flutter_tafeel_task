import 'package:flutter/material.dart';

import 'user_item_shimmer_widget.dart';

class UsersLoadingMoreShimmer extends StatelessWidget {
  const UsersLoadingMoreShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 1, thickness: 0.5, color: Colors.grey),
        ...List.generate(
          3, // Show 3 shimmer items for loading more
          (index) => Column(
            children: [
              UserItemShimmerWidget(),
              if (index < 2)
                const Divider(height: 1, thickness: 0.5, color: Colors.grey),
            ],
          ),
        ),
      ],
    );
  }
}
