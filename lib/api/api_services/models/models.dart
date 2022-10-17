class  GetEthereumwalletModel {
  String xpub;
  String mnemonic;

  GetEthereumwalletModel({this.xpub, this.mnemonic});

 GetEthereumwalletModel.fromJson(Map<String, dynamic> json) {
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
