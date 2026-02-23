// Mock AI-powered lead scoring service
import '../models/lead.dart';

class AiScoringService {
  // In a real app, replace this with an AI model or API call
  double scoreLead(Lead lead) {
    // Simple mock: score based on name length
    return (lead.name.length % 10) / 10.0;
  }
}
