import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/model/movie.dart';

import '../common/colors_const.dart';
import '../common/image_path_const.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  List<Movie> _lstMoveTrending = [Movie('','','','','https://www.cgv.vn/media/catalog/product/cache/1/small_image/240x388/dd828b13b1cb77667d034d5f59a82eb6/b/l/bloodshot_cgv_1.jpg', '', ''),
  Movie('','','','','https://www.cgv.vn/media/catalog/product/cache/1/small_image/240x388/dd828b13b1cb77667d034d5f59a82eb6/p/o/poster_onward_official_1__1.jpg', '', ''),
  Movie('','','','','https://www.cgv.vn/media/catalog/product/cache/1/small_image/240x388/dd828b13b1cb77667d034d5f59a82eb6/i/-/i-still-believe-1-poster-cgv_1.jpg', '', ''),
  Movie('','','','','https://www.cgv.vn/media/catalog/product/cache/1/small_image/240x388/dd828b13b1cb77667d034d5f59a82eb6/b/l/bloodshot_cgv_1.jpg', '', '')];

  PageController _pageController = PageController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConst.mainColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 400,
                    child: Image.asset('assets/img_poster_film.jpg', fit: BoxFit.fitWidth,)
                ),
                SafeArea(child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Container(width: double.infinity, height: 320,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _headerWidget(_pageController),
                        _playButtonWidget()
                      ],
                    ),
                  ),
                )),
              ],
            ),

            _listProduct(),

            _listMoviePopullar(),

            _listMoviePopullar()
          ],
        ),
      ),
    );
  }

  ///vẽ phần Header gồm ảnh + các button
  Widget _headerWidget(PageController pageController) {

    return Container(
      constraints: BoxConstraints(
        minHeight: 30, maxHeight: 60
      ),
      child: PageView.builder(
        controller: pageController,
        itemCount: _lstMoveTrending.length,
        itemBuilder: (BuildContext context, int index){
          return Expanded(child: Image.network(
            _lstMoveTrending[index].imagePoster,
            fit: BoxFit.fitWidth,));
        },
      ),
    );
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//      children: <Widget>[
//        Container(
//            height: 50,
//            child: Image.asset(
//                'assets/icLogo.png',
//              fit: BoxFit.fitHeight,
//            )
//        ),
//
//        _headerButtonWidget()
//      ],
//    );
  }

  /// vẽ phần header button tìm kiếm, mua gói
  Widget _headerButtonWidget() {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white70
              ),
              child: Center(
                child: Icon(Icons.search),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white70
              ),
              child: Icon(Icons.favorite),
            ),
          ),

          RaisedButton(
            disabledColor: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(18.0),
            ),
            child: Text('Mua gói', style: TextStyle(color: Colors.white, )
            ),
          )

        ],
      ),
    );
  }

  ///ve button play tren poster phim
  Widget _playButtonWidget() {
    return Container(
      width: 120,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.play_arrow),
            Text('Phát', style: TextStyle(color: Colors.white, fontSize: 16),)
          ],
        ),
      ),
    );
  }

  ///ve list sp sunshine
  Widget _listProduct() {
    return Padding(padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text('SunShine', style: TextStyle(color: Colors.white, fontSize: 20,),)
          ),

          Container(
            height: 120,
            child: ListView(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _productSunshine('', ImagePathConst.imgProduct1),
                _productSunshine('', ImagePathConst.imgProduct2),
                _productSunshine('', ImagePathConst.imgProduct3),
                _productSunshine('', ImagePathConst.imgProduct1),
                _productSunshine('', ImagePathConst.imgProduct2),
                _productSunshine('', ImagePathConst.imgProduct3),
              ],
            ),
          ),

        ],
      ),
    );
  }

  ///ve templet cho 1 sp
  Widget _productSunshine(String overview, String imgPath) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            constraints: BoxConstraints(minHeight: 60, maxHeight: 70),
            child: Stack(
              children: <Widget>[
                Image(image: AssetImage(imgPath), height: 70, fit: BoxFit.fitWidth,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 0, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(4.0)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text('09 33', style: TextStyle(color: Colors.white, fontSize: 8),),
                    ),
                  ),
                )
              ],
      ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text('tong quan gioi thieu',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(color: Colors.white),)
          )
        ],
      ),
    );
  }

  ///danh sach phim thinh hanh trong tuan
  Widget _listMoviePopullar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
              alignment: Alignment.topLeft,
              child: Text('Tất cả', style: TextStyle(color: Colors.white, fontSize: 20),)
          ),
          SizedBox(height: 6,),
          Container(
            constraints: BoxConstraints(minHeight: 120, maxHeight: 200),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _templeMovie(ImagePathConst.imgMovie, 'Move 1'),
                _templeMovie(ImagePathConst.imgMovie, 'Move 2'),
                _templeMovie(ImagePathConst.imgMovie, 'Move 3'),
                _templeMovie(ImagePathConst.imgMovie, 'Move 4'),
                _templeMovie(ImagePathConst.imgMovie, 'Move 5'),
                _templeMovie(ImagePathConst.imgMovie, 'Move 6'),
                _templeMovie(ImagePathConst.imgMovie, 'Move 9'),
              ],
            )
          ),
        ],
      ),
    );
  }
  
  Widget _templeMovie(String imgPath, String title) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
        child: Column(
          children: <Widget>[
            Image(image: AssetImage(imgPath), width: 100,),
            SizedBox(height: 6,),
            Text(title, style: TextStyle(color: Colors.white, fontSize: 10),)
          ],
        ),
      ),
    );
  }
}