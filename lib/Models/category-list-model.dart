import 'package:ezyo/Widgets/categoryItemListTile.dart';
import 'package:flutter/cupertino.dart';

class CategoryListModel {
  final String title;
  final List<CategoryItemListTileWidget> tiles;
  bool isExpanded;

  CategoryListModel(
      {@required this.title, this.tiles = const [], this.isExpanded = false});
}
