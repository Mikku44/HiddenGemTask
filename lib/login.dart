import 'package:flutter/material.dart';
import 'package:test/db_/appDB.dart';
import 'package:test/main.dart';
import 'register.dart';
import 'package:email_validator/email_validator.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passController = TextEditingController();
  var msg = "";
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
                'เข้าสู่ระบบ',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 20),
              Text('Email / Username',
                  style: Theme.of(context).textTheme.bodyLarge),
              TextField(
                controller: usernameController,
                decoration:
                    const InputDecoration(hintText: "กรอกอีเมล์ผู้ใช้งาน"),
                
              ),
              const SizedBox(
                height: 20,
              ),
              Text('Password', style: Theme.of(context).textTheme.bodyLarge),
              TextField(
                controller: passController,
                obscureText: true,
               decoration:
                    const InputDecoration(hintText: "กรอกรหัสผู้ใช้งาน"),
           
              ),
              const SizedBox(
                height: 20,
              ),
              Text(msg),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()));
                },
                child: const Text(
                  "สมัครสมาชิก",
                  style: TextStyle(
                      decoration: TextDecoration.underline, color: Colors.blue),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 54,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (usernameController.text.isEmpty) {
                          msg = 'กรุณากรอกข้อมูลเพื่อเข้าใช้งาน';
                          setState(() {});
                          return;
                        }
                        if (!EmailValidator.validate(usernameController.text)) {
                          setState(() {
                            msg = 'อีเมลไม่ถูกต้อง';
                          });
                          return;
                        }

                        Future<bool> log =
                            fetch(usernameController.text, passController.text);
                        if (await log) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyHomePage(
                                      title: 'BMI Calculator')));
                        } else {
                          msg = 'มีบางอย่างไม่ถูกต้อง';
                          setState(() {});
                        }
                      },
                      child: const Text('เข้าสู่ระบบ'))),
            ],
          ),
        ),
      ),
    );
  }
}
