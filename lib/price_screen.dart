import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedCurrency = 'AUD';
  String selectedCoin = 'BTC';
  Map<String,String> coinRates = {};
  bool isWaiting = false;

  void getData() async{
    isWaiting = false;
    try{
      var coinData = await CoinData().getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinRates = coinData;
      });
    }
    catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  List<Text> getPickerItems(){
    List<Text> dropdownItems = [];

    for (String currency in currenciesList){
      dropdownItems.add(Text(currency));
    }
    return dropdownItems;
  }



  Column getCards(){
    List<CryptoCard> cards = [];
    for (String coin in cryptoList){
      CryptoCard cryptoCard = CryptoCard(
          selectedCoin: coin,
          coinRate: isWaiting ? '?' : coinRates[coin],
          selectedCurrency: selectedCurrency);
      cards.add(cryptoCard);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cards,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          getCards(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: CupertinoPicker(
              backgroundColor: Colors.lightBlue,
                itemExtent: 32,
                onSelectedItemChanged: (index) {
                setState(() {
                  selectedCurrency = currenciesList[index];
                  getData();
                });
                },
                children: getPickerItems()),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key key,
    @required this.selectedCoin,
    @required this.coinRate,
    @required this.selectedCurrency,
  }) : super(key: key);

  final String selectedCoin;
  final String coinRate;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
    child: Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $selectedCoin = $coinRate $selectedCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    ),
    );
  }
}
