import 'package:http/http.dart' as http;
import 'dart:convert';

const ApiKey = 'YOUR-API-HERE';

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

  Future getCoinData(String selectedCurrency) async{

    Map<String, String> data = {};

    for (String coin in cryptoList){
      String url = 'https://rest.coinapi.io/v1/exchangerate/$coin/$selectedCurrency?apikey=$ApiKey';

      http.Response response = await http.get((Uri.parse(url)));
      if (response.statusCode==200){
        var resp = jsonDecode(response.body);
        double rawRate = resp['rate'];
        data[coin] = rawRate.toStringAsFixed(0);
      } else {
        print(response.statusCode);
      }
    }
    return data;

}

}

// class CoinData {
//   Future getCoinData(String selectedCurrency) async {
//     //4: Use a for loop here to loop through the cryptoList and request the data for each of them in turn.
//     //5: Return a Map of the results instead of a single value.
//     Map<String, String> cryptoPrices = {};
//     for (String crypto in cryptoList) {
//       //Update the URL to use the crypto symbol from the cryptoList
//       String requestURL =
//           'https://rest.coinapi.io/v1/exchangerate/$crypto/$selectedCurrency?apikey=$ApiKey';
//       http.Response response = await http.get(Uri.parse(requestURL));
//       if (response.statusCode == 200) {
//         var decodedData = jsonDecode(response.body);
//         double lastPrice = decodedData['rate'];
//         //Create a new key value pair, with the key being the crypto symbol and the value being the lastPrice of that crypto currency.
//         cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
//       } else {
//         print(response.statusCode);
//         throw 'Problem with the get request';
//       }
//     }
//     return cryptoPrices;
//   }
// }
