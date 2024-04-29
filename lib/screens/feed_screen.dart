import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travelbuddy/resources/auth_methods.dart';
import 'package:travelbuddy/screens/login_screen.dart';
import 'package:travelbuddy/utils/colors.dart';
import 'package:travelbuddy/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: Image.asset(
          'assets/logo-white.png',
          height: 50,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthMethods().SignOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.login,
              color: primaryColor,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => Container(
              child: PostCard(snap: snapshot.data!.docs[index].data()),
            ),
          );
        },
      ),
    );
  }
}
