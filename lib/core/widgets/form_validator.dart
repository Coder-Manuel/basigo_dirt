import 'package:flutter/material.dart';

class FormValidator<T> extends StatelessWidget {
  const FormValidator({
    super.key,
    required this.child,
    this.validator,
  });

  final Widget child;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: validator,
      builder: (FormFieldState<T> state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            child,
            Visibility(
              visible: state.hasError,
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  state.errorText ?? '',
                  style: const TextStyle(fontSize: 12, color: Colors.red),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
