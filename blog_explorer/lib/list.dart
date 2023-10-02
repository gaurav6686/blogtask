import 'package:blog_explorer/detailBlogPage.dart';
import 'package:blog_explorer/sizeconfig.dart';
import 'package:blog_explorer/values/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api.dart';
import 'model/blog.dart';

class BlogListScreen extends StatefulWidget {
  const BlogListScreen({super.key});

  @override
  State<BlogListScreen> createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);
    blogProvider.fetchBlogs();
    SizeConfig().init(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text('Blog List', style: largeTextStyle),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {},
              ),
            ],
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(233, 236, 64, 164),
                  Color.fromARGB(237, 174, 21, 197),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100.fh),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.fh),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.fw),
                    child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          prefixIcon: const Icon(Icons.search),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.fh, horizontal: 12.fw),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.fh),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        onChanged: (text) {
                          setState(() {
                            searchQuery = text;
                          });
                        }),
                  ),
                ),
                TabBar(
                  indicator: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white, width: 3.fw),
                    ),
                  ),
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  tabs: const [
                    Tab(
                      text: 'Home',
                    ),
                    Tab(text: 'Latest'),
                    Tab(text: 'Blogs'),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            buildTabContent(blogProvider.blogs),
            buildTabContent(blogProvider.blogs),
            buildTabContent(blogProvider.blogs),
          ],
        ),
      ),
    );
  }

  Widget buildTabContent(List<Blog> blogs) {
    return Consumer<BlogProvider>(
      builder: (context, provider, child) {
        final filteredBlogs = provider.blogs.where((blog) {
        final title = blog.title.toLowerCase();
        final query = searchQuery.toLowerCase();
        return title.contains(query);
      }).toList();
        if (filteredBlogs.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: filteredBlogs.length,
            itemBuilder: (context, index) {
              final blog = filteredBlogs[index];
              return Container(
                margin: EdgeInsets.only(top: 8.fh, right: 10.fw, left: 10.fw),
                height: 300.fh,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                  color: Colors.white,
                ),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.only(left: 5.fw, right: 5.fw, top: 2.fh),
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
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        height: 50.fh,
                        padding: EdgeInsets.only(top: 10.fh, left: 5.fw),
                        child: Text(
                          blog.title,
                          style: dateTextStyle,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 240.fw, top: 5.fh),
                        height: 35.fh,
                        width: 100.fw,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: const Center(
                          child: Text(
                            "Read More",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailedBlogScreen(blog: blog),
                      ),
                    );
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
