import 'package:coffe_front/features/inventory/presentation/view_models/inventory_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class OrderDialog extends StatefulWidget {
  final IngredientModel ing;
  final Function() order;
  const OrderDialog({super.key, required this.order, required this.ing});

  @override
  State<OrderDialog> createState() => _OrderDialogState();
}

class _OrderDialogState extends State<OrderDialog> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(
      text: '${(widget.ing.quantityToOrder)}',
    );
    void increment() {
      final int current = int.tryParse(controller.text) ?? 0;
      setState(() {
        if (current < widget.ing.maxOrder!) {
          widget.ing.quantityToOrder = (current + 1);
        }
      });
    }

    void decrement() {
      final int current = int.tryParse(controller.text) ?? 0;
      setState(() {
        if (widget.ing.quantityToOrder! > 0 &&
            current <= widget.ing.maxOrder!) {
          widget.ing.quantityToOrder = (current - 1);
        }
      });
    }

    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Order: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "Total price:\n\$ ${(widget.ing.quantityToOrder! * widget.ing.price!).toStringAsFixed(2)}",
          ),
          SizedBox(height: 10),
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SvgPicture.asset(
                      "assets/svgs/${widget.ing.ingName}.svg",
                      width: 30,
                      height: 30,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.ing.ingName!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text("\$${widget.ing.price}"),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Text("Amount: "),
          Row(
            children: [
              IconButton(onPressed: decrement, icon: Icon(Icons.remove)),
              SizedBox(
                width: 80,
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^-?\d*$')),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 4,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    if (int.parse(value) >= 0 &&
                        int.parse(value) <= widget.ing.maxOrder!) {
                      widget.ing.quantityToOrder = int.parse(value);
                    }
                  },
                ),
              ),
              IconButton(onPressed: increment, icon: Icon(Icons.add)),
            ],
          ),
          SizedBox(height: 5),
          Text("Max quantity to order : ${widget.ing.maxOrder}"),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                widget.order();
                Navigator.of(context).pop();
              },
              child: Text("Order"),
            ),
          ),
        ],
      ),
    );
  }
}

showOrderDialog(BuildContext context, Function() order, IngredientModel ing) {
  showDialog(
    context: context,
    builder: (context) {
      return OrderDialog(order: order, ing: ing);
    },
  );
}
