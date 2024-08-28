import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class todopage extends StatefulWidget {
  todopage({super.key});

  @override
  State<todopage> createState() => _todopageState();
}

class _todopageState extends State<todopage> {
  List<String>? todos = [];

  void dialogbox() {
    var datacollct = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Add your data'),
                TextField(
                  controller: datacollct,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        todos!.add(datacollct.text);
                        adddat();

                        print(todos);
                      });
                    },
                    child: Text('OK'))
              ],
            ),
          ),
        );
      },
    );
  }

  adddat() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList("todos", todos!);
  }

  getdata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? data = pref.getStringList("todos");
    setState(() {
      todos = data!;
    });
  }

  @override
  void initState() {
    getdata();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'TODO LIST',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Color.fromRGBO(47, 102, 2, 0.966),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            return dialogbox();
          },
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: todos!.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                //  Text(),
                Text(todos![index]),
              ],
            );
          },
        ));
  }
}
