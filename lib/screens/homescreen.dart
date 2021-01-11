import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_app/screens/authscreen.dart';
import 'package:flutter_demo_app/screens/users_screen.dart';
import 'package:flutter_demo_app/utilities.dart/google_auth.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleAuthentication googleAuthentication = GoogleAuthentication();

  CalendarController _calendarController;
  TextEditingController _textEditingController;
  UserCredential user;
  String selectedDate = "Select a date..";

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _textEditingController = TextEditingController();
    auth.authStateChanges().listen(
          (User user) => {
            if (user == null)
              {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => AuthScreen(),
                  ),
                ),
              },
          },
        );
  }

  @override
  void dispose() {
    _calendarController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: _sidebar(),
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.red[700],
              ),
              onPressed: () => googleAuthentication.signOutFromGoogle(),
            )
          ],
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.menu),
            color: Colors.black87,
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
          title: Text("Home Screen"),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              _buildCalendar(),
              SizedBox(
                height: 20.0,
              ),
              _buildSelectedDateTextfield(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sidebar() {
    return Container(
      width: (MediaQuery.of(context).size.width * 2) / 3,
      child: Drawer(
        child: Container(
          color: Colors.grey[100],
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Image.asset(
                'assets/flutter.png',
                width: 60.0,
                height: 60.0,
              ),
              Divider(
                color: Colors.black38,
              ),
              _buildDrawerButton(
                  context, "Home", () => {Navigator.of(context).pop()}),
              _buildDrawerButton(context, "Users", _openUserPage),
              _buildDrawerButton(context, "Logout",
                  () => googleAuthentication.signOutFromGoogle()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerButton(
      BuildContext context, String label, Function action) {
    return TextButton(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
        ),
        width: (MediaQuery.of(context).size.width * 2) / 3,
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 20.0,
          ),
        ),
      ),
      onPressed: action,
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      startDay: DateTime.now(),
      startingDayOfWeek: StartingDayOfWeek.monday,
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: (DateTime day, List events, List holidays) => {
        setState(() {
          selectedDate = "${day.day}/${day.month}/${day.year}";
        })
      },
    );
  }

  Widget _buildSelectedDateTextfield() {
    return Container(
      width: MediaQuery.of(context).size.width * 3 / 4,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black45,
            style: BorderStyle.solid,
            width: 2.0,
          ),
        ),
      ),
      alignment: Alignment.center,
      child: Center(
        child: Text(
          selectedDate,
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
      ),
    );
  }

  void _openUserPage() {
    // _scaffoldKey.currentState.dra;
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UsersScreen(),
      ),
    );
  }
}
