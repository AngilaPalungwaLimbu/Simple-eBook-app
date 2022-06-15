import 'package:bookstore/Controller/cartcontroller.dart';
import 'package:bookstore/services/remote_service.dart';
import 'package:bookstore/widgets/cached.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  var cc = Get.find<CartController>();
  String? userId;
  String? name;
  String? email;
  String? address;
  String? mobile;

  getUserDetail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString("id");
    if (id != null) {
      userId = preferences.getString("id");
      name = preferences.getString("name");
      email = preferences.getString("email");
      address = "Dharan-15,Bhajoghara";
      mobile = "9834896034";
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetail();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Checkout"),
        ),
        body: Obx((() => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "Delivery Details",
                        textScaleFactor: 1.2,
                      ),
                      subtitle: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Full name: $name"),
                            Text("Email: $email "),
                            Text('City: $address'),
                            Text('Delivery Address: Buddha Chowk'),
                            Text('Contact: 9823851938'),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Cart Summary",
                        textScaleFactor: 1.2,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cc.items.length,
                      itemBuilder: (context, index) {
                        var mydata = cc.items[index];
                        return Card(
                          child: ListTile(
                            leading: CachedImage(imagePath: mydata.item.image),
                            title: Text(mydata.item.name),
                            subtitle: Text(
                                "${mydata.qty}*${mydata.item.sellingPrice}=${mydata.amount}"),
                            trailing: IconButton(
                                onPressed: () async {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  var id = preferences.getString("id");
                                  RemoteService.deleteCartItem(mydata.id)
                                      .whenComplete(() => cc.getcartdetail(
                                          int.parse(id.toString())));
                                },
                                icon: Icon(Icons.delete)),
                          ),
                        );
                      },
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          "Payment Methods",
                          textScaleFactor: 1.2,
                        ),
                        subtitle: CheckboxListTile(
                          value: true,
                          onChanged: (value) {},
                          title: Text("Cash on Delivery"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ))),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Map data = {
                      "userId": userId,
                      "total": 250,
                      "charge": 50,
                      "grandTotal": 300,
                      "city": address,
                      "StreetName": "Sayapatri Marga",
                      "contact": mobile,
                      "itemOrder":cc.items.map((e) {
                        return {
                          "itemId": e.itemId, 
                          "qty": e.qty, 
                          "amount": e.amount
                        };
                      }).toList()
                    };
                    RemoteService.placeOrder(data); 
                  },
                  child: Text(
                    "Place Order",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
