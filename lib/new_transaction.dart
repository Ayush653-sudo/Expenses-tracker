import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {
final Function addTx;

NewTransaction(this.addTx);
@override
_NewTransactionState createState()=>_NewTransactionState();
}
class _NewTransactionState extends State<NewTransaction>
{
  final _titleController=TextEditingController();
final _amountController=TextEditingController();
DateTime _selectedDate;
void submitData(){
  final enteredTitle=_titleController.text;
  final enteredAmount=double.parse(_amountController.text);
  if(enteredTitle.isEmpty||enteredAmount<=0||_selectedDate==null){
    return;
  }
 widget.addTx(enteredTitle,enteredAmount,_selectedDate);
 Navigator.of(context).pop();
}
void _presentDatePicker(){
  showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime.now()
  ).then((pickedDate){
    if(pickedDate==null)
    {return;
    }
    setState(() {
      _selectedDate=pickedDate;
    });
    
  });
}
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
    child: Card(
            elevation:5,
            child: Container(
              padding: EdgeInsets.only(
                top:10,
                left:10,
                right:10,
                bottom:MediaQuery.of(context).viewInsets.bottom+10,
              ),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    //onChanged:(val){
                      //titleInput=val;
                    //},
                    controller: _titleController,
                     keyboardType: TextInputType.text,
                  onSubmitted:(_)=>submitData,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                   // onChanged: (value){
                //amountInput=value;
                  //  },
                  
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted:(_)=>submitData,
                  ),

                  Row(children: <Widget>[
                    Expanded(
                   child: Text(_selectedDate==null?'No date Chosen':DateFormat().format(_selectedDate),),
                    ),
                    // ignore: deprecated_member_use
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text('Chosse Date',style:TextStyle(fontWeight: FontWeight.bold)),onPressed:_presentDatePicker),
                  ],),
                  // ignore: deprecated_member_use
                  
                      // ignore: deprecated_member_use
                      RaisedButton(
                        
                        child: Text('Add Transaction'),
                        
                        color:Colors.purple,
                        textColor:Colors.white,
                        onPressed: submitData,
                        ),
                    ],
                  
                
              ),

            ),
          ),);
      
    
  }

 
}

