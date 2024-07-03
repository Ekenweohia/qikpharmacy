import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/profile/presentation/cubit/user/user_cubit.dart';
import 'package:qik_pharma_mobile/shared/widgets/circular_loading_widget.dart';
import 'package:qik_pharma_mobile/utils/qikpharma_dialog_manager.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class PersonalInfoAccountSection extends StatelessWidget {
  const PersonalInfoAccountSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 15, 38, 0),
                child: Text(
                  "Account",
                  style: textStyle17w400,
                ),
              ),
              Divider(color: Colors.black.withOpacity(.2)),
              const SizedBox(height: 15),
              if (state is UserLoading)
                const Center(child: CircularLoadingWidget()),
              if (state is UserLoaded)
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 0, 28, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("User ID", style: textStyle15w400),
                      const SizedBox(height: 6),
                      Text(
                        state.user.userId!,
                        style: textStyle17w400,
                      ),
                      const SizedBox(height: 15),
                      Text('Name', style: textStyle15w400),
                      const SizedBox(height: 6),
                      Text(
                        state.user.name!,
                        style: textStyle17w400,
                      ),
                      const SizedBox(height: 15),
                      Text('Email', style: textStyle15w400),
                      const SizedBox(height: 6),
                      Text(
                        state.user.email!,
                        style: textStyle17w400,
                      ),
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: () async {
                          QikPharmaDialogManager.showCloseAccountDialog(
                              context);
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 60),
                          child: Text(
                            "Close my account",
                            style: textStyle17w400.copyWith(
                              color: AppCustomColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
