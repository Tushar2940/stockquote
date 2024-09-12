import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stockquote/src/stock/data/stock_quote_model.dart';

class StockInfoRepository{
  Future<StockQuoteModel> quote(String symbol) async {
    debugPrint("https://finnhub.io/api/v1/quote?symbol=$symbol&token=crgra09r01qrbc70v6bgcrgra09r01qrbc70v6c0");
    try {
      final response = await http.get(
        Uri.parse(
          "https://finnhub.io/api/v1/quote?symbol=$symbol&token=crgra09r01qrbc70v6bgcrgra09r01qrbc70v6c0",
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return StockQuoteModel.fromJson(data);
      }
      else if(response.statusCode == 429){
        throw Exception("Status code: ${response.statusCode}\nApi limit is exceeded");
      }
      else if(response.statusCode == 403){
        throw Exception("Status code: ${response.statusCode}\nYou don't have access to this resource.");
      }
      else {
        throw Exception("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      if(e.toString().contains("Failed host lookup")){
        throw Exception("Internet is not Connected");
      }
      throw Exception("$e");
    }
  }
}