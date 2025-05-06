import 'package:coffe_front/features/home/presentation/viewmodels/home_view_model.dart';
import 'package:coffe_front/features/home/presentation/widgets/revenue_exp_container.dart';
import 'package:coffe_front/features/home/presentation/widgets/revenues_expenses_chart.dart';
import 'package:coffe_front/features/home/presentation/widgets/total_orders_recieved_container.dart';
import 'package:coffe_front/utils/color_manager.dart';
import 'package:coffe_front/utils/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

var initialDate = DateTime(2024, 2, 17);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prov = ref.watch(homeProvider);
    Future<void> refresh() async {
      // ignore: unused_result
      ref.refresh(homeProvider);
      initialDate = DateTime(2024, 2, 17);
    }

    return Center(
      child: RefreshIndicator(
        onRefresh: refresh,
        child:
            prov is LoadingState
                ? Lottie.asset("assets/lotties/loading.json")
                : prov is ErrorState
                ? Text(
                  StringManager.error,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.red[900],
                    fontWeight: FontWeight.bold,
                  ),
                )
                : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
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
                                      .read(homeProvider.notifier)
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
                        RevenueExpContainer(
                          revenue: (prov as SuccessState).data.todayRevenue!,
                          expense: prov.data.todayExpenses!,
                        ),
                        Container(
                          height: 240,
                          width: 335,
                          decoration: BoxDecoration(
                            color: ColorManager.barChartBackground,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: Colors.redAccent,
                                      size: 10,
                                    ),
                                    SizedBox(width: 2),
                                    Text("Expenses"),
                                    SizedBox(width: 10),
                                    Icon(
                                      Icons.circle,
                                      color: Colors.green,
                                      size: 10,
                                    ),
                                    SizedBox(width: 2),
                                    Text("Revenues"),
                                  ],
                                ),

                                SizedBox(
                                  height: 200,
                                  width: 335,
                                  child: RevenueExpenseChart(
                                    revenues:
                                        prov.data.lastSevenDays!.revenues ?? [],
                                    expenses:
                                        prov.data.lastSevenDays!.expenses ?? [],
                                    labels:
                                        prov.data.lastSevenDays!.labels ?? [],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        OrdersContainer(
                          iconpath: "brief_case.svg",
                          title: "Total orders Recieved",
                          value: prov.data.todayOrderCount.toString(),
                        ),
                        SizedBox(height: 10),
                        OrdersContainer(
                          iconpath: "thumbup.svg",
                          title: "Total stock",
                          value: prov.data.todayProfit!.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
      ),
    );
  }
}
