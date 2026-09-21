import 'package:flutter/material.dart';
import '../../../core/models/module_item.dart';

class CategoryChips extends StatelessWidget {
  final ModuleCategory selectedCategory;
  final ValueChanged<ModuleCategory> onCategoryChanged;

  const CategoryChips({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildChip(
            label: 'Semua Modul',
            icon: Icons.dashboard_outlined,
            category: ModuleCategory.all,
          ),
          const SizedBox(width: 8),
          _buildChip(
            label: '📚 Tugas Kuliah',
            icon: Icons.assignment_outlined,
            category: ModuleCategory.tugas,
          ),
          const SizedBox(width: 8),
          _buildChip(
            label: '🧪 Latihan Praktikum',
            icon: Icons.science_outlined,
            category: ModuleCategory.latihan,
          ),
        ],
      ),
    );
  }

  Widget _buildChip({
    required String label,
    required IconData icon,
    required ModuleCategory category,
  }) {
    final isSelected = selectedCategory == category;

    return FilterChip(
      selected: isSelected,
      showCheckmark: false,
      avatar: Icon(
        icon,
        size: 16,
        color: isSelected ? Colors.white : Colors.grey.shade700,
      ),
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey.shade800,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      backgroundColor: Colors.white,
      selectedColor: const Color(0xFF3B82F6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: isSelected ? const Color(0xFF3B82F6) : Colors.grey.shade300,
        ),
      ),
      onSelected: (_) => onCategoryChanged(category),
    );
  }
}

