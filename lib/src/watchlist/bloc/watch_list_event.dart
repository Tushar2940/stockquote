part of 'watch_list_bloc.dart';

sealed class WatchListEvent extends Equatable {
  const WatchListEvent();
}

class AddToWatchListEvent extends WatchListEvent{
  const AddToWatchListEvent(this.watchListModel);
  final WatchListModel watchListModel;

  @override
  List<Object?> get props => [watchListModel];
}

class RemoveFromIndexWatchListEvent extends WatchListEvent{
  const RemoveFromIndexWatchListEvent(this.index);
  final int index;

  @override
  List<Object?> get props => [index];
}