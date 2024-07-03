class ToggleFA {
  String? issuer;
  String? user;
  Config? config;
  String? secret;
  String? url;
  List<String>? backupCodes;
  String? qrcode;
  bool? isTwoFa;

  ToggleFA({
    this.issuer,
    this.user,
    this.config,
    this.secret,
    this.url,
    this.backupCodes,
    this.qrcode,
    this.isTwoFa,
  });

  ToggleFA.fromJson(Map<String, dynamic> json) {
    issuer = json['issuer'];
    user = json['user'];
    config = json['config'] != null ? Config.fromJson(json['config']) : null;
    secret = json['secret'];
    url = json['url'];
    backupCodes = json['backupCodes'] != null
        ? List<String>.from(json['backupCodes'])
        : null;
    qrcode = json['qrcode'];
    isTwoFa = json['isTwoFA'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isTwoFA'] = isTwoFa;

    data['issuer'] = issuer;
    data['user'] = user;
    if (config != null) {
      data['config'] = config!.toJson();
    }
    data['secret'] = secret;
    data['url'] = url;
    data['backupCodes'] = backupCodes;
    data['qrcode'] = qrcode;

    return data;
  }
}

class Config {
  String? algo;
  int? digits;
  int? period;
  int? secretSize;

  Config({
    this.algo,
    this.digits,
    this.period,
    this.secretSize,
  });

  Config.fromJson(Map<String, dynamic> json) {
    algo = json['algo'];
    digits = json['digits'];
    period = json['period'];
    secretSize = json['secretSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['algo'] = algo;
    data['digits'] = digits;
    data['period'] = period;
    data['secretSize'] = secretSize;
    return data;
  }
}
