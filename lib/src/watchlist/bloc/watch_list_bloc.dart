import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:stockquote/src/watchlist/data/watch_list_model.dart';

part 'watch_list_event.dart';
part 'watch_list_state.dart';

class WatchListBloc extends Bloc<WatchListEvent, WatchListState> {
  List<WatchListModel> watchList = [];
  WatchListBloc() : super(WatchListInitial()) {
    on<AddToWatchListEvent>((event, emit) {
      watchList.add(event.watchListModel);
      emit(WatchListLoaded(watchList));
    });

    on<RemoveFromIndexWatchListEvent>((event, emit) {
      debugPrint(watchList.length.toString());
      watchList.removeAt(event.index);
      debugPrint(watchList.length.toString());
      emit(WatchListLoaded(watchList));
    });
  }
}
