import 'package:flutter/material.dart';
import 'package:worldnews/core/constants/app_colors.dart';

class CategoryChips extends StatelessWidget {
  const CategoryChips({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  static const List<_CategoryItem> _categories = [
    _CategoryItem(label: 'All', value: 'general'),
    _CategoryItem(label: 'World', value: 'world'),
    _CategoryItem(label: 'Technology', value: 'technology'),
    _CategoryItem(label: 'Business', value: 'business'),
    _CategoryItem(label: 'Sports', value: 'sports'),
    _CategoryItem(label: 'Health', value: 'health'),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _categories.indexWhere(
      (item) => item.value == selectedCategory,
    );
    final currentIndex = selectedIndex == -1 ? 0 : selectedIndex;

    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12),
        itemCount: _categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) => CategoryChip(
          label: _categories[index].label,
          selected: index == currentIndex,
          onTap: () => onCategorySelected(_categories[index].value),
        ),
      ),
    );
  }
}

class _CategoryItem {
  const _CategoryItem({required this.label, required this.value});

  final String label;
  final String value;
}

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.ink : AppColors.surface,
      shape: StadiumBorder(
        side: BorderSide(color: selected ? AppColors.ink : AppColors.border),
      ),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : AppColors.ink,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
