import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:jenosize_loyalty_assignment/core/presentation/status.dart';
import 'package:jenosize_loyalty_assignment/core/services/share_service.dart';
import 'package:jenosize_loyalty_assignment/features/membership/domain/membership.dart';
import 'package:jenosize_loyalty_assignment/features/membership/presentation/providers/membership_provider.dart';
import 'package:jenosize_loyalty_assignment/features/membership/presentation/providers/welcome_message_provider.dart';

class MembershipScreen extends ConsumerStatefulWidget {
  const MembershipScreen({super.key});

  @override
  ConsumerState<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends ConsumerState<MembershipScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(membershipProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Membership")),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(MembershipState state) {
    switch (state.status) {
      case Status.loading:
        return const Center(child: CircularProgressIndicator());
      case Status.error:
        return Center(child: Text(state.error ?? 'Something went wrong'));
      case Status.success:
      case Status.initial:
        if (state.membership == null) {
          return _buildNonMember(context, state);
        } else {
          return _buildMember(context, state.membership!);
        }
    }
  }

  Widget _buildNonMember(BuildContext context, MembershipState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),

            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://media.istockphoto.com/id/1173780314/vector/friends.jpg?s=612x612&w=0&k=20&c=PPBl_BRTqW3OyyBUzKO-tT3E6pONGZE0Xg1usLsrm18=',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Become a Member',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'Join now to enjoy exclusive deals, rewards, and start collecting points!',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Enter your name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: state.status == Status.loading
                  ? null
                  : () async {
                final name = _nameController.text.trim();
                if (name.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter your name')),
                  );
                  return;
                }
                await ref.read(membershipProvider.notifier).joinMembership(name);
                _nameController.clear();
              },
              child: Text(
                state.status == Status.loading ? 'Joining...' : 'Join Membership',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMember(BuildContext context, Membership membership) {
    final formattedDate = DateFormat('dd MMM yyyy').format(membership.joinedAt);
    final shareService = ref.watch(shareServiceProvider);
    final welcomeText = ref.watch(welcomeMessageProvider(membership.name));

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    'https://media.istockphoto.com/id/1173780314/vector/friends.jpg?s=612x612&w=0&k=20&c=PPBl_BRTqW3OyyBUzKO-tT3E6pONGZE0Xg1usLsrm18=',
                    height: 120,
                    width: 240,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 24),

                welcomeText.when(
                  data: (msg) => Text(
                    msg,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  loading: () => const CircularProgressIndicator(),
                  error: (e, _) => Text('Hello ${membership.name}'),
                ),

                const SizedBox(height: 20),

                Card(
                  color: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "Member ID: ",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: membership.id,
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text.rich(
                          TextSpan(
                            text: "Name: ",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: membership.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text.rich(
                          TextSpan(
                            text: "Joined: ",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: formattedDate,
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7B5CF5),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    await ref.read(membershipProvider.notifier).addReferralTransaction();
                    shareService.shareReferral(membership.id);
                  },
                  child: const Text(
                    "Share Referral Link",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
