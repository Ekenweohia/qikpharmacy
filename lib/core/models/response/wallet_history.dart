class WalletHistories {
  String? walletHistoryId;
  String? type;
  int? amount;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;

  WalletHistories(
      {this.walletHistoryId,
        this.type,
        this.amount,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt});

  WalletHistories.fromJson(Map<String, dynamic> json) {
    walletHistoryId = json['walletHistoryId'];
    type = json['type'];
    amount = json['amount'];
    description = json['description'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['walletHistoryId'] = walletHistoryId;
    data['type'] = type;
    data['amount'] = amount;
    data['description'] = description;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
