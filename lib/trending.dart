import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:scontidemo/recommenditems.dart';

class trending extends StatefulWidget {
  const trending({Key key}) : super(key: key);

  @override
  _trendingState createState() => _trendingState();
}

class _trendingState extends State<trending> {
  List<RecommendItems> postsList = [];
  final reference = FirebaseDatabase.instance.reference().child("trending");

  @override
  void initState() {
    super.initState();
    reference.once().then((DataSnapshot snap)
    {
      var Keys = snap.value.keys;
      var Data = snap.value;
      //postsList.clear();
      for(var individualkey in Keys)
      {
        RecommendItems posts = new RecommendItems(
          Data[individualkey]['postid'],
          Data[individualkey]['username'],
          Data[individualkey]['usercollege'],
          Data[individualkey]['userposttext'],
          Data[individualkey]['userpostimage'],
          Data[individualkey]['userimage'],
        );
        postsList.add(posts);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF21BFBD),
        body:ListView(
      primary: false,
      padding: EdgeInsets.only(left: 25.0, right: 20.0),
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 45.0),
            child: Container(
              height: MediaQuery.of(context).size.height-300,
              child: ListView.builder(
                  itemCount: postsList.length,
                  itemBuilder: (_, index){
                    return _dietFoodItem(postsList[index].postid,postsList[index].username,postsList[index].usercollege,postsList[index].userposttext,postsList[index].userpostimage,postsList[index].userimage);
                  }
              ),
              // child: ListView(
              //   children: [
              //     _dietFoodItem('assets/skintones/alternativemedicine.jpg', 'food 1', '10 mcg'),
              //     _dietFoodItem('assets/skintones/cardiology.jpg', 'food 2', '10 mcg'),
              //     _dietFoodItem('assets/skintones/pediatrics.jpg', 'food 3', '10 mcg')
              //   ]
              // )
            )
        )
      ],
    ),
    );
  }
  Widget _dietFoodItem(String postid, String username, String usercollege, String posttext, String postimage, String userimage){
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
          onTap: (){

          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  child: Row(
                      children: [
                        Hero(
                            tag: postimage,
                            child: Image(
                                image: AssetImage(userimage),
                                fit: BoxFit.cover,
                                height: 30,
                                width: 30
                            )
                        ),
                        SizedBox(width: 10.0),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(username,
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold
                                  )),
                              Text(usercollege,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.grey
                                  )),
                            ],
                        ),
                      ],
                  ),
              ),
              new Text(
                posttext,
                style: Theme.of(context).textTheme.title,
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 200.0,
                  child: new Image.network(postimage,fit: BoxFit.cover)
              ),

            ],
          ),
        )
    );
  }
}
