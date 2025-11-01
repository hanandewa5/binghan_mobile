import 'package:flutter/material.dart';

class AlertRequest {
  final String title;
  final String? description;
  final String buttonTitle;
  final Icon? icon;
  final bool hasSecondButton;
  final String? secondButtonTitle;
  final Icon? secondIcon;

  AlertRequest({
    required this.title,
    this.description,
    required this.buttonTitle,
    this.icon,
    this.hasSecondButton = false,
    this.secondButtonTitle,
    this.secondIcon
  });
}
