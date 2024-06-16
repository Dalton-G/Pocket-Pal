import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pocket_pal/src/providers/therapist/session_note_provider.dart';

class AddSessionNotePage extends StatefulWidget {
  const AddSessionNotePage({super.key});

  @override
  State<AddSessionNotePage> createState() => _AddSessionNotePageState();
}

class _AddSessionNotePageState extends State<AddSessionNotePage> {
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final session = routeArgs['session'];
    final patientName = routeArgs['patientName'];
    final bookingId = session['bookingId'];

    TextEditingController notesController = TextEditingController(text: session['notes'] ?? '');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Add Notes for $patientName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$patientName - ${DateFormat('dd MMM yyyy HH:mm').format(session['startTime'])} - ${DateFormat('HH:mm').format(session['endTime'])}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: notesController,
              decoration: const InputDecoration(
                labelText: 'Session Notes',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final noteProvider = Provider.of<SessionNoteProvider>(context, listen: false);
                  await noteProvider.addSessionNote(
                    bookingId: bookingId,
                    content: notesController.text,
                  );
                  Navigator.pop(context);
                },
                child: const Text('Save Notes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
