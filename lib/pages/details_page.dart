import 'package:cardprojectui1/models/credit_card_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiredDateController = TextEditingController();

  String cardNumber = "";
  String expiredDate = "";

  var cardNumberMaskFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  var expiryDateMaskFormatter = MaskTextInputFormatter(
    mask: '##/##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

//function date
  void saveCreditCard() {
    setState(() {
      String cardNumber = cardNumberController.text;
      String expiredDate = expiredDateController.text;

      CreditCard creditCard =
          CreditCard(cardNumber: cardNumber, expiredDade: expiredDate);

      if (cardNumber.trim().isEmpty || cardNumber.length < 16) {
        showToast("enter valid card number");
        return;
      }
      if (expiredDate.trim().isEmpty || expiredDate.length < 5) {
        showToast("enter valid date");
        return;
      }
      if (cardNumber.startsWith("4")) {
        creditCard.cardImage = "assets/images/ic_card_visa.png";
        creditCard.cardType = "visa";
      } else if (cardNumber.startsWith("5")) {
        creditCard.cardImage = "assets/images/ic_card_master.png";
        creditCard.cardType = "master";
      } else {
        // print("enter only visa and master card");
        showToast("Enter only visa and master card");
        return;
      }
      backToFinish(creditCard);
    });
  }

  //fuction backto finsh
  void backToFinish(CreditCard creditCard) {
    Navigator.of(context).pop(creditCard);
  }

  void showToast(String massage) {
    Fluttertoast.showToast(
        msg: massage,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  String getCardNumber() {
    if (cardNumber.isEmpty) {
      return "";
    }
    if (cardNumber.startsWith("4")) {
      return "VISA";
    } else if (cardNumber.startsWith("5")) {
      return "MASTER";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Add Card",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Container(

         color: Colors.red,
        width: MediaQuery.of(context).size.height * 0.6,

        padding: EdgeInsets.all(20),
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
               // mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  AspectRatio(
                    aspectRatio: 1005 / 555,
                    child: Container(
                      width: double.infinity,
                      // height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/im_card_bg.png"),
                              fit: BoxFit.cover)),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  getCardNumber(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                )
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      cardNumber,
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                    Text(
                                      expiredDate,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    //color: Colors.blue,

                    margin: EdgeInsets.only(top: 5),
                    //padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Enter expiradtion date",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),

                  //TextFiled

                  Container(
                    //margin: EdgeInsets.only(top: ),
                    // height: 45,
                    child: TextField(
                      controller: cardNumberController,
                      decoration: InputDecoration(hintText: "Card Number"),
                      onChanged: (value) {
                        setState(() {
                          cardNumber = value;
                        });
                      },
                      inputFormatters: [cardNumberMaskFormatter],
                    ),
                  ),

                  //textFiled dade

                  Container(
                    // margin: EdgeInsets.only(top: 10),
                    // height: 45,
                    child: TextField(
                      controller: expiredDateController,
                      decoration: InputDecoration(hintText: "expired Dade"),
                      onChanged: (value) {
                        setState(() {
                          expiredDate = value;
                        });
                      },
                      inputFormatters: [expiryDateMaskFormatter],
                    ),
                  ),
                  Container(
                    // color: Colors.blue,
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "*Only Visa Masster card cards supported",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),

            //button

            Container(
              //color: Colors.red,
              //margin: EdgeInsets.only(top: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.blue),
              child: MaterialButton(
                onPressed: () {
                  saveCreditCard();
                },
                child: Text(
                  "Save Card",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
