import 'package:flutter/material.dart';

import 'appointment_details_page.dart';

class ManageAppointmentPage extends StatelessWidget {
  const ManageAppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Example data for upcoming appointments
    final List<Map<String, dynamic>> appointments = [
      {
        'time': 'Today, 9:00 AM - 10:00 AM',
        'member': 'Johnny Sins',
        'status': 'Confirmed',
      },
      {
        'time': 'Today, 11:00 AM - 12:00 PM',
        'member': 'Grandma 101',
        'status': 'Confirmed',
      },
      {
        'time': 'Tomorrow, 1:00 PM - 2:00 PM',
        'member': 'Anonymous Panda',
        'status': 'Unconfirmed',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Appointments'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(appointment['member']),
              subtitle: Text('${appointment['time']} - ${appointment['status']}'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AppointmentDetailsPage(appointment: appointment)));
              },
              // Removed the trailing action buttons
            ),
          );
        },
      ),
    );
  }
}
