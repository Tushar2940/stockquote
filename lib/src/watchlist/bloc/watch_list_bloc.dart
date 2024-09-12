import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:stockquote/src/watchlist/data/watch_list_model.dart';
import 'package:stockquote/utils/toast_utils.dart';
import 'package:toastification/toastification.dart';

part 'watch_list_event.dart';
part 'watch_list_state.dart';

class WatchListBloc extends HydratedBloc<WatchListEvent, WatchListState> {
  List<WatchListModel> watchList = [];
  WatchListBloc() : super(WatchListInitial()) {
    on<AddToWatchListEvent>((event, emit) {

      final exists = watchList.any((element) => element.symbol == event.watchListModel.symbol);

      if(!exists) {
        final updatedList = List<WatchListModel>.from(watchList)
          ..add(event.watchListModel);
        watchList = updatedList;
        notify("Stock is added to the watchlist", ToastificationType.success);
        emit(WatchListLoaded(updatedList));
      }else{
        notify("Stock already exists in the watchlist", ToastificationType.info);
        debugPrint("Stock already exists in the watchlist");
      }
    });

    on<RemoveFromIndexWatchListEvent>((event, emit) {
      final updatedList = List<WatchListModel>.from(watchList)..removeAt(event.index);
      watchList = updatedList;
      emit(WatchListLoaded(updatedList));
    });
  }

  @override
  WatchListState? fromJson(Map<String, dynamic> json) {
    if (json['data'] != null && (json['data'] as List<dynamic>).isNotEmpty) {
      return WatchListLoaded((json['data'] as List<dynamic>)
          .map((e) => WatchListModel.fromJson(e))
          .toList());
    }
    return WatchListInitial();
  }

  @override
  Map<String, dynamic>? toJson(WatchListState state) {
    if (state is WatchListLoaded) {
      return {'data': state.watchList.map((e) => e.toJson()).toList()};
    }
    return {'data': []};
  }
}
