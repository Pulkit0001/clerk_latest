import 'package:clerk/app/utils/enums/view_state_enums.dart';

class DashboardState {
  final int pageIndex;
  final num totalPendingAmount;
  final ViewState pendingAmountState;

  DashboardState(
      {required this.pageIndex,
      required this.pendingAmountState,
      required this.totalPendingAmount});

  factory DashboardState.initial() => DashboardState(
        pageIndex: 1,
        pendingAmountState: ViewState.empty,
        totalPendingAmount: 0,
      );

  DashboardState copyWith({
    int? pageIndex,
    num? totalPendingAmount,
    ViewState? pendingAmountState,
  }) =>
      DashboardState(
        pageIndex: pageIndex ?? this.pageIndex,
        pendingAmountState: pendingAmountState ?? this.pendingAmountState,
        totalPendingAmount: totalPendingAmount ?? this.totalPendingAmount,
      );
}
