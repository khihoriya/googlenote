import 'package:flutter/material.dart';
import 'package:googlenote/main.dart';
import 'package:lottie/lottie.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return mainpage();
        },
      ));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
        Expanded(flex: 2,
          child: Container(
            child: Lottie.asset("animation/10609-note.json"),
          ),
        ),
      ]),
    );
  }
}
