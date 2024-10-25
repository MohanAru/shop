import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping/model/model.dart';
import 'package:shopping/pages/cart.dart';
import 'package:shopping/pages/productdetails.dart';
import 'package:shopping/repository/firestore.dart';
import 'package:shopping/widgets/customwidget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [];
  bool isLoading = true;

  final List<String> carouselImages = [
    'https://images.unsplash.com/photo-1561909848-977d0617f275?q=80&w=1480&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/258244/pexels-photo-258244.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/164455/pexels-photo-164455.jpeg',
  ];

  Future<void> fetchProducts() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(milliseconds: 300));
    List<Product> fetchedProducts = await ProductService().fetchProducts();
    setState(() {
      products = fetchedProducts;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CachedNetworkImage(
              imageUrl:
                  "https://i.pinimg.com/originals/ce/56/99/ce5699233cbc0f142250b520d967dff7.png",
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) {
                print("iam asset source");
                return Image.asset(
                  'assets/images/shop.png',
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          title: const Text(
            "Shopping App",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ));
                },
                child: const Icon(Icons.shopping_cart),
              ),
            ),
            const MoreOptionsMenu(),
          ],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: RefreshIndicator(
            onRefresh: () async {
              await fetchProducts();
            },
            child: Column(
              children: [
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Explore",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                    ),
                  ],
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: constraints.maxWidth > 500 ? 150 : 80.0,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          viewportFraction: 1.0,
                        ),
                        items: carouselImages.map((imageUrl) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      'assets/images/shop.png',
                                      fit: BoxFit.cover,
                                    ),
                                    fit: BoxFit.cover,
                                    maxWidthDiskCache: 500,
                                    maxHeightDiskCache: 500,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        "Premium Products",
                        style: TextStyle(
                            color: Colors.blue.withOpacity(0.7),
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // Dynamically adjust crossAxisCount based on screen width
                      int crossAxisCount = (constraints.maxWidth / 150).floor();
                      //  > 1200
                      //     ? 5
                      //     : constraints.maxWidth > 800
                      //         ? 4
                      //         : constraints.maxWidth > 600
                      //             ? 3
                      //             : 2;

                      return isLoading
                          ? GridView.builder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 0.8,
                              ),
                              itemCount: 8, // Placeholder shimmer items
                              itemBuilder: (context, index) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    margin: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                );
                              },
                            )
                          : GridView.builder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 0.8,
                              ),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                Product product = products[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsPage(
                                                product: product),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 150,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: product.imageUrl,
                                            placeholder: (context, url) =>
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                            height: 100,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          product.productName,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text('${product.price} USD',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
