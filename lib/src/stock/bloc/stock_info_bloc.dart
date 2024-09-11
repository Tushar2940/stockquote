import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stockquote/src/stock/data/stock_quote_model.dart';
import 'package:stockquote/src/stock/repo/stock_info_repo.dart';

part 'stock_info_event.dart';
part 'stock_info_state.dart';

class StockInfoBloc extends Bloc<StockInfoEvent, StockInfoState> {
  StockInfoRepository stockInfoRepository = StockInfoRepository();
  var isRefreshed = false;
  StockInfoBloc() : super(StockInfoInitial()) {
    on<GetStockInfoEvent>((event, emit) async {
      if(!isRefreshed) {
        emit(StockInfoLoading());
      }
      try {
        var result = await stockInfoRepository.quote(event.symbol);
        isRefreshed = true;
        emit(StockInfoLoaded(result));
      } catch (e) {
        emit(StockInfoError(e.toString()));
      }
    });
  }
}
