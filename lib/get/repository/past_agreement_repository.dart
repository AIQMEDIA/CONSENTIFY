import 'dart:developer';

import 'package:consentify/helper/widgets.dart';
import 'package:consentify/model/past_ipfs_response.dart';
import 'package:consentify/utils/api_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/web3dart.dart';

import '../../utils/ethereum_transaction_tester.dart';
import '../controller/main_controller.dart';

class PastAgreementRepository {
  getIpfsValue({@required String id}) async {
    final request =
        http.Request("GET", Uri.parse("${baseUrl}record?chain=ETH&id=$id"));

    final _header = {
      'x-testnet-type': 'ethereum-sepolia',
      'x-api-key': x_api_key
    };

    request.headers.addAll(_header);

    final response = await request.send();

    log("Sunil call !  ${id}");

    if (response.statusCode != 200) {
      showSnackWithoutContext('Network Issue!');
      return;
    }

    final json = await response.stream.bytesToString();

    log("Sunil ipfs value => $json");

    final result = PastIPFSResponse.fromJson(json);

    decodeData(ipfs: result.data);
  }

  decodeData({@required String ipfs}) async {
    final request = http.Request("GET", Uri.parse("${baseUrl}ipfs/${ipfs}"));

    final _header = {'x-api-key': x_api_key};

    request.headers.addAll(_header);

    final response = await request.send();

    if (response.statusCode != 200) {
      showSnackWithoutContext('Network Issue!');
      return;
    }

    final json = await response.stream.bytesToString();

    log("Sunil file$json");
  }
}
