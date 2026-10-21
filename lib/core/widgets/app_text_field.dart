import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import '../theme/app_theme.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData? icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final void Function(String)? onFieldSubmitted;
  final int maxLines;
  final int? minLines;
  final String? helper;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;

  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.icon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.minLines,
    this.helper,
    this.inputFormatters,
    this.onChanged,
  });

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(color: color),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: AppTextStyles.label),
        const SizedBox(height: 8),
        TextFormField(
          onChanged: onChanged,
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          onFieldSubmitted: onFieldSubmitted,
          maxLines: maxLines,
          minLines: minLines,
          inputFormatters: inputFormatters,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.hint),
            helperText: helper,
            helperMaxLines: 3,
            helperStyle:
            const TextStyle(fontSize: 12, color: AppColors.textSecondary),
            prefixIcon:
            icon == null ? null : Icon(icon, color: AppColors.hint, size: 20),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            enabledBorder: _border(AppColors.border),
            focusedBorder: _border(AppColors.primary),
            errorBorder: _border(AppColors.error),
            focusedErrorBorder: _border(AppColors.error),
          ),
        ),
      ],
    );
  }
}