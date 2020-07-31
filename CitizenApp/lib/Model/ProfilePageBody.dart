import 'package:flutter/material.dart';
import 'ProfilePageItem.dart';
import 'ProfilePageItemRow.dart';

class ProfilePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Container(
          color: Color(0xFF111328),
          child: new Stack(
            children: <Widget>[
              new CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: <Widget>[
                  new SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    sliver: new SliverFixedExtentList(
                      itemExtent: 152.0,
                      delegate: new SliverChildBuilderDelegate(
                        (context, index) =>
                            new ProfilePageItemRow(items[index]),
                        childCount: items.length,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
