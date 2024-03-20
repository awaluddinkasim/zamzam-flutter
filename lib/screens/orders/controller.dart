import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zamzam/screens/orders/view.dart';
import 'package:zamzam/shared/services/dio.dart';
import 'package:zamzam/shared/states/auth.dart';

abstract class OrderController extends ConsumerState<OrderScreen> {
  List orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future fetchOrders() async {
    setState(() {
      isLoading = true;
    });

    final token = ref.read(authProvider)?.token;

    Response response = await Request.get('orders', token: token);
    if (response.statusCode == 200) {
      setState(() {
        orders = response.data['orders'];
      });
    }
    setState(() {
      isLoading = false;
    });
  }
}
