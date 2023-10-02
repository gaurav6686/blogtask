import 'package:blog_explorer/api.dart';
import 'package:blog_explorer/sizeconfig.dart';
import 'package:blog_explorer/values/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/blog.dart';

class DetailedBlogScreen extends StatelessWidget {
  final Blog blog;
  DetailedBlogScreen({required this.blog});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(134.fh),
        child: AppBar(
          title: Text(
            'Detailed Blog',
            style: largeTextStyle,
          ),
          flexibleSpace: Opacity(
            opacity: 0.8,
            child: Image.network(
              blog.imageUrl,
              fit: BoxFit.cover, 
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20.fh),
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                blog.title,
                style: TextStyle(fontSize: 20.fh, fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(height: 20.fh),
            Consumer<BlogProvider>(
              builder: (context, provider, child) {
                return ElevatedButton(
                  onPressed: () {
                    provider.toggleFavoriteStatus(blog);
                  },
                  child: Text(blog.isFavorite
                      ? 'Remove from Favorites'
                      : 'Add to Favorites'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
