import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/core/models/response/user.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class WalletHistoryItem extends StatelessWidget {
  final WalletHistories history;
  final String? currency;

  const WalletHistoryItem({
    Key? key,
    required this.history,
    required this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0XFFF2F2F2),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(13),
      margin: const EdgeInsets.only(bottom: 18),
      height: 72,
      width: 242,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/icons/wallet_history_icon.png',
            height: 11,
            width: 13,
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Helper.getWalletType(history.type!),
                      style: textStyle12.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      Helper.formatDate(history.createdAt!),
                      style: textStyle11Light,
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$currency${history.amount}',
                      style: textStyle12.copyWith(
                        color: AppCustomColors.textBlue.withOpacity(.95),
                        fontWeight: FontWeight.w300,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      Helper.formatTime(history.createdAt!),
                      style: textStyle11Light,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
