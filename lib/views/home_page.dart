import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:ourstore/Headsets/Headsets.dart';
import '../Phone/Phone.dart';
import '../category/computer.dart';
import '../constants/themes.dart';
import '../controllers/itembag_controller.dart';
import '../controllers/product_controller.dart';
import '../drawer/drawer.dart';
import '../widgets/ads_banner_widget.dart';
import '../widgets/card_widget.dart';
import '../widgets/chip_widget.dart';
import 'cart_page.dart';
import 'detail_page.dart';

final currentIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class HomePage extends ConsumerWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(proudctNotifierProvider);
    final currentIndex = ref.watch(currentIndexProvider);
    final itemBag = ref.watch(itemBagProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: SvgPicture.asset(
          'assets/general/store_brand_white.svg',
          color: kWhiteColor,
          width: 180,
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
      drawer: const Drawer(
        child: drawer(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              // Ads banner section
              const AdsBannerWidget(),
              // Chip section
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children:  [
                    InkWell(child: ChipWidget(chipLabel: 'Computers'),onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>computer()));},),
                    InkWell(child: ChipWidget(chipLabel: 'Phone'),onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Phone()));},),
                    InkWell(child: ChipWidget(chipLabel: 'Headsets'),onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Headsets()));},),
                    InkWell(child: ChipWidget(chipLabel: 'Accessories'),onTap: (){},),
                    InkWell(child: ChipWidget(chipLabel: 'Printing'),onTap: (){},),
                    InkWell(child: ChipWidget(chipLabel: 'Camera'),onTap: (){},),
                  ],
                ),
              ),
              // Hot sales section
              const Gap(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Hot Sales', style: AppTheme.kHeadingOne),
                  Text(
                    'See all',
                    style: AppTheme.kSeeAllText,
                  ),
                ],
              ),

              Container(
                padding: const EdgeInsets.all(4),
                width: double.infinity,
                height: 300,
                child: ListView.builder(
                  padding: const EdgeInsets.all(4),
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      ProductCardWidget(productIndex: index),
                ),
              ),
              // Featured products
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Featured Products', style: AppTheme.kHeadingOne),
                  Text(
                    'See all',
                    style: AppTheme.kSeeAllText,
                  ),
                ],
              ),

              MasonryGridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                shrinkWrap: true,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(getIndex: index),
                      )),
                  child: SizedBox(
                    height: 250,
                    child: ProductCardWidget(productIndex: index),
                  ),
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}
