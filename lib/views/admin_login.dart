import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jewellery_app/views/admin_portal.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  @override
  Widget build(BuildContext context) {
    TextEditingController uName = TextEditingController();
    TextEditingController uPassword = TextEditingController();
    FocusNode name = FocusNode();
    FocusNode password = FocusNode();
    return GestureDetector(
      onTap: () {
        name.unfocus();
        password.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Material(
            elevation: 10,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: SizedBox(
              height: 300,
              width: 320,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Admin Login',
                        style: TextStyle(fontSize: 22),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: uName,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                        floatingLabelStyle: TextStyle(color: Colors.deepPurple),
                        labelText: 'Username',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: uPassword,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: password,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                        floatingLabelStyle: TextStyle(color: Colors.deepPurple),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.pushAndRemoveUntil(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const AdminPortal(),
                      //   ),
                      //   (Route<dynamic> route) => false,
                      // );
                      if (uName.text == 'admin' && uPassword.text == 'admin') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminPortal(),
                          ),
                        );
                        uName.clear();
                        uPassword.clear();
                        if (kDebugMode) {
                          print('Great Success');
                        }
                      } else {
                        AlertDialog alert = AlertDialog(
                          title: const Row(
                            children: [
                              Text('Error'),
                            ],
                          ),
                          content:
                              const Text('Username or Password is incorrect'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                uName.clear();
                                uPassword.clear();
                              },
                              child: const Text(
                                'OK',
                                style: TextStyle(color: Colors.deepPurple),
                              ),
                            ),
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
