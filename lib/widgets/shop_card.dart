import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/screens/list_product.dart';
import 'package:shopping_list/screens/login.dart';
import 'package:shopping_list/screens/shoplist_form.dart'; // Import halaman ShopFormPage

class ShopItem {
  final String name;
  final IconData icon;

  ShopItem(this.name, this.icon);
}

class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Material(
      color: Colors.indigo,
      child: InkWell(
        onTap: () async {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Kamu telah menekan tombol ${item.name}!"),
            ),
          );
          if (item.name == "Tambah Produk") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ShopFormPage()),
            );
          }
          else if (item.name == "Lihat Produk") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProductPage()));
          }
          // statement if sebelumnya
          // tambahkan else if baru seperti di bawah ini
          else if (item.name == "Logout") {
                  final response = await request.logout(
                      // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                      "http://localhost:8000/auth/logout/");
                  String message = response["message"];
                  if (response['status']) {
                    String uname = response["username"];
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("$message Sampai jumpa, $uname."),
                    ));
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("$message"),
                    ));
                  }
                }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(
                    item.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
