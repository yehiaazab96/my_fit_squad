import 'package:flutter/material.dart';
import 'package:my_fit_squad/features/coaches_clients_management/helpers/drop_down_data.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppDropdown<T> extends StatefulWidget {
  final String? hint;
  final List<DropDownData<T>> items;
  final void Function(T? value) onChange;
  final Color fillColor;
  final Function()? onTap;
  final bool isLoading;
  final bool shadowEnabled;
  final bool showBorder;
  final String? error;
  final double? fontSize;
  // final double? width;
  final T? initialValue;
  final bool isEnabled;
  final EdgeInsetsDirectional? contentPadding;

  final String? label;

  const AppDropdown({
    Key? key,
    this.hint,
    // required this.width,
    required this.items,
    this.fontSize,
    this.onTap,
    this.error,
    this.initialValue,
    this.shadowEnabled = false,
    this.isLoading = false,
    this.showBorder = true,
    this.contentPadding,
    this.fillColor = Colors.transparent,
    required this.onChange,
    this.isEnabled = true,
    this.label,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppDropdownState<T>();
  }
}

class _AppDropdownState<T> extends State<AppDropdown<T>> {
  late T? selectedValue = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: widget.onTap,
          child: DropdownButtonFormField<T>(
            iconSize: 0.0,
            decoration: InputDecoration(
              labelText: widget.label,
              hintText: widget.hint,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: widget.contentPadding ??
                  const EdgeInsetsDirectional.only(
                      top: 15, bottom: 15, start: 30, end: 30),
              labelStyle: Theme.of(context).textTheme.labelLarge,
              hintStyle: Theme.of(context).textTheme.labelLarge,
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant),
                  borderRadius: BorderRadius.circular(2.w),
                  gapPadding: 7),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.secondary),
                borderRadius: BorderRadius.circular(2.w),
                gapPadding: 7,
              ),
              errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.error),
                borderRadius: BorderRadius.circular(2.w),
                gapPadding: 7,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.error),
                borderRadius: BorderRadius.circular(2.w),
                gapPadding: 7,
              ),
              errorText: widget.error,
              errorStyle: const TextStyle(fontSize: 0, letterSpacing: 0),
              prefixIconColor: Theme.of(context).colorScheme.secondary,
              suffixIconColor: Theme.of(context).colorScheme.secondary,
            ),
            // hint: widget.hint != null
            //     ? Text(widget.hint ?? '',
            //         style: Theme.of(context).textTheme.bodyText2)
            //     : null,
            items: widget.items
                .map((item) => DropdownMenuItem<T>(
                    value: item.value,
                    child: Text(
                      item.label,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )))
                .toList(),
            onChanged:
                widget.isEnabled ? (value) => widget.onChange(value) : null,
            value: selectedValue,
            isExpanded: true,
          ),
        ),
      ],
    );
  }
}
