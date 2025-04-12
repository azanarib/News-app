import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/news_models.dart';
import 'package:news_app/models/view/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterItems { bbcNews, alJazeeraNews, cnn, bloomberg, foxNews }

class _HomeScreenState extends State<HomeScreen> {
  FilterItems? selectedValue;
  final format = DateFormat("MMMM dd, yyyy");
  final spinKit2 = SpinKitFadingCircle(
    color: Colors.black,
    size: 50,
  );
  String name = "bbc-news";
  @override
  Widget build(BuildContext context) {
    final sizeOfDevice = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "News",
          style: GoogleFonts.acme(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            "assets/icons/category_icon.png",
            height: 30,
            width: 30,
          ),
        ),
        actions: [
          PopupMenuButton(
            initialValue: selectedValue,
            onSelected: (FilterItems item) {
              setState(() {});
              if (FilterItems.bbcNews.name == item.name) {
                name = "bbc-news";
              } else if (FilterItems.bloomberg.name == item.name) {
                name = "bloomberg";
              } else if (FilterItems.alJazeeraNews.name == item.name) {
                name = "al-jazeera-english";
              } else if (FilterItems.cnn.name == item.name) {
                name = "cnn";
              } else if (FilterItems.foxNews.name == item.name) {
                name = "fox-news";
              }
              setState(() {
                selectedValue = item;
              });
            },
            icon: Icon(Icons.more_vert_outlined),
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<FilterItems>>[
              PopupMenuItem<FilterItems>(
                value: FilterItems.bbcNews,
                child: Text("BBC News"),
              ),
              PopupMenuItem<FilterItems>(
                value: FilterItems.alJazeeraNews,
                child: Text("Al Jazeera News"),
              ),
              PopupMenuItem<FilterItems>(
                value: FilterItems.bloomberg,
                child: Text("Bloomberg"),
              ),
              PopupMenuItem<FilterItems>(
                value: FilterItems.cnn,
                child: Text("CNN News"),
              ),
              PopupMenuItem<FilterItems>(
                value: FilterItems.foxNews,
                child: Text("Fox News"),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            width: sizeOfDevice.width,
            height: sizeOfDevice.height * .55,
            child: FutureBuilder<NewsChannelHeadLines>(
              future: NewsViewModel().fetchNewsChannelHeadlines(name),
              builder: (BuildContext context, snapshot) {
                if (!snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: SpinKitCircle(
                          color: Colors.black,
                          size: 50,
                        ),
                      ),
                    ],
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(
                        snapshot.data!.articles![index].publishedAt.toString(),
                      );
                      return SizedBox(
                        child: Stack(
                          children: [
                            // This one section is for image
                            Container(
                              height: sizeOfDevice.height * 0.6,
                              width: sizeOfDevice.width * .9,
                              padding: EdgeInsets.symmetric(
                                horizontal: sizeOfDevice.height * 0.02,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot
                                      .data!.articles![index].urlToImage
                                      .toString(),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => spinKit2,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: sizeOfDevice.height * .02,
                              // left: 20,
                              right: sizeOfDevice.width * .05,
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  height: sizeOfDevice.height * .22,
                                  alignment: Alignment.bottomCenter,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: sizeOfDevice.width * 0.7,
                                        child: Text(
                                          snapshot
                                              .data!.articles![index].content
                                              .toString(),
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.acme(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        child: Row(
                                          spacing: sizeOfDevice.width * 0.02,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data!.articles![index]
                                                  .source!.name
                                                  .toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.acme(
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              format.format(dateTime),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
