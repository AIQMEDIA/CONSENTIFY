import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:consentify/get/controller/main_controller.dart';
import 'package:consentify/helper/widgets.dart';
import 'package:consentify/model/kms_model.dart';
import 'package:consentify/model/pdf_signatureId.dart';
import 'package:consentify/model/qr_code_first/qr_code_first.dart';
import 'package:consentify/model/qr_code_second.dart';
import 'package:consentify/model/qr_code_third.dart';
import 'package:consentify/model/registration_data.dart';
import 'package:consentify/model/tx_config.dart';
import 'package:consentify/model/tx_final_config.dart';
import 'package:consentify/model/user_data.dart';
import 'package:consentify/screens/registerpage.dart';
import 'package:consentify/utils/api_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:http/http.dart' as http;
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/web3dart.dart';

import '../../api/api_services/models/models.dart';
import '../../model/user_account_data/user_account_data.dart';
import '../../utils/ethereum_transaction_tester.dart';

class MainRepository {
  getEthereumWalletApi(Function callback) async {
    var response =
        await http.get(Uri.parse("${baseUrl}ethereum/wallet"), headers: header);

    if (response.statusCode != 200) {
      showSnackWithoutContext("Create Error to create Account");
      return;
    }

    var responseJson = jsonDecode(response.body);
    GetEthereumWalletModel getEthereumWalletModel =
        GetEthereumWalletModel.fromJson(responseJson);
    Get.find<MainController>().registrationData.value.xPub =
        getEthereumWalletModel.xpub;
    Get.find<MainController>().registrationData.value.mnemonic =
        getEthereumWalletModel.mnemonic;

    onGetEthereumAddressApi(getEthereumWalletModel);
    onGetEthereumWalletPrivate(getEthereumWalletModel, callback);

    // onGetEthereumFileApi();
  }

  onGetEthereumAddressApi(GetEthereumWalletModel data) async {
    //pass
    var response = await http.get(
        Uri.parse("${baseUrl}ethereum/address/${data.xpub}/${1}"),
        headers: header);

    if (response.statusCode != 200) {
      showSnackWithoutContext("Create Error to create Account");
      return;
    }
    var responseJson = json.decode(response.body);
    EthereumAddressModel address = EthereumAddressModel.fromJson(responseJson);

    Get.find<MainController>().registrationData.value.publicKey =
        address.address;
  }

  onGetEthereumWalletPrivate(
      GetEthereumWalletModel data, Function callback) async {
    dynamic postData = {'mnemonic': data.mnemonic, 'index': 1};

    var request =
        http.Request('POST', Uri.parse("${baseUrl}ethereum/wallet/priv"));
    request.body = json.encode(postData);
    request.headers.addAll(header);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();

      var privateKey = GetEthereumprivModel.fromJson(json.decode(data));

      Get.find<MainController>().registrationData.value.privateKey =
          privateKey.address;
//yaha tak complete ho gaya hai.
      onGetEthereumFileApi(callback);
    } else {
      print(response.reasonPhrase);
    }
  }

  onGetEthereumFileApi(Function callback) async {
    final request = http.MultipartRequest("POST", Uri.parse("${baseUrl}ipfs"));
    request.headers.addAll(headerForm);

    var file = Get.find<MainController>().userFile.value;

    if (file == null) {
      showSnackWithoutContext("Something Went Wrong!");
      return;
    }

    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    final http.StreamedResponse response = await request.send();
    final String jsonDataString = await response.stream.bytesToString();
    final jsonData = jsonDecode(jsonDataString);

    var temp = GetEthereumformModel.fromJson(jsonData);
    Get.find<MainController>().registrationData.value.ipFsHash = temp.ipfsHash;
    onGetEthereumAccount(callback);
  }

  onGetEthereumAccount(Function callback) async {
    var data = Get.find<MainController>().registrationData.value;
    dynamic postData = {
      'xpub': data.xPub,
      'currency': 'ETH',
      'customer': {'externalId': data.ipFsHash}
    };

    var response = await http.post(Uri.parse("${baseUrl}ledger/account"),
        body: json.encode(postData), headers: header);

    // GetEthereumLedgerModel getEthereumledgerModel =
    //     GetEthereumLedgerModel.fromJson(json.decode(response.body));

    var result = UserAccountData.fromJson(response.body);

    Get.find<MainController>().registrationData.value.id = result.id;

    onGetEthereumOffChainApi(id: result.id, callback: callback);
  }

  onGetEthereumOffChainApi({String id, Function callback}) async {
    dynamic postData = {'id': id};

    var response = await http.post(
        Uri.parse("${baseUrl}offchain/account/$id/address?index=1"),
        // body: postData,
        headers: header);

    var responseJson = json.decode(response.body);

    var result = GetEthereumChainModel.fromJson(responseJson);

    if (Get.find<MainController>().registrationData.value.publicKey ==
        result.address) {
      callback();
    }
  }

/*****************************For QR Code Generation********************/

  generateQrCodeStep1({Function callback}) async {
    var address = Get.find<MainController>().registrationData.value.publicKey;

    if (address == null) {
      address = Get.find<MainController>().loginSession.value.account;
    }
    var response = await http.get(
        Uri.parse("${baseUrl}offchain/account/address/$address/ETH"),
        headers: header);

    if (response.statusCode != 200) {
      showSnackWithoutContext(jsonDecode(response.body)['message']);

      return;
    }

    var result = QrCodeFirst.fromJson(response.body);

    Get.find<MainController>().qrCodeData.value.customerId = result.customerId;

    generateQrCodeStep2(result.customerId, callback);
  }

  generateQrCodeStep2(String id, Function callback) async {
    var response = await http.get(Uri.parse("${baseUrl}ledger/customer/$id"),
        headers: header);
    if (response.statusCode != 200) {
      showSnackWithoutContext("Something went Wrong!");

      return;
    }

    var result = QrCodeSecond.fromJson(response.body);

    Get.find<MainController>().qrCodeData.value.externalId = result.externalId;
    generateQrCodeStep3(result.externalId, callback);
  }

  generateQrCodeStep3(String id, Function callback) async {
    var response =
        await http.get(Uri.parse("${baseUrl}ipfs/$id"), headers: header);
    if (response.statusCode != 200) {
      showSnackWithoutContext("Something went Wrong!");

      return;
    }

    var result = UserData.fromJson(response.body);

    Get.find<MainController>().userData.value = result;

    callback(result);
  }

  /***************pdf Code************************/

  pdfIpFs(File file, Function callback) async {
    final request = http.MultipartRequest("POST", Uri.parse("${baseUrl}ipfs"));
    request.headers.addAll(headerForm);

    if (file == null) {
      showSnackWithoutContext("Pdf File Not Valid!");
      return;
    }

    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    final http.StreamedResponse response = await request.send();
    final String jsonDataString = await response.stream.bytesToString();
    final jsonData = jsonDecode(jsonDataString);

    var temp = GetEthereumformModel.fromJson(jsonData);
    Get.find<MainController>().pdfData.value.ipFsHash = temp.ipfsHash;

    pdfRecord(callback);
  }

  pdfRecord(Function callback) async {
    var data = Get.find<MainController>().pdfData.value;

    var publicKey = Get.find<MainController>().registrationData.value.publicKey;

    if (publicKey == null) {
      publicKey = Get.find<MainController>().loginSession.value.account;
    }

    var postData = {
      'data': data.ipFsHash,
      'chain': "ETH",
      'signatureId': "b7ad58f7-d826-4db5-8a52-4f492935a7b4",
      'to': publicKey
    };

    log("post Data => ${postData}");

    var request = http.Request("POST", Uri.parse("${baseUrl}record"));

    request.headers.addAll(header);
    request.body = json.encode(postData);

    http.StreamedResponse response = await request.send();

    var result = await response.stream.bytesToString();

    log("Response =>  $result");

    if (response.statusCode != 200) {
      showSnackWithoutContext("Wrong Record!");
      return;
    }

    var signatureId = SignatureId.fromJson(result);

    Get.find<MainController>().pdfData.value.signatureId =
        signatureId.signatureId;

    pdfKms(callback);
  }

  pdfKms(Function callback) async {
    var signatureId = Get.find<MainController>().pdfData.value.signatureId;
    var request = http.Request("GET", Uri.parse("${baseUrl}kms/$signatureId"));
    request.headers.addAll(header);

    var response = await request.send();

    if (response.statusCode != 200) {
      showSnackWithoutContext("Wrong Kms!");
      callback(false);
      return;
    }

    var result = await response.stream.bytesToString();

    var data = KmsModel.fromJson(result);

    var txConfigJson = stripHtmlIfNeeded(data.serializedTransaction);
    var txConfig = TxConfig.fromJson(txConfigJson);
    var publicKey = Get.find<MainController>().registrationData.value.publicKey;
    if (publicKey == null) {
      publicKey = Get.find<MainController>().loginSession.value.account;
    }
    var txFinalConfig = TxFinalConfig();
    txFinalConfig.from = publicKey;
    // var d = int.parse(txConfig.gasPrice).toRadixString(16);
    // log("Sunil hex => ${d}");
    txFinalConfig.gasPrice = txConfig.gasPrice;
    txFinalConfig.data = txConfig.data;
    txFinalConfig.to = txConfig.to;
    txFinalConfig.id = data.id;

    sendToMetaMask(txFinalConfig, callback);
  }

  sendToMetaMask(TxFinalConfig txFinalConfig, Function callback) async {
    var apiUrl =
        "https://sepolia.infura.io/v3/e9b0375c83db4b36b6fe52c06579ca24";
    var privateKey =
        Get.find<MainController>().registrationData.value.privateKey;
    var userData = Get.find<MainController>().registrationData.value.publicKey;
    if (userData == null) {
      userData = Get.find<MainController>().loginSession.value.account;
    }
    var httpClient = http.Client();
    var ethClient = Web3Client(apiUrl, httpClient);

    privateKey =
        "0xcedf55d482b42c49b9e10310031c45ecdaaabe771e1ba4d429798d3f6866e36a";
    if (privateKey == null) {
      sendToMetaMaskByConnector(txFinalConfig, ethClient, callback);
      return;
    }

    var credentials = EthPrivateKey.fromHex(privateKey);

    // var credentials =
    //     EthPrivateKey.fromHex("0xf86fa21ebf2b604f98322697a3b1eb7410301683");

    List<int> list = utf8.encode(txFinalConfig.data);
    Uint8List bytes = Uint8List.fromList(list);

    final amount = await ethClient.getBalance(credentials.address);

    if (amount.getInWei <= BigInt.from(0)) {
      showSnackWithoutContext("Insufficient Fund!");
      callback("Insufficient Fund!");
      return;
    }

    var result = await ethClient.sendTransaction(
        credentials,
        Transaction(
          from: EthereumAddress.fromHex(txFinalConfig.from),
          to: EthereumAddress.fromHex(txFinalConfig.to),
          gasPrice: EtherAmount.inWei(BigInt.parse(txFinalConfig.gasPrice)),
          maxGas: 100000,
          data: bytes,
          value: EtherAmount.inWei(BigInt.parse(txFinalConfig.gasPrice)),
        ),
        chainId: 11155111);

    Get.find<MainController>().storeDataInFirebase(
        publicKey: userData,
        value: result,
        callback: () {
          callback(true);
        });
  }

  sendToMetaMaskByConnector(TxFinalConfig txFinalConfig, Web3Client ethereum,
      Function callback) async {
    log("sunil come in sendtometamaskbyconnecetor");
    final connector = Get.find<MainController>().connector.value;

    if (connector == null) {
      showSnackWithoutContext("Please Login!");
      return;
    }
    final provider = EthereumWalletConnectProvider(connector);
    final credential = WalletConnectEthereumCredentials(provider: provider);

    List<int> list = utf8.encode(txFinalConfig.data);
    Uint8List bytes = Uint8List.fromList(list);

    final transaction = Transaction(
      from: EthereumAddress.fromHex(txFinalConfig.from),
      to: EthereumAddress.fromHex(txFinalConfig.from),
      gasPrice: EtherAmount.inWei(BigInt.parse(txFinalConfig.gasPrice)),
      maxGas: 100000,
      data: bytes,
      value: EtherAmount.inWei(BigInt.parse(txFinalConfig.gasPrice)),
    );

    final amount =
        await ethereum.getBalance(EthereumAddress.fromHex(txFinalConfig.from));
    log("Sunil amount => ${amount.getInWei} \n public key => ${txFinalConfig.from}");
    if (amount.getInWei <= BigInt.from(0)) {
      log("Sunil amount => ${amount.getInWei}");
      showSnackWithoutContext("Insufficient Fund!");
      callback("Insufficient Fund!");
      return;
    }

    final result = await ethereum
        .sendTransaction(credential, transaction, chainId: 5)
        .catchError((e) {
      log("Sunil error => ${e}");
    });

    // final result = await provider.sendTransaction(
    //     from: EthereumAddress.fromHex(txFinalConfig.from).toString(),
    //     to: transaction.to.toString(),
    //     gasPrice: BigInt.parse(txFinalConfig.gasPrice),
    //     data: bytes,
    //     value: BigInt.parse(txFinalConfig.gasPrice));

    log("Sunil login result => ${result}");

    Get.find<MainController>().storeDataInFirebase(
        publicKey: txFinalConfig.from,
        value: result,
        callback: () {
          callback(true);
        });
  }
}

String stripHtmlIfNeeded(String text) {
  return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
}
