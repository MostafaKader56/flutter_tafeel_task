import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/utils/size_config.dart';

class UserItemShimmerWidget extends StatelessWidget {
  const UserItemShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      highlightColor: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Avatar shimmer
            CircleAvatar(
              radius: SizeConfig.defaultSize! * 3,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest,
            ),
            SizedBox(width: SizeConfig.defaultSize! * 2),

            // Content shimmer
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name shimmer
                  Container(
                    height: 16,
                    width: double.infinity * 0.6,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Email shimmer
                  Container(
                    height: 14,
                    width: double.infinity * 0.8,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),

            // Chevron shimmer
            Container(
              width: SizeConfig.defaultSize! * 2,
              height: SizeConfig.defaultSize! * 2,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
