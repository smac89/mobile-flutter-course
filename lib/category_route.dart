// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:task_05_stateful_widgets/category.dart';
import 'package:task_05_stateful_widgets/unit.dart';

final _backgroundColor = Colors.green[100];

/// Category Route (screen).
///
/// This is the 'home' screen of the Unit Converter. It shows a header and
/// a list of [Categories].
///
/// While it is named CategoryRoute, a more apt name would be CategoryScreen,
/// because it is responsible for the UI at the route's destination.
class CategoryRoute extends StatefulWidget {
  @override
  createState() => _CategoryRouteState();
}

class _CategoryRouteState extends State<CategoryRoute> {
  final categories = <Category>[];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _categoryNames.length; i++) {
      categories.add(Category(
        name: _categoryNames[i],
        color: _baseColors[i],
        iconLocation: Icons.cake,
        units: _retrieveUnitList(_categoryNames[i]),
      ));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            'Unit Converter',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30.0,
            ),
          ),
          centerTitle: true,
          backgroundColor: _backgroundColor,
        ),
        body: Container(
          color: _backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: _buildCategoryWidgets(categories),
        ),
      );

  /// Returns a list of mock [Unit]s.
  List<Unit> _retrieveUnitList(String categoryName) => [
        for (var i = 1; i <= 10; i++)
          Unit(
            name: '$categoryName Unit $i',
            conversion: i.toDouble(),
          )
      ];

  /// Makes the correct number of rows for the list view.
  ///
  /// For portrait, we use a [ListView].
  Widget _buildCategoryWidgets(List<Widget> categories) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => categories[index],
      itemCount: categories.length,
    );
  }
}

const _categoryNames = <String>[
  'Length',
  'Area',
  'Volume',
  'Mass',
  'Time',
  'Digital Storage',
  'Energy',
  'Currency',
];

const _baseColors = <Color>[
  Colors.teal,
  Colors.orange,
  Colors.pinkAccent,
  Colors.blueAccent,
  Colors.yellow,
  Colors.greenAccent,
  Colors.purpleAccent,
  Colors.red,
];
