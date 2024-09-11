import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stockquote/core/res/colors/stock_colors.dart';
import 'package:stockquote/core/res/media/stock_media.dart';
import 'package:stockquote/core/res/text/stock_text.dart';
import 'package:stockquote/src/dashboard/bloc/search_stock_bloc.dart';
import 'package:stockquote/src/dashboard/views/searched_list_widget.dart';
import 'package:stockquote/utils/debouncer.dart';
import 'package:stockquote/utils/network_utils.dart';
import 'package:stockquote/utils/toast_utils.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  static const path = '/dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController searchController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 500);
  SearchStockBloc searchStockBloc = SearchStockBloc();

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
  }

  Future<void> _checkInternetConnection() async {
    bool hasConnection = await InternetUtil.hasInternetConnection();
    if (!hasConnection) {
      notify("No Internet", ToastificationType.error);
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => searchStockBloc,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: StockColors.primaryColor,
          child: const Icon(Iconsax.bookmark_copy, color: Colors.white,),
          onPressed: () {},
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                TextFormField(
                  controller: searchController,
                  decoration: const InputDecoration(
                      labelText: "Search"
                  ),
                  onTapOutside: (event) =>
                      FocusScope.of(context).requestFocus(FocusNode()),
                  onChanged: (value) {
                    _debouncer.run(() =>
                        searchStockBloc.add(OnChangedSearchEvent(value)));
                  },
                ),
                BlocBuilder<SearchStockBloc, SearchStockState>(
                  builder: (context, state) {
                    if(state is SearchedStock){
                      return SearchedListWidget(list: state.stockList);
                    }
                    if(state is SearchedError){
                      notify(state.error, ToastificationType.error);
                    }
                    return Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(StockMedia.searchPlaceholder),
                          const Text(StockText.searchPlaceholderText,),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
