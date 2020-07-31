import 'package:flutter/material.dart';
import 'package:police_app/Components/reusablecard.dart';
import 'package:police_app/Utilities/network.dart';

import '../constants.dart';

class NewsGenerator {
  var newsData = null;

  Future<dynamic> getNews(String currnews) async {
    newsData = null;
    NetworkHelper networkHelper = NetworkHelper(
        'https://safe-beyond-08524.herokuapp.com/' + currnews + '/news');
    newsData = await networkHelper.getData();
    print(newsData);
    return newsData;
  }

  Widget makeList(String currnews) {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if ((projectSnap.connectionState == ConnectionState.none &&
                projectSnap.hasData == null) ||
            newsData == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        return ListView.builder(
          itemCount: projectSnap.data.length,
          itemBuilder: (context, index) {
//            return Column(
//              children: <Widget>[
//                // Widget to display the list of project
//              ],
//            );
            return ReusableCard(
//              width: 100,
//              margin: EdgeInsets.all(20),
//              padding: EdgeInsets.all(20),
//              height: 320,
              colour: kActiveCardColor,
              cardChild: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          (index + 1).toString() + '.  ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        Container(
                          width: 350,
                          child: Column(
                            children: <Widget>[
                              Text(
                                newsData[index]['title'].toString(),
                                style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                newsData[index]['content'].toString(),
                                style: TextStyle(
                                  color: Colors.white70,
                                  letterSpacing: 1.25,
                                  fontSize: 14,
                                  wordSpacing: 2.0,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(newsData[index]['postedAt'].toString(),
                        style: TextStyle(
                          color: Colors.cyanAccent,
                          letterSpacing: 1.5,
                        )),
                  ],
                ),
              ),
            );
          },
        );
      },
      future: getNews(currnews),
    );
  }
}
