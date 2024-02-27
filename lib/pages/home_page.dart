import 'package:cardprojectui1/models/credit_card_model.dart';
import 'package:cardprojectui1/pages/details_page.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
//listNumber
class _HomePageState extends State<HomePage> {
  List<CreditCard> cards = [
    CreditCard(
        cardNumber: "8888 8888 8888 8888",
        expiredDade: "12/12",
        cardType: "visa",
        cardImage: "assets/images/ic_card_master.png"),
    CreditCard(
        cardNumber: "7777 7777 7777 7777 ",
        expiredDade: "12/20",
        cardType: "master",
        cardImage: "assets/images/ic_card_visa.png")
  ];
//
  Future _openDetailsPage()async{
    CreditCard result= await Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context){
        return const DetailPage();
      })
    );
    setState(() {
      if(result!= null) {
        cards.add(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("My Card"),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
        
              child: ListView.builder(
                  itemCount: cards.length,
                  itemBuilder: (context, i) {
                    return _itemOfCardList(cards[i]);
                  }
                  ),
            ),
            Container(

             // color: Colors.blue,
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue,
              ),

              //button

              child: MaterialButton(
                onPressed: (){
                  _openDetailsPage();
                  },
                child: Text("Add Card",style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white
                ),),
                
              ),
            )
          ],
        ),
      ),

    );
  }
//function widget
  Widget _itemOfCardList(CreditCard creditCard) {
    return Container(
     margin: EdgeInsets.only(top: 15),
      height: 70,
      width: double.infinity,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: Image(
              image: AssetImage(creditCard.cardImage!),
            ),
          ),
          Column(
            children: [
              Text(
                creditCard.cardNumber!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                creditCard.expiredDade!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
