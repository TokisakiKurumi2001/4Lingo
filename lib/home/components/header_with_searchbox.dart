import 'package:flutter/material.dart';
import 'package:ForLingo/models/vocabs_interface.dart' as vs;

class HeaderWithSearchBox extends StatefulWidget {
  final Function sethomestate;
  const HeaderWithSearchBox({
    this.sethomestate,
    Key key,
    @required this.size,
  }) : super(key: key);
  final Size size;

  @override
  _HeaderWithSearchBoxState createState() => _HeaderWithSearchBoxState();
}

class _HeaderWithSearchBoxState extends State<HeaderWithSearchBox> {
  TextEditingController controller1 = TextEditingController();
  @override
  void initState() {
    super.initState();
    print('initstate');
  }

  @override
  Widget build(BuildContext context) {
    if (vs.handleSearch == true) {
      controller1.clear();
      vs.handleSearch = false;
    }
    return Container(
        height: widget.size.height * 0.12,
        child: Stack(children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 56,
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 50,
                  color: Colors.blue.withOpacity(0.23),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: "Search word",
                      hintStyle: TextStyle(
                        color: Colors.blue.withOpacity(0.5),
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    controller: controller1,
                    onChanged: (val) {
                      widget.sethomestate(val);
                    },
                  ),
                ),
                Icon(
                  Icons.search,
                  color: Colors.blue,
                ),
              ],
            ),
          )
        ]));
  }
}

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget widget;

  PersistentHeader({this.widget});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: double.infinity,
      height: 105.0,
      child: Card(
        margin: EdgeInsets.all(0),
        color: Colors.white,
        elevation: 0,
        child: Center(child: widget),
      ),
    );
  }

  @override
  double get maxExtent => 105.0;

  @override
  double get minExtent => 105.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
