import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenosize_loyalty_assignment/core/presentation/status.dart';
import 'package:jenosize_loyalty_assignment/core/providers/bottom_nav_provider.dart';
import 'package:jenosize_loyalty_assignment/features/campaign/presentation/providers/campaign_provider.dart';
import 'package:jenosize_loyalty_assignment/features/membership/presentation/providers/membership_provider.dart';
import 'package:jenosize_loyalty_assignment/features/membership/presentation/screens/membership_screen.dart';

class HomeScreen extends ConsumerWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(campaignProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: _buildBody(context, ref, state),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, state) {
    switch (state.status) {
      case Status.loading:
        return const Center(child: CircularProgressIndicator());
      case Status.error:
        return Center(child: Text(state.error ?? 'Something went wrong'));
      case Status.success:
      case Status.initial:
      return ListView.builder(
        itemCount: state.campaigns.length,
        itemBuilder: (context, index) {
          final campaign = state.campaigns[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(
                  campaign.imageUrl,
                  height: 180,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        campaign.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        campaign.description,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: campaign.isJoined
                                ? null
                                : () {
                              final membershipState = ref.read(membershipProvider);
                              if (membershipState.membership == null) {
                                ref.read(bottomNavIndexProvider.notifier).setIndex(1);
                                return;
                              }
                              ref.read(campaignProvider.notifier).joinCampaign(campaign.id);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: campaign.isJoined
                                  ? Colors.grey
                                  : Colors.deepPurple,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (campaign.isJoined)
                                  const Icon(Icons.check, size: 16),
                                if (campaign.isJoined) const SizedBox(width: 4),
                                Text(campaign.isJoined ? 'Joined' : 'Join Now'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
      default:
        return const SizedBox.shrink();
    }
  }
}