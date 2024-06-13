import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pocket_pal/src/providers/auth/user_provider.dart';
import 'package:pocket_pal/src/utils/admin/get_data.dart';
import 'package:pocket_pal/theme/app_theme.dart';
import 'package:provider/provider.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = userProvider.userModel;
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,

      // APP BAR
      appBar: AppBar(
          title: const Text('Admin Dashboard'),
          automaticallyImplyLeading: false,
          actions: [
            currentUser?.profilePicture != null
                ? GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, '/admin-edit-profile-page'),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          NetworkImage(currentUser!.profilePicture),
                    ),
                  )
                : CircleAvatar(
                    radius: 20,
                    backgroundImage:
                        AssetImage('lib/src/assets/images/avatar.png')
                            as ImageProvider,
                  ),
            const SizedBox(width: 10),
          ]),

      // BODY
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, vertical: screenHeight * 0.03),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome back, ",
                  style: AppTheme.normalTextGrey,
                ),
                Text(
                  "${currentUser?.firstName} ${currentUser?.lastName}",
                  style: AppTheme.mediumTextGreen,
                ),
                const SizedBox(height: 20),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  children: [
                    FutureBuilder<int>(
                      future: getTotalUsers('Member'),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return GridItem(
                            title: "Total Members",
                            count: snapshot.data!,
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                    FutureBuilder<int>(
                      future: getTotalUsers('Therapist'),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return GridItem(
                            title: "Total Therapists",
                            count: snapshot.data!,
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                    FutureBuilder<int>(
                      future: getTotalBookings(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return GridItem(
                            title: "Total Bookings",
                            count: snapshot.data!,
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                    FutureBuilder<int>(
                      future: getTotalPosts(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return GridItem(
                            title: "Total Posts",
                            count: snapshot.data!,
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
                Divider(color: AppTheme.primaryGreen),
                Text("User Distribution Chart", style: AppTheme.normalTextGrey),
                const SizedBox(height: 10),
                FutureBuilder<Map<String, int>>(
                  future: getUserCountsByType(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final userCounts = snapshot.data!;
                      return Container(
                        decoration: BoxDecoration(
                          color: AppTheme.secondaryGreen,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 250,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: PieChart(
                            PieChartData(
                              centerSpaceRadius: 30,
                              sections: [
                                PieChartSectionData(
                                  color: AppTheme.primaryBlue,
                                  value: userCounts['Admins']!.toDouble(),
                                  title: "Admins (${userCounts['Admins']})",
                                  titlePositionPercentageOffset: 1.8,
                                  titleStyle: AppTheme.smallTextGrey,
                                ),
                                PieChartSectionData(
                                  color: AppTheme.primaryGreen,
                                  value: userCounts['Therapists']!.toDouble(),
                                  title:
                                      "Therapists (${userCounts['Therapists']})",
                                  titlePositionPercentageOffset: 2.1,
                                  titleStyle: AppTheme.smallTextGrey,
                                ),
                                PieChartSectionData(
                                  color: AppTheme.primaryOrange,
                                  value: userCounts['Members']!.toDouble(),
                                  title: "Members (${userCounts['Members']})",
                                  titlePositionPercentageOffset: 2.1,
                                  titleStyle: AppTheme.smallTextGrey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String title;
  final int count;
  const GridItem({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: AppTheme.normalTextGrey),
            const SizedBox(height: 5),
            Text(count.toString(), style: AppTheme.mediumTextGreen),
          ],
        ),
      ),
    );
  }
}
