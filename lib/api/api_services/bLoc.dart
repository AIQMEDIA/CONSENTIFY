import 'package:consentify/api/api_services/models/EthereumAddress.dart';
import 'package:consentify/api/api_services/models/models.dart';
import 'package:consentify/api/api_services/repo.dart';
import 'package:rxdart/rxdart.dart';

class GetEthereumwalletbloc {
  final _getyEthereumwallet = PublishSubject<GetEthereumwalletModel>();
  final _repository = Repository();

  Stream<GetEthereumwalletModel> get getEthereumwalletstream =>
      _getyEthereumwallet.stream;

  Future getEthereumwalletsink() async {
    // ignore: non_constant_identifier_names
    final GetEthereumwalletModel Model =
        await _repository.ongetEthereumwalletApi();
    _getyEthereumwallet.sink.add(Model);
  }

  void dispose() {
    _getyEthereumwallet.close();
  }
}

final getEthereumwalletbloc = GetEthereumwalletbloc();

// ========================================================================================== //
class GetEthereumAddressbloc {
  final _getyEthereumAddress = PublishSubject<EthereumAddress>();
  final _repository = AddressRepository();

  Stream<EthereumAddress> get getEthereumAddressstream =>
      _getyEthereumAddress.stream;

  Future getEthereumAddresssink() async {
    // ignore: non_constant_identifier_names
    final EthereumAddress Model =
        await _repository.ongetEthereumAddressApi();
    _getyEthereumAddress.sink.add(Model);
  }

  void dispose() {
    _getyEthereumAddress.close();
  }
}

final getEthereumAddressbloc = GetEthereumAddressbloc();
