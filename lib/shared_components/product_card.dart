import 'package:cartgo/constants/app_sizes.dart';
import 'package:cartgo/constants/colors.dart';
import 'package:cartgo/domain/product.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key, required this.product, this.discountApplied = true});

  final Product product;
  final bool discountApplied;

  double get price => discountApplied
      ? product.price - (product.price * product.discountPercentage / 100)
      : product.price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.p8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.p12),
        color: kWhiteColor,
      ),
      child: Column(
        children: [

          /// product image
          CachedNetworkImage(
            imageUrl: product.thumbnail,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),

          /// product name
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              product.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                fontSize: Sizes.p16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          ///
          gapH8,

          /// product description
          Text(
            product.description,
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
            style: const TextStyle(
              fontSize: Sizes.p16,
              fontWeight: FontWeight.w500,
            ),
          ),

          ///
          const Spacer(),

          ///
          Row(
            children: [

              /// product price
              Visibility(
                visible: discountApplied,
                child: Text(
                  "\$${product.price}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: Sizes.p12,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.lineThrough,
                    color: kGreyColor
                
                  ),
                ),
              ),

              ///
              gapW8,

              /// price net price
              Text(
                "\$${price.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: Sizes.p12,
                  fontStyle: FontStyle.italic,
                ),
              ),

              ///
              gapW8,

              /// discount percentage
              Visibility(
                visible: discountApplied,
                child: Text(
                  "${product.discountPercentage}% off",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 111, 255, 118),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: Sizes.p12,
                  ),
                ),
              ),

              ///
              const Spacer(),
            ],
          ),

          gapH20
        ],
      ),
    );
  }
}
