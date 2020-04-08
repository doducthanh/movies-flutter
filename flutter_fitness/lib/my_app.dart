
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text("FITNESS AT HOME"),
        ),
        backgroundColor: Colors.grey[300],
        body: Container(
          child: Center(
            child: CachedNetworkImage(
              imageUrl:
                  "https://media2.giphy.com/media/qBiQ7sC7HQSac/giphy.webp?cid=ecf05e473b9f81ea6ae49f7df48bb61af1614d4635864cd2&rid=giphy.webp",
              width: 200,
              height: 200,
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                title: Text("Home"), icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                title: Text("Home"), icon: Icon(Icons.favorite)),
            BottomNavigationBarItem(
                title: Text("Home"), icon: Icon(Icons.contact_mail)),
          ],
        ),
      ),
    );
  }
}
