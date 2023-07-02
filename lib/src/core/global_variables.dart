import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final _deviceProperties = MediaQuery.of(navigatorKey.currentContext!);

final usableHeight =
    _deviceProperties.size.height - _deviceProperties.padding.top - _deviceProperties.padding.bottom - _deviceProperties.systemGestureInsets.bottom;
final usableHeightWithAppbar = usableHeight - kToolbarHeight;
final usableWidth = _deviceProperties.size.width - _deviceProperties.padding.left - _deviceProperties.padding.right;