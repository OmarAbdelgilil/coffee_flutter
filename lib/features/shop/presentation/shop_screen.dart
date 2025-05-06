import 'package:coffe_front/features/shop/presentation/viewmodels/shop_view_model.dart';
import 'package:coffe_front/features/shop/presentation/widgets/cart_item.dart';
import 'package:coffe_front/features/shop/presentation/widgets/shop_list_item.dart';
import 'package:coffe_front/utils/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class Shopscreen extends ConsumerWidget {
  const Shopscreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prov = ref.watch(shopProvider);
    final provRead = ref.read(shopProvider.notifier);
    return Center(
      child:
          prov is SuccessState ||
                  prov is CartUpdated ||
                  prov is CartLoading ||
                  prov is CartError
              ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CartItem(),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height - 320,
                        child: ListView.builder(
                          itemCount: provRead.items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ShopListItem(item: provRead.items[index]);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
              : prov is LoadingState
              ? Lottie.asset("assets/lotties/loading.json")
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
