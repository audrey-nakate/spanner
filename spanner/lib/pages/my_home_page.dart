import 'package:flutter/rendering.dart';
import 'package:flutter_payment_app/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_payment_app/widgets/large_buttons.dart';
import 'package:flutter_payment_app/widgets/text_size.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePagetState createState() => _MyHomePagetState();
}

class _MyHomePagetState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height; 
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: Container(
        height: h,
        child: Stack(
          children: [
            _headSection(),
            _listBills(),
            _payButton(),


          ],
        ),
      ),
    );
      
   
  }
  _headSection(){
    return Container(
      height: 311,
      width: 800,
      
      child: Stack(
        children: [
          _mainBackground(),
          _curveImageContainer(), 
          _buttonContainer(),

        ],
      ),
    );
  }
  _buttonContainer(){
    return Positioned(
      right: 0, 
      bottom: 50, 
      child: GestureDetector(
        onTap: (){
          showModalBottomSheet(
            barrierColor: Colors.grey.withOpacity(0.8),
            //can also make colors.transparent,
            backgroundColor: Colors.grey.withOpacity(0.5),
            context: context, builder: (BuildContext bc){
              return Container(
                height: 800,

              );

            });
        },
        child: Container(
        height: 40,
        width: 40,
       decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
        width: 3,
        color: Colors.grey,

        ),
        image: DecorationImage(
         image: AssetImage(
            "assets/menu.png"
            
          ), ),
       //this is where ive removed the boxshadow from, i will return it. boxShadow: [
        //  BoxShadow(
          //  blurRadius: 15,
            //offset: Offset(0,  1),
            //color: Color(0xFF11324d).withOpacity(0.2)
         // )
        //]


       ),
       


    )));
  
  }
  _mainBackground(){
    return Positioned(
      child: Container(
        //new
        height: 200,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage(
              "assets/machanika.jpg"
            ) )
        ),
      ) 
      );
  }
  _curveImageContainer(){
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      
       child:
    Container (
      height: MediaQuery.of(context).size.height*0.1,
       decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitHeight,
            image: AssetImage(
              "assets/curvve.png"
            ) )
        ),

    )
    );
  }
  _listBills(){
    return Positioned(
      top: 320,
      right: 0,
      left: 0,
      bottom: 0,

      child: Container(
        height: 130,
        width: MediaQuery.of(context).size.width -20,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFd8db0),
              offset: Offset(1, 1),
              blurRadius: 20.0,
              spreadRadius: 10,
              //you can add spreadRadius:10
            )
          ]),
          child:Container(
            margin: const EdgeInsets.only(top:10, left:18),
            child: Row(    
              children: [
                Column(
                  children: [
                    Row(
                    children: [
                      Container(                      
        //new
                          height: 60,
                          width: 60,
                           decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 3,
                              color: Colors.grey ),
                          image: DecorationImage(
                          fit: BoxFit.fitHeight ,
                          image: AssetImage(
                          "assets/icon.png"
                             )
                           ),
                       ) 

                      ),
                Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Car Service ",
                            style: TextStyle(
                              fontSize: 16,
                              color:  AppColor.mainColor,
                              fontWeight: FontWeight.w700
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                            "ID: 192160 ",
                            style: TextStyle(
                              fontSize: 16,
                              color:  AppColor.idColor,
                              fontWeight: FontWeight.w700
                              )
                            ),
                        ],
                      ),
                Row(
                  children: [
                    Column(
                      children: [
                         Container(
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColor.selectBackground
                          ),
                          child: Center(
                            child: Text(
                            "Select",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColor.selectColor),
                          ),
                      ),
                         ),
                         Text(
                            "\15,000.00/=",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: AppColor.mainColor
                           ),
                          )
                        
                      ],
                     
                    )

                  ],
                )
                    
                    ],
                     
                  ),
                   
                  SizedText(text: "Auto pay on 24th Oct", color:AppColor.green),
                  SizedBox(height: 5,)
                ],
                )
              ]
              ),
          )) 
      
    );
    
        }
} 
  _payButton(){

    return Positioned(
      bottom: 20,
      child: AppLargeButton(text: "Pay all bills", textColor: Colors.white,),
    );

  }