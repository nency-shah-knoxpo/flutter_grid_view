class Product {
  final String name;
  final int price;
  final String image;
static List<String> urls = new List();
  Product(this.name, this.price, this.image);

  static List<Product> getAllProducts(){
    List<Product> products = new List<Product>();

    products.add(new Product("Product-1", 100, "image1.png"));
    products.add(new Product("Product-2", 790, "image2.png"));
    products.add(new Product("Product-3", 900, "image3.png"));
    products.add(new Product("Product-4", 678, "image4.png"));
    products.add(new Product("Product-5", 867, "image5.png"));
    products.add(new Product("Product-6", 990, "image6.png"));
return products;

  }

}