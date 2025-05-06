import 'package:coffe_front/features/shop/presentation/viewmodels/shop_view_model.dart';
import 'package:coffe_front/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartDialog extends ConsumerWidget {
  const CartDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prov = ref.watch(shopProvider);
    final provRead = ref.read(shopProvider.notifier);
    getCartTotalPrice() {
      double sum = 0;
      for (final i in provRead.cart) {
        sum += i.price;
      }
      return sum.toStringAsFixed(2);
    }

    return AlertDialog(
      backgroundColor: const Color.fromARGB(217, 17, 46, 126),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              "Cart",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            subtitle: Text(
              "Total Price:\n\$${getCartTotalPrice()}",
              style: TextStyle(color: Colors.white),
            ),
          ),
          if (provRead.cart.isNotEmpty) ...[
            SizedBox(
              height: 150,
              width: 300,
              child: ListView.builder(
                itemCount: provRead.cart.length,
                itemBuilder: (context, index) {
                  final i = provRead.cart[index];
                  return orderTile(
                    i.name,
                    i.price,
                    () => provRead.removeFromCart(index),
                  );
                },
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child:
                    prov is CartLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                          onPressed: () {
                            provRead.placeOrder();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text("Order"),
                        ),
              ),
            ),
          ],
          if (prov is CartUpdated && prov.message != null)
            Text(
              'Order Placed successfully',
              style: TextStyle(color: Colors.green),
            ),
          if (prov is CartError)
            Text(prov.error, style: TextStyle(color: Colors.green)),
        ],
      ),
    );
  }
}

Widget orderTile(String name, double price, Function delete) {
  return Card(
    color: ColorManager.tileBackgroundColor,
    child: ListTile(
      title: Text(name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              delete();
            },
            icon: Icon(Icons.delete),
          ),
          SizedBox(width: 10),
          Text("\$${price.toStringAsFixed(2)}"),
        ],
      ),
    ),
  );
}

showCartDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return CartDialog();
    },
  );
}
