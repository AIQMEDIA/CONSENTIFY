import 'package:consentify/api/api_services/providers.dart';

class Config {
  static const String apiurl = 'https://api-eu1.tatum.io/v3/ethereum/wallet';

  static const String getethethereumwallet = 'getethethereumwallet';
}

class PrefKeys {
  static const String USERDATA = 'userdata';
  static const String TOKEN = 'token';
  static const String ADDID = 'AddId';
  static const String ADDRESS = 'Address';
  static const String CARTLIST = 'cartlist';
  static const String LANG = 'language';
}

class Repository {
  //=================== GET ETHEREUMWALLET API  ===================
  final GetEthereumwalletApi getEthereumwalletApi = GetEthereumwalletApi();
  Future<dynamic> ongetEthereumwalletApi() =>
      getEthereumwalletApi.onGetEthereumwalletApi();
}

// class AddressRepository {
//   //=================== GET ETHEREUMWALLET API  ===================
//   final GetEthereumAddressApi getEthereumAddressApi = GetEthereumAddressApi();
//   Future<dynamic> ongetEthereumAddressApi() =>
//       getEthereumAddressApi.onGetEthereumAdressApi();
// }
