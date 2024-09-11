part of 'stock_info_bloc.dart';

sealed class StockInfoState extends Equatable {
  const StockInfoState();
  @override
  List<Object> get props => [];
}

class StockInfoInitial extends StockInfoState {}

class StockInfoLoading extends StockInfoInitial {}

class StockInfoLoaded extends StockInfoInitial {
  StockInfoLoaded(this.stockQuote);
  final StockQuoteModel stockQuote;
  @override
  List<Object> get props => [stockQuote];
}

class StockInfoError extends StockInfoInitial {
  StockInfoError(this.error);
  final String error;
  @override
  List<Object> get props => [error];
}
