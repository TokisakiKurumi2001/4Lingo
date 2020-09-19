import 'package:ForLingo/home/components/word/wordpage.dart';
import 'package:flutter/material.dart';
//import 'components/body.dart';
import 'components/header_with_searchbox.dart';
import 'components/bottom_nav_bar/bottom_nav_bar.dart';
import 'components/word/add.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //appBar: buildAppBar(),
      //body: Body(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0,
            pinned: false,
            snap: false,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                '4Lingo',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
          ),
          // SliverAppBar(
          //   toolbarHeight: 80,
          //   pinned: true,
          //   backgroundColor: Colors.white,
          //   automaticallyImplyLeading: false,
          //   actions: <Widget>[
          //     Container(),
          //   ],
          //   title: HeaderWithSearchBox(size: size),
          // ),
          SliverPersistentHeader(
            pinned: true,
            delegate: PersistentHeader(
              widget: HeaderWithSearchBox(size: size),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  children: <Widget>[
                    Word(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Adding()))
                .then((value) => setState(() {}));
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                '4Lingo',
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text(
                'Guide',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                //Guide popup
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'Setting',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                //Setting popup
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

/*
  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: Text(
        '4Lingo',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
   */
}
