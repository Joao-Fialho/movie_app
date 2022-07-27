import 'package:flutter/material.dart';

import '../../../../../../../core/app_colors.dart';

class FilterButton extends StatefulWidget {
  final String textFilter;
  final bool isSelected;
  final void Function()? onTap;

  const FilterButton({
    Key? key,
    required this.textFilter,
    this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Row(
      children: [
        GestureDetector(
          onTap: widget.onTap,
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
              color: widget.isSelected ? theme.primary : theme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
              child: Text(
                widget.textFilter,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
