import 'package:clerk/app/modules/charge/bloc/states/charge_detail_state.dart';
import 'package:clerk/app/modules/charge/bloc/states/charge_list_state.dart';
import 'package:clerk/app/repository/charge_repo/charge_repo.dart';
import 'package:clerk/app/utils/enums/payment_interval_enums.dart';
import 'package:clerk/app/utils/enums/payment_type.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:clerk/app/values/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChargesListCubit extends Cubit<ChargesListState> {
  ChargesListCubit({
    required this.repo,
    required this.charges,
    this.excludeCharges = const <String>[],
    this.type,
    this.interval,
  }) : super(ChargesListState.initial()) {
    loadCharges(charges, excludeCharges);
  }

  final List<String>? charges;
  final List<String>? excludeCharges;
  final PaymentType? type;
  final PaymentInterval? interval;
  final ChargeRepo repo;

  loadCharges(List<String>? chargeIds, [List<String>? excludeCharges]) async {
    try {
      emit(state.copyWith(viewState: ViewState.loading));
      var res = await repo.getAllCharges(
          chargeIds: chargeIds,
          type: type,
          interval: interval,
          excludeCharges: excludeCharges);
      res.fold((l) {
        if (l.isEmpty) {
          emit(state.copyWith(charges: l, viewState: ViewState.empty));
        } else {
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

  Future<bool> deleteCharge(String id) async {
    try {
      emit(state.copyWith(viewState: ViewState.loading));
      var res = await repo.deleteCharge(chargeId: id);
      return res.fold<bool>((l) {
        if (l) {
          emit(state.copyWith(
            viewState: ViewState.idle,
            errorMessage: "Charge deleted successfully",
          ));
          loadCharges(charges, excludeCharges);
          return true;
        } else {
          emit(state.copyWith(errorMessage: defaultErrorBody));
          return false;
        }
      }, (r) {
        emit(state.copyWith(errorMessage: defaultErrorBody));
        return false;
      });
    } catch (e) {
      emit(state.copyWith(errorMessage: defaultErrorBody));
      return false;
    }
  }
}
