import 'package:clerk/app/modules/charge/bloc/states/charge_detail_state.dart';
import 'package:clerk/app/repository/charge_repo/charge_repo.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChargeDetailsCubit extends Cubit<ChargeDetailsState> {
  ChargeDetailsCubit({
    required String chargeId,
    required this.repo,
  }) : super(ChargeDetailsState.initial(chargeId: chargeId)) {
    loadCharge();
  }

  final ChargeRepo repo;

  loadCharge() async {
    try {
      emit(state.copyWith(viewState: ViewState.loading));
      var res = await repo.getAllCharges(chargeIds: [state.chargeId]);
      res.fold((l) {
        emit(state.copyWith(charge: l.first, viewState: ViewState.idle));
      }, (r) {
        emit(state.copyWith(errorMessage: r, viewState: ViewState.error));
      });
    } catch (e) {
      emit(state.copyWith(
          viewState: ViewState.error, errorMessage: e.toString()));
    }
  }
}
