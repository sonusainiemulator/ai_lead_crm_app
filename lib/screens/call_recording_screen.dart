import 'package:flutter/material.dart';
import '../models/lead.dart';
import '../services/perfex_api_service.dart';

class CallRecordingScreen extends StatefulWidget {
  const CallRecordingScreen({super.key});

  @override
  State<CallRecordingScreen> createState() => _CallRecordingScreenState();
}

class _CallRecordingScreenState extends State<CallRecordingScreen> {
  final PerfexApiService _perfexApiService = PerfexApiService(baseUrl: 'https://demo.perfexcrm.local');
  bool isRecording = false;
  bool isUploading = false;
  String? recordingPath;
  String selectedLeadId = 'L-1001';
  String selectedModule = 'Leads';
  final List<String> modules = const [
    'Leads',
    'Web to Lead',
    'Campaign Leads',
  ];
  List<String> uploadedRecordings = [
    'meeting_with_alice.aac',
    'client_demo_bob.aac',
    'followup_charlie.aac',
  ];

  void _startRecording() {
    setState(() {
      isRecording = true;
      // TODO: Start recording using a plugin
    });
  }

  void _stopRecording() {
    setState(() {
      isRecording = false;
      recordingPath = 'mock_recording.aac'; // Placeholder
      // TODO: Stop recording and save file
    });
  }

  Future<void> _uploadRecording() async {
    if (recordingPath == null) {
      return;
    }
    setState(() {
      isUploading = true;
    });

    final response = await _perfexApiService.uploadCallRecording(
      filePath: recordingPath!,
      leadId: selectedLeadId,
      module: selectedModule,
    );

    if (!mounted) return;
    setState(() {
      isUploading = false;
      uploadedRecordings.add(response['recording_file'] as String);
      recordingPath = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response['message'] as String)),
    );
  }

  void _pickRecording() {
    // TODO: Implement file picker for existing recordings
    setState(() {
      recordingPath = 'picked_recording.aac'; // Placeholder
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Call Recording')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (isRecording)
              const Text('Recording...')
            else if (recordingPath != null)
              Text('Recording ready: $recordingPath')
            else
              const Text('No recording'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: isRecording ? _stopRecording : _startRecording,
                  child: Text(isRecording ? 'Stop Recording' : 'Start Recording'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _pickRecording,
                  child: const Text('Pick Existing'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedLeadId,
              decoration: const InputDecoration(labelText: 'Attach to Lead'),
              items: mockLeads
                  .map(
                    (lead) => DropdownMenuItem(
                      value: lead.id,
                      child: Text('${lead.name} (${lead.id})'),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedLeadId = value;
                  });
                }
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedModule,
              decoration: const InputDecoration(labelText: 'Perfex Module'),
              items: modules
                  .map((module) => DropdownMenuItem(value: module, child: Text(module)))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedModule = value;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: recordingPath != null && !isUploading ? _uploadRecording : null,
              child: isUploading
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Upload to CRM'),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const Text('Uploaded Recordings (Mock):', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: uploadedRecordings.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.audiotrack),
                    title: Text(uploadedRecordings[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
