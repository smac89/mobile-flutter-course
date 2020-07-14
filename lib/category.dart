// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// To keep your imports tidy, follow the ordering guidelines at
// https://www.dartlang.org/guides/language/effective-dart/style#ordering
import 'package:flutter/material.dart';

const widgetHeight = 100.0;
const iconSize = 60.0;
const iconWithColorBackgroundWidth = 70.0;
const textSize = 24.0;

/// A custom [Category] widget.
///
/// The widget is composed on an [Icon] and [Text]. Tapping on the widget shows
/// a colored [InkWell] animation.
class Category extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;

  /// Creates a [Category].
  ///
  /// A [Category] saves the name of the Category (e.g. 'Length'), its color for
  /// the UI, and the icon that represents it (e.g. a ruler).
  const Category(
      {@required this.name, @required this.icon, @required this.color});

  /// Builds a custom widget that shows [Category] information.
  ///
  /// This information includes the icon, name, and color for the [Category].
  @override
  // This `context` parameter describes the location of this widget in the
  // widget tree. It can be used for obtaining Theme data from the nearest
  // Theme ancestor in the tree. Below, we obtain the display1 text theme.
  // See https://docs.flutter.io/flutter/material/Theme-class.html
  Widget build(BuildContext context) {
    return Container(
      height: widgetHeight,
      padding: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: this._onTap,
        splashColor: this.color,
        highlightColor: this.color,
        borderRadius: BorderRadius.circular(widgetHeight / 2),
        child: Row(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(this.icon, size: iconSize)),
            Center(
              child: Text(
                this.name,
                style: TextStyle(fontSize: textSize),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onTap() {
    print('I was tapped!');
  }
}
