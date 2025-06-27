import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_feature/features/cart_checkout/data/models/cart_item_model.dart';
import 'package:payment_feature/features/cart_checkout/presentation/view_models/product_cubit/product_cubit_cubit.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/basket_item.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/basket_widget.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/product_tooltip.dart';

class BasketWithItems extends StatefulWidget {
  const BasketWithItems({super.key, required this.cartItems});
  final List<CartItemModel> cartItems;
  @override
  State<BasketWithItems> createState() => _BasketWithItemsState();
}

class _BasketWithItemsState extends State<BasketWithItems> {
  int? hoveredIndex;
  OverlayEntry? overlayEntry;
  final GlobalKey basketKey = GlobalKey();

  final Map<int, List<Offset>> fixedPositions = {
    1: [Offset(0.5, 0.5)],
    2: [Offset(0.4, 0.37), Offset(0.6, 0.65)],
    3: [Offset(0.5, 0.3), Offset(0.35, 0.55), Offset(0.65, 0.65)],
    4: [
      Offset(0.35, 0.35),
      Offset(0.65, 0.35),
      Offset(0.35, 0.65),
      Offset(0.65, 0.65),
    ],
    5: [
      Offset(0.5, 0.32),
      Offset(0.3, 0.5),
      Offset(0.7, 0.5),
      Offset(0.35, 0.75),
      Offset(0.65, 0.75),
    ],
    6: [
      Offset(0.4, 0.3),
      Offset(0.6, 0.3),
      Offset(0.4, 0.5),
      Offset(0.6, 0.5),
      Offset(0.4, 0.7),
      Offset(0.6, 0.7),
    ],
    7: [
      Offset(0.3, 0.3),
      Offset(0.5, 0.3),
      Offset(0.7, 0.3),
      Offset(0.3, 0.5),
      Offset(0.5, 0.5),
      Offset(0.7, 0.5),
      Offset(0.5, 0.7),
    ],
    8: [
      Offset(0.3, 0.3),
      Offset(0.5, 0.3),
      Offset(0.7, 0.3),
      Offset(0.3, 0.5),
      Offset(0.5, 0.5),
      Offset(0.7, 0.5),
      Offset(0.4, 0.7),
      Offset(0.6, 0.7),
    ],
    9: [
      Offset(0.3, 0.3),
      Offset(0.5, 0.3),
      Offset(0.7, 0.3),
      Offset(0.3, 0.5),
      Offset(0.5, 0.5),
      Offset(0.7, 0.5),
      Offset(0.3, 0.7),
      Offset(0.5, 0.7),
      Offset(0.7, 0.7),
    ],
  };

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  void deactivate() {
    _removeOverlay();
    super.deactivate();
  }

  void _removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  void _removeProduct(int index) {
    setState(() {
      if (index < widget.cartItems.length) {
        widget.cartItems.removeAt(index);
        hoveredIndex = null;
      }
    });
    _removeOverlay();
  }

  void _showProductOverlay(int index, Offset position) {
    _removeOverlay();

    if (index >= widget.cartItems.length) return;

    final cartItem = widget.cartItems[index];
    final renderBox =
        basketKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final basketPosition = renderBox.localToGlobal(Offset.zero);
    final absolutePosition = Offset(
      basketPosition.dx + position.dx,
      basketPosition.dy + position.dy,
    );

    overlayEntry = OverlayEntry(
      builder: (context) => ProductTooltip(
        position: absolutePosition,
        productName: cartItem.product.name,
        price: cartItem.product.price,
        quantity: cartItem.quantity,
        availableQuantity: cartItem.product.availableQuantity,
        onQuantityChanged: (newQuantity, newAvailableQuantity) {
          setState(() {
            widget.cartItems[index].quantity = newQuantity;
            BlocProvider.of<ProductCubitCubit>(
              context,
            ).updateQuantity(cartItem.product, newQuantity);
            widget.cartItems[index].product.availableQuantity =
                newAvailableQuantity;
          });
        },
        onRemove: () {
          BlocProvider.of<ProductCubitCubit>(
            context,
          ).removeFromCart(cartItem.product);
          _removeProduct(index);
        },
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    int count = widget.cartItems.length;
    final positions = fixedPositions[count];

    double baseSize = 150;
    double minSize = 70;
    double imageSize = (baseSize - (count - 1) * 12).clamp(minSize, baseSize);

    return LayoutBuilder(
      key: basketKey,
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        List<Widget> widgets = List.generate(count, (index) {
          final pos = positions![index];
          final left = (pos.dx * width) - imageSize / 2;
          final top = (pos.dy * height) - imageSize / 2;

          return Positioned(
            left: left,
            top: top,
            child: GestureDetector(
              onTap: () {
                if (hoveredIndex == index) {
                  _removeOverlay();
                  setState(() {
                    hoveredIndex = null;
                  });
                } else {
                  _showProductOverlay(index, Offset(left, top - 20));
                  setState(() {
                    hoveredIndex = index;
                  });
                }
              },

              child: BasketItem(
                isSeclected: hoveredIndex == index,
                imagePath: widget.cartItems[index].product.imagePath,
                imageSize: imageSize,
              ),
            ),
          );
        });

        return BasketWidget(widgets: widgets);
      },
    );
  }
}
