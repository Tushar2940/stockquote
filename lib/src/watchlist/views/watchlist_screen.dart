import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stockquote/src/stock/views/stock_info_screen.dart';
import 'package:stockquote/src/watchlist/bloc/watch_list_bloc.dart';
import 'package:stockquote/src/watchlist/views/watchlist_card.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  static const path = '/watchListScreen';

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("WatchList",style: Theme.of(context).textTheme.titleLarge),),
      body: BlocBuilder<WatchListBloc,WatchListState>(
        builder: (context, state) {
          if(state is WatchListLoaded){
            if(state.watchList.isNotEmpty){
              return ListView.builder(
                itemCount: state.watchList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        context.push("${StockInfoScreen.path}?symbol=${state.watchList[index].symbol}&name=${state.watchList[index].name}");
                      },
                      child: WatchListCard(watchListModel: state.watchList[index],index: index,));
                },
              );
            }
            else{
              return Center(child: Text("WatchList is Empty",style: Theme.of(context).textTheme.labelLarge,),);
            }
          }
          return Center(child: Text("WatchList is Empty",style: Theme.of(context).textTheme.titleLarge,),);
        },
      )
    );
  }
}
