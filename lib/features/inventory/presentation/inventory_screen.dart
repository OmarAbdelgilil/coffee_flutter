import 'package:coffe_front/features/inventory/presentation/view_models/inventory_view_model.dart';
import 'package:coffe_front/features/inventory/presentation/widgets/ingredient_list_item.dart';
import 'package:coffe_front/utils/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prov = ref.watch(inventoryProvider);
    final provRead = ref.read(inventoryProvider.notifier);
    Future<void> refresh() async {
      // ignore: unused_result
      ref.refresh(inventoryProvider);
    }

    return RefreshIndicator(
      onRefresh: refresh,
      child:
          prov is LoadingState
              ? Center(child: Lottie.asset("assets/lotties/loading.json"))
              : prov is SuccessState
              ? SafeArea(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Low in Stock", style: TextStyle(fontSize: 18)),
                        Text(
                          "${provRead.lowInStock} Item’s",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Donut Chart
                    CircularPercentIndicator(
                      radius: 100.0,
                      lineWidth: 30.0,
                      percent: provRead.lowPercent,
                      reverse: true,
                      center: Text(
                        "${(provRead.lowPercent * 100).toStringAsFixed(2)}%",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      progressColor: Colors.blue[700],
                      backgroundColor: Colors.pink.shade200,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                    const SizedBox(height: 16),
                    // Ingredient List
                    ...prov.data.map(
                      (item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: IngredientListItem(
                          ing: item,
                          order: () {
                            ref.read(inventoryProvider.notifier).orderIng(item);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
              : Center(
                child: Text(
                  StringManager.error,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.red[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
    );
  }
}
