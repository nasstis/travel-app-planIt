part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchWordRequired extends SearchEvent {
  final String word;

  const SearchWordRequired(this.word);
}
