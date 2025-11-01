import 'package:flutter/material.dart';

class PictureLoader extends StatelessWidget {
  final bool isBusy;
  final String url;
  final double width;
  final double height;
  final bool editable;
  final Function onPressed;

  PictureLoader(
      {this.isBusy,
      this.url,
      this.width,
      this.height,
      this.editable = false,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Stack(
        children: <Widget>[
          FadeInImage(
            fit: BoxFit.cover,
            width: width,
            height: height,
            placeholder: AssetImage("lib/_assets/images/loading.gif"),
            image: isBusy
                ? AssetImage("lib/_assets/images/loading.gif")
                : (url != null && url != "")
                    ? NetworkImage(url)
                    : AssetImage("lib/_assets/images/profile.png"),
          ),
          editable
              ? Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.black54,
                    child: IconButton(
                      onPressed: onPressed,
                      iconSize: 40,
                      color: Colors.white,
                      icon: Icon(Icons.edit),
                    ),
                  ),
                )
              : SizedBox(
                  height: 0,
                )
        ],
      ),
    );
  }
}
