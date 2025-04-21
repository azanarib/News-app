import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class NewsDetailScreen extends StatefulWidget {
  dynamic data;
  NewsDetailScreen({
    super.key,
    required this.data,
  });

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final sizeOfDevice = MediaQuery.of(context).size;
    final format = DateFormat("MMMM dd, yyyy");
    DateTime dateTime = DateTime.parse(widget.data["newsDate"]);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          SizedBox(
            height: sizeOfDevice.height * .5,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: CachedNetworkImage(
                scale: 1.0,
                imageUrl: widget.data["imageUrl"],
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: SpinKitCircle(
                    size: 50,
                    color: Colors.black,
                  ),
                ),
                errorWidget: (context, url, error) => Center(
                    child: Icon(
                  Icons.error_outline,
                  color: Colors.red,
                )),
              ),
            ),
          ),
          Container(
            height: sizeOfDevice.height * .9,
            margin: EdgeInsets.only(top: sizeOfDevice.height * .4),
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: ListView(
              children: [
                Text(
                  widget.data["newsTitle"],
                  style: GoogleFonts.acme(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: sizeOfDevice.height * .02,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.data["source"],
                        style: GoogleFonts.acme(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      format.format(dateTime),
                      style: GoogleFonts.acme(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: sizeOfDevice.height * .03,
                ),
                Text(
                  widget.data["description"],
                  style: GoogleFonts.acme(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
