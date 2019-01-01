import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import './models/Topic.dart';

void main() {
  runApp(CNodeApp());
}

class CNodeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CNode',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RootPage(),
    );
  }
}

class DetailPage extends StatefulWidget {
  DetailPage({
    Key key,
    this.topicId,
    this.topicTitle,
    this.author,
  }) : super(key: key);

  final String topicId;
  final String topicTitle;
  final Author author;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class DetailHero extends StatelessWidget {
  DetailHero({
    Key key,
    this.topicId,
    this.topicTitle,
    this.author,
  }) : super(key: key);

  final String topicId;
  final String topicTitle;
  final Author author;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
      child: Row(
        children: <Widget>[
          Hero(
            tag: 'avatarHero_$topicId',
            child: Image.network(author.avatarUrl, width: 60, height: 60),
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Hero(
                tag: 'titleHero_$topicId',
                child: Material(
                  color: Colors.transparent,
                  child: Text(topicTitle, textAlign: TextAlign.left, style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailPageState extends State<DetailPage> {
  Topic _topic;

  @override
  void initState() {
    super.initState();

    (() async {
      var topicId = widget.topicId;
      var response = await http.get('https://cnodejs.org/api/v1/topic/$topicId');
      var parsedResult = jsonDecode(response.body)['data'];

      setState(() {
        _topic = Topic.fromData(parsedResult);
      });
    })();
  }

  _onLinkTap(url) async {
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CNode Detail',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('CNode'),
        ),
        body: _topic != null ? ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
              child: Row(
                children: <Widget>[
                  Hero(
                    tag: 'avatarHero_${widget.topicId}',
                    child: Image.network(widget.author.avatarUrl, width: 60, height: 60),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Hero(
                        tag: 'titleHero_${widget.topicId}',
                        child: Material(
                          color: Colors.transparent,
                          child: Text(widget.topicTitle, textAlign: TextAlign.left, style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Html(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                onLinkTap: _onLinkTap,
                data: _topic.content,
              ),
            ),
          ],
        ) : Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
              child: Row(
                children: <Widget>[
                  Hero(
                    tag: 'avatarHero_${widget.topicId}',
                    child: Image.network(widget.author.avatarUrl, width: 60, height: 60),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Hero(
                        tag: 'titleHero_${widget.topicId}',
                        child: Material(
                          color: Colors.transparent,
                          child: Text(widget.topicTitle, textAlign: TextAlign.left, style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
      MaterialPageRoute(builder: (context) => DetailPage(
        topicId: id,
        topicTitle: title,
        author: author,
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CNode'),
      ),
      body: _topics.length > 0 ? ListView(
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
      ),
    );
  }
}
