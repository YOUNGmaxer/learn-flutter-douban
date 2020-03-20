import 'package:douban_app/HotMovieData.dart';
import 'package:douban_app/HotMovieItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HotMovieListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HotMovieListWidgetState();
  }
}

class HotMovieListWidgetState extends State<HotMovieListWidget> {

  List<HotMovieData> hotMovies = new List<HotMovieData>();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    List<HotMovieData> serverDataList = new List();
    var response = await http.get(
      'https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E6%B7%B1%E5%9C%B3&start=0&count=10'
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      for (dynamic data in responseJson['subjects']) {
        HotMovieData hotMovieData = HotMovieData.fromJson(data);
        serverDataList.add(hotMovieData);
      }
      setState(() {
        hotMovies = serverDataList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: hotMovies.length,
      itemBuilder: (context, index) {
        print(index);
        return HotMovieItemWidget(hotMovies[index]);
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: 1,
          color: Colors.black26
        );
      },
    );
  }
}