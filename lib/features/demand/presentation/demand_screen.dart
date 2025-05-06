import 'package:coffe_front/features/demand/presentation/viewmodels/demand_view_model.dart';
import 'package:coffe_front/features/demand/presentation/widgets/demand_chart.dart';
import 'package:coffe_front/features/demand/presentation/widgets/list_container.dart';
import 'package:coffe_front/utils/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

var initialDate = DateTime(2024, 2, 12);

class DemandScreen extends ConsumerWidget {
  const DemandScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prov = ref.watch(demandProvider);

    Future<void> refresh() async {
      // ignore: unused_result
      ref.refresh(demandProvider);
    }

    return Center(
      child: RefreshIndicator(
        onRefresh: refresh,
        child:
            prov is SuccessState
                ? SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () async {
                                final pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: initialDate,
                                  firstDate: DateTime(2024, 2, 12),
                                  lastDate: DateTime.now().add(
                                    const Duration(days: 3),
                                  ),
                                );

                                if (pickedDate != null) {
                                  final formattedDate =
                                      "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                                  await ref
                                      .read(demandProvider.notifier)
                                      .getData(formattedDate);
                                }
                                initialDate = pickedDate!;
                              },
                              icon: Icon(
                                Icons.calendar_month,
                                color: Colors.purple,
                              ),
                            ),
                          ),
                        ),
                        DemandChart(
                          labels: prov.topItemsLabels,
                          quantities: prov.topItemsQuantity,
                          predict: ref.read(demandProvider.notifier).predict,
                          predictFunction:
                              ref.read(demandProvider.notifier).togglePredict,
                        ),
                        ListContainer(
                          title: "Top Needed Items",
                          content: prov.itemsMap,
                        ),
                        const SizedBox(height: 10),
                        ListContainer(
                          title: "Top Needed Ingredients",
                          content: prov.ingMap,
                        ),
                      ],
                    ),
                  ),
                )
                : prov is LoadingState
                ? Lottie.asset("assets/lotties/loading.json")
                : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      StringManager.error,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
      ),
    );
  }
}
