import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zamzam/models/cart_item.dart';

class CartState {
  List<CartItem> cartItems = [];

  CartState(this.cartItems);

  CartState withItemAdded(CartItem item) {
    final updatedItems = List.of(cartItems);
    updatedItems.add(item);
    return CartState(updatedItems);
  }

  CartState withItemQuantityUpdated(CartItem item, int newQuantity) {
    final updatedItems = List.of(cartItems);
    final index = updatedItems.indexWhere(
      (existingItem) => existingItem.uuid == item.uuid,
    );
    if (index != -1) {
      updatedItems[index] = item.copyWith(qty: newQuantity);
    } else {
      updatedItems.add(item.copyWith(qty: newQuantity));
    }
    return CartState(updatedItems);
  }

  CartState withItemRemoved(String uuid) {
    final updatedItems = List.of(cartItems).where((item) => item.uuid != uuid).toList();
    return CartState(updatedItems);
  }
}

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(CartState([]));

  void addToCart(CartItem item) {
    state = state.withItemAdded(item);
  }

  void updateItemQuantity(CartItem item, int newQuantity) {
    if (newQuantity > 0) {
      state = state.withItemQuantityUpdated(item, newQuantity);
    } else {
      removeFromCart(item.uuid);
    }
  }

  void removeFromCart(String uuid) {
    state = state.withItemRemoved(uuid);
  }

  void clearCart() {
    state = CartState([]);
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, CartState>(
  (ref) => CartNotifier(),
);
