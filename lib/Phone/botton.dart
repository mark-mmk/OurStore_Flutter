import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/itembag_controller.dart';
import '../controllers/product_controller.dart';
import '../model/product_model.dart';

class botton extends ConsumerWidget {
  const botton({
    super.key,
    required this.productIndex,

  });

  final int productIndex;

  @override

  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(proudctNotifierProvider);
    return IconButton(
                      onPressed: () {
                        ref.read(proudctNotifierProvider.notifier).isSelectItem(
                            product[productIndex].pid, productIndex);
                        if (product[productIndex].isSelected == false) {
                          ref.read(itemBagProvider.notifier).addNewItemBag(
                            ProductModel(
                              pid: product[productIndex].pid,
                              imgUrl: product[productIndex].imgUrl,
                              title: product[productIndex].title,
                              price: product[productIndex].price,
                              shortDescription:
                              product[productIndex].shortDescription,
                              longDescription:
                              product[productIndex].longDescription,
                              review: product[productIndex].review,
                              rating: product[productIndex].rating,
                              qty: product[productIndex].qty,
                            ),
                          );
                        } else {
                          ref
                              .read(itemBagProvider.notifier)
                              .removeItem(product[productIndex].pid);
                        }
                      },
                      icon: Icon(
                        product[productIndex].isSelected
                            ? Icons.check_circle
                            : Icons.add_circle,
                        size: 30,
                      ),
    );
  }
}
