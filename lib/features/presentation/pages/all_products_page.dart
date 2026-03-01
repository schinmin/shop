import 'package:flutter/material.dart';

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({Key? key}) : super(key: key);

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  String selectedCategory = 'All';
  String selectedBrand = 'All';
  RangeValues selectedPrice = const RangeValues(0, 300);

  final List<String> categories = [
    'All',
    'Clothing',
    'Shoes',
    'Electronics',
    'Accessories',
  ];

  final List<String> brands = [
    'All',
    'Nike',
    'Apple',
    'Ray-Ban',
    'North Face',
  ];

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Classic White T-Shirt',
      'price': 29.99,
      'category': 'Clothing',
      'brand': 'Nike',
      'image':
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400',
    },
    {
      'name': 'Nike Running Shoes',
      'price': 89.99,
      'category': 'Shoes',
      'brand': 'Nike',
      'image':
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400',
    },
    {
      'name': 'Apple Watch Series 8',
      'price': 199.99,
      'category': 'Electronics',
      'brand': 'Apple',
      'image':
          'https://images.unsplash.com/photo-1434494878577-86c23bcb06b9?w=400',
    },
    {
      'name': 'Ray-Ban Sunglasses',
      'price': 39.99,
      'category': 'Accessories',
      'brand': 'Ray-Ban',
      'image':
          'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=400',
    },
    {
      'name': 'North Face Backpack',
      'price': 49.99,
      'category': 'Accessories',
      'brand': 'North Face',
      'image':
          'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400',
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    return products.where((product) {
      final matchesCategory =
          selectedCategory == 'All' || product['category'] == selectedCategory;

      final matchesBrand =
          selectedBrand == 'All' || product['brand'] == selectedBrand;

      final matchesPrice = product['price'] >= selectedPrice.start &&
          product['price'] <= selectedPrice.end;

      return matchesCategory && matchesBrand && matchesPrice;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('All Products'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          // FILTER SECTION
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Dropdown
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  items: categories
                      .map((cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(cat),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                ),
                const SizedBox(height: 10),

                // Brand Dropdown
                DropdownButtonFormField<String>(
                  value: selectedBrand,
                  decoration: const InputDecoration(
                    labelText: 'Brand',
                    border: OutlineInputBorder(),
                  ),
                  items: brands
                      .map((brand) => DropdownMenuItem(
                            value: brand,
                            child: Text(brand),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedBrand = value!;
                    });
                  },
                ),
                const SizedBox(height: 10),

                // Price Range Slider
                const Text('Price Range'),
                RangeSlider(
                  values: selectedPrice,
                  min: 0,
                  max: 300,
                  divisions: 30,
                  labels: RangeLabels(
                    '\$${selectedPrice.start.round()}',
                    '\$${selectedPrice.end.round()}',
                  ),
                  onChanged: (values) {
                    setState(() {
                      selectedPrice = values;
                    });
                  },
                ),
              ],
            ),
          ),

          // PRODUCT GRID
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(child: Text('No products found'))
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.65,
                    ),
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 5,
                              color: Colors.black12,
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.vertical(
                                        top: Radius.circular(15)),
                                child: Image.network(
                                  product['image'],
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['name'],
                                    maxLines: 1,
                                    overflow:
                                        TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '\$${product['price']}',
                                    style: const TextStyle(
                                      color: Colors.deepPurple,
                                      fontWeight:
                                          FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}