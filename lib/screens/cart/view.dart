import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:zamzam/screens/cart/controller.dart';
import 'package:zamzam/shared/utils.dart';
import 'package:zamzam/shared/widgets/input_label.dart';
import 'package:zamzam/shared/states/cart.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends CartController {
  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat();
    final cartNotifier = ref.watch(cartProvider.notifier);

    cartItems = ref.watch(cartProvider).cartItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
      ),
      body: cartItems.isNotEmpty
          ? ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text("${item.barang} - ${item.varian['nama']}"),
                  subtitle: Text('Harga: Rp. ${formatter.format(item.harga)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          cartNotifier.updateItemQuantity(item, item.qty - 1);
                        },
                      ),
                      Text(item.qty.toString()),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          cartNotifier.updateItemQuantity(item, item.qty + 1);
                        },
                      ),
                    ],
                  ),
                );
              },
            )
          : const Center(
              child: Text('Keranjang Anda kosong'),
            ),
      bottomSheet: cartItems.isNotEmpty
          ? Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const InputLabel(label: "Tanggal Penyewaan"),
                            TextField(
                              onTap: () {
                                selectDate(context);
                              },
                              controller: tanggal,
                              readOnly: true,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      SizedBox(
                        width: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const InputLabel(label: "Jumlah Hari"),
                            TextField(
                              controller: hari,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: Rp. ${formatter.format(totalPrice)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      FilledButton(
                        onPressed: () {
                          loading(context);
                          order();
                        },
                        child: const Text('Pesan'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
