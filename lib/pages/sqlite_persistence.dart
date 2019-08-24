import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

class Dog {
    final int id;
    final String name;
    final int age;

    Dog({this.id, this.name, this.age});

    Map<String, dynamic> toMap() {
      return {
        'id': id,
        'name': name,
        'age': age,
      };
  }
}

  Future<Database> getDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), 'doggie_database.db'),
    version: 1,
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
      );
    });
  }

  final Future<Database> database = getDatabase();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  Future<void> insertDog(Dog dog) async {
    final Database db = await database;

    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateDog(Dog dog) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'dogs',
      dog.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [dog.id],
    );
  }

  Future<List<Dog>> getDogs() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('dogs');
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    var list = List.generate(maps.length, (i) {
      return Dog(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
    return list;
  }

class SqlitePage extends StatefulWidget{
  @override
  SqliteState createState() => SqliteState();
}

class SqliteState extends State<SqlitePage>{


  Future<void> deleteDog(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the Database.
    await db.delete(
      'dogs',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
  
  Future<List<Dog>> dogs;
  int dogToUpdate;

  @override
  Widget build(context){
    return Scaffold(
      body: 
      Center(
        child: 
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Form(
                  child: TextFormField(
                    controller: _nameController ,
                    decoration: InputDecoration(labelText: "Dog's name"),
                  ),
                ),
                Form(
                  child: TextFormField(
                    controller: _ageController ,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Dog's age"),
                  ),
                ),
                RaisedButton(
                  child: Text("Send!"),
                  onPressed: () {_saveDog();},
                ),
                FutureBuilder<List<Dog>>(
                  future: dogs,
                  builder: (context, snapshot) {
                    print(snapshot.hasData);
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          shrinkWrap: true,
                          itemBuilder: (context, i){
                            print(snapshot.data[i].name);
                            return Dismissible(
                              key: Key(snapshot.data[i].id.toString()),
                                onDismissed: (direction) {
                                    dogs.then((res){
                                      res.remove(snapshot.data[i]);
                                    });

                                    deleteDog(snapshot.data[i].id);
                                  },
                                  // Show a red background as the item is swiped away.
                                background: Container(color: Colors.red),
                                child: ListTile(
                                  onTap: (){ 
                                    setState(() {
                                      dogToUpdate = snapshot.data[i].id;
                                    });
                                    _nameController.text = snapshot.data[i].name;
                                    _ageController.text = snapshot.data[i].age.toString();
                                  },
                                  title: Text("Name: ${snapshot.data[i].name}, Age: ${snapshot.data[i].age}"),
                                )
                            );
                          }
                        )
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    // By default, show a loading spinner.
                    return Center(child: CircularProgressIndicator());
                  },
            ),
          ])
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getDogs,
        tooltip: 'Get dogs',
        child: Icon(Icons.refresh),
      ), 
    );
  }

  _saveDog () {
    if(dogToUpdate == 0){
      insertDog(new Dog(
          name: _nameController.text,
          age: int.parse(_ageController.text) 
      ));
    }else{
      updateDog(new Dog(
          id: dogToUpdate,
          name: _nameController.text,
          age: int.parse(_ageController.text) 
      ));
      dogToUpdate = 0;
    }
  }

  _getDogs () {
    dogs = getDogs();
  }
}

