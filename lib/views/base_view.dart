import 'package:binghan_mobile/_config/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:binghan_mobile/viewmodels/_basemodel.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Function(T)? onModelReady;
  final Brightness? statusBarTheme;
  final Color statusBarColor;

  const BaseView({
    super.key,
    required this.builder,
    this.onModelReady,
    this.statusBarTheme,
    this.statusBarColor = Colors.transparent,
  });

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {
  T model = locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady?.call(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: widget.statusBarColor,
          statusBarBrightness: widget.statusBarTheme,
          statusBarIconBrightness: widget.statusBarTheme,
        ),
        child: Consumer<T>(builder: widget.builder),
      ),
    );
  }
}
