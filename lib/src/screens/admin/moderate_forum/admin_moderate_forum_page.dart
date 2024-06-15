import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pocket_pal/src/providers/forum/author_provider.dart';
import 'package:pocket_pal/theme/app_theme.dart';
import 'package:provider/provider.dart'; // Import provider package
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModerateForumPage extends StatefulWidget {
  const AdminModerateForumPage({super.key});

  @override
  State<AdminModerateForumPage> createState() => _AdminModerateForumPageState();
}

class _AdminModerateForumPageState extends State<AdminModerateForumPage> {
  List<DocumentSnapshot> _allResults = [];
  List<DocumentSnapshot> _resultList = [];
  final _searchController = TextEditingController();
  String _selectedCategory = 'Anxiety';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    getPostsStream();
  }

  getPostsStream() async {
    var data = await FirebaseFirestore.instance.collection('posts').get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultList();
  }

  _onSearchChanged() {
    searchResultList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  searchResultList() {
    var filteredResults = <DocumentSnapshot>[];
    for (var post in _allResults) {
      var title = post['title'].toString().toLowerCase();
      var description = post['description'].toString().toLowerCase();
      var category = post['category'].toString().toLowerCase();
      var isReported = post['is_reported'] ?? false;

      if (_selectedCategory == 'Reported') {
        if (isReported) {
          if (_searchController.text.isEmpty ||
              title.contains(_searchController.text.toLowerCase()) ||
              description.contains(_searchController.text.toLowerCase())) {
            filteredResults.add(post);
          }
        }
      } else {
        if (category == _selectedCategory.toLowerCase() && !isReported) {
          if (_searchController.text.isEmpty ||
              title.contains(_searchController.text.toLowerCase()) ||
              description.contains(_searchController.text.toLowerCase())) {
            filteredResults.add(post);
          }
        }
      }
    }

    setState(() {
      _resultList = filteredResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppTheme.backgroundWhite,
        appBar: AppBar(
          toolbarHeight: 120,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text("Manage Forum"),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/add-post-page'),
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CupertinoSearchTextField(
                controller: _searchController,
                itemColor: AppTheme.primaryGreen,
                backgroundColor: AppTheme.backgroundWhite,
                style: AppTheme.smallTextGrey,
                placeholder: 'Search Title or Description',
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            labelStyle: AppTheme.smallTextGrey,
            labelColor: AppTheme.white,
            indicatorColor: AppTheme.primaryOrange,
            unselectedLabelColor: AppTheme.secondaryGreen,
            isScrollable: true,
            onTap: (index) {
              switch (index) {
                case 0:
                  setState(() {
                    _selectedCategory = 'Anxiety';
                    searchResultList();
                  });
                  break;
                case 1:
                  setState(() {
                    _selectedCategory = 'Depression';
                    searchResultList();
                  });
                  break;
                case 2:
                  setState(() {
                    _selectedCategory = 'Loneliness';
                    searchResultList();
                  });
                  break;
                case 3:
                  setState(() {
                    _selectedCategory = 'Reported';
                    searchResultList();
                  });
                  break;
              }
            },
            tabs: [
              Tab(text: "Anxiety"),
              Tab(text: "Depression"),
              Tab(text: "Loneliness"),
              Tab(text: "Reported"),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            buildPostListView(context),
            buildPostListView(context),
            buildPostListView(context),
            buildPostListView(context),
          ],
        ),
      ),
    );
  }

  Widget buildPostListView(BuildContext context) {
    return _resultList.isEmpty
        ? Center(
            child: Text(
              _selectedCategory == 'Reported'
                  ? "No reported posts found."
                  : "No posts for this category.",
              style: AppTheme.normalTextGrey,
            ),
          )
        : ListView.builder(
            itemCount: _resultList.length,
            itemBuilder: (context, index) {
              if (_resultList.isNotEmpty) {
                var post = _resultList[index].data() as Map<String, dynamic>;
                return FutureBuilder(
                  future: Provider.of<AuthorProvider>(context, listen: false)
                      .fetchUserData(post['author_id']),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      var userData =
                          Provider.of<AuthorProvider>(context, listen: false)
                              .getUserData(post['author_id']);
                      var name =
                          "${userData['first_name']} ${userData['last_name']}";
                      return ListTile(
                        onTap: () {},
                        title: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 10,
                                  backgroundImage: NetworkImage(
                                    userData["profile_picture"],
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(name, style: AppTheme.smallTextGreen),
                              ],
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post['title'], style: AppTheme.mediumTextGrey),
                          ],
                        ),
                        trailing: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage(
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                            placeholder: AssetImage(
                                'lib/src/assets/images/placeholder_image.png'),
                            image: NetworkImage(post['thumbnail']),
                          ),
                        ),
                      );
                    }
                  },
                );
              } else {
                return Container();
              }
            },
          );
  }
}
