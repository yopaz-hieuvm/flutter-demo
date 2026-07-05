import 'package:flutter/material.dart';
import 'package:flutter_demo/Widgets/my_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(padding: EdgeInsets.all(16.0), child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration:  InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.visibility)
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            SizedBox(
              child: MyButton(onTap: (){} , buttontext: 'Sign Up', color: Colors.blueAccent)
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    // Navigate to the login screen
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}