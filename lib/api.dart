import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class apipage extends StatefulWidget {
  const apipage({super.key});

  @override
  State<apipage> createState() => _apipageState();
}

class _apipageState extends State<apipage> {
  String imageurl = '';
  bool isloading = false;
  getdata() async {
    setState(() {
      isloading = true;
    });
    var uri = Uri.parse("https://random.dog/woof.json");
    var response = await http.get(uri);
    var data = jsonDecode(response.body);
    print(data['url']);
    setState(() {
      imageurl = data['url'];
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.network(
            imageurl,
            height: 150,
          ),
          isloading
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () {
                    getdata();
                  },
                  child: Text('get data'))
        ],
      ),
    );
  }
}
