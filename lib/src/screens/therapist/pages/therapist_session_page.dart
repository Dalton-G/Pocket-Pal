import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pocket_pal/src/providers/user_provider.dart';
import 'package:pocket_pal/src/providers/therapist/booking_provider.dart';
import 'package:pocket_pal/routes.dart';

class TherapistSessionPage extends StatefulWidget {
  const TherapistSessionPage({super.key});

  @override
  State<TherapistSessionPage> createState() => TherapistSessionPageState();
}

class TherapistSessionPageState extends State<TherapistSessionPage> with TickerProviderStateMixin {
  bool isWeeklyFormat = false;
  late TabController _tabController;
  List<DateTime> weekDays = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _generateWeekDays();
    _fetchBookings();
  }

  void _generateWeekDays() {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    weekDays = List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  void _fetchBookings() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final therapistId = userProvider.userModel?.id;
    if (therapistId != null) {
      context.read<BookingProvider>().getBookings(therapistId);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = userProvider.userModel;

    Map<DateTime, List<Map<String, dynamic>>> sessionsByDate = {};
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

    for (var session in bookingProvider.bookings) {
      DateTime sessionDate = DateTime(session['startTime'].year, session['startTime'].month, session['startTime'].day);
      if (sessionDate.isAfter(startOfWeek.subtract(Duration(days: 1))) && sessionDate.isBefore(endOfWeek.add(Duration(days: 1)))) {
        if (sessionsByDate.containsKey(sessionDate)) {
          sessionsByDate[sessionDate]!.add(session);
        } else {
          sessionsByDate[sessionDate] = [session];
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Therapist Sessions'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildControlPanel(context, currentUser!.id),
            isWeeklyFormat
                ? _buildWeeklyView(context, sessionsByDate)
                : _buildTabbedView(context, sessionsByDate),
          ],
        ),
      ),
    );
  }

  Widget _buildControlPanel(BuildContext context, String therapistId) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 48,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, Routes.sessionRecordsPage);
              },
              icon: Icon(Icons.history, color: Colors.green),
              label: const Text('Session Records', style: TextStyle(color: Colors.green)),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.green),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 48,
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  isWeeklyFormat = !isWeeklyFormat;
                });
              },
              child: Row(
                children: [
                  Text(
                    'Weekly',
                    style: TextStyle(
                      color: isWeeklyFormat ? Colors.green : Colors.grey,
                    ),
                  ),
                  Transform.scale(
                    scale: 0.6,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isWeeklyFormat = !isWeeklyFormat;
                        });
                      },
                      child: Switch(
                        value: isWeeklyFormat,
                        onChanged: (value) {
                          setState(() {
                            isWeeklyFormat = value;
                          });
                        },
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.green),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyView(BuildContext context, Map<DateTime, List<Map<String, dynamic>>> sessionsByDate) {
    if (sessionsByDate.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'No sessions available for this week.',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      );
    }

    List<DateTime> sortedDates = sessionsByDate.keys.toList()..sort((a, b) => a.compareTo(b));

    List<Widget> weeklyViews = sortedDates.map((date) {
      List<Map<String, dynamic>> dailySessions = sessionsByDate[date]!;

      return ExpansionTile(
        title: Text(DateFormat('EEEE, dd MMM yyyy').format(date)),
        children: dailySessions.map((session) {
          return _buildSessionTile(context, session);
        }).toList(),
      );
    }).toList();

    return Column(children: weeklyViews);
  }

  Widget _buildTabbedView(BuildContext context, Map<DateTime, List<Map<String, dynamic>>> sessionsByDate) {
    if (sessionsByDate.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'No sessions available for this week.',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      );
    }

    List<DateTime> availableDates = sessionsByDate.keys.toList()..sort((a, b) => a.compareTo(b));
    _tabController = TabController(length: availableDates.length, vsync: this);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: availableDates.map((date) {
              return Tab(text: DateFormat('EEE, dd').format(date));
            }).toList(),
          ),
        ),
        Container(
          height: 400,
          child: TabBarView(
            controller: _tabController,
            children: availableDates.map((date) {
              List<Map<String, dynamic>> dailySessions = sessionsByDate[date]!;

              return _buildSessionList(context, dailySessions);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSessionList(BuildContext context, List<Map<String, dynamic>> sessions) {
    if (sessions.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text('No sessions available', style: TextStyle(color: Colors.grey)),
      );
    }

    return Column(
      children: sessions.map((session) {
        return _buildSessionTile(context, session);
      }).toList(),
    );
  }

  Widget _buildSessionTile(BuildContext context, Map<String, dynamic> session) {
    DateTime currentDateTime = DateTime.now();
    bool isOngoing = session['startTime'].isBefore(currentDateTime) && session['endTime'].isAfter(currentDateTime);
    bool isCompleted = session['endTime'].isBefore(currentDateTime);
    bool isWithinThisWeek = session['startTime'].isAfter(currentDateTime.subtract(Duration(days: currentDateTime.weekday - 1))) &&
        session['endTime'].isBefore(currentDateTime.add(Duration(days: DateTime.daysPerWeek - currentDateTime.weekday)));

    Color tileColor = Colors.white;
    Color? indicatorColor;

    if (isCompleted && isWithinThisWeek) {
      tileColor = Colors.grey[200]!;
    } else if (isOngoing) {
      indicatorColor = Colors.orange;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: tileColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(session['imageUrl']),
                radius: 25,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(session['details']),
                    const SizedBox(height: 10),
                    Text(
                      '${DateFormat('dd MMM yyyy HH:mm').format(session['startTime'])} - ${DateFormat('HH:mm').format(session['endTime'])}',
                    ),
                  ],
                ),
              ),
              if (indicatorColor != null)
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: indicatorColor,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.addSessionNotePage,
                  arguments: {
                    'session': session,
                    'patientName': session['name'],
                  },
                );
              },
              child: const Text('Add/Edit Note'),
            ),
          ),
        ],
      ),
    );
  }
}
