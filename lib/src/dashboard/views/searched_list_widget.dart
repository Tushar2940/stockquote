import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stockquote/src/dashboard/data/stock_search_model.dart';
import 'package:stockquote/src/stock/views/stock_info_screen.dart';

class SearchedListWidget extends StatelessWidget {
  const SearchedListWidget({super.key,required this.list});
  final List<StockSearchModel> list;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                context.push("${StockInfoScreen.path}?symbol=${list[index].symbol}&name=${list[index].description}");
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(list[index].symbol ?? '',style: Theme.of(context).textTheme.bodyLarge,),
                      const Icon(Iconsax.arrow_right_1_copy),
                    ],
                  ),
                  Text(list[index].description ?? '',style: Theme.of(context).textTheme.bodyLarge,),
                  const Divider()
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
