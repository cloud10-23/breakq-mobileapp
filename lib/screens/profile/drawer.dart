import 'package:breakq/data/models/category_model.dart';
import 'package:breakq/data/models/category_tab_model.dart';
import 'package:breakq/widgets/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/blocs/auth/auth_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/screens/profile/widgets/profile_info.dart';
import 'package:breakq/utils/ui.dart';
import 'package:breakq/widgets/arrow_right_icon.dart';
import 'package:breakq/widgets/list_item.dart';
import 'package:breakq/widgets/list_title.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:flutter_icons/flutter_icons.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key key, @required this.categories}) : super(key: key);
  final List<CategoryTabModel> categories;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (AuthState previousState, AuthState currentState) {
        return currentState is PreferenceSaveSuccessAuthState;
      },
      builder: (BuildContext context, AuthState state) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: Theme.of(context).brightness == Brightness.dark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
          child: Scaffold(
            backgroundColor: kWhite,
            body: Column(
              children: <Widget>[
                Container(
                  color: kBlue,
                  padding: const EdgeInsets.all(kPaddingL),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: kPaddingL),
                      ProfileInfo(),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
                    child: ListView(
                      children: <Widget>[
                        ListTitle(title: L10n.of(context).categoriesTitle),
                        AllCategoriesListItems(categories: categories),
                        SizedBox(height: kPaddingM),
                        ListTitle(title: L10n.of(context).orderTitle),
                        SizedBox(height: kPaddingM),
                        ListItem(
                          title: L10n.of(context).orderListMyCart,
                          leading:
                              const Icon(FontAwesome.shopping_cart, size: 18),
                          trailing: const ArrowRightIcon(),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(Routes.cart);
                            // getIt.get<AppGlobals>().showCartPage(context);
                          },
                        ),
                        ListItem(
                          title: L10n.of(context).orderListMyOrders,
                          leading: const Icon(FontAwesome.archive, size: 18),
                          trailing: const ArrowRightIcon(),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(Routes.orders);
                          },
                        ),
                        SizedBox(height: kPaddingM),
                        ListTitle(
                            title: L10n.of(context).profileListTitleSettings),
                        ListItem(
                          title: L10n.of(context).profileListEdit,
                          leading:
                              const Icon(FontAwesome5Solid.user_edit, size: 18),
                          trailing: const ArrowRightIcon(),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, Routes.editProfile);
                          },
                        ),
                        SizedBox(height: kPaddingM),
                        // ListTitle(
                        //     title:
                        //         L10n.of(context).settingsListTitleInterface),
                        // ListItem(
                        //   title: L10n.of(context).settingsListLanguage,
                        //   onPressed: () {
                        //     _showLanguagePicker(context);
                        //   },
                        //   trailing: Row(
                        //     children: <Widget>[
                        //       Text(
                        //         L10n.of(context).commonLocales(getIt
                        //             .get<AppGlobals>()
                        //             .selectedLocale
                        //             .toString()),
                        //         style: Theme.of(context)
                        //             .textTheme
                        //             .bodyText1
                        //             .bold,
                        //       ),
                        //       const ArrowRightIcon(),
                        //     ],
                        //   ),
                        // ),
                        // ListItem(
                        //   title: L10n.of(context).settingsListDarkMode,
                        //   onPressed: () {
                        //     _showDarkModePicker(context);
                        //   },
                        //   trailing: Row(
                        //     children: <Widget>[
                        //       Text(
                        //         L10n.of(context).commonDarkMode(getIt
                        //             .get<AppGlobals>()
                        //             .darkThemeOption
                        //             .toString()),
                        //         style: Theme.of(context)
                        //             .textTheme
                        //             .bodyText1
                        //             .bold,
                        //       ),
                        //       const ArrowRightIcon(),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(height: kPaddingL),
                        ListTitle(
                            title: L10n.of(context).settingsListTitleSupport),
                        ListItem(
                          title: L10n.of(context).settingsListTerms,
                          trailing: const ArrowRightIcon(),
                          onPressed: () {
                            // Async.launchUrl(kTermsOfServiceURL);
                          },
                        ),
                        ListItem(
                          title: L10n.of(context).settingsListPrivacy,
                          trailing: const ArrowRightIcon(),
                          onPressed: () {
                            // Async.launchUrl(kPrivacyPolicyURL);
                          },
                        ),
                        SizedBox(height: kPaddingM),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: kPaddingL),
                          child: Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 80,
                                  child: const Image(
                                      image: AssetImage(AssetImages.mts_logo)),
                                ),
                              ),
                              // SizedBox(height: kPaddingM),
                              // Padding(
                              //   padding: const EdgeInsets.only(top: kPaddingS),
                              //   child: Image(
                              //     image: AssetImage(AssetImages.bq_logo),
                              //     height: 30,
                              //   ),
                              // ),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.only(top: kPaddingS),
                              //   child: Text(
                              //     kAppName,
                              //     style: Theme.of(context)
                              //         .textTheme
                              //         .headline6
                              //         .w600,
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: kPaddingS, bottom: kPaddingS),
                                child: Text(
                                  L10n.of(context).settingsCopyright,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: kPaddingM, bottom: kPaddingL),
                          child: BlocBuilder<AuthBloc, AuthState>(builder:
                              (BuildContext context, AuthState logoutState) {
                            return BlocListener<AuthBloc, AuthState>(
                              listener: (BuildContext context,
                                  AuthState logoutListener) {
                                if (logoutListener is LogoutFailureAuthState) {
                                  UI.showErrorDialog(context,
                                      message: logoutListener.message);
                                }
                              },
                              child: Center(
                                child: ThemeButton(
                                  onPressed: () =>
                                      BlocProvider.of<AuthBloc>(context)
                                          .add(UserLoggedOutAuthEvent()),
                                  text: L10n.of(context).profileListLogout,
                                  // style: Theme.of(context)
                                  //     .textTheme
                                  //     .subtitle1
                                  //     .w400
                                  //     .copyWith(
                                  //         color:
                                  //             Theme.of(context).hintColor),
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Future<void> _showLanguagePicker(BuildContext context) async {
  //   final List<PickerItem<Locale>> _pickerItems = <PickerItem<Locale>>[];
  //   final List<PickerItem<Locale>> _selectedItems = <PickerItem<Locale>>[];

  //   for (final Locale _l in L10n.delegate.supportedLocales) {
  //     _pickerItems.add(PickerItem<Locale>(
  //       text: L10n.of(context).commonLocales(_l.toString()),
  //       value: _l,
  //     ));
  //   }

  //   _selectedItems.add(PickerItem<Locale>(
  //     text: L10n.of(context)
  //         .commonLocales(getIt.get<AppGlobals>().selectedLocale.toString()),
  //     value: getIt.get<AppGlobals>().selectedLocale,
  //   ));

  //   final dynamic selectedLanguage = await Navigator.pushNamed(
  //     context,
  //     Routes.picker,
  //     arguments: <String, dynamic>{
  //       'title': L10n.of(context).pickerTitleLanguages,
  //       'items': _pickerItems,
  //       'itemsSelected': _selectedItems,
  //     },
  //   );

  //   if (selectedLanguage != null) {
  //     BlocProvider.of<LanguageBloc>(context)
  //         .add(ChangeRequestedLanguageEvent(selectedLanguage as Locale));
  //   }
  // }

  // Future<void> _showDarkModePicker(BuildContext context) async {
  //   final List<PickerItem<DarkOption>> _pickerItems =
  //       <PickerItem<DarkOption>>[];
  //   final List<PickerItem<DarkOption>> _selectedItems =
  //       <PickerItem<DarkOption>>[];

  //   for (final DarkOption option in DarkOption.values) {
  //     _pickerItems.add(PickerItem<DarkOption>(
  //       text: L10n.of(context).commonDarkMode(option.toString()),
  //       value: option,
  //     ));
  //   }

  //   _selectedItems.add(PickerItem<DarkOption>(
  //     text: L10n.of(context)
  //         .commonDarkMode(getIt.get<AppGlobals>().darkThemeOption),
  //     value: getIt.get<AppGlobals>().darkThemeOption,
  //   ));

  //   final dynamic selectedDarkMode = await Navigator.pushNamed(
  //     context,
  //     Routes.picker,
  //     arguments: <String, dynamic>{
  //       'title': L10n.of(context).settingsListDarkMode,
  //       'items': _pickerItems,
  //       'itemsSelected': _selectedItems,
  //     },
  //   );

  //   if (selectedDarkMode != null) {
  //     BlocProvider.of<ThemeBloc>(context).add(ChangeRequestedThemeEvent(
  //         darkOption: selectedDarkMode as DarkOption));
  //   }
  // }
}

class AllCategoriesListItems extends StatelessWidget {
  AllCategoriesListItems({this.categories});
  final List<CategoryTabModel> categories;
  @override
  Widget build(BuildContext context) {
    return Column(
        children: categories
            .map(
              // (category) => ListItem(
              //   title: category.category.title,
              //   onPressed: () => Navigator.pushNamed(context, Routes.listing,
              //       arguments: category.category),
              (category) => ExpansionTile(
                title: Text(category.category.title),
                tilePadding: EdgeInsets.zero,
                children: List.generate(
                    category.category.subCategories.length,
                    (index) => ListItem(
                          title: category.category.subCategories[index].title,
                          titleTextStyle:
                              Theme.of(context).textTheme.caption.black.w600,
                          trailing: const ArrowRightIcon(),
                          onPressed: () => Navigator.pushNamed(
                              context, Routes.listing,
                              arguments: <CategoryModel, int>{
                                category.category: index
                              }),
                        )),
              ),
            )
            .toList());
  }
}
