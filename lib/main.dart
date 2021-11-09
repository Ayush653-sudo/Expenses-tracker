
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/new_transaction.dart';
import './transaction.dart';
import './chart.dart';
import './transaction_list.dart';



// ignore: unused_import


void main()=>runApp(MyApp());
class MyApp extends StatelessWidget {
    @override
  Widget build(BuildContext context) {
    
      return  MaterialApp(
        title:'dd',
        // ignore: deprecated_member_use
        theme:ThemeData(primarySwatch: Colors.indigo,accentColor: Colors.amber,errorColor:Colors.red,fontFamily:'Quicksand',textTheme: ThemeData.light().textTheme.copyWith(subtitle1:TextStyle(fontFamily:'OpenSans',fontWeight: FontWeight.bold,fontSize:20,),),),
        home:Myhome(),
      );
      
  
  }
}
// ignore: must_be_immutable
class Myhome extends StatefulWidget {
  
//String titleInput;
//String amountInput;
  // ignore: non_constant_identifier_names
  @override
  _MyhomeState createState()=>_MyhomeState();
}
class _MyhomeState extends State<Myhome>{
   final List<Transaction>_userTransaction=[
    
  
    
  ];
  bool _showChart=false;
  List<Transaction>get _recentTransaction{
    return _userTransaction.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days:7),),);
    }).toList();
  }
  void _addNewTransaction(String txtitle, double txAmount,DateTime chosenDate){
    print(txtitle);
    print(txAmount);
    final newTx=Transaction(
      title:txtitle,
      amount: txAmount,
      date:chosenDate,
      id:DateTime.now().toString(),
    );
    setState(() {
      _userTransaction.add(newTx);
    });
  }
  void _startAddNewTransaction(BuildContext ctx){
 showModalBottomSheet(context: ctx, builder: (_){
return GestureDetector(   //used when we use bottom sheet and if this is not there then it would vanish our
onTap: (){},              //bottomsheet even if we touch on bottom sheet also by this we romove bottom sheet
 child: NewTransaction(_addNewTransaction),//by touching on backside
behavior: HitTestBehavior.opaque,
);

 },
 );

  }
  void _deleteTransaction(String id){
    setState((){
      _userTransaction.removeWhere((tx) =>tx.id==id);
    });
  }

@override
  
  Widget build(BuildContext context) {
    final isLandscape =MediaQuery.of(context).orientation==Orientation.landscape;
    // ignore: unused_local_variable
  final PreferredSizeWidget appBar= Platform.isIOS?CupertinoNavigationBar(middle:Text('Day Expenses'),
  trailing:Row(
    children:<Widget>[
      
      GestureDetector(
        child:Icon(CupertinoIcons.add),
        onTap:()=>_startAddNewTransaction(context),),
    ],
  ),
  ):
  
   AppBar(title: Text('Day Expenses',style:TextStyle(fontFamily:'OpenSans'),),
      actions: <Widget>[
        IconButton( 
          icon: Icon(Icons.add),
          onPressed: () =>_startAddNewTransaction(context),
          )
      ],
      );
      final pageBody =SafeArea(child: SingleChildScrollView(
      child:Column(
      
        children:<Widget>[
        if(isLandscape)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
            Text('Show Chart',style: Theme.of(context).textTheme.headline6),
            // ignore: deprecated_member_use
            Switch.adaptive(activeColor:Theme.of(context).accentColor,value:_showChart,onChanged: (val){   //adaptive is platfoam specific and changed itself for iphone and mobile
              setState(() {
                _showChart=val;
              });
            },),
          ],),
          if(!isLandscape)  Container( height:(MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.3, child: Chart(
_recentTransaction
          ),
       ),
       if(!isLandscape)  Container( height:(MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,child:TransactionList(_userTransaction,_deleteTransaction),),
       
   if(isLandscape)  _showChart? Container( height:(MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7, child: Chart(
_recentTransaction
          ),
       ):
        Container( height:(MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,child:TransactionList(_userTransaction,_deleteTransaction),),
        ],
          ),
      ),);
    return Platform.isIOS?CupertinoPageScaffold(child:pageBody,navigationBar:appBar, ) :Scaffold(
      appBar: appBar,
      body:pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:Platform.isIOS?Container(): FloatingActionButton(
        child:Icon(Icons.add),
        onPressed:() =>_startAddNewTransaction(context),
      ),
    );
      
    
  }
}

