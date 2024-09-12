import 'package:flutter/material.dart';
import 'package:stockquote/core/res/media/stock_media.dart';
import 'package:stockquote/core/res/text/stock_text.dart';

class SearchPlaceHolder extends StatelessWidget {
  const SearchPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(StockMedia.searchPlaceholder),
          const Text(
            StockText.searchPlaceholderText,
          ),
        ],
      ),
    );
  }
}
