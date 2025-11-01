import 'dart:convert';
import 'package:binghan_mobile/_services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/_config/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final NavigationService _navigationService = locator<NavigationService>();

  String pictUrl =
      "https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584__340.png";
  String fullName = "Doe, John";
  String email = "johnDoe@mail.co";

  void _setProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = json.decode(prefs.getString("userData"));

    setState(() {
      this.fullName = "${userData["last_name"]}, ${userData["first_name"]}";
      this.email = userData["email"];
      this.pictUrl = userData["photo_profile"];
    });
  }

  @override
  void initState() {
    super.initState();
    _setProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Center(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 40.0,
                    backgroundImage: NetworkImage(
                        "https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584__340.png"),
                  ),
                  Text(
                    this.fullName,
                    style: TextStyle(color: Color(0xFFF3F3F3)),
                  ),
                  Text(
                    this.email,
                    style: TextStyle(color: Color(0xFFD3D3D3)),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text('New Member'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              _navigationService.goBack();
              _navigationService.navigateTo("NewMember");
            },
          ),
          ListTile(
            title: Text('Logout'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // _dashboardViewModel.logout();
            },
          ),
        ],
      ),
    );
  }
}
