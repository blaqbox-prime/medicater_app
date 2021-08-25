import 'package:flutter/material.dart';
import 'package:medicater_app/constants.dart';
import 'package:medicater_app/models/cart.dart';
import 'package:medicater_app/models/cartItems.dart';

import '../../../size_config.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({Key? key, required this.cartItem}) : super(key: key);

  final CartItem cartItem;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(88),
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[50],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: cartItem.product!.img != null
                    ? Image.network(cartItem.product!.img as String,
                        alignment: Alignment.center, fit: BoxFit.cover)
                    : Image.asset("assets/images/logo.png",
                        alignment: Alignment.center, fit: BoxFit.cover)),
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(20)),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            cartItem.product!.name as String,
            style: TextStyle(fontSize: 13, color: text_color),
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Text.rich(
            TextSpan(
                text: "\R${cartItem.product!.price}",
                style: TextStyle(color: primary_color),
                children: [
                  TextSpan(
                      text: " x${cartItem.quantity}",
                      style: TextStyle(color: text_color))
                ]),
          )
        ]),
      ],
    );
  }
}
