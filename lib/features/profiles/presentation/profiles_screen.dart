import 'package:coffe_front/features/profiles/presentation/view_models/profile_view_model.dart';
import 'package:coffe_front/utils/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class ProfilesScreen extends ConsumerWidget {
  const ProfilesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prov = ref.watch(profilesProvider);
    return Center(
      child:
          prov is LoadingState
              ? Lottie.asset("assets/lotties/loading.json")
              : prov is SuccessState
              ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 600,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "My Team",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          height: 500,
                          child: ListView.separated(
                            padding: EdgeInsets.all(16.0),

                            itemBuilder: (BuildContext context, int index) {
                              return TeamMemberCard(
                                name: prov.data[index].userName!,
                                position: prov.data[index].role!,
                                deleteUser:
                                    () => ref
                                        .read(profilesProvider.notifier)
                                        .deleteUser(prov.data[index].id!),
                              );
                            },
                            separatorBuilder: (
                              BuildContext context,
                              int index,
                            ) {
                              return Divider();
                            },
                            itemCount: prov.data.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              : Text(
                StringManager.error,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.red[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
    );
  }
}

class TeamMemberCard extends StatelessWidget {
  final String name;
  final String position;
  final Function() deleteUser;

  const TeamMemberCard({
    super.key,
    required this.name,
    required this.position,
    required this.deleteUser,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: ListTile(
        leading: Icon(Icons.account_circle_rounded, size: 50),
        title: Text(
          name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          position,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        trailing: IconButton(
          onPressed: () {
            deleteDialog(context, deleteUser);
          },
          icon: Icon(Icons.delete, color: Colors.red),
        ),
      ),
    );
  }
}

deleteDialog(BuildContext context, Function() delete) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          content: Text(
            "Are you sure you want to delete this user ? ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
              onPressed: () {
                delete();
                Navigator.of(context).pop();
              },
              child: Text("YES", style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("NO"),
            ),
          ],
        ),
  );
}
