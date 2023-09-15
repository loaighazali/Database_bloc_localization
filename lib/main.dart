import 'package:elancer_database_project/bloc/bloc/contact_bloc.dart';
import 'package:elancer_database_project/bloc/states/crud_state.dart';
import 'package:elancer_database_project/database/db_controllar.dart';
import 'package:elancer_database_project/get/language_getx_controllar.dart';
import 'package:elancer_database_project/pref/shared_pref_controllar.dart';
import 'package:elancer_database_project/screens/create_contact_screen.dart';
import 'package:elancer_database_project/screens/login_screen.dart';
import 'package:elancer_database_project/screens/lunch_screen.dart';
import 'package:elancer_database_project/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefControllar().initPref();
  await DbControllar().initDatabase();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
 // const MyApp({super.key});

 final LanguageGetxControllar _languageGetxControllar =
      Get.put<LanguageGetxControllar>(LanguageGetxControllar());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:const Size(375, 812),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
          BlocProvider<ContactBloc>(
                 create: (BuildContext context) => ContactBloc(LoadingState()),
               ),
          ],
          child: Obx(
                () {
              return MaterialApp(

                debugShowCheckedModeBanner: false,

                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: Locale(_languageGetxControllar.language.value),
                initialRoute: '/lunch_screen',

                routes: {
                  '/lunch_screen' : (context) =>const LunchScreen(),
                  '/main_screen' : (context) =>const MainScreen(),
                  '/create_contact_screen' : (context) =>const CreateContactScreen(),
                  '/login_screen' : (context) =>const LoginScreen(),
                },

              );
            },
          ),
        );
      },
      
    );
  }
}

