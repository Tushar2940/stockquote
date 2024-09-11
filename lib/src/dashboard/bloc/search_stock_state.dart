part of 'search_stock_bloc.dart';

abstract class SearchStockState extends Equatable {
  const SearchStockState();
  @override
  List<Object> get props => [];
}

class SearchStockInitial extends SearchStockState {}

class SearchingStock extends SearchStockState {}

class SearchedStock extends SearchStockState {
  const SearchedStock(this.stockList);
  final List<StockSearchModel> stockList;
  @override
  List<Object> get props => [stockList];
}

class SearchedError extends SearchStockState {
  const SearchedError(this.error);
  final String error;
  @override
  List<Object> get props => [error];
}


