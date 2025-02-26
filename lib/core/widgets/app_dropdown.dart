import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class AppDropDownField<T> extends StatelessWidget {
  const AppDropDownField({
    super.key,
    required this.items,
    this.onChanged,
    this.hint,
    this.prefix,
    this.value,
    this.borderColor,
    this.style,
    this.searchController,
    this.searchHint,
    this.onSearch,
    this.enabledSearch = false,
    this.isCollapsed,
    this.padding,
    this.validator,
    this.enabled = true,
  });

  final List<DropdownMenuItem<T>>? items;
  final void Function(T?)? onChanged;
  final Widget? hint;
  final Widget? prefix;
  final T? value;
  final Color? borderColor;
  final TextStyle? style;
  final TextEditingController? searchController;
  final String? searchHint;
  final bool Function(DropdownMenuItem<T>, String)? onSearch;
  final bool enabledSearch;
  final bool? isCollapsed;
  final EdgeInsetsGeometry? padding;
  final String? Function(T?)? validator;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField2<T>(
        validator: validator,
        dropdownSearchData: enabledSearch
            ? DropdownSearchData<T>(
                searchController: searchController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    controller: searchController,
                    style: const TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: searchHint,
                      hintStyle: const TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: onSearch,
              )
            : null,
        isExpanded: true,
        decoration: InputDecoration(
          enabled: enabled,
          isCollapsed: isCollapsed,
          prefixIcon: prefix,
          contentPadding: padding ??
              const EdgeInsets.only(
                left: 10,
                top: 0,
                bottom: 0,
              ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor ?? Colors.grey[400]!),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor ?? Colors.grey[400]!),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor ?? Colors.grey[400]!),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          elevation: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 10),
        ),
        style: style ?? const TextStyle(fontSize: 14, color: Colors.black),
        hint: hint,
        isDense: true,
        items: items,
        onChanged: enabled ? onChanged : null,
        value: value,
      ),
    );
  }
}
