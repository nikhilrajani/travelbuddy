import 'package:flutter/material.dart';
import 'package:travelbuddy/screens/add_post_screen.dart';
import 'package:travelbuddy/screens/feed_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  AddPostScreen(),
  Text('search'),
  Text('notification'),
  Text('profile'),
];
