import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stockquote/src/dashboard/repo/dashboard_repo.dart';

part 'search_stock_event.dart';
part 'search_stock_state.dart';

class SearchStockBloc extends Bloc<SearchStockEvent, SearchStockState> {
  DashboardRepository dashboardRepository = DashboardRepository();
  SearchStockBloc() : super(SearchStockInitial()) {
    on<OnChangedSearchEvent>((event, emit) {
      emit(SearchingStock());
      try{
        var result = dashboardRepository.searchStock(event.query);
      }catch(e){

      }
    });
  }
}
