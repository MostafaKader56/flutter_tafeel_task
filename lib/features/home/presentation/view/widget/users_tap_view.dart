import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../data/model/user.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/get_all_users_cubit/get_all_users_cubit.dart';
import 'error_loading_users.dart';
import 'first_users_loading_shimmer.dart';
import 'loading_users_empty_state.dart';
import 'user_item_widget.dart';
import 'users_loading_more_shimmer.dart';

class UsersTapView extends StatefulWidget {
  const UsersTapView({super.key});

  @override
  State<UsersTapView> createState() => _UsersTapViewState();
}

class _UsersTapViewState extends State<UsersTapView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      BlocProvider.of<GetAllUsersCubit>(context).loadMoreUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize! * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.defaultSize! * 2,
            ),
            child: Text(
              S.of(context).users,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: SizeConfig.defaultSize! * 2),

          Expanded(
            child: BlocBuilder<GetAllUsersCubit, GetAllUsersState>(
              builder: (context, state) {
                return _buildUsersList(state);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _maybeLoadNext() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients &&
          _scrollController.position.maxScrollExtent == 0) {
        context.read<GetAllUsersCubit>().loadMoreUsers();
      }
    });
  }

  Widget _buildUsersList(GetAllUsersState state) {
    if (state is GetAllUsersSuccess && state.currentPage == 1) {
      _maybeLoadNext();
    }
    final List<User> users = _getUsersFromState(state);
    final bool hasUsers = users.isNotEmpty;

    return RefreshIndicator(
      onRefresh: () =>
          BlocProvider.of<GetAllUsersCubit>(context).refreshUsers(),
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          if (hasUsers)
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                if (index < users.length) {
                  return Column(
                    children: [
                      UserItemWidget(
                        user: users[index],
                        onTap: () => _onUserTap(users[index]),
                      ),
                      if (index < users.length - 1)
                        const Divider(
                          height: 1,
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                    ],
                  );
                }
                return null;
              }, childCount: users.length),
            ),

          if (state is GetAllUsersSuccess && state.isLoadingMore)
            SliverToBoxAdapter(child: UsersLoadingMoreShimmer()),

          if (state is GetAllUsersFailure && !state.isFirstPage)
            SliverToBoxAdapter(
              child: ErrorLoadingUsers(
                exception: state.exception,
                isFirstPage: false,
              ),
            ),

          if (state is GetAllUsersLoading && !state.isFirstPage)
            SliverToBoxAdapter(child: UsersLoadingMoreShimmer()),

          if (!hasUsers) ...[
            if (state is GetAllUsersLoading && state.isFirstPage)
              SliverFillRemaining(child: FirstUsersLoadingShimmer())
            else if (state is GetAllUsersFailure && state.isFirstPage)
              SliverFillRemaining(
                child: ErrorLoadingUsers(
                  exception: state.exception,
                  isFirstPage: true,
                ),
              )
            else if (state is GetAllUsersSuccess && users.isEmpty)
              SliverFillRemaining(child: LoadingUsersEmptyState()),
          ],
        ],
      ),
    );
  }

  List<User> _getUsersFromState(GetAllUsersState state) {
    return switch (state) {
      GetAllUsersSuccess() => state.users,
      GetAllUsersLoading() => state.users ?? [],
      GetAllUsersFailure() => state.users ?? [],
      GetAllUsersInitial() => [],
    };
  }

  void _onUserTap(User user) {
    GoRouter.of(context).push(AppRouter.kUserDetailsView, extra: user.id);
  }
}
