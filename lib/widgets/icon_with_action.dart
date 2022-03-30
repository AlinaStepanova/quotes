import 'package:flutter/material.dart';
import 'package:quotes_app/utils/constants.dart';

class IconWithAction extends StatefulWidget {
  final IconData icon;
  final double size;
  final double iconSize;
  final Function call;
  const IconWithAction(this.icon, this.size, this.iconSize, this.call);
  @override
  _IconWithActionState createState() => _IconWithActionState();
}

class _IconWithActionState extends State<IconWithAction> {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.white,
        child: InkWell(
          splashColor: Constants.primaryColor,
          onTap: () => widget.call(),
          child: SizedBox(
              width: widget.size,
              height: widget.size,
              child: Icon(widget.icon,
                  size: widget.iconSize, color: Colors.black)),
        ),
      ),
    );
  }
}
