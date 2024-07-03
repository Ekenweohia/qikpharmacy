import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qik_pharma_mobile/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:qik_pharma_mobile/features/wallet/presentation/widgets/wallet_text_field.dart';
import 'package:qik_pharma_mobile/shared/widgets/widgets.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class CreditWalletDialog extends StatefulWidget {
  const CreditWalletDialog({Key? key}) : super(key: key);

  @override
  State<CreditWalletDialog> createState() => _CreditWalletDialogState();
}

class _CreditWalletDialogState extends State<CreditWalletDialog> {
  final TextEditingController _amountController = TextEditingController();

  bool buttonEnabled() => _amountController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 82,
              width: 82,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1,
                  color: Colors.grey.withOpacity(0.3),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 10,
                    color: Colors.white,
                  ),
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/wallet.png",
                  height: 38,
                  width: 38,
                ),
              ),
            ),
            const SizedBox(height: 21),
            FittedBox(
              child: Text(
                "Credit wallet",
                style: textStyle16Bold.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              'Enter amount you wish to Credit',
              style: textStyle12.copyWith(fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            WalletTextfield(
              controller: _amountController,
              onChanged: (value) {
                setState(() {
                  final formattedString = Helper.formatAmountString(value);
                  _amountController.value = TextEditingValue(
                    text: formattedString,
                    selection:
                        TextSelection.collapsed(offset: formattedString.length),
                  );
                });
              },
              hint: '20,600',
              showPrefix: false,
              length: 6,
            ),
            const SizedBox(height: 23),
            PrimaryButton(
              title: 'Fund Wallet',
              width: 110,
              isEnabled: buttonEnabled(),
              onPressed: buttonEnabled()
                  ? () {
                      Navigator.maybePop(context);

                      final cubit = BlocProvider.of<WalletCubit>(context);
                      cubit.creditWallet(
                          context,
                          double.parse(
                              _amountController.text.replaceAll(',', '')));
                    }
                  : null,
            )
          ],
        ),
      ),
    );
  }
}
