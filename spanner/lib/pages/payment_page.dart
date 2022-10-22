import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery
          .of(context)
          .size
          .height;
    double w = MediaQuery
          .of(context)
          .size
          .width;      
     
    return Scaffold(
      body: Container(
        //new
        height: h,
        width: w,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              "assets/back.png"
            ) )
        ),
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: h*0.14,
              decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              "assets/sucess.png"
            ) )
        )

            )
          ],

        ),
      ),


    );
  }
}