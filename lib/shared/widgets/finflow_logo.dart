
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_finance_budgeting_system/shared/styles/app_colors.dart';

class FinFlowLogo extends StatelessWidget {
  final Color? textColor;
  final double iconSize;
  final double textSize;

  const FinFlowLogo({
    super.key,
    this.textColor,
    this.iconSize = 48.0,
    this.textSize = 36.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.account_balance_wallet_rounded,
          color: textColor ?? AppColors.onPrimaryColor,
          size: iconSize,
        ),
        const SizedBox(width: 8.0),
        Text(
          'FinFlow',
          style: GoogleFonts.poppins(
            color: textColor ?? AppColors.onPrimaryColor,
            fontSize: textSize,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.0,
          ),
        ),
      ],
    );
  }
}
