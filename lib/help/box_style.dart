import 'package:flutter/material.dart';
import 'package:webcom/help/app_config.dart' as config;

class CommonContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color borderColor;
  final double borderRadius;
  final Widget? child;

  const CommonContainer({
    super.key,
    this.height = 6,
    this.width = 100,
    this.borderColor = Colors.black,
    this.borderRadius = 2,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: config.AppConfig(context).appHeight(height),
      width: config.AppConfig(context).appWidth(width),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(config.AppConfig(context).appWidth(borderRadius)),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: config.AppConfig(context).appWidth(2),
            right: config.AppConfig(context).appWidth(2)),
        child: child,
      ),
    );
  }
}
