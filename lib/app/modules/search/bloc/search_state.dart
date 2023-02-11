import 'package:clerk/app/utils/enums/view_state_enums.dart';

class SearchState {
  final ViewState viewState;
  final String searchQuery;
  final List<String> searchedItems;

  SearchState(
      {required this.viewState,
      required this.searchQuery,
      required this.searchedItems});

  factory SearchState.initial() => SearchState(
      viewState: ViewState.idle, searchQuery: "", searchedItems: <String>[]);
  copyWith({
    ViewState? viewState,
    String? searchQuery,
    List<String>? searchedItems,
  }) =>
      SearchState(
          viewState: viewState ?? this.viewState,
          searchQuery: searchQuery ?? this.searchQuery,
          searchedItems: searchedItems ?? this.searchedItems);
}
