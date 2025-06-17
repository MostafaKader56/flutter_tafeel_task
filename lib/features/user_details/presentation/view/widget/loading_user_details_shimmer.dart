import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/utils/size_config.dart';

class LoadingUserDetailsShimmer extends StatelessWidget {
  const LoadingUserDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        highlightColor: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            SizedBox(height: SizeConfig.defaultSize! * 4),

            // Avatar shimmer
            Container(
              width: SizeConfig.defaultSize! * 10,
              height: SizeConfig.defaultSize! * 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                border: Border.all(
                  color: Theme.of(
                    context,
                  ).colorScheme.outline.withValues(alpha: 0.3),
                ),
              ),
            ),

            SizedBox(height: SizeConfig.defaultSize! * 2),

            // Name shimmer
            Container(
              height: 28,
              width: SizeConfig.screenWidth! * 0.6,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(6),
              ),
            ),

            SizedBox(height: SizeConfig.defaultSize! * 4),

            // Profile fields shimmer
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.defaultSize! * 2,
              ),
              child: Column(
                children: [
                  _buildShimmerProfileField(context),
                  SizedBox(height: SizeConfig.defaultSize! * 2),
                  _buildShimmerProfileField(context),
                  SizedBox(height: SizeConfig.defaultSize! * 2),
                  _buildShimmerProfileField(context),
                ],
              ),
            ),

            SizedBox(height: SizeConfig.defaultSize! * 4),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerProfileField(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.defaultSize! * 1.6),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerLowest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(SizeConfig.defaultSize! * 1.2),
        border: Border.all(
          color: Theme.of(
            context,
          ).colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          // Icon shimmer
          Container(
            width: SizeConfig.defaultSize! * 2,
            height: SizeConfig.defaultSize! * 2,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(width: SizeConfig.defaultSize! * 1.6),

          // Content shimmer
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Label shimmer
                Container(
                  height: 12,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(height: SizeConfig.defaultSize! * 0.4),

                // Value shimmer
                Container(
                  height: 18,
                  width: double.infinity * 0.7,
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
        ],
      ),
    );
  }
}
