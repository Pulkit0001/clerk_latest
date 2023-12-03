import 'package:clerk/app/custom_widgets/clerk_progress_indicator.dart';
import 'package:clerk/app/custom_widgets/empty_state_view.dart';
import 'package:clerk/app/modules/invoices/widgets/invoice_page_view.dart';
import 'package:clerk/app/modules/invoices/bloc/cubit/invoice_list_cubit.dart';
import 'package:clerk/app/modules/invoices/bloc/state/invoice_list_state.dart';
import 'package:clerk/app/repository/invoice_repo/invoice_repo.dart';
import 'package:clerk/app/utils/enums/invoice_status.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InvoicePager extends StatelessWidget {
  const InvoicePager({Key? key}) : super(key: key);

  static Route<dynamic> getRoute(
          [List<String>? candidateIds]) =>
      MaterialPageRoute(
          builder: (_) => BlocProvider<InvoiceListCubit>(
              create: (_) => InvoiceListCubit(
                  repo: getIt<InvoiceRepo>(),
                  status: InvoiceStatus.pending,
                  candidateIds: candidateIds),
              child: InvoicePager()));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoiceListCubit, InvoiceListState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: state.viewState == ViewState.idle
              ? PageView.builder(
                  itemCount: state.invoices.length,
                  itemBuilder: (context, index) =>
                      InvoicePageView.getWidget(state.invoices[index]),
                )
              : ViewState.loading == state.viewState
                  ? ClerkProgressIndicator()
                  : (ViewState.empty == state.viewState ||
                          ViewState.error == state.viewState)
                      ? EmptyStateWidget(
                          image: 'assets/illustrations/no_data.svg',
                          message:
                              'Congratulations!!! No Pending Invoices Found.')
                      : EmptyStateWidget(
                          image: 'assets/illustrations/no_data.svg',
                          message: "Didn't find any Pending Invoices.",
                        ),
        );
      },
    );
  }
}
