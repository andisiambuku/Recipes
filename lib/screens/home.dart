import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes/main.dart';
import 'package:recipes/service/model.dart';

Future<Recipes> fetchRecipes() async {
  final response = await http.get(
    Uri.parse(
        'https://hf-android-app.s3-eu-west-1.amazonaws.com/android-test/recipes.json'),
  );

  if (response.statusCode == 200) {
    print(response.body.toString());
    var reponse;
    return Recipes.fromJson(jsonDecode(reponse.body));
  } else {
    throw Exception('Failed to load Recipes');
  }
}

void main() {
  var myHome = const MyHome();
  return runApp(myHome);
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late Future<Recipes> futureRecipes;
  @override
  Widget build(BuildContext context) {
    var data = 'Recipes';
    return MaterialApp(
      title: 'Recipes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(data),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<List<Recipes>>(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //return Text(snapshot.data!description);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
