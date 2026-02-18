import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:yb_news/style/colors/colors.dart';

class FromFieldWidget extends StatelessWidget {
  const FromFieldWidget({
    super.key,
    required this.label,
    required this.hint,
    this.validator,
    this.controller,
    this.onChanged,
    this.errorText,
    this.isRequired = false,
    this.keyboardType = TextInputType.text,
  });

  final String label;
  final String hint;
  final bool isRequired;
  final RxnString? errorText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
            children: [
              if (isRequired)
                const TextSpan(
                  text: " *",
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),

        const SizedBox(height: 6),

        Obx(
          () => TextFormField(
            controller: controller,
            validator: validator,
            onChanged: onChanged,
            keyboardType: keyboardType,
            obscureText: keyboardType == TextInputType.visiblePassword
                ? true
                : false,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.primaryWhite,
              hintText: hint,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 16,
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFFDADCE0),
                  width: 1,
                ),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.bgBlack,
                  width: 1,
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.blue, // biru saat focus
                  width: 1.5,
                ),
              ),
              errorText: errorText?.value,
            ),
          ),
        ),
      ],
    );
  }
}
