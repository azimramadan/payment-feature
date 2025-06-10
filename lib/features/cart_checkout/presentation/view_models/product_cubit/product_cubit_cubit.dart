import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:payment_feature/core/constants/app_assets.dart';
import 'package:payment_feature/features/cart_checkout/data/models/cart_item_model.dart';
import 'package:payment_feature/features/cart_checkout/data/models/order_summary_model.dart';
import 'package:payment_feature/features/cart_checkout/data/models/product_model.dart';

part 'product_cubit_state.dart';

class ProductCubitCubit extends Cubit<ProductCubitState> {
  ProductCubitCubit() : super(ProductCubitInitial());

  List<ProductModel> productList = [
    ProductModel(
      id: 1,
      name: 'Kinetic Sand Dino Dig Playset',
      price: 19.99,
      availableQuantity: 10,
      imagePath: AppAssets.imagesProduct1,
    ),
    ProductModel(
      id: 2,
      name: 'Dinoshapes',
      price: 49.99,
      availableQuantity: 5,
      imagePath: AppAssets.imagesProduct2,
    ),
    ProductModel(
      id: 3,
      name: 'Colors Together',
      price: 19.99,
      availableQuantity: 20,
      imagePath: AppAssets.imagesProduct3,
    ),
    ProductModel(
      id: 4,
      name: 'Pencil Case',
      price: 39.99,
      availableQuantity: 8,
      imagePath: AppAssets.imagesProduct4,
    ),
    ProductModel(
      id: 5,
      name: 'Desk Organizer',
      price: 59.99,
      availableQuantity: 2,
      imagePath: AppAssets.imagesProduct5,
    ),
    ProductModel(
      id: 6,
      name: 'Calculator',
      price: 24.99,
      availableQuantity: 15,
      imagePath: AppAssets.imagesProduct6,
    ),
    ProductModel(
      id: 7,
      name: 'Pen Holder',
      price: 34.99,
      availableQuantity: 12,
      imagePath: AppAssets.imagesProduct7,
    ),
    ProductModel(
      id: 8,
      name: 'Cable Organizer',
      price: 44.99,
      availableQuantity: 7,
      imagePath: AppAssets.imagesProduct8,
    ),
    ProductModel(
      id: 9,
      name: 'Eraser',
      price: 14.99,
      availableQuantity: 25,
      imagePath: AppAssets.imagesProduct9,
    ),
    ProductModel(
      id: 10,
      name: 'Pen Holder',
      price: 39.99,
      availableQuantity: 3,
      imagePath: AppAssets.imagesProduct10,
    ),
  ];
  List<CartItemModel> cardItemList = [];
  OrderSummaryModel get summary => OrderSummaryModel(cartItems: cardItemList);
  void addToCart(ProductModel product) {
    if (cardItemList.any((item) => item.product.id == product.id)) {
      // If the product is already in the cart, just update the quantity
      cardItemList
          .firstWhere((item) => item.product.id == product.id)
          .quantity++;
      _updateState();
      return;
    }
    if (cardItemList.length >= 9) {
      emit(
        ProductCubitError(
          message: 'You can only add up to 9 items to the cart.',
        ),
      );
      return;
    }
    cardItemList.add(
      CartItemModel(
        product: product,
        quantity: product.availableQuantity > 0 ? 1 : 0,
      ),
    );

    _updateState();
  }

  bool inTheBasket(ProductModel product) {
    return cardItemList.any((item) => item.product.id == product.id);
  }

  void removeFromCart(ProductModel product) {
    cardItemList.removeWhere((item) => item.product.id == product.id);
    _updateState();
  }

  void updateQuantity(ProductModel product, int quantity) {
    final cartItem = cardItemList.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItemModel(product: product, quantity: 0),
    );
    cartItem.quantity = quantity;

    _updateState();
  }

  void updateAvailableQuantity(ProductModel product, int quantity) {
    final productIndex = productList.indexWhere((p) => p.id == product.id);
    if (productIndex != -1) {
      productList[productIndex].availableQuantity = quantity;
    }
    _updateState();
  }

  void _updateState() {
    emit(ProductCubitUpdated(cartItems: List.from(cardItemList)));
  }
}
