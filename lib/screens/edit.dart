import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reservation.dart';

class Edit extends StatefulWidget{
  Reservation res;
  static const rout='edit';
  void build(BuildContext context){
    res=ModalRoute.of(context).settings.arguments as Reservation;
  }
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  Widget build(BuildContext context){
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    widget.build(context);
    @override
    var iswaiting=false;
  void changeStatus()async{
    try{
      setState(() {
        iswaiting=true;
        if(widget.res.isConfirmed=='0'){
      widget.res=Reservation(
        creatorid:widget.res.creatorid,
           id:widget.res.id,
           mno:widget.res.mno,
           email:widget.res.email,
           dob:widget.res.dob,
           seats:widget.res.seats,
           time:widget.res.time,
           isConfirmed:'1'
      );
    }else{
      widget.res=Reservation(
        creatorid:widget.res.creatorid,
           id:widget.res.id,
           mno:widget.res.mno,
           email:widget.res.email,
           dob:widget.res.dob,
           seats:widget.res.seats,
           time:widget.res.time,
           isConfirmed:'0'
      );
    }
      });
      await Provider.of<Reservations>(context,listen:false).edit(widget.res.isConfirmed,widget.res.id);
    }catch(error){
      print('error');
    }
    setState(() {
      iswaiting=false;
    });
  }
    return Scaffold(
      appBar:AppBar(
        title:Text('Reservation details')
      ),
      body:Padding(
        padding:EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children:[
                  Text('Mobile No',style:TextStyle(fontSize:height/32,fontWeight:FontWeight.bold)),
                  SizedBox(width:width/4,),
                  Text(widget.res.mno,style:TextStyle(fontSize:height/32,),)
                ]
              ),
              SizedBox(height:height/15),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children:[
                  Text('E Mail',style:TextStyle(fontSize:height/32,fontWeight:FontWeight.bold)),
                  SizedBox(width:width/4,),
                  Text(widget.res.email,style:TextStyle(fontSize:height/32,))
                ]
              ),
              SizedBox(height:height/15),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children:[
                  Text('Date Of Birth',style:TextStyle(fontSize:height/32,fontWeight:FontWeight.bold)),
                  SizedBox(width:width/4,),
                  Text(widget.res.dob,style:TextStyle(fontSize:height/32,))
                ]
              ),
              SizedBox(height:height/15),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children:[
                  Text('Seats',style:TextStyle(fontSize:height/32,fontWeight:FontWeight.bold)),
                  SizedBox(width:width/4,),
                  Text(widget.res.seats,style:TextStyle(fontSize:height/32,))
                ]
              ),
              SizedBox(height:height/15),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children:[
                  Text('Time',style:TextStyle(fontSize:height/32,fontWeight:FontWeight.bold)),
                  SizedBox(width:width/4,),
                  Text(widget.res.time,style:TextStyle(fontSize:height/32,))
                ]
              )
            ],
          )
          ),
      ),
      bottomNavigationBar:
      iswaiting?CircularProgressIndicator():FloatingActionButton(
        onPressed:changeStatus,
        child:Text('Toggle'),
        ),
    );
  }
}