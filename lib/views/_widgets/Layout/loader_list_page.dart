import 'package:binghan_mobile/views/_widgets/ColorLoader.dart';
import 'package:flutter/material.dart';

class LoaderListPage extends StatelessWidget {
  final bool? isLoading;
  final int? length;
  final Future<void> Function() refresh;
  final String? listType;

  final Widget? child;

  const LoaderListPage({
    required this.refresh,
    this.listType = "list",
    this.isLoading,
    this.length,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: refresh,
      child: (listType == "list")
          ? Container(
              child: isLoading == true
                  ? Center(child: CircularProgressIndicator())
                  : length == 0
                  ? SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Center(child: Text("Data Kosong")),
                      ),
                    )
                  : child,
            )
          : (listType == "grid")
          ? SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: length == 0 || isLoading == true ? height - 155 : null,
                child: isLoading == true
                    ? Center(child: ColorLoader2())
                    : length == 0
                    ? Center(child: Text("Data Kosong"))
                    : child,
              ),
            )
          : Text("This Page Not Build Properly"),
    );
  }
}
