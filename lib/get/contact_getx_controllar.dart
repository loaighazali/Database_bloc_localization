import 'package:get/get.dart';

import '../database/controllars/contact_db_controllar.dart';
import '../models/contact.dart';

class ContactGetxControllar extends GetxController {
  RxList<Contact> contacts = <Contact>[].obs;

  RxBool loading = false.obs ;

  final ContactDbControllar _dbControllar = ContactDbControllar();

  static ContactGetxControllar get to => Get.find();

  @override
  void onInit() {
    read();
    super.onInit();
  }

  Future<void> read () async {
    loading.value = true ;
    contacts.value = await _dbControllar.read();
    loading.value = false ;
   // update();
  }

  Future<bool> create (Contact contact) async {
    int newRowId = await _dbControllar.create(contact);
    if(newRowId !=0){
      contact.id = newRowId;
      contacts.add(contact);
     // update();
    }
    return newRowId !=0 ;
  }

  Future<bool> delete(int id) async {
    bool deleted = await _dbControllar.delete(id);

    if(deleted){
      contacts.removeWhere((contact) => contact.id == id );
      //update();
    }

    return deleted ;
  }


  Future<bool> updateContact (Contact contact) async {
    bool updated = await _dbControllar.update(contact);

    if(updated){
      int index = contacts.indexWhere((element) => element.id == contact.id);
      if(index != -1) {
        contacts[index] == contact ;
       // update();
      }
    }

    return updated ;
  }


}