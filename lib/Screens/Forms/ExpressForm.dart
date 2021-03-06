import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khartoumport/Screens/Ticket/ExpressDetails.dart';
import 'package:khartoumport/homepage.dart';


class ExpressForm extends StatefulWidget {
  const ExpressForm({Key? key}) : super(key: key);

  @override
  State<ExpressForm> createState() => _ExpressFormState();
}

class _ExpressFormState extends State<ExpressForm> {

  final _formkey = GlobalKey<FormState>();

  final NameController = new TextEditingController();
  final PhoneController= new TextEditingController();
  final NationalNumberController = new TextEditingController();
  final LocationController = new TextEditingController();
  final TimeController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          leading: FlatButton.icon(
            color:Colors.lightBlueAccent,
            icon: Icon(Icons.logout),
            label: Text(
              "رجوع",
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (Context) => ExpressDetails()
              )
              );
            },
          ),
          actions: <Widget>[
            FlatButton.icon(
              color:Colors.blue,
              icon: Icon(Icons.home),
              label: Text(
                "الرئيسية",
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (Context) => home()
                )
                );
              },
            )
          ],
          title: Text(''),
        ),
        body:ListView(
            padding :EdgeInsets.all(20.0),
            children:[
              Form(
                key:_formkey,
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Container(
                      width:150,
                      height:150,
                      child:Image(
                        image: AssetImage(
                            'assets/ticket.png'
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: NameController,
                        keyboardType: TextInputType.name,
                        validator: (value){
                          if(value!.isEmpty){
                            return "الرجاء ادخال الاسم ";
                          }
                          return null;
                        },
                        onSaved:(value)
                        {
                          NameController.text =value!;
                        },
                        decoration: InputDecoration(
                          border:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          hintText: 'ادخل الاسم رباعي',
                          labelText:' الاسم',
                          prefixIcon: Icon(
                              Icons.person
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: PhoneController,
                        keyboardType: TextInputType.number,
                        validator: (value){
                          if(value!.isEmpty){
                            return "الرجاء ادخال رقم الهاتف";
                          }
                          return null;
                        },
                        onSaved:(value) {
                          PhoneController.text= value!;
                        },

                        decoration: InputDecoration(
                          border:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          hintText: 'رقم الهاتف',
                          labelText:' رقم الهاتف',
                          prefixIcon: Icon(
                              Icons.phone
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: NationalNumberController,
                        keyboardType: TextInputType.number,
                        validator: (value){
                          if(value!.isEmpty){
                            return "الرجاء ادخال الرقم الوطني";
                          }
                          return null;
                        },
                        onSaved: (value){
                          NationalNumberController.text = value!;
                        },
                        decoration: InputDecoration(
                          border:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          hintText: 'الرقم الوطني',
                          labelText:'الرقم الوطني',
                          prefixIcon: Icon(
                              Icons.email
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: LocationController,
                        keyboardType: TextInputType.text,
                        validator: (value){
                          if(value!.isEmpty){
                            return "الرجاء  ادخال مكان السكن";
                          }
                          return null;
                        },
                        onSaved: (value){
                          LocationController.text=value!;
                        },
                        decoration: InputDecoration(
                          border:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          hintText: 'مكان السكن',
                          labelText:' مكان السكن',
                          prefixIcon: Icon(
                              Icons.location_pin

                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: TimeController,
                        keyboardType: TextInputType.number,
                        validator: (value){
                          if(value!.isEmpty){
                            return "الرجاء  ادخال مواعيد";
                          }
                          return null;
                        },
                        onSaved: (value){
                          TimeController.text=value!;
                        },
                        decoration: InputDecoration(
                          border:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          hintText: 'التوقيت',
                          labelText:'الزمن',
                          prefixIcon: Icon(
                              Icons.access_time

                          ),
                        ),
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.blue
                        ),
                        child:Padding(
                          padding: EdgeInsets.all(20.0),
                          child: FlatButton(
                            color: Colors.blue,
                            child:Container(
                              width: 30,
                              height: 30,
                              child: Text('حجز', style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15
                              ),),
                            ),
                            onPressed: () async {
                              if(_formkey.currentState!.validate()) {
                                await FirebaseFirestore.instance.collection(
                                    "ExpressTicket").add(
                                    {
                                      "name": NameController.text,
                                      "phone": PhoneController.text,
                                      "nationalNo": NationalNumberController.text,
                                      "location": LocationController.text,
                                      "time":TimeController.text
                                      // "busNo":

                                    });
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (Context) => home()
                                )
                                );
                              }
                            },

                          ),
                        )
                    ),
                  ],
                ),

              ),
            ]
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items:<BottomNavigationBarItem> [
            BottomNavigationBarItem(
              icon:Icon(Icons.home),
              label:'Home',
            ),
            BottomNavigationBarItem(
              icon:Icon(Icons.logout),
              label:'تسجيل الخروج',
            ),
          ],

        ),
      ),
    );
  }
}
