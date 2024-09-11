class StockQuoteModel {
  final double currentPrice;
  final double change;
  final double percentChange;
  final double highPrice;
  final double lowPrice;
  final double openPrice;
  final double previousClosePrice;
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
      currentPrice: json['c'].toDouble(),
      change: json['d'].toDouble(),
      percentChange: json['dp'].toDouble(),
      highPrice: json['h'].toDouble(),
      lowPrice: json['l'].toDouble(),
      openPrice: json['o'].toDouble(),
      previousClosePrice: json['pc'].toDouble(),
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