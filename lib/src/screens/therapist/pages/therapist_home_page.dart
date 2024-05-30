import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TherapistHomePage extends StatefulWidget {
  const TherapistHomePage({super.key});

  @override
  _TherapistHomePageState createState() => _TherapistHomePageState();
}

class _TherapistHomePageState extends State<TherapistHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> sessions = [
    {
      'name': 'Sarah Miller',
      'details': '25 y/o - Depression - Takes meds',
      'imageUrl': 'https://via.placeholder.com/150',
      'startTime': DateTime(2024, 5, 18, 9, 0),
      'endTime': DateTime(2024, 5, 18, 9, 30)
    },
    {
      'name': 'Jill Robbins',
      'details': '23 y/o - ADHD - No meds',
      'imageUrl': 'https://via.placeholder.com/150',
      'startTime': DateTime(2024, 6, 12, 12, 0),
      'endTime': DateTime(2024, 6, 12, 13, 0)
    },
    {
      'name': 'Tom Stuart',
      'details': '30 y/o - Anxiety - No meds',
      'imageUrl': 'https://via.placeholder.com/150',
      'startTime': DateTime(2024, 6, 20, 14, 0),
      'endTime': DateTime(2024, 6, 20, 15, 0)
    },
    {
      'name': 'Edward Wong',
      'details': '30 y/o - Anxiety - No meds',
      'imageUrl': 'https://via.placeholder.com/150',
      'startTime': DateTime(2024, 6, 20, 14, 0),
      'endTime': DateTime(2024, 6, 20, 15, 0)
    },
  ];

  final List<Map<String, dynamic>> recentChats = [
    {
      'name': 'Alice Henry',
      'message': 'You: Hi, my name is John, I am a licensed therapist and your cousin...',
      'time': '12:14 PM',
      'imageUrl': 'https://via.placeholder.com/150',
      'isOnline': true
    },
    {
      'name': 'Mikie Henry',
      'message': 'You: Hi, my name is John, I am a licensed therapist and your cousin...',
      'time': '12:14 PM',
      'imageUrl': 'https://via.placeholder.com/150',
      'isOnline': false
    },
    {
      'name': 'Allison Tan',
      'message': 'You: Hi, my name is John, I am a licensed therapist and your cousin...',
      'time': '12:14 PM',
      'imageUrl': 'https://via.placeholder.com/150',
      'isOnline': false
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: const Text('Therapist Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildHeader(context),
              ),
              _buildScheduleContainer(),
              const SizedBox(height: 16),
              _buildChatContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleContainer() {
    return Container(
      width: double.infinity, // Make sure the container uses the full width
      margin: const EdgeInsets.symmetric(horizontal: 0), // Remove horizontal margin
      decoration: BoxDecoration(
        color: Colors.white, // Light mode background color
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Subtle shadow effect
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'My Schedule',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Today'),
              Tab(text: 'Upcoming'),
            ],
            indicator: BoxDecoration(
              color: Colors.grey[200], // Background color for the selected tab
              border: Border(
                bottom: BorderSide(
                  color: Colors.green, // Custom underline color
                  width: 3.0, // Custom underline height
                ),
              ),
            ),
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Text color for selected tab
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.grey, // Text color for unselected tab
            ),
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 350, // Set a maximum height for the container
            ),
            child: Flexible(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildSessionList(_buildTodaySessions()),
                  _buildSessionList(_buildUpcomingSessions()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatContainer() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Chat Rooms',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              GestureDetector(
                onTap: () {
                  // Handle "See All" tap
                },
                child: const Text(
                  'See all',
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recentChats.length,
            itemBuilder: (context, index) {
              return _buildChatTile(
                recentChats[index]['name'],
                recentChats[index]['message'],
                recentChats[index]['time'],
                recentChats[index]['imageUrl'],
                recentChats[index]['isOnline'],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChatTile(String name, String message, String time, String imageUrl, bool isOnline) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
        radius: 25,
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        message,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          if (isOnline)
            Icon(
              Icons.circle,
              color: Colors.green,
              size: 12,
            ),
        ],
      ),
    );
  }

  Widget _buildSessionList(List<Widget> sessionTiles) {
    return SingleChildScrollView(
      child: Column(
        children: sessionTiles,
      ),
    );
  }

  List<Widget> _buildTodaySessions() {
    DateTime now = DateTime.now();
    List<Widget> todaySessions = [];

    for (var session in sessions) {
      DateTime sessionTime = session['startTime'];
      DateTime sessionEndTime = session['endTime'];
      if (sessionTime.year == now.year && sessionTime.month == now.month && sessionTime.day == now.day) {
        todaySessions.add(
          _buildSessionTile(
            context,
            session['name'],
            session['details'],
            session['imageUrl'],
            DateFormat('dd MMM yyyy HH:mm').format(sessionTime), // Format the session start time
            DateFormat('HH:mm').format(sessionEndTime), // Format the session end time
            false,
          ),
        );
      }
    }

    if (todaySessions.isEmpty) {
      return [
        const Center(
          child: Text(
            'No sessions today',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ];
    }

    return todaySessions;
  }

  List<Widget> _buildUpcomingSessions() {
    DateTime now = DateTime.now();
    List<Widget> upcomingSessions = [];

    for (var session in sessions) {
      DateTime sessionTime = session['startTime'];
      DateTime sessionEndTime = session['endTime'];
      if (sessionTime.isAfter(now)) {
        upcomingSessions.add(
          _buildSessionTile(
            context,
            session['name'],
            session['details'],
            session['imageUrl'],
            DateFormat('dd MMM yyyy HH:mm').format(sessionTime), // Format the session start time
            DateFormat('HH:mm').format(sessionEndTime), // Format the session end time
            false,
          ),
        );
      }
    }

    if (upcomingSessions.isEmpty) {
      return [
        const Center(
          child: Text(
            'No upcoming sessions',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ];
    }

    return upcomingSessions;
  }

  Widget _buildHeader(BuildContext context) {
    int todaySessionsCount = sessions
        .where((session) {
      DateTime sessionTime = session['startTime'];
      return sessionTime.year == DateTime.now().year &&
          sessionTime.month == DateTime.now().month &&
          sessionTime.day == DateTime.now().day;
    }).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Good morning, Dr. Kim',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
/*        const SizedBox(height: 8),
        Text(
          'You have $todaySessionsCount sessions today',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),*/
      ],
    );
  }

  Widget _buildSessionTile(BuildContext context, String name, String details, String imageUrl, String startTime, String endTime, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            radius: 25,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(details),
                const SizedBox(height: 30),
                Text('$startTime - $endTime'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
