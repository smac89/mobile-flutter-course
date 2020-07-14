// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_03_category_route/category.dart';
import 'package:tuple/tuple.dart';


// TODO: Define any constants

/// Category Route (screen).
///
/// This is the 'home' screen of the Unit Converter. It shows a header and
/// a list of [Categories].
///
/// While it is named CategoryRoute, a more apt name would be CategoryScreen,
/// because it is responsible for the UI at the route's destination.
class CategoryRoute extends StatelessWidget {
  const CategoryRoute();

  static const _categoryNames = <String>[
    'Length',
    'Area',
    'Volume',
    'Mass',
    'Time',
    'Digital Storage',
    'Energy',
    'Currency',
  ];

  static const _baseColors = <Color>[
    Colors.teal,
    Colors.orange,
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.yellow,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.red,
  ];

  static final _categories = <Tuple3<String, Color, IconData>>[
    for (int i = 0; i < _categoryNames.length; i++)
      Tuple3(_categoryNames[i], _baseColors[i], Icons.cake)
  ];

  @override
  Widget build(BuildContext context) {
    final listView = ListView.builder(
      itemBuilder: this._buildCategory,
      itemCount: _categories.length,
    ).build(context);

    final appBar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Center(
        child: Text(
          "Unit Converter",
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: appBar,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: listView
      ),
    );
  }

  Widget _buildCategory(BuildContext context, int index) {
    return Category.fromTuple3(_categories[index]);
  }
}
