part of 'search_stock_bloc.dart';

abstract class SearchStockEvent extends Equatable {
  const SearchStockEvent();

  @override
  List<Object?> get props => [];
}

class OnChangedSearchEvent extends SearchStockEvent{
  const OnChangedSearchEvent(this.query);
  final String query;

  @override
  List<Object?> get props => [query];
}