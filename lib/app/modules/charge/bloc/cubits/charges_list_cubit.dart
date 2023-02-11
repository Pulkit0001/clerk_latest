import 'package:clerk/app/modules/charge/bloc/states/charge_detail_state.dart';
import 'package:clerk/app/modules/charge/bloc/states/charge_list_state.dart';
import 'package:clerk/app/repository/charge_repo/charge_repo.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChargesListCubit extends Cubit<ChargesListState> {
  ChargesListCubit({
    required this.repo,
    required this.charges,
  }) : super(ChargesListState.initial()) {
    loadCharges(charges);
  }

  final List<String>? charges;
  final ChargeRepo repo;

  loadCharges(List<String>? chargeIds) async {
    try {
      emit(state.copyWith(viewState: ViewState.loading));
      var res = await repo.getAllCharges(chargeIds: chargeIds);
      res.fold((l) {
        if(l.isEmpty){
          emit(state.copyWith(charges: l, viewState: ViewState.empty));
        }else{
          emit(state.copyWith(charges: l, viewState: ViewState.idle));
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
