// lib/features/home/presentation/pages/home_feed_page.dart
import 'package:flutter/material.dart';
import 'package:vendox/features/presentation/pages/all_products_page.dart';
import 'package:vendox/features/presentation/pages/cart_listing_page.dart';
import 'package:vendox/features/presentation/pages/product_detail_page.dart';
import 'package:vendox/features/presentation/widgets/categories_list_page.dart';
import 'package:vendox/features/presentation/widgets/featured_banner.dart';
import 'package:vendox/features/presentation/widgets/home_header_page.dart';
import 'package:vendox/features/presentation/widgets/product_card.dart';

class HomeFeedPage extends StatefulWidget {
  const HomeFeedPage({Key? key}) : super(key: key);

  @override
  State<HomeFeedPage> createState() => _HomeFeedPageState();
}

class _HomeFeedPageState extends State<HomeFeedPage> {
  final List<Map<String, dynamic>> products = [
    {
      'id': 1,
      'name': 'Classic White T-Shirt',
      'price': 29.99,
      'rating': 4.5,
      'image': 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400&h=500&fit=crop',
      'isFavorite': false,
    },
    {
      'id': 2,
      'name': 'Nike Running Shoes',
      'price': 89.99,
      'rating': 4.8,
      'image': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400&h=500&fit=crop',
      'isFavorite': true,
    },
    {
      'id': 3,
      'name': 'Leather Crossbody Bag',
      'price': 59.99,
      'rating': 4.3,
      'image': 'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=400&h=500&fit=crop',
      'isFavorite': false,
    },
    {
      'id': 4,
      'name': 'Apple Watch Series 8',
      'price': 199.99,
      'rating': 4.7,
      'image': 'https://images.unsplash.com/photo-1434494878577-86c23bcb06b9?w=400&h=500&fit=crop',
      'isFavorite': false,
    },
    {
      'id': 5,
      'name': 'Ray-Ban Sunglasses',
      'price': 39.99,
      'rating': 4.4,
      'image': 'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=400&h=500&fit=crop',
      'isFavorite': true,
    },
    {
      'id': 6,
      'name': 'North Face Backpack',
      'price': 49.99,
      'rating': 4.6,
      'image': 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400&h=500&fit=crop',
      'isFavorite': false,
    },
  ];

  void _navigateToProductDetail(Map<String, dynamic> product) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailPage(product: product)));
  }

  void _navigateToCart() {
    
  }

  void _navigateToWishlist() {
    
  }

  void _navigateToNotifications() {
    //
  }

  void _navigateToSearch() {
    
  }

  void _navigateToCategory(String category) {
    
  }

  void _navigateToAllProducts() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AllProductsPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Header
            HomeHeader(
              onNotificationPressed: _navigateToNotifications,
              onCartPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
              },
              cartItemCount: 3,
            ),

            // Search Bar
            SliverToBoxAdapter(
              child: SearchBar(
                hintText: "Search",
                leading: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(Icons.search),
                ),
                onTap: _navigateToSearch,
                onChanged: (value) {
                  // Handle search input
                },
              ),
            ),
            // SizedBox(height: 10,),
            // Categories
            SliverToBoxAdapter(
              child: CategoriesList(
                onCategorySelected: _navigateToCategory,
              ),
            ),

            // Featured Banner
            const SliverToBoxAdapter(
              child: FeaturedBanner(),
            ),

            // Product Section Title
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Popular Products',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: _navigateToAllProducts,
                      child: Text(
                        'View All',
                        style: TextStyle(
                          color: Colors.deepPurple[400],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(top: 10)),

            // Products Grid
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return GestureDetector(
                      onTap: () => _navigateToProductDetail(products[index]),
                      child: ProductCard(
                        product: products[index],
                        onFavoritePressed: () {
                          setState(() {
                            products[index]['isFavorite'] = 
                                !(products[index]['isFavorite'] ?? false);
                          });
                        },
                        onAddToCartPressed: () {
                          // Handle add to cart
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${products[index]['name']} added to cart'),
                              backgroundColor: Colors.deepPurple,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                    );
                  },
                  childCount: products.length,
                ),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 20)),
          ],
        ),
      ),
    );
  }
}