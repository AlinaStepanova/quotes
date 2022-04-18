import 'package:flutter/material.dart';
import 'package:quotes/utils/constants.dart';

class IconWithAction extends StatelessWidget {
  final IconData icon;
  final Function onClick;
  final double? size;
  final double? iconSize;
  final Key? key;

  const IconWithAction(this.icon, this.onClick,
      {this.size, this.iconSize, this.key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipOval(
      child: Material(
        color: Colors.white,
        child: InkWell(
          splashColor: Constants.primaryColor,
          onTap: () => onClick(),
          child: SizedBox(
              width: size ?? width * 0.1,
              height: size ?? width * 0.1,
              child: Icon(icon,
                  size: iconSize ?? width * 0.07, color: Colors.black)),
        ),
      ),
    );
  }
}
