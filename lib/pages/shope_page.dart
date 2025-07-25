import 'package:flutter/material.dart';
import 'package:store/componenets/shoe_tile.dart';
import 'package:store/models/shoe.dart';
import 'package:store/services/cart_service.dart';
import 'package:store/pages/product_detail_page.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<String> _categories = ['All', 'Sneakers', 'Running', 'Basketball', 'Lifestyle'];

  final List<Shoe> _shoes = [
    Shoe(
      name: 'Air Jordan 1 Retro',
      price: '\$180',
      imagePath: 'lib/images/Air1.jfif',
      description: 'Classic basketball shoe with premium leather upper and iconic design',
      category: 'Basketball',
      rating: 4.8,
      reviewCount: 2847,
    ),
    Shoe(
      name: 'Nike Air Max 270',
      price: '\$150',
      imagePath: 'lib/images/Air1.jfif',
      description: 'Comfortable running shoe with large Air unit for maximum cushioning',
      category: 'Running',
      rating: 4.6,
      reviewCount: 1923,
    ),
    Shoe(
      name: 'Nike Dunk Low',
      price: '\$120',
      imagePath: 'lib/images/Air1.jfif',
      description: 'Retro basketball shoe with modern comfort and street style',
      category: 'Lifestyle',
      rating: 4.7,
      reviewCount: 3156,
    ),
    Shoe(
      name: 'Air Force 1 \'07',
      price: '\$110',
      imagePath: 'lib/images/Air1.jfif',
      description: 'Iconic basketball shoe with timeless design and all-day comfort',
      category: 'Sneakers',
      rating: 4.9,
      reviewCount: 4521,
    ),
    Shoe(
      name: 'Nike React Infinity',
      price: '\$160',
      imagePath: 'lib/images/Air1.jfif',
      description: 'Advanced running shoe with React foam for responsive cushioning',
      category: 'Running',
      rating: 4.5,
      reviewCount: 1687,
    ),
    Shoe(
      name: 'Jordan 4 Retro',
      price: '\$200',
      imagePath: 'lib/images/Air1.jfif',
      description: 'Premium basketball shoe with mesh panels and visible Air cushioning',
      category: 'Basketball',
      rating: 4.8,
      reviewCount: 2134,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Shoe> get filteredShoes {
    List<Shoe> filtered = _shoes;
    
    // Filter by category
    if (_selectedCategory != 'All') {
      filtered = filtered.where((shoe) => shoe.category == _selectedCategory).toList();
    }
    
    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((shoe) =>
          shoe.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          shoe.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          shoe.category.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome text with animation
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(-1, 0),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: _animationController,
                        curve: Curves.easeOutCubic,
                      )),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                            height: 1.2,
                          ),
                          children: [
                            const TextSpan(text: 'Find Your\n'),
                            TextSpan(
                              text: 'Perfect Shoes',
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.grey[300],
                                decorationThickness: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    
                    // Search bar with enhanced design
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search for shoes, brands, styles...',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                          prefixIcon: Container(
                            padding: const EdgeInsets.all(12),
                            child: Icon(
                              Icons.search_rounded,
                              color: Colors.grey[400],
                              size: 24,
                            ),
                          ),
                          suffixIcon: _searchQuery.isNotEmpty
                              ? IconButton(
                                  icon: Icon(
                                    Icons.clear_rounded,
                                    color: Colors.grey[400],
                                  ),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() {
                                      _searchQuery = '';
                                    });
                                  },
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Category filters
              Container(
                height: 50,
                margin: const EdgeInsets.only(bottom: 10),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final isSelected = _selectedCategory == category;
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: isSelected ? Colors.black : Colors.grey[300]!,
                          ),
                          boxShadow: isSelected ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ] : null,
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[700],
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              // Motivational banner
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.grey[900]!,
                      Colors.grey[700]!,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Everyone flies',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'to the moon 🚀',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Just Do It',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.rocket_launch_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Hot Picks Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Hot Picks',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          '🔥',
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    Consumer<CartService>(
                      builder: (context, cartService, child) {
                        return Row(
                          children: [
                            if (cartService.itemCount > 0)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  '${cartService.itemCount} items',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            const SizedBox(width: 10),
                            TextButton(
                              onPressed: () {
                                // Handle see all
                              },
                              child: const Text(
                                'See all',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              
              // Horizontal shoe list
              Expanded(
                child: filteredShoes.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: filteredShoes.length,
                        itemBuilder: (context, index) {
                          final shoe = filteredShoes[index];
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset(1, 0),
                              end: Offset.zero,
                            ).animate(CurvedAnimation(
                              parent: _animationController,
                              curve: Interval(
                                index * 0.1,
                                1.0,
                                curve: Curves.easeOutCubic,
                              ),
                            )),
                            child: ShoeTile(
                              shoe: shoe,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) =>
                                        ProductDetailPage(shoe: shoe),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      return SlideTransition(
                                        position: animation.drive(
                                          Tween(begin: const Offset(1.0, 0.0), end: Offset.zero),
                                        ),
                                        child: child,
                                      );
                                    },
                                    transitionDuration: const Duration(milliseconds: 300),
                                  ),
                                );
                              },
                            ),
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 80,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No shoes found',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _searchQuery = '';
                _selectedCategory = 'All';
                _searchController.clear();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Clear Filters'),
          ),
        ],
      ),
    );
  }
}