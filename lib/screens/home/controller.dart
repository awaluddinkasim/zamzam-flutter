import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zamzam/screens/home/view.dart';
import 'package:zamzam/shared/services/dio.dart';
import 'package:zamzam/shared/states/auth.dart';

abstract class HomeController extends ConsumerState<HomeScreen> {
  List daftarBarang = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBarang();
  }

  Future fetchBarang() async {
    final token = ref.read(authProvider)?.token;

    Response response = await Request.get("barang", token: token);
    if (response.statusCode == 200) {
      setState(() {
        daftarBarang = response.data['daftarBarang'];
        isLoading = false;
      });
    }
  }
}
