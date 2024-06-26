class GetEthereumWalletModel {
  String xpub;
  String mnemonic;

  GetEthereumWalletModel({this.xpub, this.mnemonic});

  GetEthereumWalletModel.fromJson(Map<String, dynamic> json) {
    xpub = json['xpub'];
    mnemonic = json['mnemonic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['xpub'] = this.xpub;
    data['mnemonic'] = this.mnemonic;
    return data;
  }
}

class EthereumAddressModel {
  String address;

  EthereumAddressModel({this.address});

  EthereumAddressModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    return data;
  }
}

class GetEthereumprivModel {
  String mnemonic;
  int index;
  String address;

  GetEthereumprivModel({this.mnemonic, this.index, this.address});

  GetEthereumprivModel.fromJson(Map<String, dynamic> json) {
    mnemonic = json['mnemonic'];
    index = json['index'];
    address = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mnemonic'] = this.mnemonic;
    data['index'] = this.index;
    data['address'] = this.address;

    return data;
  }
}

class GetEthereumformModel {
  String ipfsHash;

  GetEthereumformModel({this.ipfsHash});

  GetEthereumformModel.fromJson(Map<String, dynamic> json) {
    ipfsHash = json['ipfsHash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ipfsHash'] = this.ipfsHash;

    return data;
  }
}

class GetEthereumLedgerModel {
  String id;
  String currency;
  bool active;
  Balance balance;
  bool frozen;
  String xpub;
  String accountingCurrency;

  GetEthereumLedgerModel({
    this.currency,
    this.active,
    this.balance,
    this.frozen,
    this.xpub,
    this.accountingCurrency,
    this.id,
  });

  GetEthereumLedgerModel.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    active = json['active'];
    balance =
        json['balance'] != null ? new Balance.fromJson(json['balance']) : null;
    frozen = json['frozen'];
    xpub = json['xpub'];
    accountingCurrency = json['accountingCurrency'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency'] = this.currency;
    data['active'] = this.active;
    if (this.balance != null) {
      data['balance'] = this.balance.toJson();
    }
    data['frozen'] = this.frozen;
    data['xpub'] = this.xpub;
    data['accountingCurrency'] = this.accountingCurrency;
    data['id'] = this.id;

    return data;
  }
}

class Balance {
  String accountBalance;
  String availableBalance;

  Balance({this.accountBalance, this.availableBalance});

  Balance.fromJson(Map<String, dynamic> json) {
    accountBalance = json['accountBalance'];
    availableBalance = json['availableBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountBalance'] = this.accountBalance;
    data['availableBalance'] = this.availableBalance;
    return data;
  }
}

class GetEthereumChainModel {
  String xpub;
  int derivationKey;
  String address;
  String currency;

  GetEthereumChainModel(
      {this.xpub, this.currency, this.address, this.derivationKey});

  GetEthereumChainModel.fromJson(Map<String, dynamic> json) {
    xpub = json['xpub'];
    currency = json['currency'];
    address = json['address'];
    derivationKey = json['derivationKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['xpub'] = this.xpub;
    data['currency'] = this.currency;
    data['derivationKey'] = this.derivationKey;
    data['address'] = this.address;

    return data;
  }
}
