import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? tooltip;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isNumber;
  final bool isRequired;
  final bool isPassword;
  final bool isMultiline;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? minLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool autofocus;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final BoxConstraints? constraints;

  const CustomTextField({
    super.key,
    this.label,
    this.tooltip,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isNumber = false,
    this.isRequired = false,
    this.isPassword = false,
    this.isMultiline = false,
    this.controller,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.maxLines = 1,
    this.minLines,
    this.readOnly = false,
    this.onTap,
    this.autofocus = false,
    this.textStyle,
    this.labelStyle,
    this.fillColor,
    this.contentPadding,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    // Determine keyboard type
    final effectiveKeyboardType = keyboardType ??
        (isNumber
            ? TextInputType.number
            : isMultiline
                ? TextInputType.multiline
                : TextInputType.text);

    // Determine input formatters
    final effectiveInputFormatters = inputFormatters ??
        (isNumber ? [FilteringTextInputFormatter.digitsOnly] : null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Row(
            children: [
              Text(
                isRequired ? '$label *' : label!,
                style: labelStyle ??
                    theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              if (tooltip != null)
                IconButton(
                  icon: const Icon(Icons.info_outline, size: 16),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(tooltip!),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  },
                ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        Container(
          constraints: constraints,
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            validator: validator ??
                (isRequired
                    ? (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      }
                    : null),
            keyboardType: effectiveKeyboardType,
            inputFormatters: effectiveInputFormatters,
            obscureText: isPassword,
            maxLines: isPassword ? 1 : maxLines,
            minLines: minLines,
            readOnly: readOnly,
            onTap: onTap,
            autofocus: autofocus,
            style: textStyle,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              filled: false,
              fillColor: fillColor ?? theme.cardColor,
              contentPadding: contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFF1A2A57),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: theme.primaryColor,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: theme.colorScheme.error,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: theme.colorScheme.error,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
