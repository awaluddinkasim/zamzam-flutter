import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zamzam/screens/profil_edit/view.dart';
import 'package:zamzam/shared/states/auth.dart';
import 'package:zamzam/shared/widgets/header.dart';
import 'package:zamzam/shared/widgets/menu.dart';

class ProfilScreen extends ConsumerStatefulWidget {
  const ProfilScreen({super.key});

  @override
  ConsumerState<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends ConsumerState<ProfilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Header(title: "Profil"),
          SvgPicture.asset(
            "assets/profile.svg",
            width: 300,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    userDetail(
                      "Nama Lengkap",
                      ref.watch(authProvider)!.user.nama,
                    ),
                    userDetail(
                      "Email",
                      ref.watch(authProvider)!.user.email,
                    ),
                    userDetail(
                      "Alamat",
                      ref.watch(authProvider)!.user.alamat,
                    ),
                    userDetail(
                      "No. HP",
                      ref.watch(authProvider)!.user.noHP,
                    ),
                    FilledButton.tonalIcon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ProfilEditScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit_note_outlined),
                      label: const Text("Edit"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
      drawer: const Menu(
        screen: "profile",
      ),
    );
  }

  Column userDetail(String label, String nama) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          nama,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
