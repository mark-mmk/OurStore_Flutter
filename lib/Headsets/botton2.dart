import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../constants/themes.dart';
import '../controllers/itembag_controller.dart';
import '../controllers/product_controller.dart';
import '../model/product_model.dart';
import '../views/cart_page.dart';
import '../views/home_page.dart';


class botton2 extends ConsumerWidget {
  botton2({super.key, required this.getIndex});

  int getIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    final product = ref.watch(proudctNotifierProvider);
    final itemBag = ref.watch(itemBagProvider);
    return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kSecondaryColor,
                        minimumSize: const Size(double.infinity, 50)),
                    onPressed: () {
                      ref.read(proudctNotifierProvider.notifier)
                          .isSelectItem(product[getIndex].pid, getIndex);
                      if (product[getIndex].isSelected == false) {
                        ref.read(itemBagProvider.notifier).addNewItemBag(
                          ProductModel(
                              pid: product[getIndex].pid,
                              imgUrl: product[getIndex].imgUrl,
                              title: product[getIndex].title,
                              price: product[getIndex].price *
                                  product[getIndex].qty,
                              shortDescription:
                              product[getIndex].shortDescription,
                              longDescription:
                              product[getIndex].longDescription,
                              review: product[getIndex].review,
                              rating: product[getIndex].rating,
                              qty: product[getIndex].qty),
                        );
                      } else {
                        ref
                            .read(itemBagProvider.notifier)
                            .removeItem(product[getIndex].pid);
                      }
                    },
                    child: const Text(
                      'Add item to bag',
                      style: TextStyle(color: Colors.white),
                    ),
    );
  }
}
