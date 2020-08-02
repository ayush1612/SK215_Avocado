import 'package:flutter/material.dart';
import 'HomePageItem.dart';

class HomePageItemRow extends StatelessWidget {
  final HomePageItem item;

  HomePageItemRow(this.item);

  @override
  Widget build(BuildContext context) {
    final itemThumbnail = new Container(
      margin: new EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      child: new Image(
        image: new AssetImage(item.icon),
        height: 92.0,
        width: 92.0,
      ),
    );

    final baseTextStyle = const TextStyle(
      fontFamily: 'Poppins',
    );

    final headerTextStyle = baseTextStyle.copyWith(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );

    final regularTextStyle = baseTextStyle.copyWith(
        color: Color(0xffb6b2df), fontSize: 9.0, fontWeight: FontWeight.w400);

    final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 12.0);

    final itemCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(
            item.name,
            style: headerTextStyle,
          ),
          new Container(height: 10.0),
          new Text(item.description, style: subHeaderTextStyle),
          new Container(
              margin: new EdgeInsets.symmetric(vertical: 8.0),
              height: 2.0,
              width: 18.0,
              color: Color(0xff00c6ff)),
        ],
      ),
    );

    final itemCard = new GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, item.routeId);
      },
      child: new Container(
        child: itemCardContent,
        height: 124.0,
        margin: new EdgeInsets.only(left: 46.0),
        decoration: new BoxDecoration(
            color: new Color(0xFF1D1E33),
            shape: BoxShape.rectangle,
            borderRadius: new BorderRadius.circular(8.0),
            boxShadow: <BoxShadow>[
              new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0))
            ]),
      ),
    );

    return new Container(
      height: 120.0,
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: new Stack(
        children: <Widget>[
          itemCard,
          itemThumbnail,
        ],
      ),
    );
  }
}
