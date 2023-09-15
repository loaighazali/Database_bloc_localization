import 'package:elancer_database_project/database/controllars/db_opertionns.dart';
import 'package:elancer_database_project/database/db_controllar.dart';
import 'package:elancer_database_project/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDbControllar implements DbOperations<Contact> {
  final Database _database = DbControllar().database;

  @override
  Future<int> create(Contact object) async {
    // TODO: implement create
    return await _database.insert('contacts', object.toMap());
  }

  @override
  Future<bool> delete(int id) async {
    // TODO: implement delete
    int numberOfDeleted = await _database.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );

    return numberOfDeleted >0 ;
  }

  @override
  Future<List<Contact>> read() async{
    // TODO: implement read
    List<Map<String , dynamic>> rowsMap = await _database.query('contacts');
    return rowsMap.map((rowMap) => Contact.fromMap(rowMap)).toList();
  }

  @override
  Future<Contact?> show(int id) async {
    // TODO: implement show
    List<Map<String , dynamic>> rows = await _database.query(
      'contacts',
      where: 'id = ?',
        whereArgs: [id],
    );

    return rows.isNotEmpty ? Contact.fromMap(rows.first) : null ;
  }

  @override
  Future<bool> update(Contact object)async {
    // TODO: implement update
    int numberodUbdateRows = await _database.update(
        'contacts',
        object.toMap(),
        where: 'id = ?',
      whereArgs: [object.id]
    );

    return numberodUbdateRows >0;
  }
}
