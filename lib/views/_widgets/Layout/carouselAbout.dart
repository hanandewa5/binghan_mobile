import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/_services/navigation_service.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class CarouselAbout extends StatefulWidget {
  final List<Widget> items;
  const CarouselAbout({required this.items, super.key});

  @override
  State<CarouselAbout> createState() => _CarouselAboutState();
}

class _CarouselAboutState extends State<CarouselAbout> {
  final NavigationService _navigationService = locator<NavigationService>();
  final CarouselSliderController? controller = null;

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    void changeIndex(int i) {
      // setState(() {
      //   _current = _current + i;
      //   print(_current);
      // });
      print("$_current , ${widget.items.length}");

      if (i > 0) {
        controller?.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.linear,
        );
        if (widget.items.length == _current + 1) {
          _navigationService.goBack();
        }
      } else {
        controller?.previousPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.linear,
        );
      }
    }

    return Stack(
      children: [
        CarouselSlider(
          items: widget.items,
          carouselController: controller,
          options: CarouselOptions(
            enableInfiniteScroll: false,
            height: MediaQuery.of(context).size.height,
            viewportFraction: 0.99,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Positioned(
          top: 22,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(widget.items, (index, url) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Color.fromRGBO(0, 0, 0, 0.9)
                        : Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                );
              }),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: UIHelper.marginSymmetric(10, 15),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _current > 0
                        ? InkWell(
                            onTap: () {
                              changeIndex(-1);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black54,
                            ),
                          )
                        : Paragraft(
                            text: "",
                            textStyle: textMedium,
                            color: Colors.black54,
                            fontSize: 20,
                          ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        changeIndex(1);
                      },
                      child: _current < widget.items.length - 1
                          ? Icon(Icons.arrow_forward_ios, color: Colors.black54)
                          : Paragraft(
                              text: "LOGIN NOW",
                              textStyle: textMedium,
                              fontSize: 20,
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
