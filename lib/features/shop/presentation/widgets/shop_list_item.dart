import 'package:coffe_front/features/shop/data/models/responses/items_response/item.dart';
import 'package:coffe_front/features/shop/presentation/viewmodels/shop_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShopListItem extends ConsumerStatefulWidget {
  final Item item;
  const ShopListItem({super.key, required this.item});

  @override
  ShopListItemState createState() => ShopListItemState();
}

class ShopListItemState extends ConsumerState<ShopListItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final provRead = ref.read(shopProvider.notifier);
    Widget buildOptionRow(String size, double price, String id) {
      return Row(
        children: [
          Icon(Icons.local_cafe_outlined),
          SizedBox(width: 10),
          Text('$size  \$${price.toStringAsFixed(2)}'),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              provRead.addtoCart(
                OrderItemModel("${widget.item.item} $size", id, price),
              );
            },
            child: Text('Add'),
          ),
        ],
      );
    }

    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          // Header
          ListTile(
            title: Text(
              widget.item.item!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.receipt_long_outlined), // invoice
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                ),
              ],
            ),
          ),
          // Expanded content
          AnimatedCrossFade(
            duration: Duration(milliseconds: 200),
            crossFadeState:
                _isExpanded
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
            firstChild: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  for (final size in widget.item.sizes!) ...[
                    buildOptionRow(size.size!, size.price!, size.itemId!),
                    SizedBox(height: 8),
                  ],
                ],
              ),
            ),
            secondChild: SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
