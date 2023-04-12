import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:consentify/api/api_services/models/models.dart';

// ======= 1st api =======//
class GetEthereumwalletApi {
  Future<void> onGetEthereumwalletApi() async {
    try {
      final uri = Uri.parse('https://api-eu1.tatum.io/v3/ethereum/wallet');
      final response = await http.get(uri, headers: {
        'content-Type': 'application/json',
        'x-api-key': 'c24ff763-3212-4198-87aa-d68699df1283',
      });

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        GetEthereumWalletModel getEthereumwalletModel =
            GetEthereumWalletModel.fromJson(responseJson);
        print(response.body);
        await onGetEthereumAdressApi(xpub: getEthereumwalletModel.xpub);
        await onGetEthereumprivApi(mnemonic: getEthereumwalletModel.mnemonic);
        await onGetEthereumformApi();
        await onGetEthereumledgerApi(xpub: getEthereumwalletModel.xpub);

        // return GetEthereumwalletModel.fromJson(responseJson);
      } else {
        null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }

// ======= 2nd api =======//
  Future<dynamic> onGetEthereumAdressApi({String xpub, int index = 1}) async {
    try {
      final uri = Uri.parse(
          'https://api-eu1.tatum.io/v3/ethereum/address/${xpub}/${index}');

      final response = await http.get(uri);

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);

        print(response.body);
        return EthereumAddressModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }

// ======= 3rd api =======//
  Future<dynamic> onGetEthereumprivApi({String mnemonic, int index = 1}) async {
    try {
      final uri = Uri.parse('https://api-eu1.tatum.io/v3/ethereum/wallet/priv');
      dynamic postData = {'mnemonic': mnemonic, 'index': index};
      final response =
          await http.post(uri, body: json.encode(postData), headers: {
        'content-Type': 'application/json',
        'x-api-key': 'c24ff763-3212-4198-87aa-d68699df1283',
      });
      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        print(response.body);
        return GetEthereumprivModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }

// ======= 4th api =======//
  Future onGetEthereumformApi() async {
    final client = http.Client();
    try {
      final String fullURL = 'https://api-eu1.tatum.io/v3/ipfs';

      var headers = {
        'Content-Type': 'multipart/form-data',
        'x-api-key': 'c24ff763-3212-4198-87aa-d68699df1283'
      };

      // file generate .json + // save storage = path storage +// api ma path
      // log('API Url: $fullURL', level: 1);
      // log('API header: $headers');

      final request = http.MultipartRequest("POST", Uri.parse(fullURL));
      request.headers.addAll(headers);
      // request.fields.addAll(body);

      request.files.add(await http.MultipartFile.fromPath(
          'file', 'storage/emulated/0/pictures/IMG_20221022_134716.jpg'));

      final http.StreamedResponse response = await request.send();
      final String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);
      print(jsonData);
      return GetEthereumformModel.fromJson(jsonData);
    } catch (exception) {
      client.close();
      rethrow;
    }
  }

// ======= 5th api =======//
  Future<dynamic> onGetEthereumledgerApi(
      {String xpub, String currency, String externalId}) async {
    String currency = 'ETH';
    String ipfsHash;
    try {
      final uri = Uri.parse('https://api-eu1.tatum.io/v3/ledger/account');
      dynamic postData = {
        'xpub': xpub,
        'currency': currency,
        "externalId": ipfsHash
      };
      final response =
          await http.post(uri, body: json.encode(postData), headers: {
        'content-Type': 'application/json',
        'x-api-key': 'c24ff763-3212-4198-87aa-d68699df1283',
      });
      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);

        GetEthereumLedgerModel getEthereumledgerModel =
            GetEthereumLedgerModel.fromJson(responseJson);

        print(response.body);

        await onGetEthereumoffchainApi(id: getEthereumledgerModel.id);

        return GetEthereumLedgerModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }

// ======= 6th api =======//
  Future<dynamic> onGetEthereumoffchainApi({String id}) async {
    try {
      dynamic postData = {'id': id};
      final uri = Uri.parse(
          'https://api-eu1.tatum.io/v3/offchain/account/${id}/address?index=1');
      final response = await http.post(
        uri,
        headers: {
          'content-Type': 'application/json',
          'x-api-key': 'c24ff763-3212-4198-87aa-d68699df1283',
        },
        body: json.encode(postData),
      );
      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        print(response.body);

        return GetEthereumChainModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      // print('exception---- $exception');
      return null;
    }
  }
}
