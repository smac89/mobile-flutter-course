// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:meta/meta.dart' show required;
import 'package:task_04_navigation/unit.dart';

/// Converter screen where users can input amounts to convert.
///
/// Currently, it just displays a list of mock units.
///
/// While it is named ConverterRoute, a more apt name would be ConverterScreen,
/// because it is responsible for the UI at the route's destination.
class ConverterRoute extends StatelessWidget {
  /// Units for this [Category].
  final List<Unit> units;
  final Color color;

  /// This [ConverterRoute] requires the color and units to not be null.
  const ConverterRoute({
    @required this.color,
    @required this.units,
  })  : assert(color != null),
        assert(units != null);

  @override
  Widget build(BuildContext context) {
    // Here is just a placeholder for a list of mock units

    return ListView(
      children: [
        for (var unit in this.units)
          Container(
            color: this.color,
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Text(
                  unit.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  'Conversion: ${unit.conversion}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          )
      ],
    );
  }
}
