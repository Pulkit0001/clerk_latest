import 'package:clerk/app/custom_widgets/empty_state_view.dart';
import 'package:clerk/app/modules/charge/bloc/states/charge_list_state.dart';
import 'package:clerk/app/modules/charge/views/charges_form_view.dart';
import 'package:clerk/app/utils/enums/view_state_enums.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../custom_widgets/charge_vertical_list_tile_view.dart';
import '../../../custom_widgets/clerk_progress_indicator.dart';
import '../../../repository/charge_repo/charge_repo.dart';
import '../bloc/cubits/charges_list_cubit.dart';

class ChargeVerticalListView extends StatelessWidget {
  const ChargeVerticalListView({Key? key, this.charges}) : super(key: key);

  static Widget getWidget(List<String>? charges) {
    return BlocProvider<ChargesListCubit>(
        create: (context) => ChargesListCubit(
              repo: getIt<ChargeRepo>(),
              charges: charges,
            ),
        child: ChargeVerticalListView(charges: charges,));
  }

  final List<String>? charges;
  @override
  Widget build(BuildContext context) {
    context.read<ChargesListCubit>().loadCharges(charges);
    return BlocBuilder<ChargesListCubit, ChargesListState>(
      builder: (context, state) {
        if (state.viewState == ViewState.loading) {
          return ClerkProgressIndicator();
        } else if (state.viewState == ViewState.empty) {
          return EmptyStateWidget(
              image: '',
              message: "Don't you have added any Charges yet",
              onActionPressed: () async {
                await context.navigate.push(ChargesFormView.getRoute());
              });
        } else {
          return Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.charges.length,
              itemBuilder: (context, index) => Container(
                child: ChargeVerticalListTile(
                  charge: state.charges[index],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
