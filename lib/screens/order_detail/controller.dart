import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zamzam/screens/order_detail/view.dart';
import 'package:zamzam/shared/services/dio.dart';
import 'package:zamzam/shared/states/auth.dart';

abstract class OrderDetailController extends ConsumerState<OrderDetailScreen> {
  Map order = {};

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrder();
  }

  Future fetchOrder() async {
    final token = ref.read(authProvider)?.token;

    Response response = await Request.get('orders/${widget.order['id']}', token: token);
    if (response.statusCode == 200) {
      setState(() {
        order = response.data['order'];
        isLoading = false;
      });
    }
  }
}
