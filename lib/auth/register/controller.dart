import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zamzam/auth/register/view.dart';
import 'package:zamzam/shared/services/dio.dart';

abstract class RegisterController extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final nama = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final alamat = TextEditingController();
  final noHP = TextEditingController();

  String? message;
  bool showPassword = false;

  Future register() async {
    final navigator = Navigator.of(context);

    Map data = {
      "nama": nama.text,
      "email": email.text,
      "password": password.text,
      "alamat": alamat.text,
      "no_hp": noHP.text,
    };

    Response response = await Request.post('register', data);
    if (response.statusCode == 200) {
      setState(() {
        message = response.data['message'];
      });
      navigator.pop();
      navigator.pop();
    }
  }
}
