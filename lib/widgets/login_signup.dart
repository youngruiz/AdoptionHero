import 'package:adoption_hero/app.dart';
import 'package:adoption_hero/widgets/db_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginSignup extends StatefulWidget {
  const LoginSignup({Key? key}) : super(key: key);

  @override
  State<LoginSignup> createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.blueAccent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              controller: _emailField,
              decoration: const InputDecoration(
                hintText: "something@gmail.com",
                hintStyle: TextStyle(color: Colors.white),
                labelText: "Email",
                labelStyle: TextStyle(
                  color: Colors.white
                )
              ),
            ),
            TextFormField(
              controller: _passwordField,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "password",
                hintStyle: TextStyle(color: Colors.white),
                labelText: "Password",
                labelStyle: TextStyle(
                  color: Colors.white
                )
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white
              ),
              child: MaterialButton(
                onPressed: () async {
                  bool shouldNavigate = await register(_emailField.text, _passwordField.text);
                  if (shouldNavigate){
                    // ignore: use_build_context_synchronously
                    Navigator
                    .push(context, 
                    MaterialPageRoute(
                      builder: (context) => const DbTestApp()
                      ));
                  }
                },
                child: const Text("register") 
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white
              ),
              child: MaterialButton(
                onPressed: () async {
                  bool shouldNavigate = await signIn(_emailField.text, _passwordField.text);
                  if (shouldNavigate){
                    // ignore: use_build_context_synchronously
                    Navigator
                    .push(context, 
                    MaterialPageRoute(
                      builder: (context) => const DbTestApp()
                      ));
                  }
                },
                child: const Text("login") 
              ),
            ),
          ],
        )
      ),
    );
  }
}

Future<bool> signIn(String email, String password) async {
  try{
    await FirebaseAuth.instance
    .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch(e){
    print(e.toString());
    return false;
  }
}

Future<bool> register(String email, String password) async {
  try{
    await FirebaseAuth.instance
    .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if(e.code == 'weak-password'){
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use'){
      print('The account already exists for that email.');
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}