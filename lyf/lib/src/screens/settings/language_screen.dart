import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/services/lyf_settings.dart';
import 'package:lyf/src/state/theme/theme_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants/language_constants.dart';
import '../../state/language/language_state.dart';

class LanguageSettingsScreen extends ConsumerStatefulWidget {
  const LanguageSettingsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState
    extends ConsumerState<LanguageSettingsScreen> {
  void _changeLanguage(Locale langName) {
    ref.read(languageNotifier.notifier).changeLanguage(langName);
    // LyfService.themeService.setTheme(themeIndex.toString());
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var theme = ref.read(themeNotifier.notifier).getCurrentState();
    final languageConstants = languageProvider(context);

    return Stack(
      children: [
        Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: theme.gradientColors,
            ),
          ),
          child: const CustomPaint(),
        ),
        SizedBox(
          height: size.height,
          width: size.width,
          child: Scaffold(
            appBar: AppBar(
              // shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () {
                  goRouter.pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              title: Text(
                AppLocalizations.of(context)!.language,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            backgroundColor: Colors.transparent,
            body: SizedBox(
              width: size.width,
              height: size.height,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.05 * size.width,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width,
                      height: 0.15 * size.height,
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 0.05 * size.width,
                          vertical: 0.025 * size.height,
                        ),
                        leading: Icon(
                          FontAwesomeIcons.language,
                          color: Theme.of(context).iconTheme.color,
                          size: 35,
                        ),
                        title: Text(
                          AppLocalizations.of(context)!.appLanguage,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context)!.appLanguageDesc,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        tileColor: Colors.transparent,
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      height: 0.70 * size.height,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: ((context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context).primaryColor,
                              child: Text(
                                languageConstants[index]['code'],
                                style: TextStyle(
                                  color: theme.gradientColors[0],
                                ),
                              ),
                            ),
                            title: Text(
                              languageConstants[index]['langName'],
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            onTap: () => _changeLanguage(
                              languageConstants[index]['locale'],
                            ),
                            tileColor: Colors.transparent,
                          );
                        }),
                        itemCount: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
