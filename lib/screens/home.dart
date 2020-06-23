import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reservation.dart';
import '../widgets/item.dart';
import '../providers/auth.dart';

class Home extends StatefulWidget{
  static const rout='view-reservation';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Reservation> res=[];
  var isloading=false;
  var isinit=true;
  @override
  void didChangeDependencies() {
    if(isinit){
      setState(() {
        isloading=true;
      });
      Provider.of<Reservations>(context,listen:false).fetchAndSet().then((_){
        setState((){
          isloading=false;
        });
      });
    }
    isinit=false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context){
    final res=Provider.of<Reservations>(context,listen:true).reservations;
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title:Text('View reservations made'),
        actions: <Widget>[
              InkWell(
                onTap:()=>Provider.of<Auth>(context,listen:false).logout(),
                child:SizedBox(
                  height:height/15,width:width/8,
                  child:Image.asset('assets/logout.jfif',fit:BoxFit.fill,)
                )
              )
            ]
      ),
      body:isloading?Center(child: CircularProgressIndicator()):
      res.length==0?Column(children: <Widget>[Center(child:Text('You have not made any reservation so far',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)))],):
      ListView.builder(
        itemBuilder:(ctx,i)=>Item(res[i]),
        itemCount:res.length,),//SizedBox()
    );
  }
}