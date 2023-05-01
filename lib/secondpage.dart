import 'package:flutter/material.dart';
import 'package:googlenote/databaseclass.dart';
import 'package:googlenote/main.dart';
import 'package:googlenote/splashh.dart';
import 'package:sqflite/sqflite.dart';

class secondpage extends StatefulWidget {
  const secondpage({Key? key}) : super(key: key);

  @override
  State<secondpage> createState() => _secondpageState();
}

class _secondpageState extends State<secondpage> {
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  Database? db;
  List bgcolor = [
    Colors.black,
    Colors.white,
    Colors.pinkAccent,
    Colors.pink,
    Colors.deepOrangeAccent,
    Colors.redAccent,
    Colors.blue,
    Colors.indigo,
    Colors.green,
    Colors.purpleAccent,
    Colors.brown,
    Colors.lightGreen,
    Colors.blueAccent,
    Colors.grey,
    Colors.greenAccent,
    Colors.teal,
    Colors.lime,
    Colors.yellow,
    Colors.lime,
    Colors.cyan,
    Colors.white10,
    Colors.black54,
    Colors.deepOrange,
  ];
  Color currentcolor = Colors.orangeAccent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewdatabase();
  }

  viewdatabase() {
    databaseclass().fordatabase().then((value) {
      setState(() {
        db = value;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       leading: Icon(Icons.menu),
       title: Text('Number Puzzle'),
       actions: [
         Icon(Icons.favorite),
         Padding(
           padding: EdgeInsets.symmetric(horizontal: 16),
           child: Icon(Icons.search),
         ),
         Icon(Icons.more_vert),
       ],
       backgroundColor: Colors.purple,
     ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.blue,
                  height: 40,
                  width: double.infinity,
                  child: Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          margin: EdgeInsets.all(5),
                          child: Icon(Icons.health_and_safety_rounded)),
                      Container(
                          margin: EdgeInsets.all(5),
                          child: Icon(Icons.add_alert)),
                      Container(
                          margin: EdgeInsets.all(5),
                          child: Icon(Icons.archive_outlined))
                    ],
                  )),
                ),
              )
            ],
          ),
          Expanded(
              flex: 1,
              child: Card(
                child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        border: Border.all(color: Colors.white, width: 10),
                        boxShadow: [
                          BoxShadow(color: Colors.black, blurRadius: 25)
                        ]),
                    child: Column(children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              child: Text(
                                "Title",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                                    margin: EdgeInsets.all(5),
                                    child: TextField(
                                      controller: title,
                                      decoration: InputDecoration(
                                          hintText: "Write a Title.."),
                                    )))
                          ],
                        ),
                      )
                    ])),
              )),
          Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.all(40),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                    border: Border.all(color: Colors.white, width: 10),
                    boxShadow: [
                      BoxShadow(color: Colors.black, blurRadius: 25)
                    ]),
                child: Column(children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Text(
                          "Notes",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.only(bottom: 50),
                              child: TextField(
                                controller: note,
                                decoration: InputDecoration(
                                    hintText: "Write a notes.."),
                              )))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          String titlee = title.text;
                          String notess = note.text;

                          databaseclass()
                              .insertdata(titlee, notess ,db!)
                              .then((value) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return splashh();
                              },
                            ));
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.black, width: 5)),
                          child: Center(child: Text("Add Note")),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4),
                                  itemBuilder: (context, index) {
                                    return InkWell(onTap: () {
                                            setState(() {
                                              currentcolor=bgcolor[index];
                                            });
                                    },
                                        child: Container(
                                      margin: EdgeInsets.all(10),
                                      color: bgcolor[index],
                                    ));
                                  },
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(20),
                          height: 30,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.black, width: 5)),
                          child: Center(child: Text("Choose Background Color")),
                        ),
                      )
                    ],
                  )
                ]),
              )),

          // Expanded(
          //   flex: 2,
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: Card(
          //           child: Container(
          //             margin: EdgeInsets.all(30),
          //             color: Colors.orangeAccent,
          //             child: Expanded(
          //                 child: Row(children: [
          //               Expanded(
          //                   child: Container(
          //                       margin: EdgeInsets.all(10),
          //                       child: TextField(
          //                         decoration: InputDecoration(hintText: "Enterr Title"),
          //                       )))
          //             ])),
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // Expanded(
          //   flex: 5,
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: Card(
          //           child: Container(
          //             margin: EdgeInsets.all(30),
          //             color: Colors.blue,
          //             child: Expanded(child: TextField(decoration: InputDecoration(hintText: "nknsdf"),)),
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
