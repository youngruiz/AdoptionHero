import 'package:adoption_hero/screens/add_user.dart';
import 'package:adoption_hero/screens/navigator_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adoption_hero/screens/login.dart';
import 'package:flutter/services.dart';



class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {

  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();

  @override
  void dispose(){
    _emailField.dispose();
    _passwordField.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Icon(Icons.pets_rounded),
        backgroundColor: Colors.green[100],
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Adoption Hero',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 20),
                  )
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: emailField(),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: passwordField(),
                ),
                Container(
                  height: 40,
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: registerButton(),
                ),
                signInLink(),
            ],
          )
        ),
      )
    );
  }

  Future<bool> register() async {
    try{
      await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: _emailField.text.trim(), password: _passwordField.text.trim());
      print("Registered");
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
    }
    return false;
  }

  Widget emailField(){
    return TextFormField(
      controller: _emailField,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Email Address',
      ),
      validator: (value) {
        if(value!.isEmpty || !value.contains('@')){
          return 'Please enter a valid email address';
        } else {
          return null;
        }
      },
    );
  }

  Widget passwordField(){
    return TextFormField(
      obscureText: true,
      controller: _passwordField,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Password',
      ),
      validator: (value) {
        if(value!.isEmpty){
          return 'Password cannot be empty';
        } else {
          return null;
        }
      },
    );
  }

  Widget registerButton(){
    return ElevatedButton(
      child: const Text('Register'),
      onPressed: () async {
        if(formKey.currentState!.validate()){
          formKey.currentState!.save();
          bool shouldNavigate = await register();
          if(shouldNavigate){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AddUser()));
          }
        }
      },
    );
  }

  Widget signInLink(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Already have an account?'),
        TextButton(
          child: const Text(
            'Sign in',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginWidget()));
          },
        )
      ],
    );
  }
}