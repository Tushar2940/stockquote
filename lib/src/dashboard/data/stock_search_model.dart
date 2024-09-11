class StockSearchModel {
  final String description;
  final String displaySymbol;
  final String symbol;
  final String type;

  StockSearchModel({
    required this.description,
    required this.displaySymbol,
    required this.symbol,
    required this.type,
  });

  // Factory method to create a StockResultModel from a JSON object
  factory StockSearchModel.fromJson(Map<String, dynamic> json) {
    return StockSearchModel(
      description: json['description'] ?? '',
      displaySymbol: json['displaySymbol'] ?? '',
      symbol: json['symbol'] ?? '',
      type: json['type'] ?? '',
    );
  }

  // Method to convert a StockResultModel instance to JSON format
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'displaySymbol': displaySymbol,
      'symbol': symbol,
      'type': type,
    };
  }

  // Static method to parse a list of JSON objects into a list of StockResultModel
  static List<StockSearchModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => StockSearchModel.fromJson(json)).toList();
  }
}
