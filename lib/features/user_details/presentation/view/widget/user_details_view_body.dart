import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/error_handle/app_exception.dart';
import '../../../../../core/error_handle/ui_error_handler.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/model/user_details.dart';
import '../../manager/get_user_details_cubit/get_user_details_cubit.dart';

class UserDetailsViewBody extends StatelessWidget {
  const UserDetailsViewBody({super.key, required this.userId});
  final int userId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserDetailsCubit, GetUserDetailsState>(
      builder: (context, state) {
        if (state is GetUserDetailsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetUserDetailsFailure) {
          return _buildErrorWidget(state.exception, context, state.exception);
        } else if (state is GetUserDetailsSuccess) {
          return RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<GetUserDetailsCubit>(
                context,
              ).getUserDetails(userId);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.defaultSize! * 4),
                  Container(
                    width: SizeConfig.defaultSize! * 10,
                    height: SizeConfig.defaultSize! * 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.surfaceContainerLow,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: state.userDetails.avatarUrl,
                        width: SizeConfig.defaultSize! * 10,
                        height: SizeConfig.defaultSize! * 10,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => _buildShimmerPlaceholder(
                          context,
                          SizeConfig.defaultSize! * 5,
                        ),
                        errorWidget: (context, url, error) =>
                            _buildFallbackAvatar(
                              context,
                              SizeConfig.defaultSize! * 5,
                              state.userDetails,
                            ),
                      ),
                    ),
                  ),

                  SizedBox(height: SizeConfig.defaultSize! * 2),

                  Text(
                    '${state.userDetails.firstName} ${state.userDetails.lastName}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: SizeConfig.defaultSize! * 4),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.defaultSize! * 2,
                    ),
                    child: Column(
                      children: [
                        _buildProfileField(
                          context: context,
                          icon: Icons.person_outline,
                          label: S.of(context).firstName,
                          value: state.userDetails.firstName,
                        ),

                        SizedBox(height: SizeConfig.defaultSize! * 2),

                        _buildProfileField(
                          context: context,
                          icon: Icons.person_outline,
                          label: S.of(context).lastName,
                          value: state.userDetails.lastName,
                        ),

                        SizedBox(height: SizeConfig.defaultSize! * 2),

                        _buildProfileField(
                          context: context,
                          icon: Icons.email_outlined,
                          label: S.of(context).email,
                          value: state.userDetails.email,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: SizeConfig.defaultSize! * 4),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildProfileField({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.defaultSize! * 1.6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(SizeConfig.defaultSize! * 1.2),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            size: SizeConfig.defaultSize! * 2,
          ),
          SizedBox(width: SizeConfig.defaultSize! * 1.6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: SizeConfig.defaultSize! * 0.4),
                Text(
                  value,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(
    Exception exception,
    BuildContext context,
    AppException appException,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: SizeConfig.defaultSize! * 6,
            color: Theme.of(context).colorScheme.error,
          ),
          SizedBox(height: SizeConfig.defaultSize! * 2),
          Text(
            UIErrorHandler.getLocalizedMessage(appException, context),
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: SizeConfig.defaultSize! * 2),
          ElevatedButton(
            onPressed: () => BlocProvider.of<GetUserDetailsCubit>(
              context,
            ).getUserDetails(userId),
            child: Text(S.of(context).retry),
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackAvatar(
    BuildContext context,
    double radius,
    UserDetails userDetails,
  ) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Text(
        "${userDetails.firstName[0]}${userDetails.lastName[0]}".toUpperCase(),
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildShimmerPlaceholder(BuildContext context, double radius) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      highlightColor: Theme.of(context).colorScheme.surface,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
    );
  }
}
