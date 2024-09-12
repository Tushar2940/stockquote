import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:stockquote/core/res/colors/stock_colors.dart';
import 'package:stockquote/core/res/media/stock_media.dart';
import 'package:stockquote/core/res/text/stock_text.dart';
import 'package:stockquote/core/widgets/loader_widget.dart';
import 'package:stockquote/core/widgets/search_placeholder.dart';
import 'package:stockquote/src/dashboard/bloc/search_stock_bloc.dart';
import 'package:stockquote/src/dashboard/views/searched_list_widget.dart';
import 'package:stockquote/src/stock/views/stock_info_screen.dart';
import 'package:stockquote/src/watchlist/views/watchlist_screen.dart';
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
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => searchStockBloc,
      child: BlocListener<SearchStockBloc, SearchStockState>(
        listener: (context, state) {
          if (state is SearchedError) {
            FocusScope.of(context).requestFocus(FocusNode());
            notify(state.error, ToastificationType.error);
          }
        },
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: StockColors.primaryColor,
            child: const Icon(
              Iconsax.bookmark_copy,
              color: Colors.white,
            ),
            onPressed: () {
              context.push(WatchlistScreen.path);
            },
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextFormField(
                    controller: searchController,
                    decoration: const InputDecoration(labelText: "Search"),
                    onTapOutside: (event) =>
                        FocusScope.of(context).requestFocus(FocusNode()),
                    onChanged: (value) {
                      _debouncer.run(() =>
                          searchStockBloc.add(OnChangedSearchEvent(value)));
                    },
                  ),
                  BlocBuilder<SearchStockBloc, SearchStockState>(
                    builder: (context, state) {
                      if (state is SearchedStock) {
                        if(state.stockList.isEmpty){
                          return Expanded(
                            child: Center(
                              child: Text("Invalid Symbol",style: Theme.of(context).textTheme.headlineLarge,),
                            ),
                          );
                        }else {
                          return SearchedListWidget(list: state.stockList);
                        }
                      }
                      if (state is SearchingStock) {
                        return const Expanded(child: LoaderWidget());
                      }
                      return const SearchPlaceHolder();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
