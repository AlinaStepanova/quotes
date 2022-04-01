import 'package:flutter/material.dart';
import 'package:quotes/utils/constants.dart';

class IconWithAction extends StatefulWidget {
  final IconData icon;
  final Function onClick;
  final double? size;
  final double? iconSize;
  final Key? key;

  const IconWithAction(this.icon, this.onClick,
      {this.size, this.iconSize, this.key})
      : super(key: key);
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
          onTap: () => widget.onClick(),
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
