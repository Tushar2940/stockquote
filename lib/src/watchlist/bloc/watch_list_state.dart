part of 'watch_list_bloc.dart';

sealed class WatchListState extends Equatable {
  const WatchListState();
  @override
  List<Object> get props => [];
}

class WatchListInitial extends WatchListState {}

class WatchListLoading extends WatchListInitial {}

class WatchListLoaded extends WatchListInitial {
  WatchListLoaded(this.watchList);
  final List<WatchListModel> watchList;
  @override
  List<Object> get props => [watchList];
}

class WatchListError extends WatchListInitial {
  WatchListError(this.error);
  final String error;
  @override
  List<Object> get props => [error];
}