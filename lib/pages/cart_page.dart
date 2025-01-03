import 'package:ebookstore_app/bloc/ebookstore_bloc.dart';
import 'package:ebookstore_app/model/book_model.dart';
import 'package:ebookstore_app/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        title: Text(
          "Shopping cart",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.greyLight),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.greyLight),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: AppColor.white,
      body: BlocBuilder<EbookstoreBloc, EbookstoreState>(
        builder: (context, state) {
          if (state.cartScreenState == CartScreenState.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.cart.isEmpty) {
            return const Center(
              child: Text("The cart is empty"),
            );
          }

          final total = state.cart.fold<double>(
            0.0,
            (sum, book) => sum + (book.price * book.quantity),
          );

          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Total: ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColor.black,
                      ),
                    ),
                    Text(
                      "\$${total.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColor.black,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.cart.length,
                  itemBuilder: (context, index) {
                    final book = state.cart[index];
                    return _buildCartItem(context, book);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<EbookstoreBloc>()
                          .add(const CheckoutCartEvent());
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Checkout is done. All the books moved to 'Reading'.",
                          ),
                        ),
                      );
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.orange,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      "Checkout",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, BookModel book) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              context.read<EbookstoreBloc>().add(
                    DeleteCartBookEvent(book: book),
                  );
            },
            icon: const Icon(Icons.close),
            color: AppColor.red,
          ),
          const SizedBox(width: 8),

          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              book.imageUrl,
              width: 60,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "By ${book.author}",
                  style: TextStyle(
                    color: AppColor.greyLight,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColor.greyBackground,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (book.quantity > 1) {
                                context.read<EbookstoreBloc>().add(
                                      AddToCartEvent(
                                          book: book,
                                          quantity: book.quantity - 1),
                                    );
                              }
                            },
                            child: Icon(
                              Icons.remove,
                              size: 16,
                              color: AppColor.black,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "${book.quantity}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColor.green,
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {
                              if (book.quantity < 5) {
                                context.read<EbookstoreBloc>().add(
                                      AddToCartEvent(
                                          book: book,
                                          quantity: book.quantity + 1),
                                    );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "You can't add more than 5 units."),
                                  ),
                                );
                              }
                            },
                            child: Icon(
                              Icons.add,
                              size: 16,
                              color: AppColor.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // Precio del libro
          Text(
            "\$${(book.price * book.quantity).toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
