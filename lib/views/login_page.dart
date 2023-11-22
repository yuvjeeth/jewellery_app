import 'package:flutter/material.dart';
import 'package:jewellery_app/views/product_catalog.dart';
import 'package:jewellery_app/views/signup_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: const AssetImage("assets/images/welcome_bg.jpg"),
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.7),
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            elevation: 8.0,
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    width: 300,
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
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
                  const SizedBox(
                    width: 300,
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      decoration: InputDecoration(
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
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductCatalog(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('New user? '),
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: const Text(
                          ' Sign up now',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
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
