import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googlenote/databaseclass.dart';
import 'package:googlenote/secondpage.dart';
import 'package:googlenote/splashscreen.dart';
import 'package:googlenote/updatepage.dart';
import 'package:neon_widgets/neon_widgets.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: splashscreen()));
}

class mainpage extends StatefulWidget {
  const mainpage({Key? key}) : super(key: key);

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  Database? db1;
  List<Map> detail = [];
  List<Map> searchlist = [];
  bool Issearch = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() {
    databaseclass().fordatabase().then((value) {
      setState(() {
        db1 = value;
      });
      databaseclass().viewdata(db1!).then((value) {
        setState(() {
          detail = value;
          searchlist = value;
        });
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Issearch
          ? AppBar(
              backgroundColor: Colors.white,
              title: TextField(
                autofocus: true,
                onChanged: (value) {
                  setState(() {
                    if (value.isNotEmpty) {
                      searchlist = [];
                      for (int u = 0; u < detail.length; u++) {
                        String titlee = detail[u]['title'];
                        String notess = detail[u]['notes'];
                        if (titlee.toLowerCase().contains(value.toLowerCase()) ||
                            notess
                                .toString()
                                .toUpperCase()
                                .contains(value.toUpperCase())) {
                          searchlist.add(detail[u]);
                        } else {

                        }
                      }
                    }
                    else {
                      searchlist = detail;
                    }
                  });
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            Issearch = false;
                            searchlist = detail;
                          });
                        },
                        icon: Icon(Icons.close))),
              ),
            )
          : AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        Issearch = true;
                      });
                    },
                    icon: Icon(Icons.search))
              ],
            ),
      backgroundColor: Colors.grey,
      body: Container(
        child: GridView.builder(
          itemCount: Issearch?searchlist.length:detail.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.9),
          itemBuilder: (context, index) {

            Map map = Issearch ? searchlist[index] : detail[index];

            return oNeonContainer(
                spreadColor: Colors.teal.shade200,
                borderColor: Colors.teal.shade50,
                containerColor: Colors.orangeAccent,
                lightBlurRadius: 20,
                lightSpreadRadius: 10,
                borderRadius: BorderRadius.circular(20),
                margin: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: ListTile(
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 1) {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return updatepage(detail[index]);
                            },
                          ));
                        }
                      },
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(value: 1, child: Text("Update")),
                          PopupMenuItem(
                              value: 2,
                              onTap: () {
                                int idd = detail[index]['ID'];
                                databaseclass().deletnote(idd, db1!).then((value) {
                                  getdata();
                                });
                              },
                              child: Text("delete"))
                        ];
                      },
                    ),
                    title: Text(
                      "\n\n\n${map['title']}",
                      style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("${map['notes']}",
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                  ),
                ),);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return secondpage();
            },
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
