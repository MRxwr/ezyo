import 'package:ezyo/Models/category-list-model.dart';
import 'package:ezyo/Widgets/categoryItemListTile.dart';
import 'package:flutter/material.dart';

final categoryLists = <CategoryListModel>[
  //Salads Data
  CategoryListModel(title: "Salads", tiles: [
    CategoryItemListTileWidget(
      itemTitle: "Russian Salads",
      imagePath: "assets/images/1.png",
      specialNotes: "These classic Italian-American Style",
      price: "8.000",
    ),
    CategoryItemListTileWidget(
      itemTitle: "Desi Salads",
      imagePath: "assets/images/1.png",
      specialNotes: "These classic Italian-American Style",
      price: "8.000",
    ),
    CategoryItemListTileWidget(
      itemTitle: "Cream Salad",
      imagePath: "assets/images/1.png",
      specialNotes: "These classic Italian-American Style",
      price: "8.000",
    ),
    CategoryItemListTileWidget(
      itemTitle: "Kuwait Salad",
      imagePath: "assets/images/1.png",
      specialNotes: "These classic Italian-American Style",
      price: "8.000",
    ),
  ]),
  //Main Dishes Data
  CategoryListModel(title: "Main Dishes", tiles: [
    CategoryItemListTileWidget(
      itemTitle: "Italian Burger",
      imagePath: "assets/images/1.png",
      specialNotes: "These classic Italian-American Style",
      price: "8.000",
    ),
    CategoryItemListTileWidget(
      itemTitle: "Manchurian",
      imagePath: "assets/images/1.png",
      specialNotes: "These classic Italian-American Style",
      price: "8.000",
    ),
    CategoryItemListTileWidget(
      itemTitle: "Chicken Roll",
      imagePath: "assets/images/1.png",
      specialNotes: "These classic Italian-American Style",
      price: "8.000",
    ),
    CategoryItemListTileWidget(
      itemTitle: "Fried Chicken",
      imagePath: "assets/images/1.png",
      specialNotes: "These classic Italian-American Style",
      price: "8.000",
    ),
  ]),

  //Desert Data
  CategoryListModel(title: "Deserts", tiles: [
    CategoryItemListTileWidget(
      itemTitle: "Fruit Trifle",
      imagePath: "assets/images/1.png",
      specialNotes: "These classic Italian-American Style",
      price: "8.000",
    ),
    CategoryItemListTileWidget(
      itemTitle: "Fruit Chaat",
      imagePath: "assets/images/1.png",
      specialNotes: "These classic Italian-American Style",
      price: "8.000",
    ),
    CategoryItemListTileWidget(
      itemTitle: "Brownie",
      imagePath: "assets/images/1.png",
      specialNotes: "These classic Italian-American Style",
      price: "8.000",
    ),
    CategoryItemListTileWidget(
      itemTitle: "Caramel Pudding",
      imagePath: "assets/images/1.png",
      specialNotes: "These classic Italian-American Style",
      price: "8.000",
    ),
  ])
];
