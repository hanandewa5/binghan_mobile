import 'package:flutter/material.dart';

class IconBottom extends StatelessWidget {
  final String imgUrl;
  final String? title;
  final VoidCallback? onPress;

  const IconBottom({required this.imgUrl, this.title, this.onPress, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.12,
              child: Image.asset(imgUrl),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.22,
              child: Text(
                title ?? "",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
