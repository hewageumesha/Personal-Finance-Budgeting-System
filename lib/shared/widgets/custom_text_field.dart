
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: Theme.of(context).inputDecorationTheme.border,
        focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
        enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
        errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
        focusedErrorBorder: Theme.of(context).inputDecorationTheme.focusedErrorBorder,
        filled: Theme.of(context).inputDecorationTheme.filled,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
        hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
      ),
    );
  }
}
