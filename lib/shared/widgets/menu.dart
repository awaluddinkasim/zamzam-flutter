import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zamzam/auth/login/view.dart';
import 'package:zamzam/screens/about/view.dart';
import 'package:zamzam/screens/home/view.dart';
import 'package:zamzam/screens/orders/view.dart';
import 'package:zamzam/screens/profil/view.dart';
import 'package:zamzam/shared/services/dio.dart';
import 'package:zamzam/shared/utils.dart';
import 'package:zamzam/shared/states/auth.dart';

class Menu extends ConsumerStatefulWidget {
  const Menu({super.key, required this.screen});

  final String screen;

  @override
  ConsumerState<Menu> createState() => _MenuState();
}

class _MenuState extends ConsumerState<Menu> {
  Future _logout() async {
    final navigator = Navigator.of(context);
    final token = ref.read(authProvider)!.token;

    Response response = await Request.get('logout', token: token);
    if (response.statusCode == 200) {
      ref.read(authProvider.notifier).logout();
    } else {
      navigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    if (auth == null) {
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
            return const LoginScreen();
          }),
          (route) => false,
        );
      });
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Zam Zam',
                  style: TextStyle(
                    fontSize: 38,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Salon & Rumah Pengantin',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            selected: widget.screen == "home" ? true : false,
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              if (widget.screen != "home") {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            selected: widget.screen == "orders" ? true : false,
            leading: const Icon(Icons.receipt),
            title: const Text('Pesanan Saya'),
            onTap: () {
              if (widget.screen != "orders") {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const OrderScreen(),
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            selected: widget.screen == "profile" ? true : false,
            leading: const Icon(Icons.person),
            title: const Text('Profil'),
            onTap: () {
              if (widget.screen != "profile") {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfilScreen(),
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            selected: widget.screen == "about" ? true : false,
            leading: const Icon(Icons.info),
            title: const Text('Tentang'),
            onTap: () {
              if (widget.screen != "about") {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AboutScreen(),
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              loading(context);
              _logout();
            },
          ),
        ],
      ),
    );
  }
}
