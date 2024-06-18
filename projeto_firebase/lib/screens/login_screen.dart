import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_firebase/services/auth_firebase.dart';

import 'todolist_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthFirebase _authFirebase = AuthFirebase();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
              ),
              ElevatedButton(
                onPressed: () {_loginUsuario();}
                ,
                child: const Text('Entrar'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/registro');
                },
                child: const Text('Cadastrar'),
              ),
            ],),
        ),),
    );
  }
  
  Future<void> _loginUsuario() async{
    if (_formKey.currentState!.validate()) {
      try {
        User? user = await _authFirebase.signIn(_emailController.text, _passwordController.text);
        if (user != null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> TodolistScreen(user: user)));
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Usuário ou senha inválidos'),
            ),
          );
        }
        
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }
}