import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stockquote/core/res/colors/stock_colors.dart';
import 'package:stockquote/core/widgets/loader_widget.dart';
import 'package:stockquote/src/stock/bloc/stock_info_bloc.dart';
import 'package:stockquote/src/stock/views/stock_details_widget.dart';
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
            _timer?.cancel();
            notify(state.error, ToastificationType.error);
          }
        },
        child: Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: BlocBuilder<StockInfoBloc, StockInfoState>(
              builder: (context, state) {
                if (state is StockInfoLoading) {
                  return const LoaderWidget();
                }
                if (state is StockInfoLoaded) {
                  return StockDetails(name: widget.name,symbol: widget.symbol,stockQuote: state.stockQuote,);
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
