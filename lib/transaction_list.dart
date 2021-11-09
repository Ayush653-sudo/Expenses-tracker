import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './transaction.dart';
// ignore: unused_import
import 'package:intl/intl.dart';
class TransactionList extends StatelessWidget {
final List<Transaction>transaction;
final Function deleteTx;
TransactionList(this.transaction,this.deleteTx);

  @override
  Widget build(BuildContext context) {
   
            
          return 
           transaction.isEmpty?LayoutBuilder(builder:(ctx,constraints){
             
             return Column(children:<Widget>[
            // ignore: deprecated_member_use
            Text("NO transaction added yet!!",style:Theme.of(context).textTheme.headline6,),
          
           Container(
             height: constraints.maxHeight*0.6,
           child: Image.asset('assets/image/waiting.png',fit: BoxFit.cover,),
           ),
           
          ],
          );
           })
          :ListView.builder(
            itemBuilder:(ctx,index){
               return Card(
                 elevation: 5,
                 margin: EdgeInsets.symmetric(horizontal: 5,vertical: 8),
               child: ListTile(
                 leading: CircleAvatar(
                   radius: 30,
                   child:Padding(
                     padding: EdgeInsets.all(6),
                     child:FittedBox(
                   child:Text('\$${transaction[index].amount}'),
                     ),
                   ),
                 
                 ),
                 title: Text(transaction[index].title,
                 style:Theme.of(context).textTheme.headline6,
                 ),
                 subtitle:Text(DateFormat.yMMMd().format(transaction[index].date),
                 
                 ),
                 trailing: MediaQuery.of(context).size.width>460? FlatButton.icon(icon:Icon(Icons.delete),label:Text('Delete'),textColor:Theme.of(context).errorColor,onPressed:()=>deleteTx(transaction[index].id) ,)
                 : IconButton(icon: Icon(Icons.delete),color:Theme.of(context).errorColor,
                 onPressed: ()=>deleteTx(transaction[index].id),
                 ),
               ),
               );
               
            },
            itemCount:transaction.length,
          );
           
          
          }
          }
          
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
             
       
                  
      
    
  