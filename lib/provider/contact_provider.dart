import 'package:elancer_database_project/database/controllars/contact_db_controllar.dart';
import 'package:elancer_database_project/database/db_controllar.dart';
import 'package:elancer_database_project/models/contact.dart';
import 'package:flutter/material.dart';

class ContactProvider extends ChangeNotifier{

  List<Contact> contacts = <Contact>[];

 final ContactDbControllar _dbControllar = ContactDbControllar();

 Future<void> read () async {
   contacts = await _dbControllar.read();
   notifyListeners();
 }

 Future<bool> create (Contact contact) async {
   int newRowId = await _dbControllar.create(contact);
   if(newRowId !=0){
     contact.id = newRowId;
     contacts.add(contact);
     notifyListeners();
   }
   return newRowId !=0 ;
 }

 Future<bool> delete(int id) async {
    bool deleted = await _dbControllar.delete(id);

    if(deleted){
      contacts.removeWhere((contact) => contact.id == id );
      notifyListeners();
    }

    return deleted ;
 }


 Future<bool> update (Contact contact) async {
   bool updated = await _dbControllar.update(contact);

   if(updated){
     int index = contacts.indexWhere((element) => element.id == contact.id);
     if(index != -1) {
       contacts[index] == contact ;
       notifyListeners();
     }
   }

   return updated ;
 }

}