import 'package:flutter/material.dart';
import 'package:googlenote/main.dart';
import 'package:lottie/lottie.dart';

class splashh extends StatefulWidget {
  const splashh({Key? key}) : super(key: key);

  @override
  State<splashh> createState() => _splashhState();
}

class _splashhState extends State<splashh> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return mainpage();
      },));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      child: Lottie.asset("animation/110457-notes-document.json"),
    )));
  }
}
