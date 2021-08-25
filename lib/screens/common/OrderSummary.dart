import 'package:flutter/material.dart';
import 'package:medicater_app/constants.dart';
import 'package:medicater_app/models/driver.dart';
import 'package:medicater_app/models/order.dart';
import 'package:medicater_app/providers/orderProvider.dart';
import 'package:medicater_app/screens/common/w_Title.dart';
import 'package:medicater_app/services/mysql_service.dart';
import 'package:provider/provider.dart';

class OrderSummary extends StatefulWidget {
  Order? order;
  String? viewer;

  OrderSummary({this.order, this.viewer});

  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  bool driverIsSet = false;
  List<DeliveryMan> availableDrivers = [];

  @override
  void initState() {
    // TODO: implement initState
    if (widget.order!.deliveryMan != null) {
      driverIsSet = true;
    }
    MysqlService()
        .getDrivers('Polokwane')
        .then((drivers) => {availableDrivers = drivers});
    Provider.of<OrderProvider>(context, listen: false).order = widget.order!;
    print('available drivers > \n $availableDrivers');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Order? order = this.widget.order;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ScreenTitle(
                  text1: "Order",
                  text2: "\nSummary",
                ),
                Text(widget.order!.orderStatus!,
                    style: TextStyle(color: widget.order!.statusClr()))
              ],
            ),
            SizedBox(height: 20),
            Text(
              order!.customer!.fullname,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 10),
            Text(
                "${order.delivAddress!.street}\n${order.delivAddress!.suburb}\n${order.delivAddress!.city}\n${order.delivAddress!.province}\n${order.delivAddress!.zipCode}"),
            SizedBox(height: 20),
            Text("Items",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
            ListView.builder(
                itemCount: order.orderItems!.length,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var item = order.orderItems![index];
                  return ListTile(
                    leading: Container(
                        height: 30,
                        width: 30,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              item.product!.img!,
                              fit: BoxFit.scaleDown,
                            ))),
                    title: Text(
                      item.product!.name!,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Quantity: ${item.quantity}",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    trailing: Text(
                      "R${item.total.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: accent_color,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                }),
            ListTile(
              title: Text(
                "Order Total",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Including delivery fee.",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              trailing: Text(
                "R${order.billAmnt!.toStringAsFixed(2)}",
                style: TextStyle(
                    color: accent_color,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Deliveryman",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
                widget.viewer == 'seller'
                    ? TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (ctx) => selectDriver());
                        },
                        child: Text("Select a driver"))
                    : SizedBox()
              ],
            ),
            ListTile(
              leading: Icon(Icons.account_circle, size: 50),
              title: Text(
                widget.order!.deliveryMan!.fullName,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                widget.order!.deliveryMan!.vehicleDetail,
                style: TextStyle(fontSize: 12),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            widget.viewer == "seller"
                ? _buildButtons(this.context)
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    Order order = Provider.of<OrderProvider>(context, listen: false).order;
    return ListView(shrinkWrap: true, physics: ScrollPhysics(), children: [
      createButton(order.orderStatus!, order.is_delivery!),
      (order.orderStatus != 'on pick-up' &&
              order.orderStatus != 'on delivery' &&
              order.orderStatus != 'fulfilled' &&
              order.orderStatus != 'cancelled')
          ? ElevatedButton(
              onPressed: () {
                Provider.of<OrderProvider>(context, listen: false)
                    .cancelOrder();
                Navigator.of(context).pop();
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  widget.viewer == "seller" ? "Reject Order" : "Cancel Order",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
            )
          : SizedBox()
    ]);
  }

  createButton(String order_status, bool is_delivery) {
    switch (order_status) {
      case 'new':
        return ElevatedButton(
          onPressed: () async {
            await Provider.of<OrderProvider>(context, listen: false)
                .confirmOrder();
            Navigator.of(context).pop();
          },
          child: Container(
            alignment: Alignment.center,
            child: Text(
              "Approve Order",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        );
        break;
      case 'processing':
        return ElevatedButton(
          onPressed: () async {
            is_delivery
                ? await Provider.of<OrderProvider>(context, listen: false)
                    .deliverOrder()
                : await Provider.of<OrderProvider>(context, listen: false)
                    .pickUpOrder();
            Navigator.of(context).pop();
          },
          child: Container(
            alignment: Alignment.center,
            child: Text(
              is_delivery ? "Ready for delivery" : "Ready for pick up",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        );
        break;
      case 'fulfilled':
      case 'cancelled':
        return OutlinedButton(
          onPressed: () async {
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (ctx) => AlertDialog(
                      title: Text('Delete Order'),
                      content: Text('Are you sure you want to delete?'),
                      actions: [
                        TextButton(
                            onPressed: () => {Navigator.pop(context, 'No')},
                            child: Text(
                              'No',
                              style: TextStyle(color: Colors.grey),
                            )),
                        TextButton(
                            onPressed: () => {Navigator.pop(context, 'Yes')},
                            child: Text(
                              'Yes',
                              style: TextStyle(color: accent_color),
                            )),
                      ],
                    )).then((value) => {
                  if (value == 'Yes')
                    {
                      Provider.of<OrderProvider>(context, listen: false)
                          .deleteOrder()
                    }
                });
            Navigator.of(context).pop();
          },
          child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delete),
                  Text(
                    "Delete order",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: accent_color),
                  ),
                ],
              )),
        );
        break;
      default:
        return SizedBox();
    }
  }

  selectDriver() {
    return AlertDialog(
      title: Text('Select delivery driver'),
      scrollable: true,
      content: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: ListView.builder(
              itemCount: availableDrivers.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                DeliveryMan deliveryMan = availableDrivers[index];
                return ListTile(
                  onTap: () => {print(deliveryMan.fullName)},
                  leading: Icon(Icons.account_circle, size: 50),
                  title: Text(
                    deliveryMan.fullName,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    deliveryMan.vehicleDetail,
                    style: TextStyle(fontSize: 12),
                  ),
                );
              })),
    );
  }
}
