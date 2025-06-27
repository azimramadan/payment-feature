import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:payment_feature/core/constants/app_assets.dart';
import 'package:payment_feature/features/cart_checkout/data/models/cart_item_model.dart';
import 'package:payment_feature/features/cart_checkout/data/models/order_summary_model.dart';
import 'package:payment_feature/features/cart_checkout/data/models/product_model.dart';
import 'package:payment_feature/features/cart_checkout/data/models/transaction/amount.dart';
import 'package:payment_feature/features/cart_checkout/data/models/transaction/details.dart';
import 'package:payment_feature/features/cart_checkout/data/models/transaction/item.dart';
import 'package:payment_feature/features/cart_checkout/data/models/transaction/item_list.dart';
import 'package:payment_feature/features/cart_checkout/data/models/transaction/transaction.dart';

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
  List<CartItemModel> cartItemList = [];
  OrderSummaryModel get summary => OrderSummaryModel(cartItems: cartItemList);
  Transactions get transactions => Transactions(
    amount: Amount(
      total: summary.total.toStringAsFixed(2),
      currency: 'USD',
      details: Details(
        shipping: summary.shipping.toString(),
        shippingDiscount: summary.discount.toInt(),
        subtotal: summary.subtotal.toString(),
      ),
    ),
    description: "Azim",
    itemList: ItemList(
      items: cartItemList.map((item) {
        return Item(
          currency: 'USD',
          name: item.product.name,
          price: item.product.price.toString(),
          quantity: item.quantity,
        );
      }).toList(),
    ),
  );
  void addToCart(ProductModel product) {
    if (cartItemList.any((item) => item.product.id == product.id)) {
      cartItemList
          .firstWhere((item) => item.product.id == product.id)
          .quantity++;
      _updateState();
      return;
    }
    if (cartItemList.length >= 9) {
      emit(
        ProductCubitError(
          message: 'You can only add up to 9 items to the cart.',
        ),
      );
      return;
    }
    cartItemList.add(
      CartItemModel(
        product: product,
        quantity: product.availableQuantity > 0 ? 1 : 0,
      ),
    );

    _updateState();
  }

  bool inTheBasket(ProductModel product) {
    return cartItemList.any((item) => item.product.id == product.id);
  }

  void removeFromCart(ProductModel product) {
    cartItemList.removeWhere((item) => item.product.id == product.id);
    _updateState();
  }

  void updateQuantity(ProductModel product, int quantity) {
    final cartItem = cartItemList.firstWhere(
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
    emit(ProductCubitUpdated(cartItems: List.from(cartItemList)));
  }

  void updateAvailableQuantities() {
    for (var cartItem in cartItemList) {
      if (cartItem.quantity > 0) {
        final index = productList.indexWhere(
          (product) => product.id == cartItem.product.id,
        );

        if (index != -1) {
          productList[index].availableQuantity -= cartItem.quantity;
          cartItem.quantity = 0;
          if (productList[index].availableQuantity < 0) {
            productList[index].availableQuantity = 0;
          }
        }
      }
    }
    _updateState();
  }
}
