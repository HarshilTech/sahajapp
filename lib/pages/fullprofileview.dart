import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class fullprofileview extends StatefulWidget {
  String imgpath;
  fullprofileview(this.imgpath);
  // const fullprofileview({super.key});

  @override
  State<fullprofileview> createState() => _fullprofileviewState();
}

class _fullprofileviewState extends State<fullprofileview> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.black,
        alignment: Alignment.center,
        // child: Image.network(widget.imgpath),
        child: CachedNetworkImage(
          placeholder: (context, url) =>
              //     CircularProgressIndicator(
              //   color: Colors.orange,
              // ),
              SpinKitCircle(
            color: Colors.orange,
            size: 50.0,
          ),
          imageUrl: widget.imgpath,
          fit: BoxFit.cover,
          // height: 60,
          // width: 60,
        ),
      ),
    );
  }
}
