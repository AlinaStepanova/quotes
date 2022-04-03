import 'package:flutter/material.dart';

import '../utils/constants.dart';

class OfflineStatusBar extends StatelessWidget {
  const OfflineStatusBar({
    Key? key,
    required bool isOffline,
    required this.height,
    required this.width,
  })  : _isOffline = isOffline,
        super(key: key);

  final bool _isOffline;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
          decoration: BoxDecoration(color: Colors.grey[200]),
          duration: const Duration(milliseconds: 750),
          curve: Curves.fastOutSlowIn,
          height: _isOffline ? height * 0.05 : 0,
          child: _isOffline
              ? Container(
                  alignment: Alignment.center,
                  width: width,
                  child: Text(Constants.offlineText),
                )
              : null),
    );
  }
}
