import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:stockquote/core/common/api_constant.dart';

class DashboardRepository{

  Future<void> searchStock(String query) async {
    http.Response response = await http.get(
      Uri.parse("${ApiConstant.baseUrl}SYMBOL_SEARCH&keywords=$query&apikey=${ApiConstant.apiKey}"
      ),
    );
    debugPrint(response.statusCode.toString());
  }
}