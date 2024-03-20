import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zamzam/auth/login/view.dart';
import 'package:zamzam/shared/services/dio.dart';
import 'package:zamzam/shared/states/auth.dart';

abstract class LoginController extends ConsumerState<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();

  String? error;
  bool showPassword = false;

  void login() async {
    final navigator = Navigator.of(context);

    Map data = {"email": email.text, "password": password.text};

    Response response = await Request.post("login", data);
    if (response.statusCode == 200) {
      ref.read(authProvider.notifier).login(
            response.data['user'],
            response.data['token'],
          );
    } else {
      navigator.pop();
      setState(() {
        error = response.data['message'];
      });
      // alert(context, status: "Gagal", msg: "Email atau Password salah");
    }
  }
}
