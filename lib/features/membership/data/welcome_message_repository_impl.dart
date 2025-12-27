import 'package:jenosize_loyalty_assignment/features/membership/domain/welcome_message_repository.dart';

class WelcomeMessageRepositoryImpl implements WelcomeMessageRepository {

  Future<List<String>> getWelcomeMessages(String memberName) async {
    // Mock messages
    final messages = [
      "Welcome back, $memberName!",
      "Good to see you again, $memberName!",
      "We missed you, $memberName!",
      "Hello $memberName! Ready for new rewards?",
    ];

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));

    return messages;
  }

  @override
  Future<String> getWelcomeMessage(String memberName) async {
    final msgs = await getWelcomeMessages(memberName);
    msgs.shuffle();
    return msgs.first;
  }
}
