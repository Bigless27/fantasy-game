import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gg/UI/profile_placeholder.dart';
import 'dart:io';
import 'dart:core';
import 'package:gg/Functions/fetch_user_info.dart';
import 'package:sortedmap/sortedmap.dart';

String username;
String posts;
String followers;
String following;
String _currentUser;
List<String> postUsername = [];
List<String> postBody = [];
List<String> postUser = [];
List<String> postMediaURL = [];
List<String> postID = [];
List<DateTime> postTimeStamp = [];
List<int> postLikes = [];
List<int> postReposts = [];
List postUserImage = [];
List<IconData> postLikeIcons = [];
List<Color> postLikeColors = [];
List<Color> postRepostColors = [];
String postIDS;
var _banner;
var postIMG;
var _profileIMG;
String path;
var profileImage;
List<bool> postMedia = [];
List<bool> postLiked = [];
bool userInfoLoaded = false;
bool postUserImageLoaded = false;
bool postsLoaded = false;
int postCount;
int like;
Map<dynamic, dynamic> unorderedPosts = {};
Map<dynamic, dynamic> orderedPosts = {};
Map<dynamic, dynamic> sortedMap;
Map<dynamic, dynamic> userInfo = {};
File profilePic;
=======
>>>>>>> c056af465ff9ad3f4a30f919850fe8df5d308025

class ProfilePage extends StatefulWidget {
  _ProfilePage createState() => new _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  @override
<<<<<<< HEAD
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }

  void _fetchCurrentUser() async {
    print("WORKING");
    await FirebaseAuth.instance.currentUser().then((user) {
      if (user != null) {
        _currentUser = user.uid;
        _fetchUserInfo();
        fetchPostID();
        print(_currentUser);
      } else {
        print("error");
      }
    });
  }

  void _fetchUserInfo() async {
    await Firestore.instance
        .document("Users/$_currentUser")
        .get()
        .then((userData) {
      if (userData.exists) {
        print(userData.data["username"]);
        username = userData.data["username"];
        posts = userData.data["profile"]["posts"].toString();
        followers = userData.data["profile"]["followers"].toString();
        following = userData.data["profile"]["following"].toString();
      } else {
        print("NO USERNAME");
      }
    }).whenComplete(() => fetchProfileImage());
  }

  void fetchProfileImage() async {
    FirebaseStorage.instance
        .ref()
        .child("$_currentUser/Profile/Profile Image/profilePicture.jpg")
        .getData(1 * 1024 * 1024)
        .then((profileIMG) {
      if (profileIMG.isNotEmpty) {
        _profileIMG = profileIMG;
      } else {
        print("NO PROFILE IMAGE");
      }
    }).whenComplete(() => fetchBanner());
  }

  void fetchBanner() {
    FirebaseStorage.instance
        .ref()
        .child("$_currentUser/Profile/Banner/banner.JPG")
        .getData(1 * 1024 * 1024)
        .then((banner) {
      if (banner.isNotEmpty) {
        _banner = banner;
        setState(() {
          userInfoLoaded = true;
        });
      } else {
        print("NO BANNER");
      }
    });
  }

  fetchPostID() async {
    postBody = [];
    postUser = [];
    postUsername = [];
    postMedia = [];
    postMediaURL = [];
    postUserImage = [];
    postTimeStamp = [];
    postID = [];
    postLikes = [];
    postLiked = [];
    postReposts = [];
    postLikeIcons = [];
    postLikeColors = [];
    postRepostColors = [];
    print("PostID");
    await Firestore.instance
        .document("Users/$_currentUser")
        .get()
        .then((posts) {
      if (posts.exists) {
        Map<dynamic, dynamic> post = posts.data["posts"];
        var sortedKeys = post.keys.toList(growable: false)
          ..sort((k1, k2) => post[k1].compareTo(post[k2]));
        sortedMap = new Map.fromIterable(sortedKeys.reversed,
            key: (k) => k, value: (k) => post[k]);
        print(sortedMap);
        print("${post.length}!!!!!!!");
        postCount = post.length;
        fetchPosts();
      }
    });
    await Firestore.instance
        .document("Users/$_currentUser")
        .get()
        .then((userData) {
      if (userData.exists) {
        userInfo = userData.data;
      }
    });
  }

  fetchPosts() async {
    print("WORKING!!");
    for (String postID in sortedMap.keys) {
      await Firestore.instance.document("Posts/$postID").get().then(
        (postInfo) {
          if (postInfo.exists) {
            //print(postInfo.data);
            Map<dynamic, dynamic> unorderedPost = {
              postInfo.documentID: postInfo.data
            };
            unorderedPosts.addAll(unorderedPost);
          }
        },
      );
    }
    if (unorderedPosts.length == postCount) {
      loadPosts();
    }
  }

  loadPosts() {
    orderedPosts = {};
    for (String orderedKey in sortedMap.keys) {
      Map<dynamic, dynamic> orderedPost = {
        orderedKey: unorderedPosts[orderedKey]
      };
      orderedPosts.addAll(orderedPost);
    }
    print(orderedPosts);
    if (orderedPosts.length == postCount) {
      for (var info in orderedPosts.values) {
        Map<dynamic, dynamic> post = info;
        print(post);
        postBody.add(post["body"]);
        postMedia.add(post["media"]);
        postUsername.add(post["username"]);
        postUser.add(post["userID"]);
        postTimeStamp.add(post["time"]);
        postLikes.add(post["likes"]);
        postReposts.add(post["reposts"]);
        postID.add(post["postID"]);
        postRepostColors.add(Color.fromRGBO(170, 170, 170, 1.0));
        if (post["mediaURL"] != null) {
          postMediaURL.add(post["mediaURL"]);
        } else {
          postMediaURL.add("");
        }
        if (userInfo["likedPosts"][post["postID"]] != null &&
            userInfo["likedPosts"][post["postID"]] != 0) {
          postLiked.add(true);
          postLikeIcons.add(Icons.favorite);
          postLikeColors.add(Colors.red);
        } else {
          postLiked.add(false);
          postLikeIcons.add(Icons.favorite_border);
          postLikeColors.add(Color.fromRGBO(170, 170, 170, 1.0));
        }
      }
      if (postBody.length == postCount &&
          postMedia.length == postCount &&
          postUsername.length == postCount &&
          postMediaURL.length == postCount &&
          postTimeStamp.length == postCount &&
          postLikes.length == postCount &&
          postReposts.length == postCount &&
          postLikeIcons.length == postCount &&
          postLikeColors.length == postCount &&
          postRepostColors.length == postCount &&
          postID.length == postCount &&
          postUser.length == postCount &&
          postLiked.length == postCount) {
        postUser.forEach((userID) => FirebaseStorage.instance
                .ref()
                .child("$userID/Profile/Profile Image/profilePicture.jpg")
                .getData(1 * 1024 * 1024)
                .then((image) {
              if (image.isNotEmpty) {
                postUserImage.add(image);
                if (postUserImage.length == postCount) {
                  setState(() {
                    postsLoaded = true;
                  });
                }
              }
            }));
      }
    }
  }

  postLoaded() {
    if (postsLoaded != true) {
      return new SliverToBoxAdapter(
        child: new Container(
          margin: EdgeInsets.all(0.0),
          child: new Center(
            child: new CircularProgressIndicator(
              backgroundColor: Color.fromRGBO(0, 150, 255, 1.0),
            ),
          ),
        ),
      );
    } else {
      return new PostList();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userInfoLoaded != true) {
      return ProfilePlaceholder();
    } else {
      return Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Color.fromRGBO(23, 23, 23, 1.0),
          bottomNavigationBar: new Theme(
            data: new ThemeData(
              canvasColor: Color.fromRGBO(5, 5, 10, 0.9),
              primaryColor: Color.fromRGBO(0, 150, 255, 1.0),
              textTheme: new TextTheme(
                caption: new TextStyle(
                  color: Color.fromRGBO(170, 170, 170, 1.0),
                  fontSize: 12.0,
                ),
              ),
            ),
            child: new BottomNavigationBar(
              currentIndex: 4,
              type: BottomNavigationBarType.fixed,
              fixedColor: Color.fromRGBO(0, 150, 255, 1.0),
              items: [
                BottomNavigationBarItem(
                  icon: new Icon(
                    Icons.home,
                  ),
                  title: new Text(
                    "Home",
                    style: new TextStyle(
                      fontSize: 12.0,
                      fontFamily: "Century Gothic",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: new Icon(
                    Icons.search,
                    size: 25.0,
                  ),
                  title: new Text(
                    "Search",
                    style: new TextStyle(
                      fontSize: 12.0,
                      fontFamily: "Century Gothic",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: new Icon(
                    IconData(0xe900, fontFamily: "Trophy"),
                  ),
                  title: new Text(
                    "Tournaments",
                    style: new TextStyle(
                      fontSize: 12.0,
                      fontFamily: "Century Gothic",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: new Icon(
                    Icons.chat,
                  ),
                  title: new Text(
                    "Messages",
                    style: new TextStyle(
                      fontSize: 12.0,
                      fontFamily: "Century Gothic",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: new Icon(
                    IconData(0xe971, fontFamily: "Profile"),
                    size: 25.0,
                  ),
                  title: new Text(
                    "Me",
                    style: new TextStyle(
                      fontSize: 12.0,
                      fontFamily: "Century Gothic",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: new CustomScrollView(
            slivers: <Widget>[
              new SliverAppBar(
                backgroundColor: Colors.transparent,
                leading: new Container(),
                expandedHeight: 190.0,
                elevation: 0.0,
                flexibleSpace: new FlexibleSpaceBar(
                  background: new Container(
                    //  color: Colors.blue,
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          height: 160.0,
                          child: new Stack(
                            alignment: Alignment.topRight,
                            children: <Widget>[
                              new Stack(
                                alignment: Alignment.topRight,
                                fit: StackFit.expand,
                                children: <Widget>[
                                  new Image.memory(
                                    _banner,
                                    fit: BoxFit.cover,
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      new CircleAvatar(
                                        radius: 50.0,
                                        backgroundColor:
                                            Color.fromRGBO(0, 150, 255, 1.0),
                                        child: CircleAvatar(
                                          backgroundImage: new MemoryImage(
                                            _profileIMG,
                                          ),
                                          radius: 46.0,
                                          backgroundColor: Colors.white,
                                        ),
                                      ),
                                      new Container(
                                        margin: EdgeInsets.only(
                                            top: 2.0, bottom: 3.0),
                                        child: new Text(
                                          username,
                                          style: new TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Century Gothic",
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              new Stack(
                                //alignment: Alignment.bottomLeft,
                                children: <Widget>[
                                  new Container(
                                    margin:
                                        EdgeInsets.only(right: 15.0, top: 30.0),
                                    width: 30.0,
                                    height: 30.0,
                                    decoration: new BoxDecoration(
                                      borderRadius:
                                          new BorderRadius.circular(2.0),
                                      color: Color.fromRGBO(50, 50, 50, 1.0),
                                    ),
                                  ),
                                  new IconButton(
                                    splashColor:
                                        Color.fromRGBO(0, 150, 255, 1.0),
                                    padding:
                                        EdgeInsets.only(right: 18.0, top: 33.0),
                                    onPressed: () {
                                      for (var biscuit in orderedPosts.values) {
                                        Map<dynamic, dynamic> dogs = biscuit;
                                        print(dogs["body"]);
                                      }
                                      // Navigator
                                      //     .of(context)
                                      //     .pushNamed('/LoginPage');
                                    },
                                    icon: new Icon(
                                      Icons.description,
                                      size: 25.0,
                                      color: Colors.white,
=======
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color.fromRGBO(23, 23, 23, 1.0),
        bottomNavigationBar: new Theme(
          data: new ThemeData(
            canvasColor: Color.fromRGBO(5, 5, 10, 0.9),
            primaryColor: Color.fromRGBO(0, 150, 255, 1.0),
            textTheme: new TextTheme(
              caption: new TextStyle(
                color: Color.fromRGBO(170, 170, 170, 1.0),
                fontSize: 12.0,
              ),
            ),
          ),
          child: new BottomNavigationBar(
            currentIndex: 4,
            type: BottomNavigationBarType.fixed,
            fixedColor: Color.fromRGBO(0, 150, 255, 1.0),
            items: [
              BottomNavigationBarItem(
                icon: new Icon(
                  Icons.home,
                ),
                title: new Text(
                  "Home",
                  style: new TextStyle(
                    fontSize: 12.0,
                    fontFamily: "Century Gothic",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: new Icon(
                  Icons.search,
                  size: 25.0,
                ),
                title: new Text(
                  "Search",
                  style: new TextStyle(
                    fontSize: 12.0,
                    fontFamily: "Century Gothic",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: new Icon(
                  IconData(0xe900, fontFamily: "Trophy"),
                ),
                title: new Text(
                  "Tournaments",
                  style: new TextStyle(
                    fontSize: 12.0,
                    fontFamily: "Century Gothic",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: new Icon(
                  Icons.chat,
                ),
                title: new Text(
                  "Messages",
                  style: new TextStyle(
                    fontSize: 12.0,
                    fontFamily: "Century Gothic",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: new Icon(
                  IconData(0xe971, fontFamily: "Profile"),
                  size: 25.0,
                ),
                title: new Text(
                  "Me",
                  style: new TextStyle(
                    fontSize: 12.0,
                    fontFamily: "Century Gothic",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: new CustomScrollView(
          slivers: <Widget>[
            new SliverAppBar(
              backgroundColor: Colors.transparent,
              leading: new Container(),
              expandedHeight: 190.0,
              elevation: 0.0,
              flexibleSpace: new FlexibleSpaceBar(
                background: new Container(
                //  color: Colors.blue,
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        height: 160.0,
                        child: new Stack(
                          alignment: Alignment.bottomCenter,
                          fit: StackFit.expand,
                          children: <Widget>[
                            new Image.asset(
                              "assets/background.png",
                              fit: BoxFit.cover,
                            ),
                            new Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                new CircleAvatar(
                                  radius: 50.0,
                                  backgroundColor:
                                      Color.fromRGBO(0, 150, 255, 1.0),
                                  child: CircleAvatar(
                                    backgroundImage: new NetworkImage("https://i.imgur.com/BoN9kdC.png"),
                                    radius: 45.0,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                                new Container(
                                  margin:
                                      EdgeInsets.only(top: 2.0, bottom: 3.0),
                                  child: new Text(
                                    "Ninja",
                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Century Gothic",
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      new Container(
                        alignment: Alignment.center,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                              width: 60.0,
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Container(
                                    child: new Text(
                                      "100",
                                      style: new TextStyle(
                                        color:
                                            Color.fromRGBO(170, 170, 170, 1.0),
                                        fontFamily: "Century Gothic",
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  new Container(
                                    margin:
                                        EdgeInsets.only(top: 4.0, left: 4.0),
                                    child: new Text(
                                      "Posts",
                                      style: new TextStyle(
                                        color:
                                            Color.fromRGBO(170, 170, 170, 1.0),
                                        fontFamily: "Century Gothic",
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            new Container(
                              margin: EdgeInsets.only(left: 25.0, right: 25.0),
                              width: 60.0,
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Container(
                                    child: new Text(
                                      "1M",
                                      style: new TextStyle(
                                        color:
                                            Color.fromRGBO(170, 170, 170, 1.0),
                                        fontFamily: "Century Gothic",
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  new Container(
                                    margin:
                                        EdgeInsets.only(top: 4.0, left: 4.0),
                                    child: new Text(
                                      "Followers",
                                      style: new TextStyle(
                                        color:
                                            Color.fromRGBO(170, 170, 170, 1.0),
                                        fontFamily: "Century Gothic",
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
>>>>>>> c056af465ff9ad3f4a30f919850fe8df5d308025
                                    ),
                                  ),
                                ],
                              ),
<<<<<<< HEAD
                            ],
                          ),
                        ),
                        new Container(
                          child: new Stack(
                            alignment: Alignment.centerRight,
                            children: <Widget>[
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Container(
                                    width: 60.0,
                                    child: new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Container(
                                          child: new Text(
                                            posts,
                                            style: new TextStyle(
                                              color: Color.fromRGBO(
                                                  170, 170, 170, 1.0),
                                              fontFamily: "Century Gothic",
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        new Container(
                                          margin: EdgeInsets.only(
                                              top: 4.0, left: 4.0),
                                          child: new Text(
                                            "Posts",
                                            style: new TextStyle(
                                              color: Color.fromRGBO(
                                                  170, 170, 170, 1.0),
                                              fontFamily: "Century Gothic",
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  new Container(
                                    margin: EdgeInsets.only(
                                        left: 25.0, right: 25.0),
                                    width: 60.0,
                                    child: new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Container(
                                          child: new Text(
                                            followers,
                                            style: new TextStyle(
                                              color: Color.fromRGBO(
                                                  170, 170, 170, 1.0),
                                              fontFamily: "Century Gothic",
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        new Container(
                                          margin: EdgeInsets.only(
                                              top: 4.0, left: 4.0),
                                          child: new Text(
                                            "Followers",
                                            style: new TextStyle(
                                              color: Color.fromRGBO(
                                                  170, 170, 170, 1.0),
                                              fontFamily: "Century Gothic",
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  new Container(
                                    width: 60.0,
                                    child: new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Container(
                                          child: new Text(
                                            following,
                                            style: new TextStyle(
                                              color: Color.fromRGBO(
                                                  170, 170, 170, 1.0),
                                              fontFamily: "Century Gothic",
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        new Container(
                                          margin: EdgeInsets.only(top: 4.0),
                                          child: new Text(
                                            "Following",
                                            style: new TextStyle(
                                              color: Color.fromRGBO(
                                                  170, 170, 170, 1.0),
                                              fontFamily: "Century Gothic",
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
=======
                            ),
                            new Container(
                              width: 60.0,
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Container(
                                    child: new Text(
                                      "50",
                                      style: new TextStyle(
                                        color:
                                            Color.fromRGBO(170, 170, 170, 1.0),
                                        fontFamily: "Century Gothic",
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  new Container(
                                    margin: EdgeInsets.only(top: 4.0),
                                    child: new Text(
                                      "Following",
                                      style: new TextStyle(
                                        color:
                                            Color.fromRGBO(170, 170, 170, 1.0),
                                        fontFamily: "Century Gothic",
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
>>>>>>> c056af465ff9ad3f4a30f919850fe8df5d308025
                                    ),
                                  ),
                                ],
                              ),
<<<<<<< HEAD
                              new IconButton(
                                padding: EdgeInsets.only(right: 10.0),
                                icon: new Icon(
                                  Icons.settings,
                                  size: 30.0,
                                  color: Color.fromRGBO(170, 170, 170, 1.0),
                                ),
                                onPressed: () {
                                  fetchPostID();
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              postLoaded()
            ],
          ));
    }
  }
}

class PostList extends StatefulWidget {
  _PostList createState() => new _PostList();
}

class _PostList extends State<PostList> {
  bool reposted;

  void initState() {
    super.initState();
    reposted = false;
  }

  Widget likeButton(BuildContext context, int index) {
    handleLike() async {
      postLiked[index] = !postLiked[index];
      if (postLiked[index] == true) {
        print(userInfo);
        Firestore.instance.runTransaction((Transaction transaction) async {
          await transaction
              .get(Firestore.instance.document("Posts/${postID[index]}"))
              .then((post) async {
            if (post.exists) {
              await transaction.update(
                  Firestore.instance.document("Posts/${postID[index]}"),
                  <String, dynamic>{"likes": postLikes[index]});
            }
          });
        });
        Firestore.instance
            .document("Users/$_currentUser")
            .get()
            .then((likedPost) {
          if (likedPost.data["likedPosts"][postID[index]] == null) {
            Firestore.instance
                .document("Users/$_currentUser")
                .setData(<String, dynamic>{
              "likedPosts": {
                postID[index]: DateTime.now().millisecondsSinceEpoch
              }
            }, merge: true);
          } else {
            print("POST IS ALREADY LIKED");
          }
        });
        setState(() {
          return [
            postLikeIcons[index] = Icons.favorite,
            postLikes[index] = postLikes[index] + 1,
            postLikeColors[index] = Colors.red
          ];
        });
      } else if (postLiked[index] == false || postLiked[index] == null) {
        Firestore.instance.runTransaction((Transaction transaction) async {
          await transaction
              .get(Firestore.instance.document("Posts/${postID[index]}"))
              .then((post) async {
            if (post.exists) {
              await transaction.update(
                  Firestore.instance.document("Posts/${postID[index]}"),
                  <String, dynamic>{"likes": postLikes[index]});
            }
          });
        });
        Firestore.instance
            .document("Users/$_currentUser")
            .get()
            .then((likedPost) {
          if (likedPost.data["likedPosts"][postID[index]] != null) {
            Firestore.instance
                .document("Users/$_currentUser")
                .setData(<String, dynamic>{
              "likedPosts": {postID[index]: 0}
            }, merge: true);
          } else {
            print("LIKE DOESN'T EXIST");
          }
        });
        setState(() {
          return [
            postLikeIcons[index] = Icons.favorite_border,
            postLikes[index] = postLikes[index] - 1,
            postLikeColors[index] = Color.fromRGBO(170, 170, 170, 1.0)
          ];
        });
      }
    }

    return new GestureDetector(
      onTap: () {
        print("LIKE");
        handleLike();
      },
      child: new Container(
        width: 65.0,
        padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 5.0),
        color: Colors.transparent,
        child: new Row(
          children: <Widget>[
            new Icon(
              postLikeIcons[index],
              color: postLikeColors[index],
              size: 20.0,
            ),
            new Text(
              postLikes[index].toString(),
              style: new TextStyle(
                  color: postLikeColors[index],
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget repostButton(BuildContext context, int index) {
    handleRepost() async {
      if (reposted == true) {
        reposted = !reposted;
        Firestore.instance.runTransaction((Transaction transaction) async {
          await transaction
              .get(Firestore.instance.document("Posts/${postID[index]}"))
              .then((post) async {
            if (post.exists) {
              await transaction.update(
                  Firestore.instance.document("Posts/${postID[index]}"),
                  <String, dynamic>{"reposts": postReposts[index]});
            }
          });
        });
        setState(() {
          return [
            postReposts[index] = postReposts[index] - 1,
            postRepostColors[index] = Color.fromRGBO(170, 170, 170, 1.0)
          ];
        });
      } else if (reposted == false || reposted == null) {
        reposted = true;
        Firestore.instance.runTransaction((Transaction transaction) async {
          await transaction
              .get(Firestore.instance.document("Posts/${postID[index]}"))
              .then((post) async {
            if (post.exists) {
              await transaction.update(
                  Firestore.instance.document("Posts/${postID[index]}"),
                  <String, dynamic>{"reposts": postReposts[index]});
            }
          });
        });
        setState(() {
          return [
            postReposts[index] = postReposts[index] + 1,
            postRepostColors[index] = Color.fromRGBO(0, 150, 255, 1.0)
          ];
        });
      }
    }

    return new GestureDetector(
      onTap: () {
        print("REPOST");
        handleRepost();
      },
      child: new Container(
        padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 5.0),
        color: Colors.transparent,
        width: 65.0,
        child: new Row(
          children: <Widget>[
            new Icon(
              Icons.repeat,
              color: postRepostColors[index],
              size: 22.0,
            ),
            new Text(
              postReposts[index].toString(),
              style: new TextStyle(
                  color: postRepostColors[index],
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new SliverList(
      delegate: new SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          like = postLikes[index];
          fetchMedia() {
            if (postMedia[index] == true) {
              return new Container(
                // POST HAS MEDIA
                margin: EdgeInsets.only(top: 5.0),
                child: new Container(
                  child: new Image.network(
                    postMediaURL[index],
                    fit: BoxFit.cover,
                  ),
                  height: 120.0,
                  width: 200.0,
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(2.0),
                    border: new Border.all(
                      width: 2.0,
                      color: Color.fromRGBO(40, 40, 40, 1.0),
                    ),
                  ),
                ),
              );
            } else {
              return new Container(); // NO MEDIA
            }
          }

          fetchTimeStamp() {
            var timeDifference =
                postTimeStamp[index].difference(DateTime.now()).abs();
            if (timeDifference.inSeconds < 60) {
              // BETWEEN 0 SECONDS AND 1 MINUTE
              return "${timeDifference.inSeconds.toString()}s";
            } else if (timeDifference.inSeconds >= 60 &&
                timeDifference.inSeconds < 3600) {
              // BETWEEN 1 MINUTE AND 1 HOUR
              return "${timeDifference.inMinutes.toString()}m";
            } else if (timeDifference.inSeconds >= 3600 &&
                timeDifference.inSeconds <= 43200) {
              // BETWEEN 1 HOUR AND 12 HOURS
              return "${timeDifference.inHours.toString()}h";
            } else if (timeDifference.inSeconds > 43200 &&
                timeDifference.inSeconds <= 86400) {
              // BETWEEN 12 HOURS AND 1 DAY
              return "Today";
            } else if (timeDifference.inSeconds > 86400 &&
                timeDifference.inSeconds <= 172800) {
              // BETWEEN 1 DAY AND 2 DAYS
              return "Yesterday";
            } else if (timeDifference.inSeconds > 172800) {
              // GREATER THAN 2 DAYS
              return "${postTimeStamp[index].month.toString()}/${postTimeStamp[index].day.toString()}/${postTimeStamp[index].year.toString()}";
            }
          }

          return new Container(
            margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
            decoration: new BoxDecoration(
              color: Color.fromRGBO(23, 23, 23, 1.0),
              boxShadow: [
                new BoxShadow(
                  blurRadius: 4.0,
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  offset: new Offset(0.0, 4.0),
                )
              ],
              borderRadius: new BorderRadius.all(Radius.circular(20.0)),
              border: new Border.all(
                width: 1.0,
                color: Color.fromRGBO(40, 40, 40, 1.0),
              ),
            ),
            child: new Container(
              child: new Column(
                children: <Widget>[
                  new Row(
                    //mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.only(top: 2.0, left: 2.0),
                        child: new CircleAvatar(
                          radius: 20.0,
                          backgroundColor: Color.fromRGBO(0, 150, 255, 1.0),
                          child: CircleAvatar(
                              radius: 18.0,
                              backgroundColor: Color.fromRGBO(50, 50, 50, 1.0),
                              backgroundImage:
                                  new MemoryImage(postUserImage[index])),
                        ),
                      ),
                      new Expanded(
                        child: new Container(
                          padding: EdgeInsets.only(left: 2.0),
                          child: new Text(
                            postUsername[index],
                            style: new TextStyle(
                              color: Colors.white,
                              fontFamily: "Century Gothic",
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      new Container(
                        padding: EdgeInsets.only(right: 15.0),
                        child: new Text(
                          fetchTimeStamp(),
                          style: new TextStyle(
                            color: Color.fromRGBO(170, 170, 170, 1.0),
                            fontSize: 13.0,
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0.0),
                    child: new Text(postBody[index],
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                          color: Colors.white,
                          fontFamily: "Avenir",
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  fetchMedia(), // MEDIA
                  new Container(
                    //margin: EdgeInsets.only(top: 5.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        repostButton(context, index),
                        likeButton(context, index),
                        new GestureDetector(
                          onTap: () {
                            print("MESSAGE");
                          },
                          child: new Container(
                            width: 65.0,
                            padding: EdgeInsets.only(
                                left: 25.0, top: 10.0, bottom: 5.0),
                            color: Colors.yellow,
                            child: new Row(
                              children: <Widget>[
                                new Icon(
                                  Icons.send,
                                  color: Color.fromRGBO(170, 170, 170, 1.0),
                                  size: 20.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        childCount: postCount,
      ),
    );
=======
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            new SliverList(
              delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return new Container(
                    padding: EdgeInsets.only(bottom: 10.0),
                    margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      boxShadow: [
                        new BoxShadow(
                            blurRadius: 4.0,
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            offset: new Offset(0.0, 4.0)),
                      ],
                      borderRadius: new BorderRadius.circular(20.0),
                      color: Color.fromRGBO(23, 23, 23, 1.0),
                      border: new Border.all(
                        width: 1.0,
                        color: Color.fromRGBO(40, 40, 40, 1.0),
                      ),
                    ),
                    child: new Container(
                      child: new Column(
                        children: <Widget>[
                          new Row(
                            //mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                padding: EdgeInsets.only(top: 2.0, left: 2.0),
                                child: new CircleAvatar(
                                  radius: 20.0,
                                  backgroundColor:
                                      Color.fromRGBO(0, 150, 255, 1.0),
                                  child: CircleAvatar(
                                    radius: 18.0,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                              ),
                              new Expanded(
                                child: new Container(
                                  padding: EdgeInsets.only(left: 2.0),
                                  child: new Text(
                                    "Ninja",
                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Century Gothic",
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              new Container(
                                padding: EdgeInsets.only(right: 15.0),
                                child: new Text(
                                  "4h",
                                  style: new TextStyle(
                                    color: Color.fromRGBO(170, 170, 170, 1.0),
                                    fontSize: 13.0,
                                    fontFamily: "Avenir",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          new Container(
                            margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0.0),
                            child: new Text(
                                "Looking for someone who wants to play duos with me on Fortnite",
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Avenir",
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          new Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: new Container(
                                //color: Colors.white,
                                ),
                            height: 120.0,
                            width: 200.0,
                            decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(2.0),
                                border: new Border.all(
                                  width: 2.0,
                                  color: Color.fromRGBO(40, 40, 40, 1.0),
                                )),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
>>>>>>> c056af465ff9ad3f4a30f919850fe8df5d308025
  }
}
