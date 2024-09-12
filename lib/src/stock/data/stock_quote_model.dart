class StockQuoteModel {
  final num currentPrice;
  final num change;
  final num percentChange;
  final num highPrice;
  final num lowPrice;
  final num openPrice;
  final num previousClosePrice;
  final int timestamp;

  StockQuoteModel({
    required this.currentPrice,
    required this.change,
    required this.percentChange,
    required this.highPrice,
    required this.lowPrice,
    required this.openPrice,
    required this.previousClosePrice,
    required this.timestamp,
  });


  factory StockQuoteModel.fromJson(Map<String, dynamic> json) {
    return StockQuoteModel(
      currentPrice: json['c'] ?? 0,
      change: json['d'] ?? 0,
      percentChange: json['dp'] ?? 0,
      highPrice: json['h'] ?? 0,
      lowPrice: json['l'] ?? 0,
      openPrice: json['o'] ?? 0,
      previousClosePrice: json['pc'] ?? 0,
      timestamp: json['t'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'c': currentPrice,
      'd': change,
      'dp': percentChange,
      'h': highPrice,
      'l': lowPrice,
      'o': openPrice,
      'pc': previousClosePrice,
      't': timestamp,
    };
  }
}