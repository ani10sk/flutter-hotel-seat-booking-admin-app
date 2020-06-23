import 'package:flutter/material.dart';
import '../providers/reservation.dart';
import '../screens/edit.dart';

class Item extends StatelessWidget{
  final Reservation res;
  Item(this.res);
  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap:()=>Navigator.of(context).pushNamed(Edit.rout,arguments:res),
      child: Container(
        decoration:BoxDecoration(
          color:res.isConfirmed=='0'?Colors.red:Colors.green,
          borderRadius:BorderRadius.circular(10)
        ),
        margin:EdgeInsets.all(10),
        padding:EdgeInsets.all(10),
        child:SizedBox(
          width:MediaQuery.of(context).size.width-40,
          child: Row(
            children:[
              Text(res.seats,style:TextStyle(fontSize:20,fontWeight:FontWeight.bold),),
              SizedBox(width:20,),
              Text(res.time),
              Expanded(child:SizedBox()),
              Icon(res.isConfirmed=='0'?Icons.warning:Icons.done_outline)
            ]
          ),
        )
      ),
    );
  }
}