class StockSearchModel {
  String? symbol;
  String? name;
  String? type;
  String? region;
  String? marketOpen;
  String? marketClose;
  String? timezone;
  String? currency;
  String? matchScore;

  StockSearchModel(
      {this.symbol,
        this.name,
        this.type,
        this.region,
        this.marketOpen,
        this.marketClose,
        this.timezone,
        this.currency,
        this.matchScore});

  StockSearchModel.fromJson(Map<String, dynamic> json) {
    symbol = json['1. symbol'];
    name = json['2. name'];
    type = json['3. type'];
    region = json['4. region'];
    marketOpen = json['5. marketOpen'];
    marketClose = json['6. marketClose'];
    timezone = json['7. timezone'];
    currency = json['8. currency'];
    matchScore = json['9. matchScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['1. symbol'] = Symbol;
    data['2. name'] = name;
    data['3. type'] = Type;
    data['4. region'] = region;
    data['5. marketOpen'] = marketOpen;
    data['6. marketClose'] = marketClose;
    data['7. timezone'] = timezone;
    data['8. currency'] = currency;
    data['9. matchScore'] = matchScore;
    return data;
  }
}
