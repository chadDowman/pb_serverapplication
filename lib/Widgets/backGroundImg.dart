import 'package:flutter/material.dart';

class BackgroungImg extends StatelessWidget {
  const BackgroungImg({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(

      shaderCallback: (bounds) =>  LinearGradient(
        colors: [Colors.black, Colors.black12],
        begin: Alignment.bottomCenter,
        end: Alignment.center,
      ).createShader(bounds),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('pics/b.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken)
            )
        ),
      ),



    );
  }
}