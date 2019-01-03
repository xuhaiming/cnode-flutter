import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../common/AppLayout.dart';
import '../models/Topic.dart';

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

  _buildContent(dynamicContent) {
    return <Widget>[
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
      dynamicContent,
    ];
  }

  @override
  Widget build(BuildContext context) {
    var dynamicContent =  _topic != null ? Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Html(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        onLinkTap: _onLinkTap,
        data: _topic.content,
      ),
    ) : Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );

    return AppLayout(
      child: _topic == null ? Column(
        children: _buildContent(dynamicContent),
      ) : ListView(
        children: _buildContent(dynamicContent),
      ),
    );
  }
}
