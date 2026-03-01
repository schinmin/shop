// lib/features/wishlist/presentation/pages/wishlist_page.dart
import 'package:flutter/material.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  bool _isSelectionMode = false;
  final List<int> _selectedItems = [];
  
  // Sample wishlist items
  final List<Map<String, dynamic>> _wishlistItems = [
    {
      'id': 1,
      'name': 'Nike Air Max 270',
      'brand': 'Nike',
      'price': 149.99,
      'originalPrice': 189.99,
      'rating': 4.8,
      'reviewCount': 245,
      'image': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400&h=500&fit=crop',
      'inStock': true,
      'discount': 20,
    },
    {
      'id': 2,
      'name': 'Ray-Ban Aviator Classic',
      'brand': 'Ray-Ban',
      'price': 153.99,
      'originalPrice': null,
      'rating': 4.7,
      'reviewCount': 189,
      'image': 'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=400&h=500&fit=crop',
      'inStock': true,
      'discount': 0,
    },
    {
      'id': 3,
      'name': 'Apple Watch Series 8',
      'brand': 'Apple',
      'price': 399.99,
      'originalPrice': 429.99,
      'rating': 4.9,
      'reviewCount': 567,
      'image': 'https://images.unsplash.com/photo-1434494878577-86c23bcb06b9?w=400&h=500&fit=crop',
      'inStock': false,
      'discount': 7,
    },
    {
      'id': 4,
      'name': 'Leather Weekend Bag',
      'brand': 'Coach',
      'price': 299.99,
      'originalPrice': 399.99,
      'rating': 4.6,
      'reviewCount': 98,
      'image': 'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=400&h=500&fit=crop',
      'inStock': true,
      'discount': 25,
    },
    {
      'id': 5,
      'name': 'Classic White Sneakers',
      'brand': 'Adidas',
      'price': 89.99,
      'originalPrice': 99.99,
      'rating': 4.5,
      'reviewCount': 156,
      'image': 'https://images.unsplash.com/photo-1551107696-a4b0c5a0d9a2?w=400&h=500&fit=crop',
      'inStock': true,
      'discount': 10,
    },
    {
      'id': 6,
      'name': 'Cashmere Sweater',
      'brand': 'Ralph Lauren',
      'price': 199.99,
      'originalPrice': 249.99,
      'rating': 4.7,
      'reviewCount': 67,
      'image': 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?w=400&h=500&fit=crop',
      'inStock': true,
      'discount': 20,
    },
  ];

  void _toggleSelection(int id) {
    setState(() {
      if (_selectedItems.contains(id)) {
        _selectedItems.remove(id);
      } else {
        _selectedItems.add(id);
      }
    });
  }

  void _selectAll() {
    setState(() {
      if (_selectedItems.length == _wishlistItems.length) {
        _selectedItems.clear();
      } else {
        _selectedItems.clear();
        _selectedItems.addAll(_wishlistItems.map((item) => item['id'] as int));
      }
    });
  }

  void _deleteSelected() {
    setState(() {
      _wishlistItems.removeWhere((item) => _selectedItems.contains(item['id']));
      _selectedItems.clear();
      _isSelectionMode = false;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_selectedItems.length} items removed from wishlist'),
        backgroundColor: Colors.deepPurple,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: _isSelectionMode
            ? IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.black87),
                ),
                onPressed: () {
                  setState(() {
                    _isSelectionMode = false;
                    _selectedItems.clear();
                  });
                },
              )
            : null,
        title: _isSelectionMode
            ? Text(
                '${_selectedItems.length} selected',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              )
            : const Text(
                'My Wishlist',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
        actions: [
          if (!_isSelectionMode)
            IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.more_vert, color: Colors.grey[700]),
              ),
              onPressed: () {
                _showMenuOptions();
              },
            )
          else
            IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.delete_outline, color: Colors.red[400]),
              ),
              onPressed: _selectedItems.isNotEmpty ? _deleteSelected : null,
            ),
        ],
      ),
      body: _wishlistItems.isEmpty
          ? _buildEmptyWishlist()
          : Column(
              children: [
                if (_isSelectionMode)
                  _buildSelectionBar(),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(5),
                    itemCount: _wishlistItems.length,
                    itemBuilder: (context, index) {
                      final item = _wishlistItems[index];
                      final isSelected = _selectedItems.contains(item['id']);
                      
                      return GestureDetector(
                        onTap: _isSelectionMode
                            ? () => _toggleSelection(item['id'])
                            : () {
                                // Navigate to product details
                                _showProductDetails(item);
                              },
                        onLongPress: () {
                          if (!_isSelectionMode) {
                            setState(() {
                              _isSelectionMode = true;
                              _toggleSelection(item['id']);
                            });
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.deepPurple
                                  : Colors.transparent,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Selection Circle (visible in selection mode)
                              if (_isSelectionMode) ...[
                                Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: isSelected
                                        ? Colors.deepPurple
                                        : Colors.grey[200],
                                    child: isSelected
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 14,
                                          )
                                        : null,
                                  ),
                                ),
                              ],
                              
                              // Product Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  item['image'],
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 100,
                                      width: 100,
                                      color: Colors.grey[200],
                                      child: Icon(
                                        Icons.image_not_supported_outlined,
                                        color: Colors.grey[400],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 15),
                              
                              // Product Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Brand
                                    Text(
                                      item['brand'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[500],
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    
                                    // Product Name
                                    Text(
                                      item['name'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    
                                    // Rating
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber[600],
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${item['rating']}',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                        Text(
                                          ' (${item['reviewCount']})',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    
                                    // Price and Stock Status
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Price with discount
                                            Row(
                                              children: [
                                                Text(
                                                  '\$${item['price'].toStringAsFixed(2)}',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.deepPurple[700],
                                                  ),
                                                ),
                                                if (item['discount'] > 0) ...[
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    '\$${item['originalPrice'].toStringAsFixed(2)}',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey[400],
                                                      decoration: TextDecoration.lineThrough,
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ),
                                            if (item['discount'] > 0)
                                              Container(
                                                margin: const EdgeInsets.only(top: 4),
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 2,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.green[50],
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Text(
                                                  '${item['discount']}% OFF',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green[700],
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        
                                        // Stock Status
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: item['inStock']
                                                ? Colors.green[50]
                                                : Colors.red[50],
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            item['inStock'] ? 'In Stock' : 'Out of Stock',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: item['inStock']
                                                  ? Colors.green[700]
                                                  : Colors.red[700],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Add to Cart Button (only when not in selection mode)
                              if (!_isSelectionMode)
                                Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  child: IconButton(
                                    icon: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: item['inStock']
                                            ? Colors.deepPurple[50]
                                            : Colors.grey[100],
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.shopping_cart_outlined,
                                        color: item['inStock']
                                            ? Colors.deepPurple[400]
                                            : Colors.grey[400],
                                        size: 20,
                                      ),
                                    ),
                                    onPressed: item['inStock']
                                        ? () {
                                            _addToCart(item);
                                          }
                                        : null,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildSelectionBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton.icon(
              onPressed: _selectAll,
              icon: Icon(
                _selectedItems.length == _wishlistItems.length
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
                color: Colors.deepPurple,
              ),
              label: Text(
                _selectedItems.length == _wishlistItems.length
                    ? 'Deselect All'
                    : 'Select All',
                style: const TextStyle(color: Colors.deepPurple),
              ),
            ),
          ),
          Container(
            height: 30,
            width: 1,
            color: Colors.grey[300],
          ),
          Expanded(
            child: TextButton.icon(
              onPressed: _selectedItems.isNotEmpty ? _deleteSelected : null,
              icon: Icon(
                Icons.delete_outline,
                color: _selectedItems.isNotEmpty ? Colors.red : Colors.grey[400],
              ),
              label: Text(
                'Delete',
                style: TextStyle(
                  color: _selectedItems.isNotEmpty ? Colors.red : Colors.grey[400],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWishlist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Empty Wishlist Illustration
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.deepPurple[50],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.favorite_outlined,
              size: 80,
              color: Colors.deepPurple[200],
            ),
          ),
          const SizedBox(height: 30),
          
          // Title
          const Text(
            'Your Wishlist is Empty',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          
          // Subtitle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Save your favorite items here and shop them later',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(height: 30),
          
          // Shop Now Button
          Container(
            height: 55,
            width: 200,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.deepPurple, Colors.purpleAccent],
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 10,
                ),
              ],
            ),
            child: TextButton(
              onPressed: () {
                // Navigate to home page
                Navigator.pop(context);
              },
              child: const Text(
                'Start Shopping',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMenuOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.select_all, color: Colors.deepPurple),
                title: const Text('Select Items'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _isSelectionMode = true;
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.sort, color: Colors.deepPurple),
                title: const Text('Sort by'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pop(context);
                  _showSortOptions();
                },
              ),
              ListTile(
                leading: const Icon(Icons.share, color: Colors.deepPurple),
                title: const Text('Share Wishlist'),
                onTap: () {
                  Navigator.pop(context);
                  _shareWishlist();
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Sort by',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.access_time, color: Colors.deepPurple),
                title: const Text('Recently Added'),
                onTap: () {
                  Navigator.pop(context);
                  // Implement sort logic
                },
              ),
              ListTile(
                leading: const Icon(Icons.trending_down, color: Colors.deepPurple),
                title: const Text('Price: Low to High'),
                onTap: () {
                  Navigator.pop(context);
                  // Implement sort logic
                },
              ),
              ListTile(
                leading: const Icon(Icons.trending_up, color: Colors.deepPurple),
                title: const Text('Price: High to Low'),
                onTap: () {
                  Navigator.pop(context);
                  // Implement sort logic
                },
              ),
              ListTile(
                leading: const Icon(Icons.star, color: Colors.deepPurple),
                title: const Text('Rating'),
                onTap: () {
                  Navigator.pop(context);
                  // Implement sort logic
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _shareWishlist() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Sharing feature coming soon!'),
        backgroundColor: Colors.deepPurple,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _addToCart(Map<String, dynamic> item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item['name']} added to cart'),
        backgroundColor: Colors.deepPurple,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        action: SnackBarAction(
          label: 'VIEW CART',
          textColor: Colors.white,
          onPressed: () {
            // Navigate to cart
          },
        ),
      ),
    );
  }

  void _showProductDetails(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 4,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              item['image'],
                              height: 300,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 20),
                          
                          // Product Info
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['brand'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                    Text(
                                      item['name'],
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.red[400],
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          
                          // Rating
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber[600]),
                              const SizedBox(width: 4),
                              Text(
                                '${item['rating']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                ' (${item['reviewCount']} reviews)',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          
                          // Price
                          Row(
                            children: [
                              Text(
                                '\$${item['price'].toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple[700],
                                ),
                              ),
                              if (item['discount'] > 0) ...[
                                const SizedBox(width: 10),
                                Text(
                                  '\$${item['originalPrice'].toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[400],
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green[50],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '${item['discount']}% OFF',
                                    style: TextStyle(
                                      color: Colors.green[700],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 20),
                          
                          // Description
                          const Text(
                            'Product Description',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Add to Cart Button
                  Container(
                    width: double.infinity,
                    height: 55,
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.deepPurple, Colors.purpleAccent],
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _addToCart(item);
                      },
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}