class Contact {

 late int id ;
 late String name ;
 late String phone ;

 Contact();

///تستخدم للقراءة من الداتا بيز
 Contact.fromMap(Map<String , dynamic> rowMap){
   id    = rowMap['id'];
   name  = rowMap['name'];
   phone = rowMap['phone'];
 }

 ///تستخدم لحفظ البيانات في الداتا بيز
 Map<String , dynamic> toMap(){
   Map<String , dynamic> rowMap = <String , dynamic>{};
     rowMap['name']  = name;
     rowMap['phone'] = phone;

     return rowMap;
 }
}