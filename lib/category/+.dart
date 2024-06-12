import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../constants/themes.dart';
import '../controllers/itembag_controller.dart';
import '../controllers/product_controller.dart';
import '../model/product_model.dart';
import '../views/home_page.dart';

class pluse extends ConsumerWidget {
  pluse({super.key, required this.getIndex});

  int getIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    final product = ref.watch(proudctNotifierProvider);
    final itemBag = ref.watch(itemBagProvider);
    return Container(
                        child: Row(children: [
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(proudctNotifierProvider.notifier)
                                  .decreaseQty(product[getIndex].pid);
                            },
                            icon: const Icon(
                              Icons.do_not_disturb_on_outlined,
                              size: 30,
                            ),
                          ),
                          Text(
                            product[getIndex].qty.toString(),
                            style: AppTheme.kCardTitle.copyWith(fontSize: 24),
                          ),
                          IconButton(
                              onPressed: () {
                                ref
                                    .read(proudctNotifierProvider.notifier)
                                    .incrementQty(product[getIndex].pid);
                              },
                              icon: const Icon(
                                Icons.add_circle_outline,
                                size: 30,
                              ))
                        ]),
                      );
  }
}
