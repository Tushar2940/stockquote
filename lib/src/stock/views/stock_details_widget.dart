import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stockquote/core/res/colors/stock_colors.dart';
import 'package:stockquote/src/stock/data/stock_quote_model.dart';
import 'package:stockquote/src/watchlist/bloc/watch_list_bloc.dart';
import 'package:stockquote/src/watchlist/data/watch_list_model.dart';

class StockDetails extends StatelessWidget {
  const StockDetails({super.key,required this.symbol,required this.name,required this.stockQuote});
  final String symbol;
  final String name;
  final StockQuoteModel stockQuote;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: StockColors.primaryColor,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(Iconsax.activity_copy,color: StockColors.white,),
                ),
              ),
              const SizedBox(width: 16,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(symbol,style: Theme.of(context).textTheme.headlineMedium,),
                  Text(name,style: Theme.of(context).textTheme.labelMedium,),
                  Text("${stockQuote.currentPrice} (${stockQuote.percentChange.toStringAsFixed(2)} %)",style: Theme.of(context).textTheme.bodyLarge,),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32,),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: ShapeDecoration(
              color: StockColors.primaryColor,
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(60)
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("High Price",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: StockColors.white),),
                    Text("${stockQuote.highPrice}",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: StockColors.white),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Low Price",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: StockColors.white),),
                    Text("${stockQuote.lowPrice}",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: StockColors.white),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Open Price",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: StockColors.white),),
                    Text("${stockQuote.openPrice}",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: StockColors.white),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("previous Close Price",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: StockColors.white),),
                    Text("${stockQuote.previousClosePrice}",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: StockColors.white),),
                  ],
                ),

              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          GestureDetector(
            onTap: () => context.read<WatchListBloc>().add(AddToWatchListEvent(WatchListModel(name: name,symbol: symbol))),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: ShapeDecoration(
                color: StockColors.primaryColor,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(60)
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.bookmark_copy,color: StockColors.white,),
                  const SizedBox(width: 16,),
                  Text("Add To WatchList",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: StockColors.white),)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
