import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:zamzam/models/cart_item.dart';
import 'package:zamzam/screens/cart/view.dart';
import 'package:zamzam/screens/orders/view.dart';
import 'package:zamzam/shared/services/dio.dart';
import 'package:zamzam/shared/states/auth.dart';
import 'package:zamzam/shared/states/cart.dart';

abstract class CartController extends ConsumerState<CartScreen> {
  final tanggal = TextEditingController();
  final hari = TextEditingController();

  List<CartItem> cartItems = [];
  DateTime? tanggalPenyewaan;

  double get totalPrice => cartItems.fold(0, (total, item) => total + item.harga * item.qty);

  Future order() async {
    final navigator = Navigator.of(context);
    final token = ref.read(authProvider)!.token;
    final cartNotifier = ref.read(cartProvider.notifier);

    Map data = {
      "hari": hari.text,
      "tgl_penyewaan": tanggalPenyewaan.toString(),
      "items": cartItems.map((e) => e.toJson()).toList(),
    };

    Response response = await Request.post('orders', data, token: token);
    if (response.statusCode == 200) {
      cartNotifier.clearCart();
    }
    navigator.pop();
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const OrderScreen(),
      ),
      (route) => false,
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (picked != null && picked != tanggalPenyewaan) {
      tanggalPenyewaan = picked;
      setState(() {
        tanggal.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }
}
