import 'package:flutter/material.dart';

Text text(
  String s, {
  double fontSize = 16,
  color = Colors.black,
  bold = false,
  overFlow = null,
  maxLines = null
}) {
  return Text(
    s ?? "",
    style: TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    ),
    overflow: overFlow,
    maxLines: maxLines,
  );
}