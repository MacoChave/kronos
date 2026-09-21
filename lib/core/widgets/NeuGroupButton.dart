// ignore_for_file: file_names

import 'package:flutter/widgets.dart';
import 'package:kronos/core/widgets/NeuToggleButton.dart';

class Neugroupbutton<T> extends StatelessWidget {
  final List<T> items;
  final T selectedItem;
  final String Function(T) itemLabel;
  final IconData Function(T) itemIcon;
  final Function(T) onItemSelected;

  const Neugroupbutton({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.itemLabel,
    required this.itemIcon,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: items.map((item) {
        final isSelected = item == selectedItem;
        return NeuToggleButton(
            label: itemLabel(item),
            icon: itemIcon(item),
            value: isSelected,
            onChanged: (value) => onItemSelected(item));
      }).toList(),
    );
  }
}
