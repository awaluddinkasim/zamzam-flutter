import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zamzam/screens/profil_edit/view.dart';
import 'package:zamzam/shared/services/dio.dart';
import 'package:zamzam/shared/states/auth.dart';

abstract class ProfilEditController extends ConsumerState<ProfilEditScreen> {
  final formKey = GlobalKey<FormState>();

  final nama = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final alamat = TextEditingController();
  final noHP = TextEditingController();

  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      nama.text = ref.read(authProvider)!.user.nama;
      email.text = ref.read(authProvider)!.user.email;
      alamat.text = ref.read(authProvider)!.user.alamat;
      noHP.text = ref.read(authProvider)!.user.noHP;
    });
  }

  Future update() async {
    final navigator = Navigator.of(context);
    final token = ref.read(authProvider)!.token;

    Map data = {
      "nama": nama.text,
      "email": email.text,
      "password": password.text,
      "alamat": alamat.text,
      "no_hp": noHP.text,
    };

    Response response = await Request.put('update-profile', data, token: token);
    if (response.statusCode == 200) {
      navigator.pop();
      ref.read(authProvider.notifier).updateUser(response.data['user']);
      navigator.pop();
    }
  }
}
