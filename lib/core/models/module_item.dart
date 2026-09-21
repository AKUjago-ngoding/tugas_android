import 'package:flutter/material.dart';

enum ModuleCategory {
  all,
  tugas,
  latihan,
}

class ModuleItem {
  final String id;
  final String moduleNumber;
  final String title;
  final String subtitle;
  final String description;
  final ModuleCategory category;
  final IconData icon;
  final Color color;
  final List<String> tags;
  final WidgetBuilder builder;
  final String? logicCodeSnippet;
  final String Function()? logicRunner;

  const ModuleItem({
    required this.id,
    required this.moduleNumber,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.category,
    required this.icon,
    required this.color,
    required this.tags,
    required this.builder,
    this.logicCodeSnippet,
    this.logicRunner,
  });
}
