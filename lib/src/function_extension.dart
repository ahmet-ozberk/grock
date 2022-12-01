import 'package:flutter/material.dart';

extension FunctionExtension on Function {
  void widgetBinding()=> WidgetsBinding.instance.addPostFrameCallback((_) => this());
  
}