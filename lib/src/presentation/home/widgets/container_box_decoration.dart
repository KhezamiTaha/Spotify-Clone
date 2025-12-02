import 'package:flutter/material.dart';

class ContainerBoxDecoration extends BoxDecoration {
  ContainerBoxDecoration({
    super.color,
    BorderRadiusGeometry super.borderRadius =
        const BorderRadius.all(Radius.circular(12)),
    List<BoxShadow>? boxShadow,
    bool shadow = false,
  }) : super(
          boxShadow: shadow
              ? [
                  BoxShadow(
                    color: Colors.black.withAlpha(25),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        );
}
