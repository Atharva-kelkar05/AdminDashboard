import 'package:flutter/material.dart';
import 'package:dashboard/table.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.menu_rounded,
            color: Colors.white,
          ),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: const Color(0xFF333366),
      ),
      //body: Center(child: Text('Welcome to the Admin Dashboard!')),
      // Lets create a drawer here
      drawer: Drawer(
          child: ListView(padding: const EdgeInsets.all(10), children: <Widget>[
        const Icon(
          Icons.menu_rounded,
          color: Colors.white,
        ),
        // DrawerHeader(
        //   decoration: BoxDecoration(
        //     color: Colors.blue,
        //   ),
        //   child:  Text('Drawer Header'),
        // ),
        const UserAccountsDrawerHeader(
          accountName: Text('Admin'),
          accountEmail: Text('admin@mailinator.com'),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.orangeAccent,
            child: Text(
              'A',
              style: TextStyle(fontSize: 40.0),
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Home'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ])),
      body: const EmployeeTable(),
    );
  }
}