part of 'search_stock_bloc.dart';

abstract class SearchStockState extends Equatable {
  const SearchStockState();
  @override
  List<Object> get props => [];
}

class SearchStockInitial extends SearchStockState {}

class SearchingStock extends SearchStockState {}

class SearchedStock extends SearchStockState {}

class SearchedError extends SearchStockState {}


