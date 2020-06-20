import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';

List<MenuItem> items = [
  new MenuItem<int>(
    id: 0,
    title: 'HOME',
    icon: Icons.fastfood,
  ),
  new MenuItem<int>(
    id: 1,
    title: 'CONTACT US',
    icon: Icons.person,
  ),
  new MenuItem<int>(
    id: 2,
    title: 'ABOUT US',
    icon: Icons.person,
  ),
];
final menu = Menu(
  items: items.map((e) => e.copyWith(icon: null)).toList(),
);

final menuWithIcon = Menu(
  items: items,
);
