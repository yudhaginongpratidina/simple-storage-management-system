import 'package:flutter/material.dart';
import 'package:storage_management_system/components/header_detail_menu.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        leading: const Icon(Icons.info),
        title: const Text('About'),
      ),
      body: Container(
        color: Colors.indigo,
        child: Column(children: [
          const HeaderDetailMenu(
              menuTitle: 'About', icon: Icon(Icons.storage), backToHome: false),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            height: height * 0.56,
            width: width,
            child: const Column(
              children: [
                Text("About",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                SizedBox(height: 10),
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
