import 'package:flutter/material.dart';

import '../model/custom_dropdown_item.dart';

/// Generic CustomDropDown Widget using type parameter T.
class CustomDropDown<T> extends StatefulWidget {
  const CustomDropDown({
    super.key,
    this.label,
    required this.hint,
    required this.items,
    required this.onItemSelected,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 4,
    ),
    this.isFilled,
    this.fillColor,
    this.initialSelectedIndex,
    this.value,
    this.errorText,
  });

  final String? errorText;
  final String? label;
  final String hint;
  final List<CustomDropdownItem<T>> items;
  final Function(CustomDropdownItem<T>?) onItemSelected;
  final EdgeInsetsGeometry contentPadding;
  final bool? isFilled;
  final Color? fillColor;
  final int? initialSelectedIndex;
  final CustomDropdownItem<T>? value;

  @override
  State<CustomDropDown<T>> createState() => CustomDropDownState<T>();
}

class CustomDropDownState<T> extends State<CustomDropDown<T>>
    with SingleTickerProviderStateMixin {
  CustomDropdownItem<T>? selectedItem;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _updateSelected(); // initial pass
  }

  @override
  void didUpdateWidget(CustomDropDown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle value parameter changes
    if (widget.value != oldWidget.value) {
      _updateSelectedFromValue();
    }
    // items just arrived or initial index changed:
    else if (widget.items != oldWidget.items ||
        widget.initialSelectedIndex != oldWidget.initialSelectedIndex) {
      _updateSelected();
    }
  }

  void _updateSelectedFromValue() {
    if (widget.value != null) {
      // Find the item in the list that matches the provided value
      final matchingItem = widget.items.firstWhere(
        (item) => item == widget.value,
        orElse: () => widget.value!,
      );
      if (selectedItem != matchingItem) {
        setState(() => selectedItem = matchingItem);
      }
    } else {
      if (selectedItem != null) {
        setState(() => selectedItem = null);
      }
    }
  }

  void _updateSelected() {
    CustomDropdownItem<T>? newSelectedItem;

    // Priority 1: Use value parameter if provided
    if (widget.value != null) {
      newSelectedItem = widget.items.firstWhere(
        (item) => item == widget.value,
        orElse: () => widget.value!,
      );
    }
    // Priority 2: Use initialSelectedIndex
    else {
      final idx = widget.initialSelectedIndex;
      if (idx != null && idx >= 0 && idx < widget.items.length) {
        newSelectedItem = widget.items[idx];
      }
    }

    if (selectedItem != newSelectedItem) {
      setState(() => selectedItem = newSelectedItem);
    }
  }

  void _clearSelection() {
    setState(() => selectedItem = null);
    widget.onItemSelected(null);
  }

  void _onDropdownTap() {
    setState(() => _isOpen = !_isOpen);
  }

  void _onDropdownChanged(CustomDropdownItem<T>? item) {
    setState(() => _isOpen = false);

    if (item != null && selectedItem != item) {
      setState(() => selectedItem = item);
      widget.onItemSelected(item);
    }
  }

  Color _getBorderColor(BuildContext context) {
    if (widget.errorText != null) {
      return Theme.of(context).colorScheme.error;
    }
    if (_isOpen) {
      return Theme.of(context).colorScheme.primary;
    }
    return Theme.of(context).colorScheme.outline.withValues(alpha: 0.5);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isEnabled = widget.items.isNotEmpty;

    return AbsorbPointer(
      absorbing: !isEnabled,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.6,
        child: DropdownButtonHideUnderline(
          child: InputDecorator(
            decoration: InputDecoration(
              errorText: widget.errorText,
              labelText: widget.label,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: colorScheme.error, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: colorScheme.error, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: colorScheme.primary, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: _getBorderColor(context),
                  width: 1,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: colorScheme.outline.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: colorScheme.outline),
              ),
              contentPadding: widget.contentPadding,
              hintText: widget.hint,
              filled: widget.isFilled,
              fillColor: widget.fillColor,
              suffixIcon: selectedItem != null
                  ? InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: isEnabled ? _clearSelection : null,
                      child: Icon(
                        Icons.clear,
                        size: 20,
                        color: isEnabled
                            ? colorScheme.error
                            : colorScheme.onSurface.withValues(alpha: 0.3),
                      ),
                    )
                  : null,
            ),
            child: DropdownButton<CustomDropdownItem<T>>(
              value: selectedItem,
              isExpanded: true,
              hint: Text(
                widget.hint,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: isEnabled
                    ? colorScheme.onSurface.withValues(alpha: 0.6)
                    : colorScheme.onSurface.withValues(alpha: 0.3),
              ), // Hide default icon since we use custom
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
              dropdownColor: colorScheme.surface,
              elevation: 8,
              borderRadius: BorderRadius.circular(8),
              items: widget.items.map((item) {
                final isSelected = selectedItem == item;
                return DropdownMenuItem<CustomDropdownItem<T>>(
                  value: item,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      item.text,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.onSurface,
                        fontWeight: isSelected
                            ? FontWeight.w500
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
              onTap: _onDropdownTap,
              onChanged: isEnabled ? _onDropdownChanged : null,
            ),
          ),
        ),
      ),
    );
  }
}
