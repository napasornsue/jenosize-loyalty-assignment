import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenosize_loyalty_assignment/features/membership/data/welcome_message_repository_impl.dart';
import 'package:jenosize_loyalty_assignment/features/membership/domain/welcome_message_repository.dart';

final welcomeMessageRepositoryProvider = Provider<WelcomeMessageRepository>(
      (ref) => WelcomeMessageRepositoryImpl(),
);

final welcomeMessageProvider = FutureProvider.family<String, String>((ref, memberName) async {
  final repo = ref.read(welcomeMessageRepositoryProvider);
  return repo.getWelcomeMessage(memberName);
});