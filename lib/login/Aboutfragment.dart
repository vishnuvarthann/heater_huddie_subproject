import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parker_mobile_framework/Utility/MyConstants.dart';
import 'package:parker_mobile_framework/login/NavigationDrawer.dart';


class Aboutfragment extends StatefulWidget {
  @override
  AboutFragmentState createState() => AboutFragmentState();
}

TabController _tabController;


class AboutFragmentState extends State<Aboutfragment> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.yellow,
              title: Text(
                BOTTOMNAV.title,
              ),
            ),
            body: DefaultTabController(
                length: 3,
                child: Scaffold(
                  body: SafeArea(
                    child: Column(
                      children: <Widget>[
                        PreferredSize(
                          preferredSize: Size.fromHeight(50.0),
                          child: TabBar(
                            controller: _tabController,
                            indicatorColor: Colors.yellow,
                            labelColor: Colors.red,
                            unselectedLabelColor: Colors.grey,

                            tabs: [
                              Tab(
                                text: 'ContactUs',
                                icon: Icon(Icons.contact_mail),
                              ),
                              Tab(
                                text: 'Location',
                                icon: Icon(Icons.location_on),
                              ),
                              Tab(
                                text: 'Photo',
                                icon: Icon(Icons.photo_album),
                              ),
                            ], // list of tabs
                          ),
                        ),
                        //TabBarView(children: [ImageList(),])
                        Expanded(
                          child: TabBarView(children: [
                            Container(
                              
                            ),
                            Container(
                             
                              ),
                            
                            Container(
                              color: Colors.white,
                              child: Center(child: Text("Photo details")),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ))));
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationDrawer()),
                    ModalRoute.withName("/NavigationDrawer")),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }
}
