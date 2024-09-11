import 'package:flutter/material.dart';
import 'package:stockquote/src/dashboard/data/stock_search_model.dart';

class SearchedListWidget extends StatelessWidget {
  const SearchedListWidget({super.key,required this.list});
  final List<StockSearchModel> list;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Text(list[index].name ?? '');
        },
      ),
    );
  }
}
