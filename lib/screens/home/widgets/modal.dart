import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:zamzam/models/cart_item.dart';
import 'package:zamzam/shared/constants.dart';
import 'package:zamzam/shared/states/cart.dart';

class BarangModal extends ConsumerStatefulWidget {
  const BarangModal({super.key, required this.barang});

  final Map barang;

  @override
  ConsumerState<BarangModal> createState() => _BarangModalState();
}

class _BarangModalState extends ConsumerState<BarangModal> {
  Map? selectedVariant;

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 320,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "${Constants.baseUrl}files/barang/${widget.barang['img']}",
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
            const SizedBox(
              height: 12,
            ),
            Text(
              widget.barang['nama'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'Rp. ${formatter.format(num.parse(widget.barang['harga'].toString()))}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              "Deskripsi",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              widget.barang['deskripsi'],
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              "Varian",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Wrap(
              spacing: 8,
              children: widget.barang['varian'].map<ChoiceChip>((variant) {
                return ChoiceChip(
                  label: Text(variant['nama']),
                  selected: selectedVariant == variant,
                  onSelected: (bool isSelected) {
                    setState(() {
                      if (isSelected) {
                        selectedVariant = variant;
                      } else {
                        selectedVariant = null;
                      }
                    });
                  },
                );
              }).toList(),
            ),
            FilledButton(
              onPressed: () {
                ref.read(cartProvider.notifier).addToCart(
                      CartItem(
                          uuid: const Uuid().v1(),
                          kode: widget.barang['kode'],
                          barang: widget.barang['nama'],
                          harga: int.parse(widget.barang['harga'].toString()),
                          varian: selectedVariant!,
                          qty: 1),
                    );
                Navigator.pop(context);
              },
              child: const Text("Tambah ke Keranjang"),
            ),
          ],
        ),
      ),
    );
  }
}
