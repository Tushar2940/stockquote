import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stockquote/core/res/colors/stock_colors.dart';
import 'package:stockquote/src/stock/bloc/stock_info_bloc.dart';
import 'package:stockquote/src/watchlist/bloc/watch_list_bloc.dart';
import 'package:stockquote/src/watchlist/data/watch_list_model.dart';
import 'package:stockquote/utils/network_utils.dart';
import 'package:stockquote/utils/toast_utils.dart';
import 'package:toastification/toastification.dart';

class StockInfoScreen extends StatefulWidget {
  const StockInfoScreen({super.key, required this.symbol,required this.name});

  final String symbol;
  final String name;

  static const path = '/stockInfoScreen';

  @override
  State<StockInfoScreen> createState() => _StockInfoScreenState();
}

class _StockInfoScreenState extends State<StockInfoScreen> {
  StockInfoBloc stockInfoBloc = StockInfoBloc();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    debugPrint(widget.symbol);
    _checkInternetConnection();
  }

  Future<void> _checkInternetConnection() async {
    bool hasConnection = await InternetUtil.hasInternetConnection();
    if (!hasConnection) {
      notify("No Internet", ToastificationType.error);
      return;
    }
    _fetchStockData();
    _startAutoUpdate();
  }

  void _startAutoUpdate() {
    _timer = Timer.periodic(const Duration(seconds: 15), (Timer timer) {
      _fetchStockData();
    });
  }

  // Function to fetch stock data
  void _fetchStockData() {
    stockInfoBloc.add(GetStockInfoEvent(widget.symbol));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => stockInfoBloc,
      child: BlocListener<StockInfoBloc, StockInfoState>(
        listener: (context, state) {
          if(state is StockInfoError){
            notify(state.error, ToastificationType.error);
          }
        },
        child: Scaffold(
          appBar: AppBar(
          ),
          body: BlocBuilder<StockInfoBloc, StockInfoState>(
            builder: (context, state) {
              if (state is StockInfoLoading) {
                return const Center(child: CircularProgressIndicator(),);
              }
              if (state is StockInfoLoaded) {
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
                              Text(widget.symbol,style: Theme.of(context).textTheme.headlineMedium,),
                              Text(widget.name,style: Theme.of(context).textTheme.labelSmall,),
                              Text("${state.stockQuote.currentPrice} (${state.stockQuote.percentChange.toStringAsFixed(2)} %)",style: Theme.of(context).textTheme.bodyLarge,),
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
                                Text("${state.stockQuote.highPrice}",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: StockColors.white),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Low Price",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: StockColors.white),),
                                Text("${state.stockQuote.lowPrice}",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: StockColors.white),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Open Price",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: StockColors.white),),
                                Text("${state.stockQuote.openPrice}",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: StockColors.white),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("previous Close Price",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: StockColors.white),),
                                Text("${state.stockQuote.previousClosePrice}",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: StockColors.white),),
                              ],
                            ),

                          ],
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () => context.read<WatchListBloc>().add(AddToWatchListEvent(WatchListModel(name: widget.name,symbol: widget.symbol))),
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
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
