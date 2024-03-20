class CartItem {
  final String uuid;
  final String kode;
  final String barang;
  final int harga;
  final Map varian;
  int qty;

  CartItem({
    required this.uuid,
    required this.kode,
    required this.barang,
    required this.harga,
    required this.varian,
    required this.qty,
  });

  CartItem copyWith(
      {String? uuid, String? kode, String? barang, int? harga, Map? varian, int? qty}) {
    return CartItem(
      uuid: uuid ?? this.uuid,
      kode: kode ?? this.kode,
      barang: barang ?? this.barang,
      harga: harga ?? this.harga,
      varian: varian ?? this.varian,
      qty: qty ?? this.qty,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "kode": kode,
      "barang": barang,
      "harga": harga,
      "varian": varian,
      "qty": qty,
    };
  }
}
