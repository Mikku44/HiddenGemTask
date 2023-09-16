import 'dart:math';
import 'dart:developer' as console;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test/register.dart';
import 'firebase_options.dart';
import 'package:test/login.dart';
import 'db_/appDB.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

 
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hidden Gem task',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.blue,
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: logined
            ? const MyHomePage(title: 'BMI Calculator')
            : const LoginPage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  double _bmi = 0;
  String criteria = 'เกณฑ์ที่วัดได้';
  final PageController controller = PageController();
  final wController = TextEditingController();
  final hController = TextEditingController();
  var _riskColor = Colors.blue.shade300;
  void calBMI(weight, height) {
    _bmi = (weight / pow((height / 100), 2));

    if (_bmi < 18.5) {
      _riskColor = Colors.yellow.shade300;
      criteria = 'ช่วงน้ําหนักต่ํากว่าเกณฑ์';
    } else if (_bmi < 25) {
      _riskColor = Colors.green.shade300;
      criteria = 'ช่วงน้ําหนักที่ดีต่อสุขภาพ';
    } else if (_bmi < 30) {
      _riskColor = Colors.orange.shade300;
      criteria = 'ช่วงน้ําหนักมากกว่าเกณฑ์';
    } else {
      _riskColor = Colors.red.shade300;
      criteria = 'เสี่ยงเป็นโรคอ้วน';
    }
    console.log('$_bmi');
    
    setState(() {update('$_bmi');});
  }

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(widget.title),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("ชื่อ : ${user['name']} (${user['age']} ปี)",style: Theme.of(context).textTheme.bodySmall,),
                  
                    Text("BMI : ${user['lastBMI']}",style: Theme.of(context).textTheme.bodySmall,),
                  ],
                ),
                Text(
                  'โปรแกรมหาค่ามวลดัชณีร่างกาย (BMI)',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 20),
                Text('น้ำหนัก', style: Theme.of(context).textTheme.bodyLarge),
                TextField(
                  controller: wController,
                  decoration:
                      const InputDecoration(hintText: "กรอกน้ำหนัก (กิโลกรัม)"),
                  keyboardType: TextInputType.number,
                ),
                Text('ส่วนสูง', style: Theme.of(context).textTheme.bodyLarge),
                TextField(
                  controller: hController,
                  decoration: const InputDecoration(
                      hintText: "กรอกส่วนสูง (เซนติเมตร)"),
                  keyboardType: TextInputType.number,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    _bmi.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.headline4,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    criteria,
                    style: TextStyle(color: _riskColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 54,
                    child: ElevatedButton(
                        onPressed: () => calBMI(double.parse(wController.text),
                            double.parse(hController.text)),

                        child: const Text('คำนวณ'))),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            logined = false;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
          tooltip: 'Logout',
          child: const Icon(
            Icons.logout_rounded,
          ), 
        ));
  }
}
