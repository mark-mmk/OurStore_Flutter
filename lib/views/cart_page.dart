import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../constants/themes.dart';
import '../controllers/itembag_controller.dart';

class CardPage extends ConsumerWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemBag = ref.watch(itemBagProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: const Text('MyCart Page',style: TextStyle(color: Colors.white),),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20, top: 10),
              child: Badge(
                label: Text(itemBag.length.toString()),
                child: IconButton(
                    onPressed: () {
                    },
                    icon: const Icon(
                      Icons.local_mall,
                      size: 24,
                    )),
              ))
        ],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: ListView.builder(
              itemCount: itemBag.length,
              itemBuilder: (context, index) => Card(
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: Row(children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(itemBag[index].imgUrl),
                    ),
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                itemBag[index].title,
                                style: AppTheme.kCardTitle,
                              ),
                              const Gap(6),
                              Text(
                                itemBag[index].shortDescription,
                                style: AppTheme.kBodyText,
                              ),
                              const Gap(4),
                              Text(
                                '\$${itemBag[index].price}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                              ,
                              const Gap(4),
                              Text(
                                'Count :${itemBag[index].qty}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const Gap(4),
                            ],
                          ),
                        ))
                  ]),
                ),
              ),
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Have a coupon code? enter here'),
                  const Gap(12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 1,
                        color: kPrimaryColor,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'FDS2023',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          child: Row(
                            children: const [
                              Text(
                                'Available',
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Gap(5),
                              Icon(Icons.check_circle)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Delivery Fee:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'Free',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Discount:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'No discount',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                      Text(
                        '\$${ref.watch(priceCalcProvider)}',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            )),
        Container(
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color:kSecondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child:TextButton(
              onPressed: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => UsePaypal(
                        sandboxMode: true,
                        clientId:
                        "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
                        secretKey:
                        "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
                        returnURL: "https://samplesite.com/return",
                        cancelURL: "https://samplesite.com/cancel",
                        transactions: const [
                          {
                            "amount": {
                              "total": '50',
                              "currency": "USD",
                              "details": {
                                "subtotal": '50',
                                "shipping": '0',
                                "shipping_discount": 0
                              }
                            },
                            "description":
                            "The payment transaction description.",
                            // "payment_options": {
                            //   "allowed_payment_method":
                            //       "INSTANT_FUNDING_SOURCE"
                            // },
                            "item_list": {
                              "items": [
                                {
                                  "name": "A demo product",
                                  "quantity": 1,
                                  "price": '50',
                                  "currency": "USD"
                                }
                              ],

                              // shipping address is not required though
                              "shipping_address": {
                                "recipient_name": "Jane Foster",
                                "line1": "Travis County",
                                "line2": "",
                                "city": "Austin",
                                "country_code": "US",
                                "postal_code": "73301",
                                "phone": "+00000000",
                                "state": "Texas"
                              },
                            }
                          }
                        ],
                        note: "Contact us for any questions on your order.",
                        onSuccess: (Map params) async {
                          print("onSuccess: $params");
                        },
                        onError: (error) {
                          print("onError: $error");
                        },
                        onCancel: (params) {
                          print('cancelled: $params');
                        }),
                  ),
                ),
              },
              child: const Text("Make Payment",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
        ),
      ]),
    );
  }
}
