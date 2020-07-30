// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert' show json, utf8;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:task_11_api/unit.dart';

/// The REST API retrieves unit conversions for [Categories] that change.
///
/// For example, the currency exchange rate, stock prices, the height of the
/// tides change often.
/// We have set up an API that retrieves a list of currencies and their current
/// exchange rate (mock data).
///   GET /currency: get a list of currencies
///   GET /currency/convert: get conversion from one currency amount to another
class Api {
  final httpClient = HttpClient();
  static const _baseUrl = "flutter.udacity.com";

  Future<List<Unit>> getUnits() async {
    final uri = Uri.https(_baseUrl, "/currency");

    final request = await httpClient.getUrl(uri);
    final response = await request.close();
    if (response.statusCode != HttpStatus.ok) {
      _failure(response.reasonPhrase);
      return null;
    }

    final body = await response.transform(utf8.decoder).join();
    final currencyList = (json.decode(body)["units"] as List);
    return currencyList.map((e) => Unit.fromJson(e)).toList();
  }
  /// Gets all the units and conversion rates for a given category.
  ///
  /// The `category` parameter is the name of the [Category] from which to
  /// retrieve units. We pass this into the query parameter in the API call.
  ///
  /// Returns a list. Returns null on error.

  /// Given two units, converts from one to another.
  ///
  /// Returns a double, which is the converted amount. Returns null on error.
  Future<double> convert(Currency from, Currency to, double amt) async {
    final uri = Uri.https(_baseUrl, "/currency/convert",
        {"from": from.name, 'to': to.name, 'amount': amt.toStringAsPrecision(7)});

    final request = await httpClient.getUrl(uri);
    final response = await request.close();
    if (response.statusCode != HttpStatus.ok) {
      _failure(response.reasonPhrase);
      return null;
    }

    final body = await response.transform(utf8.decoder).join();
    final jsonBody = json.decode(body);
    return jsonBody['conversion'];
  }

  void _failure(String reason) {
    print('Api request failed!: $reason');
  }

  void close() => httpClient.close(force: true);
}


class Currency {
  final String name;

  const Currency._(this.name);

  static const Currency US = const Currency._("US Dollar");
  static const Currency Brownie = const Currency._("Brownie Points");
  static const Currency BTC = const Currency._("Bitcoin");
  static const Currency GAL = const Currency._("Galleon");
  static const Currency GOLD = const Currency._("Gold Bar");
  static const Currency ZWD = const Currency._("Zimbabwean Dollar");

  factory Currency(String name) {
    switch(name) {
      case "US Dollar": return US;
      case "Brownie Points": return Brownie;
      case "Bitcoin": return BTC;
      case "Galleon": return GAL;
      case "Gold Bar": return GOLD;
      case "Zimbabwean Dollar": return ZWD;
      default: throw ("Invalid Name");
    }
  }
}
