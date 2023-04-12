import 'dart:developer';
import 'dart:io';

import 'package:consentify/helper/widgets.dart';
import 'package:consentify/model/past_ipfs_response.dart';
import 'package:consentify/utils/api_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/web3dart.dart';

import '../../utils/ethereum_transaction_tester.dart';
import '../../utils/help_utils.dart';
import '../controller/main_controller.dart';

class PastAgreementRepository {
  Future<dynamic> getIpfsValue({@required String id}) async {
    final request =
        http.Request("GET", Uri.parse("${baseUrl}record?chain=ETH&id=$id"));

    final _header = {
      'x-testnet-type': 'ethereum-sepolia',
      'x-api-key': x_api_key
    };

    request.headers.addAll(_header);

    final response = await request.send();

    if (response.statusCode != 200) {
      return 'Something Went wrong';
    }

    final json = await response.stream.bytesToString();

    final result = PastIPFSResponse.fromJson(json);

    final decode0 = await contractDecoder(contractData: result.data);

    return decodeData(ipfs: decode0);
  }

  Future<dynamic> decodeData({@required String ipfs}) async {
   
    final _header = {'x-api-key': x_api_key};

    final response =
        await http.get(Uri.parse("${baseUrl}ipfs/$ipfs"), headers: _header);

    if (response.statusCode != 200) {
      return 'Something Went wrong!';
    }

    if (response != null) {
      final Directory appDir = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory();
      String tempPath = appDir.path;
      final String fileName =
          DateTime.now().microsecondsSinceEpoch.toString() + '.pdf';
      File file = File('$tempPath/$fileName');
      if (!await file.exists()) {
        await file.create();
      }
      await file.writeAsBytes(response.bodyBytes);
      return file;
    }

    return 'Something Went Wrong!';
  }
}
