import 'package:flutter/material.dart';
import 'package:instagram_clone/widgets/instastories.dart';

class InstaList extends StatelessWidget {
  final faces = [
    "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
    "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
    "https://images.pexels.com/photos/762020/pexels-photo-762020.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
    "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
    "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTU0NDU2MTI2ODc4OTE3Njgy/hailee-steinfeld-visits-build-london-on-december-7-2017-in-london-england-photo-by-mike-marsland_mike-marsland_wireimage-square.jpg",
    "https://images.pexels.com/photos/943084/pexels-photo-943084.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"
  ];
  final images = [
    "https://images.pexels.com/photos/160933/girl-rabbit-friendship-love-160933.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
    "https://images.pexels.com/photos/160933/girl-rabbit-friendship-love-160933.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
    "https://images.pexels.com/photos/545008/pexels-photo-545008.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
    "https://images.pexels.com/photos/1116302/pexels-photo-1116302.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
    "https://images.pexels.com/photos/6492/food-breakfast-fork-bagel.jpg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
    "https://images.pexels.com/photos/825904/pexels-photo-825904.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"
  ];
  final names = [
    "rachel",
    "rachel",
    "monica",
    "phoebe",
    "phyllis",
    "pam"
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) => index == 0
          ? SizedBox(
              child: InstaStories(),
              height: 100.0,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  //1st Row
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 35.0,
                            height: 35.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: NetworkImage(faces[index]))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              names[index],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.more_vert),
                      )
                    ],
                  ),
                ),

                //image
                Flexible(
                  fit: FlexFit.loose,
                  child: Image(
                    image: NetworkImage(images[index]),
                  ),
                ),
                //3rd row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.favorite_border,
                            )),
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.chat_bubble_outline,
                            )),
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.send,
                            )),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.bookmark_border),
                    )
                  ],
                ),
                //4th Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Liked by bimsina and 43 others',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                //5th Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                      child: Container(
                        width: 25.0,
                        height: 25.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTU0NDU2MTI2ODc4OTE3Njgy/hailee-steinfeld-visits-build-london-on-december-7-2017-in-london-england-photo-by-mike-marsland_mike-marsland_wireimage-square.jpg"))),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Add a comment..')),
                    ),
                  ],
                ),
                //6th row
                Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      '3 hours ago',
                      style: TextStyle(color: Colors.grey),
                    ))
              ],
            ),
    );
  }
}
