import 'package:blog_explorer/api.dart';
import 'package:blog_explorer/bloglist.dart';
import 'package:blog_explorer/list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BlogProvider(),
      child: MaterialApp(
        title: 'Blog Explorer',
        debugShowCheckedModeBanner: false,
        // home: BlogListScreen(),
        home: BlogList(),
      ),
    ),
  );
}


