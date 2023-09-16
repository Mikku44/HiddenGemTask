import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'db_/appDB.dart';
import 'models/userModel.dart';
import 'package:email_validator/email_validator.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final nameController = TextEditingController();
  final passController = TextEditingController();
  final vpassController = TextEditingController();
  final ageController = TextEditingController();
  var msg = '';
  @override
  void initState() {
    init();
    super.initState();
  }

  void validation() {
    if (usernameController.text.isEmpty) return;
    if(!EmailValidator.validate(usernameController.text)){
      setState(() {
        msg = 'อีเมลไม่ถูกต้อง';
      });
      return;
    }
    if (passController.text != vpassController.text) {
      setState(() {
        msg = 'รหัสผ่านไม่ตรงกัน';
      });
      return;
    };
    
    try{
      add(usernameController.text, nameController.text, passController.text, 0, ageController.text, DateTime.timestamp());
      Navigator.pop(context);
    }
    on Exception catch(e) {
      msg = 'มีบางอย่างผิดปกติ';
    }
    

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        elevation: 0,
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
              Text(
                'สมัครใช้งาน',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 20),
              Text('Email / Username',
                  style: Theme.of(context).textTheme.bodyLarge),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(hintText: "กรอกอีเมล์"),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              Text('Password', style: Theme.of(context).textTheme.bodyLarge),
              TextField(
                controller: passController,
                obscureText: true,
                decoration: const InputDecoration(hintText: "กรอกรหัสผ่าน"),
              
              ),
              const SizedBox(
                height: 20,
              ),
              Text('Confirm Password',
                  style: Theme.of(context).textTheme.bodyLarge),
              TextField(
                controller: vpassController,
                obscureText: true,
                decoration:
                    const InputDecoration(hintText: "กรอกยืนยันรหัสผ่าน"),
              
              ),
              const SizedBox(
                height: 20,
              ),
              Text('ชื่อผู้ใช้', style: Theme.of(context).textTheme.bodyLarge),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: "กรอกชื่อ"),
              
              ),
              const SizedBox(
                height: 20,
              ),
              Text('Age', style: Theme.of(context).textTheme.bodyLarge),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(hintText: "กรอกอายุ"),
                keyboardType: TextInputType.number,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 20,
                child: Text(msg),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 54,
                  child: ElevatedButton(
                      onPressed: () {
                        validation();
                      },
                      child: const Text('สมัครสมาชิก'))),
            ],
          ),
        ),
      ),
    );
  }
}
