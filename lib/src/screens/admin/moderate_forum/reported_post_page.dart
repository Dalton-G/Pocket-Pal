import 'package:flutter/material.dart';
import 'package:pocket_pal/src/widgets/forum/common_post_page.dart';

class ReportedPostPage extends StatefulWidget {
  const ReportedPostPage({super.key});

  @override
  State<ReportedPostPage> createState() => _ReportedPostPageState();
}

class _ReportedPostPageState extends State<ReportedPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildReportedPostPage(getReportedPostStream()),
    );
  }
}
