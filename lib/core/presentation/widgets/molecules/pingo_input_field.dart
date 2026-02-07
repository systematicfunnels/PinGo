import 'package:flutter/material.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/theme/spacing.dart';

class PingoInputField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool isMultiline;
  final String? errorText;
  final bool isDisabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;

  const PingoInputField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.onChanged,
    this.isMultiline = false,
    this.errorText,
    this.isDisabled = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: theme.textTheme.labelMedium?.copyWith(
              color: isDisabled ? AppColors.neutral.s500 : AppColors.neutral.s900,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        TextField(
          controller: controller,
          onChanged: onChanged,
          enabled: !isDisabled,
          focusNode: focusNode,
          maxLines: isMultiline ? 5 : 1,
          minLines: isMultiline ? 3 : 1,
          keyboardType: isMultiline ? TextInputType.multiline : keyboardType,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDisabled ? AppColors.neutral.s500 : AppColors.neutral.s900,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.neutral.s500,
            ),
            errorText: errorText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: isDisabled ? AppColors.neutral.s50 : AppColors.neutral.s100,
            contentPadding: const EdgeInsets.all(AppSpacing.md),
            border: OutlineInputBorder(
              borderRadius: AppRadius.all8,
              borderSide: BorderSide(color: AppColors.neutral.s300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.all8,
              borderSide: BorderSide(color: AppColors.neutral.s300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.all8,
              borderSide: BorderSide(color: AppColors.primary.s500, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: AppRadius.all8,
              borderSide: BorderSide(color: AppColors.error.s500),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.all8,
              borderSide: BorderSide(color: AppColors.neutral.s300.withValues(alpha: 0.5)),
            ),
          ),
        ),
      ],
    );
  }
}
