// lib/features/home/presentation/widgets/categories_list.dart
import 'package:flutter/material.dart';

class CategoriesList extends StatefulWidget {
  final Function(String) onCategorySelected;

  const CategoriesList({
    Key? key,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  int _selectedIndex = 0;
  final List<String> _categories = [
    'All',
    'Clothing',
    'Shoes',
    'Accessories',
    'Electronics',
    'Beauty',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                widget.onCategorySelected(_categories[index]);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _selectedIndex == index
                      ? Colors.deepPurple
                      : Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: _selectedIndex == index
                        ? Colors.transparent
                        : Colors.grey[300]!,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _selectedIndex == index
                          ? Colors.deepPurple.withOpacity(0.3)
                          : Colors.transparent,
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    _categories[index],
                    style: TextStyle(
                      color: _selectedIndex == index
                          ? Colors.white
                          : Colors.grey[700],
                      fontWeight: _selectedIndex == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}