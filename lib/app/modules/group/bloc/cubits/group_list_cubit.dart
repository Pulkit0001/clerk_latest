import 'package:clerk/app/modules/group/bloc/states/group_list_state.dart';
import 'package:clerk/app/repository/group_repo/group_repo.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupListCubit extends Cubit<GroupsListState> {
  GroupListCubit({
    required this.repo,
  }) : super(GroupsListState.initial()) {
    loadGroup(null);
  }

  final GroupRepo repo;

  loadGroup(List<String>? groupIds) async {
    try {
      emit(state.copyWith(viewState: ViewState.loading));
      var res = await repo.getAllGroups(groupIds: groupIds);
      res.fold((l) {
        if(l.isEmpty){
          emit(state.copyWith(groups: l, viewState: ViewState.empty));
        }else {
          emit(state.copyWith(groups: l, viewState: ViewState.idle));
        }
      }, (r) {
        emit(state.copyWith(errorMessage: r, viewState: ViewState.error));
      });
    } catch (e) {
      emit(state.copyWith(
          viewState: ViewState.error, errorMessage: e.toString()));
    }
  }
}
