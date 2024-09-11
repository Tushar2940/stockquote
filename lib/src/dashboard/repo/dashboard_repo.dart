import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stockquote/core/common/api_constant.dart';
import 'package:stockquote/src/dashboard/data/stock_search_model.dart';

class DashboardRepository {
  Future<List<StockSearchModel>> searchStock(String query) async {
    http.Response response = await http.get(
      Uri.parse(
        "${ApiConstant.baseUrl}function=SYMBOL_SEARCH&keywords=$query&apikey=${ApiConstant.apiKey}",
      ),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      final List result = data["bestMatches"];
      return result.map((e) => StockSearchModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
