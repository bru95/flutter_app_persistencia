import 'package:flutter/material.dart';
import 'package:flutterapppersistencia/sqlite/add.dart';
import 'package:flutterapppersistencia/sqlite/model/person.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ListPerson extends StatefulWidget {
  @override
  _ListPersonState createState() => _ListPersonState();
}

class _ListPersonState extends State<ListPerson> {

  List<Person> personList = List();
  Database _database;

  @override
  void initState() {
    super.initState();
    getDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pessoas"),
        actions: <Widget>[
          if (_database != null) IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Future<Person> future = Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPerson(),
                  ));
              future.then((person) {
                if (person != null) insertPerson(person);
              });
            },
          )
        ],
      ),
      body: ListView.separated(
        itemCount: personList.length,
        itemBuilder: (context, index) => getListItem(index),
        separatorBuilder: (context, index) => Divider(
          height: 1,
        ),
      ),
    );
  }

  Widget getListItem(int index) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        leading: Text("${personList[index].id}"),
        title: Text(personList[index].firstName),
        subtitle: Text(personList[index].lastName),
        onLongPress: (){
          deletePerson(index);
        },
      ),
    ),
  );

  getDatabase() async {
    openDatabase(
        join(await getDatabasesPath(), 'person_database.db'),
        onCreate: (db, version)
        {
          return db.execute(
            "CREATE TABLE person(id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT)",
          );
        },
        version: 1
    ).then((db) {
      setState(() {
        _database = db;
      });

      readAll();
    });
  }

  readAll() async {
    final List<Map<String, dynamic>> maps = await _database.query('person');

    personList = List.generate(maps.length, (i) {
      return Person(
        id: maps[i]['id'],
        firstName: maps[i]['firstName'],
        lastName: maps[i]['lastName'],
      );
    });

    setState(() {});
  }

  insertPerson(Person person) async {
    await _database.insert(
      'person',
      person.toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    ).then((value) {
      person.id = value;
      setState(() {
        personList.add(person);
      });
    });
  }

  deletePerson(int index) async {
    await _database.delete(
      'person',
      where: "id = ?",
      whereArgs: [personList[index].id],
    ).then((value) {
      setState(() {
        personList.removeAt(index);
      });
    });
  }

}
