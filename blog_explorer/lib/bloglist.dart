import 'package:blog_explorer/detailBlogPage.dart';
import 'package:blog_explorer/api.dart';
import 'package:blog_explorer/sizeconfig.dart';
import 'package:blog_explorer/values/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BlogList extends StatelessWidget {
  const BlogList({super.key});

  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);
    blogProvider.fetchBlogs();
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blogs and Articles',
          style: largeTextStyle,
        ),
        backgroundColor: Colors.black,
        actions: [
          Center(
            child: Container(
              height: 34.fh,
              width: 38.fw,
              decoration: BoxDecoration(
                color: Colors.blue[700],
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              margin: EdgeInsets.only(right: 10.fw),
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: 25.fh,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Consumer<BlogProvider>(
              builder: (context, provider, child) {
                if (provider.blogs.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: provider.blogs.length,
                    itemBuilder: (context, index) {
                      final blog = provider.blogs[index];
                      return Container(
                        margin: EdgeInsets.only(
                            top: 8.fh, right: 10.fw, left: 10.fw),
                        height: 280.fh,
                        decoration:BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                          ),
                          color: Colors.grey.shade800,
                        ),
                        child: ListTile(
                          contentPadding:
                          EdgeInsets.only(left: 8.fw, right: 8.fw, top: 2.fh),
                          title: Column(
                            children: [
                              Container(
                                height: 200.fh,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0),
                                    bottomLeft: Radius.circular(8.0),
                                    bottomRight: Radius.circular(8.0),
                                  ),
                                  child: Image.network(
                                    blog.imageUrl,
                                    fit:
                                        BoxFit.fill, 
                                  ),
                                ),
                              ),
                              Container(
                                height: 70.fh,
                                padding: EdgeInsets.all(8.fh),
                                child: Text(
                                  blog.title,
                                  style: textStyle,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailedBlogScreen(blog: blog),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

