import 'package:elancer_database_project/pref/shared_pref_controllar.dart';
import 'package:get/get.dart';

class LanguageGetxControllar extends GetxController{

 static LanguageGetxControllar get to => Get.find<LanguageGetxControllar>();

  RxString language = 'en'.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    language.value = SharedPrefControllar().language;
    super.onInit();
  }

  void changeLanguage (){
    language.value = language.value == 'en' ? 'ar' : 'en';
  }

}