import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping/model/model.dart';
import 'package:shopping/pages/productdetails.dart';
import 'package:shopping/repository/firestore.dart';
import 'package:shopping/widgets/customwidget.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Example list of products
  List products = [
    'Product 1',
    'Product 2',
    'Product 3',
    'Product 4',
    'Product 5',
    // Add more products as needed
  ];

  // Example list of image URLs for the carousel
  final List<String> carouselImages = [
    'https://www.sliderrevolution.com/wp-content/uploads/2021/07/Showcase-Carousel.jpg',
    'https://img.freepik.com/free-psd/banner-sneakers-sale-template_23-2148748560.jpg',
    'https://forfrontend.com/wp-content/uploads/2021/09/20231003_133551_0000.jpg',
    'https://elfsight.com/wp-content/uploads/2019/10/image-slider-screenshot-2.jpg',
  ];
  TextEditingController controller = TextEditingController();
  FocusNode _focusNode = FocusNode();

  // Fetch products from Firestore and update the UI
  Future<void> fetchProducts() async {
    List<Product> fetchedProducts = await ProductService().fetchProducts();
    setState(() {
      if (fetchedProducts.isNotEmpty || fetchedProducts != null) {
        products = fetchedProducts;
        print("products ${products.length}");
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProducts();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
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
                  'assets/images/shop.png', // Local fallback image
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
                child: const Icon(Icons.shopping_cart),
              ),
            ),
            const MoreOptionsMenu(),
          ],
        ),
        body: GestureDetector(
          onTap: () {
            _focusNode.unfocus();
          },
          child: Column(
            children: [
              // Row(
              //   children: [
              //     Expanded(
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 15, vertical: 8),
              //         child: TextField(
              //           focusNode: _focusNode,
              //           controller: controller,
              //           decoration: const InputDecoration(
              //             hintText: 'Search for the Products',
              //             hintStyle: TextStyle(color: Colors.grey),
              //             border: OutlineInputBorder(
              //               borderRadius:
              //                   BorderRadius.all(Radius.circular(15.0)),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     const Icon(Icons.search),
              //   ],
              // ),

              // Carousel slider here
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 100.0, // Adjust height according to your design
                    autoPlay: true,
                    enlargeCenterPage: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    viewportFraction: 1.0, // Maintain aspect ratio
                  ),
                  items: carouselImages.map((imageUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: const BoxDecoration(
                              // color: Colors.amber,
                              ),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(8.0), // Rounded corners
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/shop.png', // Local fallback image
                                fit: BoxFit.cover,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),

              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Calculate the number of columns based on the available width
                    int crossAxisCount = (constraints.maxWidth / 150).floor();

                    return GridView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio:
                            1, // Adjust the aspect ratio as needed
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsPage(
                                    productName: products[index]),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 4,
                            margin: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                products[index],
                                style: const TextStyle(fontSize: 18),
                              ),
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
    );
  }
}
