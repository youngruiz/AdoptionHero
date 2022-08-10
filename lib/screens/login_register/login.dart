import 'package:adoption_hero/screens/login_register/register.dart';
import 'package:adoption_hero/screens/navigator_scaffold.dart';
import 'package:adoption_hero/widgets/error_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child:
      Scaffold(
      backgroundColor: Colors.green[50],
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
                    'Sign in',
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
                TextButton(
                  onPressed: () {
                    // forgot password screen
                  },
                  child: const Text('Forgot Password',),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: signInButton(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Don\'t have an account?'),
                    TextButton(
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const RegisterWidget()));
                      },
                    )
                  ],
                ),
              ],
            ),
          )),
    ));
  }

  Future<bool> signIn() async {
    try{
      await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _emailField.text.trim(), password: _passwordField.text.trim())
        .catchError((e){
          showDialog(
            context: context,
            builder: (BuildContext context){
              return errorAlertDialog(context, 'Error', e.toString());
            }
          );
        });
      return true;
    } catch(e){
      print(e.toString());
      return false;
    }
  }

  Widget emailField(){
    return TextFormField(
      controller: _emailField,
      autofocus: true,
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

  Widget signInButton(){
    return ElevatedButton(
      child: const Text('Login'),
      onPressed: () async {
        if(formKey.currentState!.validate()){
          formKey.currentState!.save();
          bool shouldNavigate = await signIn();
          if(shouldNavigate){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const NavigatorScaffold()));
          }
        }
      },
    );
  }
}



