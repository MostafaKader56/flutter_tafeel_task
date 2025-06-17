import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task/core/utils/app_router.dart';
import 'package:task/core/utils/shared_pref_helper.dart';

import '../../../../../core/manager/theme_cubit/theme_cubit.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../generated/l10n.dart';

class SettingsTapView extends StatefulWidget {
  const SettingsTapView({super.key});

  @override
  State<SettingsTapView> createState() => _SettingsTapViewState();
}

class _SettingsTapViewState extends State<SettingsTapView> {
  bool isDarkMode = SharedPrefsHelper.getIsDarkMode();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.defaultSize! * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              S.of(context).settings,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: SizeConfig.defaultSize! * 2),

            Card(
              margin: EdgeInsets.symmetric(
                vertical: SizeConfig.defaultSize! * 0.8,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  SizeConfig.defaultSize! * 1.2,
                ),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.defaultSize! * 2,
                  vertical: SizeConfig.defaultSize! * 0.8,
                ),
                leading: Container(
                  width: SizeConfig.defaultSize! * 4,
                  height: SizeConfig.defaultSize! * 4,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(
                      SizeConfig.defaultSize! * 0.8,
                    ),
                  ),
                  child: Icon(
                    Icons.dark_mode,
                    color: colorScheme.onSurfaceVariant,
                    size: SizeConfig.defaultSize! * 2,
                  ),
                ),
                title: Text(
                  S.of(context).darkTheme,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  S.of(context).darkThemeDescription,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                trailing: Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      BlocProvider.of<ThemeCubit>(context).toggleTheme();
                      setState(() {
                        isDarkMode = value;
                        SharedPrefsHelper.setIsDarkMode(value);
                      });
                    },
                    activeColor: colorScheme.primary,
                    inactiveThumbColor: colorScheme.outline,
                    inactiveTrackColor: colorScheme.surfaceContainerHighest,
                  ),
                ),
              ),
            ),

            Card(
              margin: EdgeInsets.symmetric(
                vertical: SizeConfig.defaultSize! * 0.8,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  SizeConfig.defaultSize! * 1.2,
                ),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.defaultSize! * 2,
                  vertical: SizeConfig.defaultSize! * 0.8,
                ),
                leading: Container(
                  width: SizeConfig.defaultSize! * 4,
                  height: SizeConfig.defaultSize! * 4,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(
                      SizeConfig.defaultSize! * 0.8,
                    ),
                  ),
                  child: Icon(
                    Icons.language,
                    color: colorScheme.onSurfaceVariant,
                    size: SizeConfig.defaultSize! * 2,
                  ),
                ),
                title: Text(
                  S.of(context).language,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  S.of(context).selectedLanguage,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: colorScheme.onSurfaceVariant,
                  size: SizeConfig.defaultSize! * 1.6,
                ),
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kSelectLanguageView);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
