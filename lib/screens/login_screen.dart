import 'package:elancer_database_project/get/language_getx_controllar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widget/app_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

 late TextEditingController _emailEditingController ;
 late TextEditingController _passwordEditingController ;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          AppLocalizations.of(context)!.login,
          style: TextStyle(
            color: Colors.black,
            fontSize: 30.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor:  Colors.cyan,
        onPressed: (){
          LanguageGetxControllar.to.changeLanguage();

        },
        child:const Icon(Icons.language , color: Colors.black),
      ),

      body: ListView(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
        physics:const NeverScrollableScrollPhysics(),
        children: [

           SizedBox(height: 150.h,),

          Text(
            AppLocalizations.of(context)!.welcome,
            style: TextStyle(
              fontSize: 25.sp,
              color: Colors.black
            ),
          ),

           SizedBox(height: 50.h,),

          AppTextField(
            textEditingController: _emailEditingController,
            hint: AppLocalizations.of(context)!.email,
            prefixIcon: Icons.person,
          ),

           SizedBox(height: 50.h,),

          AppTextField(
            textEditingController: _passwordEditingController,
            hint: AppLocalizations.of(context)!.password,
            prefixIcon: Icons.phone,
          ),

           SizedBox(height: 80.h,),

          ElevatedButton(
            onPressed: () => login() ,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan
            ),
            child: Text(
              AppLocalizations.of(context)!.login,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void login(){
   Navigator.pushReplacementNamed(context, '/main_screen');
  }
}
