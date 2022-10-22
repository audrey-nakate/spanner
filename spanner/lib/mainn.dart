import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';


void main(){
  runApp(MakePayments());
}

class MakePayments extends StatefulWidget {
  MakePayments({Key? key}) : super(key: key);
  @override
  State<MakePayments> createState() => _MakePaymentsState();
}

class _MakePaymentsState extends State<MakePayments> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

////

  TextEditingController ammount = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  final currencyController = TextEditingController();

  StreamController<String> controllerUrl = StreamController<String>();

  String selectedCurrency = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.currencyController.text = this.selectedCurrency;
    return Scaffold(
      body: Form(
        key: _key,
        child: ListView(
          children: <Widget>[  
          TextFormField( 
            controller: name, 
            decoration: const InputDecoration(  
              icon: const Icon(Icons.person),  
              hintText: 'Enter your name',  
              labelText: 'Name',  
            ),
            ),

            TextFormField( 
            controller: email, 
            decoration: const InputDecoration(  
              icon: const Icon(Icons.person),  
              hintText: 'Enter your email',  
              labelText: 'Email',  
            ),
            ),

            TextFormField( 
            controller: ammount, 
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(  
              icon: const Icon(Icons.person),  
              hintText: 'Enter amount',  
              labelText: 'Amount',  
            ),
            ),

            TextFormField( 
            controller: phoneNumber, 
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(  
              icon: const Icon(Icons.person),  
              hintText: 'Enter your Phone Number',  
              labelText: 'Tel:',  
            ),
            ),

            ///////////

            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              child: ElevatedButton(
                onPressed: () {
                  _simpleGuide(
                    context,
                    name.text.trim(),
                    email.text.trim(),
                    phoneNumber.text.trim(),
                    ammount.text.trim(),
                    // currencyController.text.trim(),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "continue",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(20),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.yellow,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _simpleGuide(BuildContext context, String name, String email,
      String phoneNumber, String ammount) {
    showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!

      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Just a simple note.",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "Please ensure you have an active and stable internet connection for a fast and smooth payment process.",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  )
                ]),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "cancel",
                      style: TextStyle(
                        // fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.redAccent),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _makePayments(
                          context,
                          name,
                          email,
                          phoneNumber,
                          ammount,
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.yellow),
                      ),
                      child: const Text(
                        "continue",
                        style: TextStyle(
                          // fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
              ],
            )
          ],
        );
      },
    );
  }

  Widget _message(String message) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: 5),
      child: Text(
        message,
        style: TextStyle(
          fontSize: 15,
          color: Colors.yellow,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future<void> _makePayments(BuildContext context, String name, String email,
      String phoneNumber, String ammount) async {
    final Customer customer = Customer(
      name: (name.trim() != "") ? name.trim() : "Anonymous",
      phoneNumber: "+256${int.parse(phoneNumber).toString()}",
      email: email.trim(),
    );


      
    final flutterwave = Flutterwave(
      context: context,
      publicKey: "FLWPUBK_TEST-67164032be44b840e68ed834f83bfca3-X",
      currency: "UGX",
      txRef: DateTime.now().toIso8601String(),
      amount: ammount.trim(),
      customer: customer,
      paymentOptions: "",
      customization: Customization(title: "Spanner"),
      // redirectUrl: "https://google.com",
      // redirectUrl:
      //     "https://mumsa-app.herokuapp.com/update/${widget.fundRaiser.id}/$ammount",
      redirectUrl: "https://google.com",
      isTestMode: true,
    );
    final ChargeResponse response = await flutterwave.charge();
    if (response != null) {
      if (response.status == "success") {
        //DO SOMETHING WHEN THE PAYMENT IS SUCCESSFULL. lIKE MAY BE ROUTING TO TO
        ///A SUCCESS PAGE.
      } else {
        print(
            "the transaction was ......................."); ////print("${response.toJson()}");
      }
    } else {
      showLoading("No Response!");
    }
  }

  void _openBottomSheet() {
    showModalBottomSheet(
        context: this.context,
        builder: (context) {
          return this._getCurrency();
        });
  }

  Widget _getCurrency() {
    final currencies = ["UGX", "USD", "NGN", "RWF", "ZAR", "GHS", "TZS"];
    return Container(
      height: 250,
      // margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: currencies
            .map((currency) => Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  child: ListTile(
                    onTap: () => {this._handleCurrencyTap(currency)},
                    title: Column(
                      children: [
                        Text(
                          currency,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  _handleCurrencyTap(String currency) {
    this.setState(() {
      this.selectedCurrency = currency;
      this.currencyController.text = currency;
    });
    Navigator.pop(this.context);
  }

  String? validateEmail(String? formEmail) {
    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);

    if (formEmail == null || formEmail.isEmpty) {
      return "email required ";
    } else if (!regex.hasMatch(formEmail)) {
      return "invalid email format";
    } else {
      return null;
    }
  }

  String? validateFields(String? formpassword) {
    if (formpassword == null || formpassword.isEmpty) {
      return "this field required ";
    } else {
      return null;
    }
  }

  Future<void> loading() {
    return showDialog(
      context: this.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            content: Container(
              padding: EdgeInsets.all(4),
              // margin: EdgeInsets.all(10),
              color: Colors.white,
              height: 100,
              width: 5,
              child: Center(
                  child: CircularProgressIndicator(color: Colors.yellow)),
            ),
          ),
        );
      },
    );
  }

  Future<void> showLoading(String? message) {
    return showDialog(
      context: this.context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 50,
            child: Center(child: Text("${message!}!")),
          ),
        );
      },
    );
  }

  FaIcon(star,
      {required MaterialColor
          color}) {} ////t 
  Customization({required String title}) {}

  //

  Flutterwave(
      {required BuildContext context,
      required String publicKey,
      required String currency,
      required String txRef,
      required String amount,
      required Customer customer,
      required String paymentOptions,
      required customization,
      required String redirectUrl,
      required bool
          isTestMode}) {} ////.
}





class ChargeResponse {
  get status => null;
}



class SuccessScreen extends StatefulWidget {
  SuccessScreen({Key? key}) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

Color themeColor = Colors.yellow;

class _SuccessScreenState extends State<SuccessScreen> {
  // double screenWidth = 600;
  // double screenHeight = 400;
  Color textColor = Colors.yellow;

  bool doneUpdating = false;

  @override
  void initState() {
    doneUpdating = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, () => showAlert(context));
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: screenHeight * 0.2,
              width: screenWidth * 0.8,
              child: Image.asset(
                "assets/images/thankyou.png",
                fit: BoxFit.contain,
                width: screenWidth * 0.55,
                height: screenHeight * 0.55,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              "Thank You",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            Flexible(
              child: HomeButton(
                title: 'Home',
                onTap: () {
                  // Navigator.of(context).pushReplacement(HomeButton());
                  // Navigator.pushReplacement(
                  //   context,
                  //   , ////tthis had home

                  // );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            padding: EdgeInsets.all(4),
            // margin: EdgeInsets.all(10),
            color: Colors.white,
            height: 100,
            width: 5,
            child:
                Center(child: CircularProgressIndicator(color: Colors.yellow)),
          ),
        );
      },
    );
  }

  void loading() {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'deleting event!',
            textAlign: TextAlign.center,
          ),
          content: Container(
            padding: EdgeInsets.all(4),
            // margin: EdgeInsets.all(10),
            color: Colors.white,
            height: 100,
            width: 5,
            child:
                Center(child: CircularProgressIndicator(color: Colors.yellow)),
          ),
        );
      },
    );
  }
}

class HomeButton extends StatelessWidget {
  HomeButton({Key? key, this.title, this.onTap}) : super(key: key);

  String? title;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Center(
          child: Text(
            title ?? '',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
