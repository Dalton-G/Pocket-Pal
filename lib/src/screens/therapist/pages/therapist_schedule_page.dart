import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';

class TherapistSchedulePage extends StatefulWidget {
  const TherapistSchedulePage({super.key});

  @override
  State<TherapistSchedulePage> createState() => _ManageSchedulePageState();
}

class _ManageSchedulePageState extends State<TherapistSchedulePage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  final List<Map<String, dynamic>> addedTimeSlots = [];

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

  void _addTimeSlot() {
    if (selectedStartTime != null && selectedEndTime != null) {
      setState(() {
        addedTimeSlots.add({
          'startTime': selectedStartTime,
          'endTime': selectedEndTime,
        });
        selectedStartTime = null;
        selectedEndTime = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both start and end times.')),
      );
    }
  }

  Future<void> _saveAvailability() async {
    String therapistId = "gSaqQfB0DQiCuxykc8LR"; // hardcoded value

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference availabilities = firestore.collection('availabilities');

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

      String availableOn = DateFormat('yyyy-MM-dd HH:mm').format(startDate);
      String availableUntil = DateFormat('yyyy-MM-dd HH:mm').format(endDate);

      await availabilities.add({
        'therapistId': therapistId,
        'availableOn': availableOn,
        'availableUntil': availableUntil,
        'isBooked': false,
      });
    }

    setState(() {
      addedTimeSlots.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Availability added successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                onPressed: _addTimeSlot,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Add Time Slot'),
              ),
            ),
            const SizedBox(height: 30),
            _buildAddedTimeSlots(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveAvailability,
        backgroundColor: Colors.green,
        child: const Icon(Icons.save),
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

  Widget _buildAddedTimeSlots() {
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
          height: 200, // Set a fixed height for the list container
          child: ListView.builder(
            itemCount: addedTimeSlots.length,
            itemBuilder: (context, index) {
              var slot = addedTimeSlots[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text('From: ${slot['startTime'].format(context)}'),
                  subtitle: Text('Until: ${slot['endTime'].format(context)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        addedTimeSlots.removeAt(index);
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
