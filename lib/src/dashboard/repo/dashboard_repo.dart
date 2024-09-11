import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stockquote/src/dashboard/data/stock_search_model.dart';

class DashboardRepository {
  Future<List<StockSearchModel>> searchStock(String query) async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://finnhub.io/api/v1/search?q=$query&exchange=US&token=crgra09r01qrbc70v6bgcrgra09r01qrbc70v6c0",
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List result = data["result"];

        if (result.isNotEmpty) {
          return result.map((e) => StockSearchModel.fromJson(e)).toList();
        } else {
          return [];
        }
      } else if(response.statusCode == 429){
        throw Exception("Status code: ${response.statusCode}\nApi limit is exceeded");
      }
      else {
        throw Exception("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      if(e.toString().contains("Failed host lookup")){
        throw Exception("Internet is not Connected");
      }
      throw Exception("Error occurred: $e");
    }
  }
}
