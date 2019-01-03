import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './DetailPage.dart';
import '../models/Topic.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  List<Topic> _topics = [];

  @override
  void initState() {
    super.initState();

    (() async {
      var response = await http.get('https://cnodejs.org/api/v1/topics');
      var parsedResult = jsonDecode(response.body)['data'];
      var typedResult = (parsedResult as List)
          .map((item) => Topic.fromData(item))
          .toList();

      setState(() {
        _topics = typedResult;
      });
    })();
  }

  void _handleItemTap({ id, title, author }) {
    Navigator.push(
      context,
      PageRouteBuilder(pageBuilder: (context, _, __) => DetailPage(
        topicId: id,
        topicTitle: title,
        author: author,
      ),
        transitionsBuilder: (_, Animation animation, __, Widget child) {
          return new FadeTransition(
            opacity: animation,
            child: child,
          );
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _topics.length > 0 ? ListView(
      children: _topics.map((t) => Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: GestureDetector(
          onTap: () => _handleItemTap(
            id: t.id,
            title: t.title,
            author: t.author,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: 'avatarHero_${t.id}',
                  child: Image.network(t.author.avatarUrl, width: 50, height: 50),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Hero(
                          tag: 'titleHero_${t.id}',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(t.title, textAlign: TextAlign.left, style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            )),
                          ),
                        ),
                        margin: EdgeInsets.only(bottom: 5),
                      ),
                      Row(
                        children: <Widget>[
                          Text(t.author.loginname),
                          Text(t.createAt),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )).toList(),
    ) : Center(
      child: CircularProgressIndicator(),
    );
  }
}
