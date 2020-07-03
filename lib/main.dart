import 'package:flutter/material.dart';
import 'package:flutterapppersistencia/firebase/list.dart';
import 'package:flutterapppersistencia/nosql/list.dart';
import 'package:flutterapppersistencia/sqlite/list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/sqlite': (context) => ListPerson(),
        '/nosql': (context) => ListBooks(),
        '/firebase': (context) => ListCars(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter - Persistência"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("SQLite"),
            subtitle: Text("Lista de Pessoas"),
            leading: Icon(Icons.developer_mode),
            trailing: Icon(Icons.navigate_next),
            onTap: (){
              Navigator.pushNamed(context, '/sqlite');
            },
          ),

          ListTile(
            title: Text("NoSQL"),
            subtitle: Text("Lista de livros"),
            leading: Icon(Icons.developer_mode),
            trailing: Icon(Icons.navigate_next),
            onTap: (){
              Navigator.pushNamed(context, '/nosql');
            },
          ),
          ListTile(
            title: Text("Firebase"),
            subtitle: Text("Lista de carros"),
            leading: Icon(Icons.developer_mode),
            trailing: Icon(Icons.navigate_next),
            onTap: (){
              Navigator.pushNamed(context, '/firebase');
            },
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
