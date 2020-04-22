import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/bloc/news_bloc.dart';
import 'package:flutterappmovie/const/colors.dart';
import 'package:flutterappmovie/model/news.dart';
import 'package:flutterappmovie/screen/detail_news_screen.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

  NewsBloc _newsBloc = NewsBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _newsBloc.getListNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MAIN_THEME,
          title: Text(
        "Tin tức SunShine",
        style: TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
      )),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: RefreshIndicator(
          onRefresh: () async {
            _newsBloc.getListNews();
          },
          child: StreamBuilder<List<News>>(
            stream: _newsBloc.getStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Container(width: 40, height: 40, child: CircularProgressIndicator(),),);
              }
              List<News> list = snapshot.data;
              return ListView.separated(
                  itemBuilder: (context, index) {
                    var news = list[index];
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (context) => DetailNewsPage(news.urlPath)));
                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          Image.network(news.urlImage),
                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(news.title, style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),
                                SizedBox(height: 6,),
                                Text(news.date, style: TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold),)
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Container(height: 8, color: Colors.white,),
                  itemCount: list.length);
            }
          ),
        )
      ),
    );
  }
}
