import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:zamzam/screens/order_detail/controller.dart';
import 'package:zamzam/screens/order_detail/widgets/modal.dart';
import 'package:zamzam/shared/constants.dart';

class OrderDetailScreen extends ConsumerStatefulWidget {
  const OrderDetailScreen({super.key, required this.order});

  final Map order;

  @override
  ConsumerState<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends OrderDetailController {
  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pesanan'),
      ),
      body: ListView(
        children: [
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text("Tanggal Penyewaan"),
                          ),
                          Text(order['tgl_penyewaan']),
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: Text("Total Harga"),
                          ),
                          Text(
                              "Rp. ${formatter.format(num.parse(order['total_harga'].toString()))}"),
                        ],
                      ),
                      if (order['status'] == "Belum Lunas")
                        Row(
                          children: [
                            const Expanded(
                              child: Text("Sisa Pembayaran"),
                            ),
                            Text("Rp. ${formatter.format(num.parse(order['sisa'].toString()))}"),
                          ],
                        ),
                      Row(
                        children: [
                          const Expanded(
                            child: Text("Status"),
                          ),
                          Text(order['status']),
                        ],
                      ),
                      if (order['tgl_selesai'] != null)
                        Row(
                          children: [
                            const Expanded(
                              child: Text("Tanggal Selesai"),
                            ),
                            Text(order['tgl_selesai']),
                          ],
                        ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Daftar Barang",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Table(
                        border: TableBorder.all(width: 1),
                        children: [
                          const TableRow(
                            children: [
                              Text(
                                "Barang",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Varian",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Harga",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Total",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          for (var item in order['items'])
                            TableRow(
                              children: [
                                Text("${item['varian']['barang']['nama']}"),
                                Text("${item['varian']['nama']} x ${item['qty']}"),
                                Text(
                                    "Rp. ${formatter.format(num.parse(item['varian']['barang']['harga'].toString()))}"),
                                Text(
                                    "Rp. ${formatter.format(num.parse(item['qty'].toString()) * num.parse(item['varian']['barang']['harga'].toString()))}"),
                              ],
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Subtotal",
                              textAlign: TextAlign.end,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                              "Rp. ${formatter.format(num.parse(order['subtotal_harga'].toString()))}"),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Total selama ${order['hari']} hari",
                              textAlign: TextAlign.end,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                              "Rp. ${formatter.format(num.parse(order['total_harga'].toString()))}"),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (order['payments'].length > 0)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "Data Pembayaran",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Table(
                              border: TableBorder.all(width: 1),
                              children: [
                                const TableRow(
                                  children: [
                                    Text(
                                      "Tanggal Upload",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Nominal",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                for (var payment in order['payments'])
                                  TableRow(
                                    children: [
                                      Text("${payment['tanggal_upload']}"),
                                      Text(
                                          "Rp. ${formatter.format(num.parse(payment['nominal'].toString()))}"),
                                      Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.stretch,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        const Text(
                                                          "Bukti Pembayaran",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        Image.network(
                                                            "${Constants.baseUrl}files/payments/${payment['bukti_pembayaran']}"),
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(vertical: 4),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 9),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).primaryColor,
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: const Text(
                                              "Buka",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (order['status'] == 'Belum Lunas')
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 30,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    "Silahkan transfer pembayaran ke rekening berikut",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Bank : ",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${rekening['bank']}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    child: Row(
                                      children: [
                                        const Text(
                                          "No. Rekening : ",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${rekening['nomor']}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FilledButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                  ),
                                  builder: (context) {
                                    return UploadModal(
                                      order: order,
                                    );
                                  },
                                ).then((e) {
                                  fetchOrder();
                                });
                              },
                              child: const Text("Upload Bukti Pembayaran"),
                            ),
                          ],
                        ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
