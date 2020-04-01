import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/common/image_path_const.dart';
import 'package:flutterappmovie/screen/chewie_list_item.dart';
import 'package:flutterappmovie/screen/playing_screen.dart';
import 'package:video_player/video_player.dart';

class ItemVideo extends StatefulWidget {
  @override
  _ItemVideoState createState() => _ItemVideoState();
}

class _ItemVideoState extends State<ItemVideo> {
  final _formKey = GlobalKey<FormState>();
  var _maxLineDescriptionVideo = 2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: _buildBodyWidget());
  }

  _buildBodyWidget() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: _buildHeaderWidget()),
          _buildContentVideoWidget(),
          Container(color: Colors.grey, height: 1,),
          _buildBottomWidget(),
        ],
      ),
    );
  }

  ///header gôm phần avatar + title video
  _buildHeaderWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //avatar
            _buildUserWidget(),
            Icon(Icons.more_horiz),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        //Description
        Wrap(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  _maxLineDescriptionVideo = 1000;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "Đóa hoa nở muộn tại thành Manchester Đóa hoa nở muộn tại thành Manchester Đóa hoa nở muộn tại thành Manchester Đóa hoa nở muộn tại thành Manchester"
                  "Đóa hoa nở muộn tại thành Manchester Đóa hoa nở muộn tại thành Manchester Đóa hoa nở muộn tại thành Manchester Đóa hoa nở muộn tại thành Manchester",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  maxLines: _maxLineDescriptionVideo,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  _buildUserWidget() {
    return Row(children: <Widget>[
      Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.orange),
        child: Center(
          child: Text("T"),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "BLV Hoàng Quân",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              Text(" . ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14)),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Theo dõi",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              )
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: <Widget>[
                Text(
                  "Hôm qua lúc: 17: 19",
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
                Text(" . ",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),
                Image.asset(
                  ImagePathConst.icSetting,
                  width: 18,
                  height: 18,
                )
              ],
            ),
          )
        ],
      ),
      SizedBox(
        width: 16,
      )
    ]);
  }

  _buildContentVideoWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ChewieListItem(
          videoPlayerController:
              VideoPlayerController.asset("assets/videos/end_game.mp4"),
          loop: true),
    );
  }

  ///bottom gôm like, comment,
  _buildBottomWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                print("click like");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.favorite_border),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Thích",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.message),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Bình luận",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.share),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Chia sẻ",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
