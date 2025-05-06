import 'package:coffe_front/utils/text_styles.dart';
import 'package:flutter/material.dart';

class RevenueExpContainer extends StatelessWidget {
  final String revenue;
  final String expense;
  const RevenueExpContainer({
    super.key,
    required this.revenue,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335,
      height: 155,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/revenue_background.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextStyles.actor_14_400("Revenue", color: Colors.white),
            SizedBox(height: 5),
            TextStyles.acme_20_400("\$$revenue", color: Colors.white),
            SizedBox(height: 10),
            TextStyles.actor_14_400("Expenses", color: Colors.white),
            SizedBox(height: 5),
            TextStyles.acme_20_400("\$$expense", color: Colors.white),
          ],
        ),
      ),
    );
  }
}
