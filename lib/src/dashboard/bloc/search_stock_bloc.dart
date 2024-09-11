import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:stockquote/src/dashboard/data/stock_search_model.dart';
import 'package:stockquote/src/dashboard/repo/dashboard_repo.dart';

part 'search_stock_event.dart';
part 'search_stock_state.dart';

class SearchStockBloc extends Bloc<SearchStockEvent, SearchStockState> {
  DashboardRepository dashboardRepository = DashboardRepository();
  SearchStockBloc() : super(SearchStockInitial()) {
    on<OnChangedSearchEvent>((event, emit) async {
      emit(SearchingStock());
      if(event.query.isEmpty){
        emit(SearchStockInitial());
      }else {
        try {
          var result = await dashboardRepository.searchStock(event.query);
          debugPrint(result.length.toString());
          emit(SearchedStock(result));
        } catch (e) {
          emit(SearchedError(e.toString()));
        }
      }
    });
  }
}
