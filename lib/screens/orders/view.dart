import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zamzam/screens/order_detail/view.dart';
import 'package:zamzam/screens/orders/controller.dart';
import 'package:zamzam/shared/widgets/header.dart';
import 'package:zamzam/shared/widgets/menu.dart';
import 'package:badges/badges.dart' as badges;

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends OrderController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: fetchOrders,
        child: ListView(
          children: [
            const Header(title: "Pesanan Saya"),
            if (isLoading)
              const SizedBox(
                height: 600,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            if (orders.isEmpty)
              const SizedBox(
                height: 600,
                child: Center(
                  child: Text("Tidak ada data"),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var order in orders)
                      Card(
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(
                                    MaterialPageRoute(
                                      builder: (context) => OrderDetailScreen(
                                        order: order,
                                      ),
                                    ),
                                  )
                                  .then(
                                    (value) => fetchOrders(),
                                  );
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              'Tanggal Penyewaan: ${order['tgl_penyewaan']}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'Jumlah Barang: ${order['items'].length}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(Icons.chevron_right_rounded),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    child: Divider(),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Status: ${order['status']}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      if (order['tgl_selesai'] != null)
                                        badges.Badge(
                                          badgeContent: Text(
                                            '${order['tgl_selesai']}',
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,
                                            ),
                                          ),
                                          badgeStyle: badges.BadgeStyle(
                                            badgeColor: Colors.green,
                                            shape: badges.BadgeShape.square,
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              )
          ],
        ),
      ),
      drawer: const Menu(
        screen: "orders",
      ),
    );
  }
}
