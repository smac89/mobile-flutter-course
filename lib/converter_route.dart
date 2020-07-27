// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'unit.dart';

const _padding = EdgeInsets.all(16.0);

/// [ConverterRoute] where users can input amounts to convert in one [Unit]
/// and retrieve the conversion in another [Unit] for a specific [Category].
///
/// While it is named ConverterRoute, a more apt name would be ConverterScreen,
/// because it is responsible for the UI at the route's destination.
class ConverterRoute extends StatefulWidget {
  /// Color for this [Category].
  final Color color;

  /// Units for this [Category].
  final List<Unit> units;

  /// This [ConverterRoute] requires the color and units to not be null.
  const ConverterRoute({
    @required this.color,
    @required this.units,
  })  : assert(color != null),
        assert(units != null);

  @override
  _ConverterRouteState createState() => _ConverterRouteState();
}

class _ConverterRouteState extends State<ConverterRoute> {
  final formatter = NumberFormat('#.#######');

  Unit inputUnit, outputUnit;
  TextEditingController inputController, outputController;

  /// Clean up conversion; trim trailing zeros, e.g. 5.500 -> 5.5, 10.0 -> 10
  String format(double conversion) => formatter.format(conversion);

  void swapUnits() {
    setState(() {
      var tempUnit = inputUnit;
      inputUnit = outputUnit;
      outputUnit = tempUnit;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.units.isNotEmpty) {
      inputUnit = outputUnit = widget.units[0];
    }
    inputController = TextEditingController(text: "0");
    outputController = TextEditingController(text: "0");

    inputController.addListener(() {
      var input = inputController.text;
      if (input?.isNotEmpty ?? false) {
        var num = double.tryParse(input);
        if (num != null) {
          outputController.text = format(num);
          return;
        }
      }
      outputController.text = "";
    });
  }

  @override
  void dispose() {
    inputController.dispose();
    outputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: _padding,
        child: Column(
          children: <Widget>[
            createGroup(isInput: true),
            Transform.rotate(
                angle: pi / 2, // 90 degrees
                child: IconButton(
                  iconSize: 40,
                  onPressed: swapUnits,
                  icon: Icon(Icons.compare_arrows),
                )),
            createGroup(isInput: false)
          ],
        ),
      );

  Widget createGroup({@required bool isInput}) => Padding(
        padding: _padding,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                  style: TextStyle(fontSize: 24),
                  readOnly: !isInput,
                  keyboardType: TextInputType.number,
                  autovalidate: true,
                  validator: validateInput,
                  controller: isInput ? inputController : outputController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: isInput ? "Input" : "Output",
                      hintText: "12")),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: InputDecorator(
                  decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 16),
                      isDense: true,
                      border: OutlineInputBorder()),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Unit>(
                        isDense: true,
                        value: isInput ? inputUnit : outputUnit,
                        items: [
                          for (var unit in widget.units)
                            DropdownMenuItem(
                                value: unit,
                                child: Text(
                                  unit.name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))
                        ],
                        onChanged: (Unit newValue) => setState(() => isInput
                            ? inputUnit = newValue
                            : outputUnit = newValue)),
                  ),
                ),
              )
            ]),
      );

  String validateInput(String input) {
    if (input?.isNotEmpty ?? false) {
      if (double.tryParse(input) == null) {
        return "Invalid number entered";
      }
    }
    return null;
  }
}
