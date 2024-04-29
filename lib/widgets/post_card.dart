import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelbuddy/models/user.dart';
import 'package:travelbuddy/providers/user_provider.dart';
import 'package:travelbuddy/resources/firestore_methods.dart';
import 'package:travelbuddy/utils/colors.dart';
import 'package:travelbuddy/widgets/like_animation.dart';

class PostCard extends StatelessWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snap['username'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    FirestoreMethods().deletePost(snap['postId']);
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),

            //Image
          ),
          Row(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Image.network(
                          'https://images.unsplash.com/photo-1711014775366-6ef8bae49b1a?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                    ),
                  ),
                  // LikeAnimation(
                  //   child: const Icon(Icons.favorite,
                  //       color: Colors.white, size: 100),
                  //   isAnimating: isLikeAnimating,
                  //   duration: const Duration(milliseconds: 400),
                  //   onEnd: (){

                  //   },
                  // ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35 * 0.2,
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                      ),
                      child:
                          Text(snap['source'] + ' --> ' + snap['destination']),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35 * 0.2,
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                      ),
                      child: Text('DOJ: ' + snap['date']),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35 * 0.2,
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                      ),
                      child:
                          Text('Weight: ' + snap['weight'].toString() + 'kg'),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35 * 0.2,
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                      ),
                      child: Text('Price: Rs.' + snap['price'].toString()),
                    ),
                  ),
                ],
              ),
            ],
          ),

          //Like Button
          // Row(
          //   children: [
          //     LikeAnimation(
          //       child: IconButton(
          //         onPressed: () {},
          //         icon: const Icon(
          //           Icons.favorite,
          //           color: Colors.red,
          //         ),
          //       ),
          //     )
          //   ],
          // ),

          //Caption
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(
                      style: const TextStyle(
                        color: primaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: snap['username'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: ": ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: snap['caption'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    snap['datePublished'],
                    style: const TextStyle(fontSize: 12, color: secondaryColor),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
