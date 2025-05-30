import 'package:flutter/material.dart';
import 'package:payment_feature/features/cart_checkout/presentation/views/widgets/tooltip_container.dart';

class ProductTooltip extends StatefulWidget {
  final Offset position;
  final String productName;
  final double price;
  final int quantity;
  final Function(int, int) onQuantityChanged;
  final VoidCallback onRemove;
  final int availableQuantity;

  const ProductTooltip({
    super.key,
    required this.position,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.onQuantityChanged,
    required this.onRemove,
    required this.availableQuantity,
  });

  @override
  State<ProductTooltip> createState() => _ProductTooltipState();
}

class _ProductTooltipState extends State<ProductTooltip>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late int currentQuantity;
  late int availableQuantity;

  @override
  void initState() {
    super.initState();
    currentQuantity = widget.quantity;
    availableQuantity = widget.availableQuantity;
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Offset _calculatePosition(Size screenSize) {
    double left = widget.position.dx - 140;
    double top = widget.position.dy - 200;

    if (left < 80) left = 80;
    if (left + 280 > screenSize.width) left = screenSize.width - 290;
    if (top < 50) top = widget.position.dy + 100;

    return Offset(left, top);
  }

  void _onQuantityChanged(int newQuantity) {
    setState(() {
      currentQuantity = newQuantity;
    });
    widget.onQuantityChanged(currentQuantity, availableQuantity);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final position = _calculatePosition(screenSize);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Positioned(
          left: position.dx,
          top: position.dy,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: TooltipContainer(
                productName: widget.productName,
                price: widget.price,
                currentQuantity: currentQuantity,
                availableQuantity: availableQuantity,
                onQuantityChanged: _onQuantityChanged,
                onRemove: widget.onRemove,
              ),
            ),
          ),
        );
      },
    );
  }
}
