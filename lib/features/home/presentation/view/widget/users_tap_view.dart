import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/error_handle/app_exception.dart';
import '../../../../../core/error_handle/ui_error_handler.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../data/model/user.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/get_all_users_cubit/get_all_users_cubit.dart';
import 'user_item_widget.dart';

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
      onRefresh: () => context.read<GetAllUsersCubit>().refreshUsers(),
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
            SliverToBoxAdapter(child: _buildLoadingMoreIndicator()),

          if (state is GetAllUsersFailure && !state.isFirstPage)
            SliverToBoxAdapter(
              child: _buildErrorWidget(state.exception, isFirstPage: false),
            ),

          if (state is GetAllUsersLoading && !state.isFirstPage)
            SliverToBoxAdapter(child: _buildLoadingWidget(isFirstPage: false)),

          if (!hasUsers) ...[
            if (state is GetAllUsersLoading && state.isFirstPage)
              SliverFillRemaining(child: _buildLoadingWidget(isFirstPage: true))
            else if (state is GetAllUsersFailure && state.isFirstPage)
              SliverFillRemaining(
                child: _buildErrorWidget(state.exception, isFirstPage: true),
              )
            else if (state is GetAllUsersSuccess && users.isEmpty)
              SliverFillRemaining(child: _buildEmptyState()),
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

  Widget _buildLoadingWidget({required bool isFirstPage}) {
    if (isFirstPage) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Container(
        padding: EdgeInsets.all(SizeConfig.defaultSize! * 2),
        child: const Center(child: CircularProgressIndicator()),
      );
    }
  }

  Widget _buildLoadingMoreIndicator() {
    return Container(
      padding: EdgeInsets.all(SizeConfig.defaultSize! * 2),
      child: const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(
    AppException exception, {
    required bool isFirstPage,
  }) {
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
              child: const Text('Retry'),
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
                child: const Text('Retry'),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildEmptyState() {
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
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  void _onUserTap(User user) {
    GoRouter.of(context).push(AppRouter.kUserDetailsView, extra: user.id);
  }
}
