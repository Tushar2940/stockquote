part of 'stock_info_bloc.dart';

sealed class StockInfoEvent extends Equatable {
  const StockInfoEvent();
  @override
  List<Object?> get props => [];
}

class GetStockInfoEvent extends StockInfoEvent{
  const GetStockInfoEvent(this.symbol);
  final String symbol;

  @override
  List<Object?> get props => [symbol];
}