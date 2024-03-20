import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zamzam/shared/widgets/header.dart';
import 'package:zamzam/shared/widgets/menu.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Header(title: "Tentang"),
          SvgPicture.asset(
            "assets/about.svg",
            width: 400,
          ),
          const Padding(
            padding: EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                    "Aplikasi Zam Zam adalah solusi praktis untuk membantu Anda merencanakan pernikahan yang sempurna. Kami menyediakan berbagai perlengkapan pengantin yang Anda butuhkan, mulai dari gaun pengantin, jas pengantin, aksesoris, hingga dekorasi pernikahan."),
                Text(
                    "Nikmati kemudahan dalam mempersiapkan hari istimewa Anda bersama Aplikasi Pesta Pernikahan. Jika ada pertanyaan atau saran, jangan ragu untuk menghubungi kami. Terima kasih!"),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Pemilik",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Hj. Marni"),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Kontak",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Whatsapp : "),
                    Expanded(
                      child: Text("081242433683"),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Alamat : "),
                    Expanded(
                      child: Text(
                          "Jl. Sukamaju II no. 8 Tamamaung, Kec. Panakkukang, Kota Makassar, Sulawesi Selatan"),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      drawer: const Menu(
        screen: "about",
      ),
    );
  }
}
