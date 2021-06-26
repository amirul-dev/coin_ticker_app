import 'package:http/http.dart' as http;
import 'dart:convert';

const ApiKey = '262F331B-7AE3-490A-A9FC-8CA1CAE1F761';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {

  Future getCoinData(selectedCurrency) async{

    Map data;

    for (String coin in cryptoList){
      String url = 'https://rest.coinapi.io/v1/exchangerate/$coin/$selectedCurrency?apikey=$ApiKey';

      http.Response response = await http.get((Uri.parse(url)));
      if (response.statusCode==200){
        var data = jsonDecode(response.body);
        double rawRate = data['rate'];
        String rate = rawRate.toStringAsFixed(0);
        data[coin] = rate;
      } else {
        print(response.statusCode);
      }
      return data;
    }

}

}
