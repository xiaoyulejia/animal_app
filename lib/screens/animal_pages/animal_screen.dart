import 'package:animal_app/models/animal_model.dart';
import 'package:animal_app/models/favorite_database.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DestinationScreen extends StatefulWidget {
  final Animal animal;

  DestinationScreen({required this.animal});

  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  // 添加到喜欢
  void addToFavorite(BuildContext context) {
    context.read<FavoriteData>().addData(widget.animal);
  }

  void removeFromFavorite(BuildContext context) {
    context.read<FavoriteData>().deleteData(widget.animal.id);
  }

  Icon likeButtom(Animal animal) {
    if (animal.isLike) {
      return Icon(
        FontAwesomeIcons.heartCircleCheck,
        color: Colors.black,
      );
    } else {
      return Icon(
        FontAwesomeIcons.heart,
        color: Colors.black,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final items = context.watch<FavoriteData>().alldata;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Hero(
                  tag: widget.animal.id,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: CachedNetworkImage(
                        imageUrl: widget.animal.imageUrl,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Colors.black,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.search),
                          iconSize: 30.0,
                          color: Colors.black,
                          onPressed: () => Navigator.pop(context),
                        ),
                        IconButton(
                          icon: Icon(Icons.sort),
                          iconSize: 25.0,
                          color: Colors.black,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 20.0,
                bottom: 20.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.animal.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.squarePollVertical,
                          size: 15.0,
                          color: Colors.white70,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          widget.animal.enName.isEmpty
                              ? widget.animal.name
                              : widget.animal.enName,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 20.0,
                bottom: 20.0,
                child: Text(
                  widget.animal.sort,
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image(
                          image: AssetImage("assets/images/sort1.png"),
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        children: [
                          SizedBox(height: 16),
                          Text(
                            "国家重点保护野生动物名录",
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(height: 3),
                          Text(
                            widget.animal.rank1,
                            style: TextStyle(color: Colors.black38),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image(
                      image: AssetImage("assets/images/sort2.png"),
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "生物多样性名录",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "IUCN红色名录",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "CITES红色名录",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        widget.animal.rank2,
                        style: TextStyle(color: Colors.black38),
                      ),
                      Text(
                        widget.animal.rank3,
                        style: TextStyle(color: Colors.black38),
                      ),
                      Text(
                        widget.animal.rank4,
                        style: TextStyle(color: Colors.black38),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "形态特征",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    widget.animal.description,
                    style: TextStyle(color: Colors.black38),
                  ),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "物种评述",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    widget.animal.comment,
                    style: TextStyle(color: Colors.black38),
                  ),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "地理分布",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    widget.animal.location,
                    style: TextStyle(color: Colors.black38),
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).indicatorColor,
        focusColor: Theme.of(context).primaryColor,
        hoverColor: Theme.of(context).primaryColor,
        onPressed: () {
          setState(() {
            if (!widget.animal.isLike) {
              addToFavorite(context);
            } else {
              removeFromFavorite(context);
            }
            widget.animal.isLike = !widget.animal.isLike;
          });
        },
        child: likeButtom(widget.animal),
      ),
    );
  }
}
