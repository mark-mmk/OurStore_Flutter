import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../constants/themes.dart';
import '../controllers/itembag_controller.dart';
import '../controllers/product_controller.dart';
import '../model/product_model.dart';
import 'cart_page.dart';
import 'home_page.dart';

class DetailsPage extends ConsumerWidget {
  DetailsPage({super.key, required this.getIndex});

  int getIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    final product = ref.watch(proudctNotifierProvider);
    final itemBag = ref.watch(itemBagProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: const Text(
          'Details Page',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20, top: 10),
              child: Badge(
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
              ))
        ],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              color: kLightBackground,
              child: Image.asset(product[getIndex].imgUrl),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product[getIndex].title,
                    style: AppTheme.kBigTitle.copyWith(color: kPrimaryColor),
                  ),
                  const Gap(12),
                  Row(
                    children: [
                      RatingBar(
                        itemSize: 20,
                        initialRating: 1,
                        minRating: 1,
                        maxRating: 5,
                        allowHalfRating: true,
                        ratingWidget: RatingWidget(

                          empty: const Icon(
                            Icons.star_border,
                            color: Colors.amber,
                          ),
                          full: const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          half: const Icon(
                            Icons.star_half_sharp,
                            color: Colors.amber,
                          ),
                        ),
                        onRatingUpdate: (value) => null,
                      ),
                      const Gap(12),
                       Text(product[getIndex].review.toString(),)
                    ],
                  ),
                  const Gap(8),
                  Text(product[getIndex].longDescription),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product[getIndex].price * product[getIndex].qty}',
                        style: AppTheme.kHeadingOne,
                      ),
                      Container(
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
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kSecondaryColor,
                        minimumSize: const Size(double.infinity, 50)),
                    onPressed: () {
                      ref.read(proudctNotifierProvider.notifier)
                          .isSelectItem(product[getIndex].pid, getIndex);
                      // Itemka ayuu ku darayaa baga
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: currentIndex,
      //   onTap: (value) =>
      //       ref.read(currentIndexProvider.notifier).update((state) => value),
      //   selectedItemColor: kPrimaryColor,
      //   unselectedItemColor: kSecondaryColor,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home_outlined),
      //       label: 'Home',
      //       activeIcon: Icon(Icons.home_filled),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.favorite_outline),
      //       label: 'Favorite',
      //       activeIcon: Icon(Icons.favorite),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.location_on_outlined),
      //       label: 'Location',
      //       activeIcon: Icon(Icons.location_on),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.notifications_outlined),
      //       label: 'Notification',
      //       activeIcon: Icon(Icons.notifications),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person_outline),
      //       label: 'Profile',
      //       activeIcon: Icon(Icons.person),
      //     ),
      //   ],
      // ),
    );
  }
}
