import 'package:clerk/app/modules/search/bloc/search_state.dart';
import 'package:clerk/app/repository/candidate_repo/candidate_repo.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.repo}) : super(SearchState.initial());

  TextEditingController searchController = TextEditingController();

  final CandidateRepo repo;
  Future<void> searchQuery() async {
    try {
      if (searchController.text.trim() != state.searchQuery) {
        emit(state.copyWith(
            viewState: ViewState.loading,
            searchQuery: searchController.text.trim()));
        var res = await repo.searchCandidates(searchQuery: state.searchQuery);
        res.fold((l) {
          if (l.isNotEmpty) {
            emit(state.copyWith(viewState: ViewState.idle, searchedItems: l));
          } else {
            emit(state.copyWith(viewState: ViewState.empty, searchedItems: l));
          }
        }, (r) {});
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
