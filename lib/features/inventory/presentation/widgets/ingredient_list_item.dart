import 'package:coffe_front/features/inventory/presentation/view_models/inventory_view_model.dart';
import 'package:coffe_front/features/inventory/presentation/widgets/order_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IngredientListItem extends StatelessWidget {
  final IngredientModel ing;
  final Function() order;
  const IngredientListItem({super.key, required this.ing, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (ing.ingTotalWeight == 0)
          Container(
            width: MediaQuery.of(context).size.width - 30,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.red[100],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.warning_rounded, color: Colors.red, size: 15),
                SizedBox(width: 2),
                Text(
                  "This Ingredient Out of stock please need to urjent order",
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ],
            ),
          ),
        Container(
          width: MediaQuery.of(context).size.width,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            border: Border.all(color: Colors.grey[350]!, width: 2),
          ),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SvgPicture.asset(
                  "assets/svgs/${ing.ingName}.svg",
                  width: 30,
                  height: 30,
                ),
              ),
              Expanded(
                child: Text(
                  ing.ingName!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
              TextButton(
                onPressed: () {
                  showOrderDialog(context, order, ing);
                },
                child: Text(
                  "Order Now >>",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,

          color: Colors.grey[350],
          child: SizedBox(
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
              title: Text(
                "Available: ${ing.ingTotalWeight}${ing.ingMeas}",
                style: TextStyle(color: Colors.grey[600]),
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(
                "Need to order: ${ing.quantityNeed}${ing.ingMeas}",
                style: TextStyle(color: Colors.grey[600]),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
