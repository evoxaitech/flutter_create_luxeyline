import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class CategoryChips extends StatefulWidget {
  final ValueChanged<String>? onCategorySelected;
  const CategoryChips({super.key, this.onCategorySelected});

  @override
  State<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  int _selected = 0;
  final _items = const ['Popular', 'Houses', 'Apartment', 'Villa', 'Land'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) {
          final sel = _selected == i;
          return GestureDetector(
            onTap: () {
              setState(() => _selected = i);
              widget.onCategorySelected?.call(_items[i]);
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: sel ? AppColors.primaryLight : Colors.white,
                border: Border.all(
                    color: sel ? AppColors.primary : AppColors.border),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _items[i],
                style: TextStyle(
                  color: sel ? AppColors.primary : AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
