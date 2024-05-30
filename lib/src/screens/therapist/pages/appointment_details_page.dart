import 'package:flutter/material.dart';

class AppointmentDetailsPage extends StatelessWidget {
  // Placeholder for appointment details. In a real app, you might pass a model or data directly.
  final Map<String, dynamic> appointment;

  const AppointmentDetailsPage({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    // Placeholder data for demonstration. Replace with your actual appointment data structure.
    final String memberName = appointment['member'] ?? 'Unknown';
    final String time = appointment['time'] ?? 'No time set';
    final String status = appointment['status'] ?? 'Status unknown';

    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment with $memberName'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Member: $memberName',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Time: $time',
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Status: $status',
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton.icon(
              onPressed: () {
                // Implement reschedule functionality
                // This could open a dialog or navigate to a rescheduling page
              },
              icon: const Icon(Icons.event, color: Colors.white),
              label: const Text('Reschedule'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.orange,
              ),
            ),
            const SizedBox(height: 12.0),
            OutlinedButton.icon(
              onPressed: () {
                // Implement cancel functionality
                // This could show a confirmation dialog before finalizing the cancellation
              },
              icon: const Icon(Icons.cancel, color: Colors.red),
              label: const Text('Cancel Appointment'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
