import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/models/news_models.dart';
import 'package:news_app/models/view/news_view_model.dart';
import 'package:news_app/screen/categories_screen.dart';
import 'package:news_app/screen/news_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterItems { bbcNews, alJazeeraNews, cnn, bloomberg, foxNews }

class _HomeScreenState extends State<HomeScreen> {
  FilterItems? selectedValue;
  final format = DateFormat("MMMM dd, yyyy");
  String name = "bbc-news";
  final spinKit2 = SpinKitFadingCircle(
    color: Colors.black,
    size: 50,
  );

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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoriesScreen(),
              ),
            );
          },
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
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDetailScreen(
                                  author: snapshot.data!.articles![index].author
                                      .toString(),
                                  content: snapshot
                                      .data!.articles![index].content
                                      .toString(),
                                  description: snapshot
                                      .data!.articles![index].description
                                      .toString(),
                                  imageUrl: snapshot
                                      .data!.articles![index].urlToImage!,
                                  newsDate: snapshot
                                      .data!.articles![index].publishedAt
                                      .toString(),
                                  newsTitle: snapshot
                                      .data!.articles![index].title
                                      .toString(),
                                  source: snapshot
                                      .data!.articles![index].source!.name
                                      .toString()),
                            ),
                          );
                        },
                        child: SizedBox(
                          child: Stack(
                            children: [
                              // This one section is for image
                              Container(
                                height: sizeOfDevice.height * 0.5,
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
                                bottom: sizeOfDevice.height * .07,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
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
                                        Row(
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
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          FutureBuilder<CategoriesNewsModel>(
            future: NewsViewModel().fetchCategoriesNewsApi("General"),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: SpinKitCircle(
                    color: Colors.black,
                    size: 50,
                  ),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.articles!.length,
                  itemBuilder: (context, index) {
                    DateTime dateTime = DateTime.parse(
                      snapshot.data!.articles![index].publishedAt.toString(),
                    );
                    return Padding(
                      padding: EdgeInsets.only(
                        left: sizeOfDevice.height * 0.02,
                        right: sizeOfDevice.height * 0.02,
                        bottom: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl: snapshot
                                  .data!.articles![index].urlToImage
                                  .toString(),
                              fit: BoxFit.cover,
                              width: sizeOfDevice.width * .4,
                              height: sizeOfDevice.height * .3,
                              placeholder: (context, url) => Center(
                                child: SpinKitCircle(
                                  size: 50,
                                  color: Colors.blue,
                                ),
                              ),
                              errorWidget: (context, url, error) => Icon(
                                Icons.error_outline,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              // width: double.infinity,
                              height: sizeOfDevice.height * .18,
                              padding: EdgeInsets.only(left: 15),
                              child: Column(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceEvenly,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      snapshot.data!.articles![index].title
                                          .toString(),
                                      maxLines: 2,
                                      style: GoogleFonts.acme(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    snapshot.data!.articles![index].source!.name
                                        .toString(),
                                    style: GoogleFonts.acme(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    format.format(dateTime),
                                    style: GoogleFonts.acme(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
