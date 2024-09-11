import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockquote/core/res/colors/stock_colors.dart';
import 'package:stockquote/src/watchlist/bloc/watch_list_bloc.dart';
import 'package:stockquote/src/watchlist/data/watch_list_model.dart';

class WatchListCard extends StatelessWidget {
  const WatchListCard({super.key, required this.watchListModel,required this.index});
  final WatchListModel watchListModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(16.0),
      decoration: ShapeDecoration(
        color: StockColors.primaryColor.withOpacity(0.2),
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(60)
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(watchListModel.symbol ?? '',style: Theme.of(context).textTheme.titleLarge,),
                Text(watchListModel.name ?? '',style: Theme.of(context).textTheme.labelSmall,),
              ],
            ),
          ),
          IconButton(icon: const Icon(CupertinoIcons.delete,color: Colors.redAccent),
            onPressed: () => context.read<WatchListBloc>().add(RemoveFromIndexWatchListEvent(index)),)
        ],
      ),
    );
  }
}
