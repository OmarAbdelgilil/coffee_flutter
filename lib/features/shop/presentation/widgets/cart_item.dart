import 'package:coffe_front/features/shop/presentation/viewmodels/shop_view_model.dart';
import 'package:coffe_front/features/shop/presentation/widgets/cart_dialog.dart';
import 'package:coffe_front/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItem extends ConsumerWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provRead = ref.read(shopProvider.notifier);
    return InkWell(
      onTap: () {
        showCartDialog(context);
      },
      child: Card(
        elevation: 2,
        color: ColorManager.navy,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          title: Text(
            "Cart",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          subtitle: Text(
            "${provRead.cart.length} Items",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          trailing: Icon(Icons.shopping_cart_outlined, color: Colors.white),
        ),
      ),
    );
  }
}
