import 'package:flutter/material.dart';
import 'package:quotes_app/utils/constants.dart';

class IconWithAction extends StatefulWidget {
  final IconData icon;
  final Function call;
  final double? size;
  final double? iconSize;

  const IconWithAction(this.icon, this.call, {this.size, this.iconSize});
  @override
  _IconWithActionState createState() => _IconWithActionState();
}

class _IconWithActionState extends State<IconWithAction> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipOval(
      child: Material(
        color: Colors.white,
        child: InkWell(
          splashColor: Constants.primaryColor,
          onTap: () => widget.call(),
          child: SizedBox(
              width: widget.size ?? width * 0.1,
              height: widget.size ?? width * 0.1,
              child: Icon(widget.icon,
                  size: widget.iconSize ?? width * 0.07, color: Colors.black)),
        ),
      ),
    );
  }
}
