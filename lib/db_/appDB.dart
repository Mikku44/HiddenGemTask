import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:crypto/crypto.dart';
import 'dart:math';
import 'dart:io';
import 'dart:convert';
import '../models/userModel.dart';

FirebaseDatabase database = FirebaseDatabase.instance;
var user;
var logined = false;
var key;
void init() {
  final firebaseApp = Firebase.app();
  final rtdb = FirebaseDatabase.instanceFor(
      app: firebaseApp,
      databaseURL:
          'https://bmical-81330-default-rtdb.asia-southeast1.firebasedatabase.app');
}

Future<bool> fetch(name, pass) async {
  key = md5.convert(utf8.encode(name + pass)).toString();
  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('Users/$key').get();
  logined = true;
  if (snapshot.exists) {
    user = snapshot.value as Map;

    print(snapshot.value);


    return true;
  } else {
    print('No data available.');
    return false;
  }
}

void add(username, name, pass, bmi, age, time) async {
  String key = md5.convert(utf8.encode(username + pass)).toString();
  print(key);

  await database
      .ref('/Users/${key}')
      .set(User(username, name, pass, bmi, age, time));
}

void update(bmi) async {
  final data = {
        'lastBMI': '$bmi',
        'updated_at': '${DateTime.timestamp()}',

    };
  print(key);
  await database.ref('/Users/$key').update(data);
  fetch(user['username'], user['password']);
}
