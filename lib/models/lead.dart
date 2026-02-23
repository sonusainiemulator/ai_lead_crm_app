class Lead {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String company;
  final String source;
  final String status;
  final String assignedTo;
  final String notes;
  final DateTime lastContactAt;
  final double score;

  Lead({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.company,
    required this.source,
    required this.status,
    required this.assignedTo,
    required this.notes,
    required this.lastContactAt,
    required this.score,
  });

  Lead copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? company,
    String? source,
    String? status,
    String? assignedTo,
    String? notes,
    DateTime? lastContactAt,
    double? score,
  }) {
    return Lead(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      company: company ?? this.company,
      source: source ?? this.source,
      status: status ?? this.status,
      assignedTo: assignedTo ?? this.assignedTo,
      notes: notes ?? this.notes,
      lastContactAt: lastContactAt ?? this.lastContactAt,
      score: score ?? this.score,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'company': company,
      'source': source,
      'status': status,
      'assigned_to': assignedTo,
      'notes': notes,
      'last_contact_at': lastContactAt.toIso8601String(),
      'score': score,
    };
  }
}

List<Lead> mockLeads = [
  Lead(
    id: 'L-1001',
    name: 'Alice Smith',
    email: 'alice.smith@northstarlogistics.com',
    phone: '+1-202-555-0141',
    company: 'Northstar Logistics',
    source: 'Website Form',
    status: 'Qualified',
    assignedTo: 'Sophia Admin',
    notes: 'Requested enterprise onboarding call this week.',
    lastContactAt: DateTime(2026, 2, 18),
    score: 0.86,
  ),
  Lead(
    id: 'L-1002',
    name: 'Rohan Patel',
    email: 'rohan@apexinfra.io',
    phone: '+91-98765-44321',
    company: 'Apex Infra',
    source: 'Facebook Campaign',
    status: 'Contacted',
    assignedTo: 'Neha Staff',
    notes: 'Interested in CRM + call recording integration.',
    lastContactAt: DateTime(2026, 2, 20),
    score: 0.72,
  ),
  Lead(
    id: 'L-1003',
    name: 'Daniel Green',
    email: 'daniel.green@brightretail.com',
    phone: '+1-303-555-0139',
    company: 'Bright Retail',
    source: 'Google Ads',
    status: 'Proposal Sent',
    assignedTo: 'Sophia Admin',
    notes: 'Needs custom workflow and API access details.',
    lastContactAt: DateTime(2026, 2, 21),
    score: 0.93,
  ),
  Lead(
    id: 'L-1004',
    name: 'Meera Kapoor',
    email: 'meera@zenlabs.in',
    phone: '+91-90040-22119',
    company: 'Zen Labs',
    source: 'Referral',
    status: 'New',
    assignedTo: 'Arjun Employee',
    notes: 'Asked for demo in Hindi and English.',
    lastContactAt: DateTime(2026, 2, 22),
    score: 0.64,
  ),
];
