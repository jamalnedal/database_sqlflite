import 'package:sqflite/sqflite.dart';
import 'package:vp9_database/database/db_controller.dart';
import 'package:vp9_database/database/db_operations.dart';
import 'package:vp9_database/models/contact.dart';

class ContactDbController implements DbOperations<Contact> {
  final Database _database = DbController().database;

  @override
  Future<int> create(Contact object) async {
    // INSERT INTO contacts (name, phone) VALUES ('NAME','123123');
    return await _database.insert('contacts', object.toMap());
  }

  @override
  Future<bool> delete(int id) async {
    // DELETE FROM contacts;
    // DELETE FROM contacts WHERE id = 1;
    int numberOfDeletedRows =
        await _database.delete('contacts', where: 'id = ?', whereArgs: [id]);
    return numberOfDeletedRows > 0;
  }

  @override
  Future<List<Contact>> read() async{
    // SELECT * FROM contacts;
    List<Map<String, dynamic>> rows = await _database.query('contacts');
    return rows.map((rowMap) => Contact.fromMap(rowMap)).toList();
  }

  @override
  Future<Contact?> show(int id)async {
    // SELECT * FROM contacts WHERE id = 1;
    List<Map<String, dynamic>> rows =await _database.query('contacts',where: 'id = ?',whereArgs: [id]);
    return rows.isNotEmpty ? Contact.fromMap(rows.first) : null;
  }

  @override
  Future<bool> update(Contact object) async {
    // UPDATE contacts SET name = 'NEW NAME' WHERE id = 1;
    int numberOfUpdatedRows = await _database.update('contacts', object.toMap(),
        where: 'id = ?', whereArgs: [object.id]);
    return numberOfUpdatedRows > 0;
  }
}
