import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/manager/localization_cubit/localization_cubit.dart';
import '../../../../../core/utils/shared_pref_helper.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../generated/l10n.dart';

class SelectLanguageViewBody extends StatefulWidget {
  const SelectLanguageViewBody({super.key});

  @override
  State<SelectLanguageViewBody> createState() => _SelectLanguageViewBodyState();
}

class _SelectLanguageViewBodyState extends State<SelectLanguageViewBody> {
  String selectedLanguage = SharedPrefsHelper.getLanguageSuffix();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.all(SizeConfig.defaultSize! * 2),
      child: Column(
        children: [
          Container(
            width: SizeConfig.defaultSize! * 10,
            height: SizeConfig.defaultSize! * 10,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.language,
              color: colorScheme.onPrimary,
              size: SizeConfig.defaultSize! * 5,
            ),
          ),
          SizedBox(height: SizeConfig.defaultSize! * 3),
          Text(
            S.of(context).chooseYourLanguage,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          SizedBox(height: SizeConfig.defaultSize),
          Text(
            S.of(context).languageDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: colorScheme.onSurface.withValues(alpha: 0.7),
              height: 1.4,
            ),
          ),
          SizedBox(height: SizeConfig.defaultSize! * 4),
          _buildLanguageOption(
            context,
            "العربية",
            S.of(context).arabicSubtitle,
            'assets/flags/eg.png',
            isSelected: selectedLanguage == 'ar',
            languageCode: 'ar',
          ),
          SizedBox(height: SizeConfig.defaultSize! * 1.5),
          _buildLanguageOption(
            context,
            'English',
            S.of(context).englishSubtitle,
            'assets/flags/uk.png',
            isSelected: selectedLanguage == 'en',
            languageCode: 'en',
          ),
          SizedBox(height: SizeConfig.defaultSize! * 4),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: SizeConfig.defaultSize! * 6.25,
            child: ElevatedButton(
              onPressed: () {
                BlocProvider.of<LocalizationCubit>(
                  context,
                ).changeLanguage(languageCode: selectedLanguage);
                GoRouter.of(context).go(AppRouter.kHomeView);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    SizeConfig.defaultSize! * 1.5,
                  ),
                ),
                elevation: 0,
              ),
              child: Text(
                S.of(context).confirm,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    String language,
    String subtitle,
    String flagAsset, {
    required bool isSelected,
    required String languageCode,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = languageCode;
        });
      },
      child: Container(
        padding: EdgeInsets.all(SizeConfig.defaultSize! * 2),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(SizeConfig.defaultSize! * 1.5),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.outline.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: SizeConfig.defaultSize! * 4,
              height: SizeConfig.defaultSize! * 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(flagAsset),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(
                  SizeConfig.defaultSize! * 0.5,
                ),
              ),
            ),
            SizedBox(width: SizeConfig.defaultSize! * 2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    language,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: SizeConfig.defaultSize! * 0.5),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: SizeConfig.defaultSize! * 3,
              height: SizeConfig.defaultSize! * 3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? colorScheme.primary
                      : colorScheme.outline.withValues(alpha: 0.5),
                  width: 2,
                ),
                color: isSelected ? colorScheme.primary : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: SizeConfig.defaultSize! * 2,
                      color: colorScheme.onPrimary,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
