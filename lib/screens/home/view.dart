import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zamzam/screens/cart/view.dart';
import 'package:zamzam/screens/home/controller.dart';
import 'package:zamzam/screens/home/widgets/barang.dart';
import 'package:zamzam/shared/widgets/header.dart';
import 'package:zamzam/shared/widgets/menu.dart';
import 'package:badges/badges.dart' as badges;
import 'package:zamzam/shared/states/cart.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends HomeController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: fetchBarang,
        child: ListView(
          children: [
            Header(
              title: "Home",
              widget: badges.Badge(
                position: badges.BadgePosition.topEnd(top: 0, end: 25),
                badgeContent: Text(
                  "${ref.watch(cartProvider).cartItems.length}",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const CartScreen()),
                    );
                  },
                  icon: Icon(
                    CupertinoIcons.bag_fill,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            if (isLoading)
              const SizedBox(
                height: 600,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            if (daftarBarang.isEmpty)
              const SizedBox(
                height: 600,
                child: Center(
                  child: Text("Tidak ada data"),
                ),
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _buildRows(),
              )
          ],
        ),
      ),
      drawer: const Menu(
        screen: "home",
      ),
    );
  }

  List<Widget> _buildRows() {
    List<Widget> rows = [];
    for (int i = 0; i < daftarBarang.length; i += 2) {
      List<Widget> row = [];
      row.add(
        Expanded(
          child: BarangCard(barang: daftarBarang[i]),
        ),
      );
      if (i + 1 < daftarBarang.length) {
        row.add(
          Expanded(
            child: BarangCard(barang: daftarBarang[i + 1]),
          ),
        );
      } else {
        row.add(
          Expanded(
            child: Container(),
          ),
        );
      }
      rows.add(Row(children: row));
    }
    return rows;
  }
}
