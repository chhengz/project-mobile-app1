class Product {
  final String name;
  final String category;
  final double price;
  final double ?oldprice;
  final String imageUrl;
  final bool isFavorite;
  final String description;

  const Product({
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.name,
    required this.price,
    this.oldprice,
    this.isFavorite = false,
  });
}

final List<Product> products = [
  const Product(
    name: 'Nike',
    category: 'Footwear',
    price: 78.99,
    oldprice: 120,
    isFavorite: true, 
    imageUrl: 'lib/images/nike1.jpg', 
    description: 'Good for running',      
  ),
    const Product(
    name: 'Addidas',
    category: 'Footwear',
    price: 78.99,
    oldprice: 100, 
    isFavorite: true,
    imageUrl: 'lib/images/addidas3.jpg', 
    description: 'Good for running',      
  ),
    const Product(
    name: 'Puma',
    category: 'Footwear',
    price: 78.99,
    oldprice: 100, 
    imageUrl: 'lib/images/puma1.jpg', 
    description: 'Good for running',      
  ),
    const Product(
    name: 'Nike',
    category: 'Run',
    price: 78.99,
    oldprice: 100, 
    imageUrl: 'lib/images/nike2.jpg', 
    description: 'Good for running',      
  ),
  const Product(
    name: 'Nike',
    category: 'Run',
    price: 78.99,
    oldprice: 100, 
    imageUrl: 'lib/images/nike2.jpg', 
    description: 'Good for running',      
  ),
  const Product(
    name: 'Puma',
    category: 'Footwear',
    price: 78.99,
    oldprice: 100, 
    imageUrl: 'lib/images/puma2.jpg', 
    description: 'Good for running',      
  ),
];