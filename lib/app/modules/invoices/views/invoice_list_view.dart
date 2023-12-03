import 'package:clerk/app/custom_widgets/empty_state_view.dart';
import 'package:clerk/app/custom_widgets/invoice_list_item_view.dart';
import 'package:clerk/app/modules/candidate/views/candidte_detail_view.dart';
import 'package:clerk/app/modules/invoices/bloc/cubit/invoice_list_cubit.dart';
import 'package:clerk/app/modules/invoices/bloc/state/invoice_list_state.dart';
import 'package:clerk/app/repository/invoice_repo/invoice_repo.dart';
import 'package:clerk/app/utils/enums/invoice_status.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../custom_widgets/clerk_progress_indicator.dart';
import '../../../values/colors.dart';

class InvoiceListView extends StatelessWidget {
  const InvoiceListView({Key? key}) : super(key: key);

  static Route<dynamic> getRoute({
    InvoiceStatus? status,
    List<String>? candidateIds,
  }) {
    return MaterialPageRoute(
      builder: (context) =>
          getWidget(status: status, candidateIds: candidateIds),
    );
  }

  static Widget getWidget({
    InvoiceStatus? status,
    List<String>? candidateIds,
  }) {
    return BlocProvider(
      create: (context) => InvoiceListCubit(
        repo: getIt<InvoiceRepo>(),
        candidateIds: candidateIds,
        status: status,
      ),
      child: InvoiceListView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoiceListCubit, InvoiceListState>(
      builder: (context, state) {
        if (state.viewState == ViewState.idle) {
          return state.invoices.isEmpty
              ? EmptyStateWidget(
                  image: 'assets/illustrations/no_data.svg',
                  message: 'No Invoices Found!!!.')
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.invoices.length,
                  itemBuilder: (BuildContext context, int index) => InkWell(
                    onTap: () {
                      context.navigate.push(CandidateDetailView.getRoute(
                          state.invoices.elementAt(index).candidate!.id));
                    },
                    child: InvoiceListItem(
                      invoice: state.invoices.elementAt(index),
                    ),
                  ),
                );
        } else if (state.viewState == ViewState.loading) {
          return ClerkProgressIndicator();
        } else if (
            state.viewState == ViewState.error) {
          return ErrorStateWidget(
            image: '',
            message:
                "Sorry We got some error in loading your invoices please try again.!!",
            onActionPressed: () {
              context.read<InvoiceListCubit>().loadInvoice();
            },
          );
        } else {
          return EmptyStateWidget(
            image: '',
            message: "No Invoices Found!!",
          );
        }
      },
    );
  }
}
