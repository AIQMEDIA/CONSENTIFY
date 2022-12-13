import 'package:consentify/api/api_services/models/models.dart';
import 'package:consentify/api/api_services/repo.dart';
import 'package:rxdart/rxdart.dart';

class GetEthereumwalletbloc {
  final _getyEthereumwallet = PublishSubject<GetEthereumWalletModel>();
  final _repository = Repository();

  Stream<GetEthereumWalletModel> get getEthereumwalletstream =>
      _getyEthereumwallet.stream;

  Future getEthereumwalletsink() async {
    // ignore: non_constant_identifier_names
    final GetEthereumWalletModel Model =
        await _repository.ongetEthereumwalletApi();
    _getyEthereumwallet.sink.add(Model);
  }

  void dispose() {
    _getyEthereumwallet.close();
  }
}

final getEthereumwalletbloc = GetEthereumwalletbloc();
