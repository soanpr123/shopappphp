import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/src/provider/cart.dart';


class CartItems extends StatelessWidget {
  final String id;
  final String productId;
  final int quantity;
  final String title;
  final double price;
  CartItems(this.id, this.productId,this.quantity, this.price, this.title);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(Icons.delete,color: Colors.white,size: 40,),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (decoratiom){
       return showDialog(context: context,
        builder: (ctx)=>AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to remove the item from the cart ? '),
          actions: <Widget>[
            FlatButton(
              child: Text('no'),
              onPressed: (){
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: Text('yes'),
              onPressed: (){
                Navigator.of(context).pop(true);
              },
            )
          ],
        )
        );
      },
      onDismissed: (decoration){
Provider.of<Cart>(context,listen:false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(child: Text('\$$price')),
                ),
              ),
              title: Text(title),
              subtitle: Text('total: \$${(price * quantity)}'),
              trailing: Text('$quantity x'),
            )),
      ),
    );
  }
}
