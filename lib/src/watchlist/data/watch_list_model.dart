class WatchListModel{
  String? symbol;
  String? name;

  WatchListModel({this.symbol, this.name});

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
    };
  }

  factory WatchListModel.fromJson(Map<String, dynamic> map) {
    return WatchListModel(
      symbol: map['symbol'] ?? '',
      name: map['name'] ?? '',
    );
  }
}