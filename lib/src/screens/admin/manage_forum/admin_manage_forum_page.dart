import 'package:flutter/material.dart';
import 'package:pocket_pal/src/screens/admin/manage_forum/anxiety_post_page.dart';
import 'package:pocket_pal/src/screens/admin/manage_forum/depression_post_page.dart';
import 'package:pocket_pal/src/screens/admin/manage_forum/loneliness_post_page.dart';
import 'package:pocket_pal/src/screens/admin/manage_forum/reported_post_page.dart';
import 'package:pocket_pal/theme/app_theme.dart';

class AdminManageForumPage extends StatefulWidget {
  const AdminManageForumPage({super.key});

  @override
  State<AdminManageForumPage> createState() => _AdminManageForumPageState();
}

class _AdminManageForumPageState extends State<AdminManageForumPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppTheme.backgroundWhite,
        appBar: AppBar(
          title: InkWell(
            onTap: () => _tabController.animateTo(0),
            child: Text("Manage Forum"),
          ),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            labelStyle: AppTheme.smallTextGrey,
            labelColor: AppTheme.white,
            indicatorColor: AppTheme.primaryOrange,
            unselectedLabelColor: AppTheme.secondaryGreen,
            isScrollable: true,
            controller: _tabController,
            tabs: [
              Tab(text: "Anxiety"),
              Tab(text: "Depression"),
              Tab(text: "Loneliness"),
              Tab(text: "Reported"),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 80.0),
          child: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, '/add-post-page'),
            child: const Icon(Icons.edit),
            backgroundColor: AppTheme.primaryOrange,
          ),
        ),
        body: TabBarView(controller: _tabController, children: [
          AnxietyPostPage(),
          DepressionPostPage(),
          LonelinessPostPage(),
          ReportedPostPage(),
        ]),
      ),
    );
  }
}
