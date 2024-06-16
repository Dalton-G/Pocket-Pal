import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pocket_pal/src/providers/user_provider.dart';
import 'package:pocket_pal/src/providers/therapist/availability_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../models/availability_model.dart';

class TherapistSchedulePage extends StatefulWidget {
  const TherapistSchedulePage({super.key});

  @override
  State<TherapistSchedulePage> createState() => TherapistSchedulePageState();
}

class TherapistSchedulePageState extends State<TherapistSchedulePage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  final List<Map<String, dynamic>> addedTimeSlots = [];

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final currentUser = userProvider.userModel;
    final availabilityProvider = Provider.of<AvailabilityProvider>(context, listen: false);
    availabilityProvider.getAvailabilities(currentUser!.id);
  }

  Future<void> _selectTime(BuildContext context, {required bool isStartTime}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          selectedStartTime = picked;
        } else {
          selectedEndTime = picked;
        }
      });
    }
  }

  Future<void> _addAvailability() async {
    if (selectedStartTime != null && selectedEndTime != null) {
      setState(() {
        addedTimeSlots.add({
          'startTime': selectedStartTime,
          'endTime': selectedEndTime,
        });
        selectedStartTime = null;
        selectedEndTime = null;
      });

      await _saveAvailability();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Availability added successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both start and end times.')),
      );
    }
  }

  Future<void> _saveAvailability() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final currentUser = userProvider.userModel;
    final availabilityProvider = Provider.of<AvailabilityProvider>(context, listen: false);

    for (var slot in addedTimeSlots) {
      DateTime startDate = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        slot['startTime'].hour,
        slot['startTime'].minute,
      );
      DateTime endDate = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        slot['endTime'].hour,
        slot['endTime'].minute,
      );

      await availabilityProvider.addAvailability(
        therapistId: currentUser!.id,
        availableOn: startDate,
        availableUntil: endDate,
      );
    }

    setState(() {
      addedTimeSlots.clear();
    });
  }

  Future<void> _removeAvailability(String id) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final currentUser = userProvider.userModel;
    final availabilityProvider = Provider.of<AvailabilityProvider>(context, listen: false);

    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this availability?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      await availabilityProvider.removeAvailability(id, currentUser!.id);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Availability removed successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availabilityProvider = Provider.of<AvailabilityProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Schedule'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildCalendar(),
            const SizedBox(height: 20),
            _buildDateDisplay(),
            const SizedBox(height: 20),
            _buildTimePicker(),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _addAvailability,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Set Timeslot'),
              ),
            ),
            const SizedBox(height: 30),
            _buildAddedTimeSlots(availabilityProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.now(),
      lastDay: DateTime(DateTime.now().year + 1),
      focusedDay: selectedDate,
      selectedDayPredicate: (day) {
        return isSameDay(selectedDate, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          selectedDate = selectedDay;
        });
      },
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Colors.green.withOpacity(0.6),
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
      ),
    );
  }

  Widget _buildDateDisplay() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selected Date',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat('yyyy-MM-dd').format(selectedDate),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTimeTile('Start Time', selectedStartTime, Icons.timer, true),
            const Divider(),
            _buildTimeTile('End Time', selectedEndTime, Icons.timer_off, false),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeTile(String title, TimeOfDay? time, IconData icon, bool isStartTime) {
    return ListTile(
      title: Text(
        '$title: ${time != null ? time.format(context) : "--:--"}',
        style: TextStyle(fontSize: 16),
      ),
      trailing: Icon(icon, color: Colors.green),
      onTap: () => _selectTime(context, isStartTime: isStartTime),
    );
  }

  Widget _buildAddedTimeSlots(AvailabilityProvider availabilityProvider) {
    return Consumer<AvailabilityProvider>(
      builder: (context, availabilityProvider, child) {
        final availabilities = availabilityProvider.availabilities;

        // Group availabilities by week starting on Monday
        Map<String, List<AvailabilityModel>> groupedAvailabilities = {};
        for (var availability in availabilities) {
          DateTime startOfWeek = availability.availableOn.subtract(Duration(days: availability.availableOn.weekday - 1));
          String week = DateFormat('MMMM dd, yyyy').format(startOfWeek);
          if (groupedAvailabilities.containsKey(week)) {
            groupedAvailabilities[week]!.add(availability);
          } else {
            groupedAvailabilities[week] = [availability];
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Opened Time Slots',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 400, // Set a fixed height for the list container
              child: ListView.builder(
                itemCount: groupedAvailabilities.keys.length,
                itemBuilder: (context, index) {
                  String week = groupedAvailabilities.keys.elementAt(index);
                  List<AvailabilityModel> availabilitiesForWeek = groupedAvailabilities[week]!;
                  return ExpansionTile(
                    title: Text(
                      'Week: $week',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    children: availabilitiesForWeek.map((availability) {
                      return ListTile(
                        title: Text(
                          'Date: ${DateFormat('EEE, dd MMM').format(availability.availableOn)} - From: ${DateFormat('HH:mm').format(availability.availableOn)} Until: ${DateFormat('HH:mm').format(availability.availableUntil)}',
                        ),
                        trailing: availability.isBooked
                            ? IconButton(
                          icon: Icon(Icons.info, color: Colors.blue),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Info'),
                                  content: const Text('This availability cannot be removed as it has been booked.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        )
                            : IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeAvailability(availability.id),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
