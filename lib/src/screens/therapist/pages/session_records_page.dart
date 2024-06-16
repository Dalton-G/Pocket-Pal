import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pocket_pal/routes.dart';
import 'package:pocket_pal/src/providers/user_provider.dart';
import 'package:pocket_pal/src/providers/therapist/booking_provider.dart';
import 'package:pocket_pal/src/providers/therapist/session_note_provider.dart';
import 'package:provider/provider.dart';

class SessionRecordsPage extends StatefulWidget {
  const SessionRecordsPage({super.key});

  @override
  State<SessionRecordsPage> createState() => SessionRecordsPageState();
}

class SessionRecordsPageState extends State<SessionRecordsPage> with TickerProviderStateMixin {
  TabController? _tabController;
  String searchQuery = '';
  DateTimeRange selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 7)),
    end: DateTime.now(),
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchData();
  }

  void _fetchData() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final therapistId = userProvider.userModel?.id;
    final sessionNoteProvider = Provider.of<SessionNoteProvider>(context, listen: false);
    if (therapistId != null) {
      context.read<BookingProvider>().getBookings(therapistId);
      context.read<BookingProvider>().getPatients(therapistId, sessionNoteProvider);
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('My Sessions'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Past Sessions'),
            Tab(text: 'Your Patients'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDateFilterView(bookingProvider.bookings),
          _buildPatientFilterView(bookingProvider.patients),
        ],
      ),
    );
  }

  Widget _buildDateFilterView(List<Map<String, dynamic>> bookings) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Filter by Date: ${DateFormat('dd MMM yyyy').format(selectedDateRange.start)} - ${DateFormat('dd MMM yyyy').format(selectedDateRange.end)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  DateTimeRange? pickedDateRange = await showDateRangePicker(
                    context: context,
                    initialDateRange: selectedDateRange,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDateRange != null && pickedDateRange != selectedDateRange) {
                    setState(() {
                      selectedDateRange = pickedDateRange;
                    });
                  }
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: _buildPastSessionList(bookings),
        ),
      ],
    );
  }

  Widget _buildPastSessionList(List<Map<String, dynamic>> bookings) {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 7 - now.weekday));

    List<Map<String, dynamic>> pastSessions = bookings.where((session) {
      DateTime sessionEndDate = session['endTime'];
      return sessionEndDate.isBefore(startOfWeek);
    }).toList();

    List<Map<String, dynamic>> filteredSessions = pastSessions.where((session) {
      DateTime sessionStartDate = session['startTime'];
      return sessionStartDate.isAfter(selectedDateRange.start) && sessionStartDate.isBefore(selectedDateRange.end);
    }).toList();

    if (filteredSessions.isEmpty) {
      return const Center(
        child: Text('No sessions found for the selected date range.'),
      );
    }

    return ListView.builder(
      itemCount: filteredSessions.length,
      itemBuilder: (context, index) {
        final session = filteredSessions[index];
        return ListTile(
          title: Text(session['name']),
          subtitle: Text(
            '${DateFormat('dd MMM yyyy HH:mm').format(session['startTime'])} - ${DateFormat('HH:mm').format(session['endTime'])}',
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Session Notes for ${session['name']}'),
                content: TextField(
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Add Session Note',
                    border: OutlineInputBorder(),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPatientFilterView(List<Map<String, dynamic>> patients) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoSearchTextField(
            placeholder: 'Search by Patient',
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
        ),
        Expanded(
          child: _buildPatientList(patients),
        ),
      ],
    );
  }

  Widget _buildPatientList(List<Map<String, dynamic>> patients) {
    final filteredPatients = patients.where((patient) {
      return patient['name'].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    if (filteredPatients.isEmpty) {
      return const Center(
        child: Text('No patients found for the search query.'),
      );
    }

    return ListView.builder(
      itemCount: filteredPatients.length,
      itemBuilder: (context, index) {
        final patient = filteredPatients[index];
        return ExpansionTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(patient['imageUrl']),
          ),
          title: Text(patient['name']),
          subtitle: Text(patient['details']),
          children: patient['sessions'].map<Widget>((session) {
            return ListTile(
              title: Text(
                '${DateFormat('dd MMM yyyy HH:mm').format(session['startTime'])} - ${DateFormat('HH:mm').format(session['endTime'])}',
              ),
              subtitle: Text(session['notes'] ?? 'No notes'),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.addSessionNotePage,
                    arguments: {
                      'session': session,
                      'patientName': patient['name'],
                    },
                  );
                },
                child: const Text('Edit Note'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  textStyle: const TextStyle(fontSize: 12),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
