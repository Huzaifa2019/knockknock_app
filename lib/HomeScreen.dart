import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import './AdminSignIn.dart';
import './JoinUs.dart';
import './Cook.dart';
import './Daycare.dart';
import './Maid.dart';
import './AboutUs.dart';
import "CategoryCards.dart";
import 'package:back_button_interceptor/back_button_interceptor.dart';
import './ContactUs.dart';
import './Driver.dart';
import './Register.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FSBStatus drawerStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      bottomNavigationBar: BottomBar(),
      body: FoldableSidebarBuilder(
        drawerBackgroundColor: Colors.blueAccent,
        drawer: CustomDrawer(
          closeDrawer: () {
            setState(() {
              drawerStatus = FSBStatus.FSB_CLOSE; // For Closing the Sidebar
            });
          },
        ),
        status: drawerStatus,
        screenContents: HS(),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlue,
          child: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {
            // To Open/Close Sidebar
            setState(() {
              drawerStatus = drawerStatus == FSBStatus.FSB_OPEN
                  ? FSBStatus.FSB_CLOSE
                  : FSBStatus.FSB_OPEN;
            });
          }),
    );
  }

  initState() {
    super.initState();
    super.reassemble();

    BackButtonInterceptor.add(myInterceptor,
        context: context, zIndex: 1, name: "First");
  }

  @override
  void dispose() {
    BackButtonInterceptor.removeByName("First");
    super.dispose();
  }

  _onBackPressed() {
    AlertDialog alert = AlertDialog(
      title: Text(
        "Are you sure?",
        style: TextStyle(
            color: Colors.redAccent, fontWeight: FontWeight.w500, fontSize: 20),
      ),
      content: Text(
        "Do you want to quit?",
        style: TextStyle(color: Colors.grey),
      ),
      actions: [
        FlatButton(
          child: Text("YES"),
          onPressed: () {
            setState(() {
              Navigator.of(context, rootNavigator: true)
                  .popUntil((route) => false);
              exit(0);

              return false;
            });
          },
        ),
        FlatButton(
          child: Text("NO"),
          onPressed: () {
            setState(() {
              Navigator.of(context, rootNavigator: true).pop();
            });
          },
        )
        //  okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    print(info.currentRoute(context));
    // If a dialog (or any other route) is open, don't run the interceptor.
//    if (["/WorkerAccount", "/ClientAccount"]
//        .contains(info.currentRoute(context))) return true;

    if (info.ifRouteChanged(context)) return false;

    _onBackPressed();

    return true;
  }
}

class HS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/image/bluegradient.jpg"),
              ),
            ),
          ),
          Container(
            height: size.height * .45,
            color: Color.fromRGBO(255, 255, 255, 0.39),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Knock Knock',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 50.0,
                        fontFamily: 'bold',
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(255, 255, 255, 1)),
                  ),
                  Text(
                    " We     are     at     your    door ",
                    style: Theme.of(context).textTheme.title.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.black,
                        ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .95,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        CategoryCard(
                            title: "Driver",
                            imgSrc: "assets/image/driver.jpg",
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return DriverScreen();
                                }),
                              );
                            }),
                        CategoryCard(
                            title: "Day-Care",
                            imgSrc: "assets/image/daycare.jpg",
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return DayCareScreen();
                                }),
                              );
                            }),
                        CategoryCard(
                            title: "Cook",
                            imgSrc: "assets/image/cook.jpg",
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return CookScreen();
                                }),
                              );
                            }),
                        CategoryCard(
                            title: "Maid",
                            imgSrc: "assets/image/maasi.jpg",
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return MaidScreen();
                                }),
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  final Function closeDrawer;

  const CustomDrawer({Key key, this.closeDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.blueAccent, Colors.redAccent],
        ),
      ),
      width: mediaQuery.size.width * 0.60,
      height: mediaQuery.size.height,
      child: Container(
        height: mediaQuery.size.height,
        color: Color.fromRGBO(255, 255, 255, 0.8),
        child: ListView(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return AboutUsPage();
                  }),
                );
              },
              leading: Icon(Icons.subject),
              title: Text(
                "About Us",
              ),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return JoinUsScreen();
                  }),
                );
              },
              leading: Icon(Icons.add),
              title: Text("Join Us"),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return Contact();
                  }),
                );
              },
              leading: Icon(Icons.contacts),
              title: Text("Contact Us"),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return JoinUsForm(
                      login: true,
                    );
                  }),
                );
              },
              leading: Icon(Icons.person),
              title: Text("Sign In"),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return AdminSignIn();
                  }),
                );
              },
              leading: Icon(Icons.label_important),
              title: Text("Admin"),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.15,
            ),
          ],
        ),
      ),
    );
  }
}
