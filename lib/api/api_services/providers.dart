import 'dart:convert';
import 'package:consentify/api/api_services/bLoc.dart';
import 'package:consentify/api/api_services/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetEthereumwalletApi {
  var xpub;
  Future<dynamic> onGetEthereumwalletApi() async {
    try {
      final uri = Uri.parse('https://api-eu1.tatum.io/v3/ethereum/wallet');

      final response = await http.get(uri, headers: {
        'content-Type': 'application/json',
        'x-api-key': 'c24ff763-3212-4198-87aa-d68699df1283'
      });

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        print(response);
        return GetEthereumwalletModel.fromJson(responseJson);
      } else {
        StreamBuilder<GetEthereumwalletModel>(
          stream: getEthereumwalletbloc.getEthereumwalletstream,
          builder: (context,
              AsyncSnapshot<GetEthereumwalletModel> getEthereumwalletsnapshot) {
            xpub = getEthereumwalletsnapshot.data.xpub;
            if (!getEthereumwalletsnapshot.hasData) {
              return const Center(
                  // child: CircularProgressIndicator(),
                  );
            }
            return Container(
              child: Text(getEthereumwalletsnapshot.data.xpub),
            );
          },
        );
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

class GetEthereumAddressApi extends GetEthereumwalletApi {
  var index = 1;

  Future<dynamic> onGetEthereumAdressApi() async {
    try {
      final uri = Uri.parse(
          'https://api-eu1.tatum.io/v3/ethereum/address/${xpub}/${index}');

      final response = await http.get(uri, headers: {
        'content-Type': 'application/json',
        'x-api-key': 'c24ff763-3212-4198-87aa-d68699df1283'
      });

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        print(response);
        return GetEthereumwalletModel.fromJson(responseJson);
      } else if (response.statusCode == 404) {
        responseJson = json.decode(response.body);
        // return DataNotFoundModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}
