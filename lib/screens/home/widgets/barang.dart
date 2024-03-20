import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zamzam/screens/home/widgets/modal.dart';
import 'package:zamzam/shared/constants.dart';

class BarangCard extends StatelessWidget {
  final Map barang;

  const BarangCard({super.key, required this.barang});

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat();

    return Card(
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                builder: (context) {
                  return BarangModal(barang: barang);
                });
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 220,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    "${Constants.baseUrl}files/barang/${barang['img']}",
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      barang['nama'],
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text('Rp. ${formatter.format(num.parse(barang['harga'].toString()))}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
