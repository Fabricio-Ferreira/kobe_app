import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              accountName: Text(
                "Fabrício Ferreira",
                style: TextStyle(color: Colors.black87, fontSize: 18),
              ),
              accountEmail: Text(
                "fabricio.thyala@gmail.com",
                style: TextStyle(color: Colors.black87, fontSize: 14),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://avatars3.githubusercontent.com/u/13634186?s=400&u=09eb76c2ceab9947b8332e9039172535b5fa7669&v=4"),
              ),
            ),
            ListTile(
              onTap: () {
                print("Item 1");
              },
              title: Text("Item 1"),
              leading: Icon(Icons.star),
            ),
            ListTile(
              onTap: () {
                print("Item 2");
              },
              title: Text("Item 2"),
              leading: Icon(Icons.star),
            ),
            ListTile(
              onTap: () {
                print("Item 3");
              },
              title: Text("Item 3"),
              leading: Icon(Icons.star),
            ),
            ListTile(
              onTap: () {
                print("Configurações");
              },
              title: Text("Configurações"),
              leading: Icon(Icons.settings),
            ),
            ListTile(
              onTap: () {
                print("Ajuda");
              },
              title: Text("Ajuda"),
              leading: Icon(Icons.help),
            ),
            ListTile(
              onTap: () {
                _logout(context);
              },
              title: Text("Logout"),
              leading: Icon(Icons.close),
            )
          ],
        ),
      ),
    );
  }

  void _logout(context) {
    // pushReplacement(context, LoginPage());
    print("Você clicou em sair");
  }
}
