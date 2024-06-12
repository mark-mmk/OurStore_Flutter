import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../constants/themes.dart';
import '../controllers/itembag_controller.dart';
import '../controllers/product_controller.dart';
import '../model/product_model.dart';
import '../views/cart_page.dart';
import '../views/home_page.dart';
class local_mail1 extends ConsumerWidget {
  local_mail1({super.key, required this.getIndex});

  int getIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    final product = ref.watch(proudctNotifierProvider);
    final itemBag = ref.watch(itemBagProvider);
    return Badge(
                label: Text(itemBag.length.toString()),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CardPage(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.local_mall,
                      size: 24,
                    )),
    );
  }
}
