import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:seip_day49/model/model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:seip_day49/pages/second_page.dart';
import 'package:seip_day49/widget/widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<ExcerciesModel> allData = [];


  String link = 'https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json?fbclid=IwAR2_RZb5xXXdgC3KVY-LE41y7m_WMF4A2qxxU0zmofgePhQg-cx6oEyAuN4';
  bool isLoading = false;

  fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });
      var responce = await http.get(Uri.parse(link)); //link hit
      print("status code is ${responce.statusCode}");
      // print("${responce.body}");
      if (responce.statusCode == 200) {
        final item = jsonDecode(responce.body);
        for (var data in item["exercises"]) {

          ExcerciesModel excerciesModel = ExcerciesModel(
              id: data["id"],
              title: data["title"],
              thumbnail: data["thumbnail"],
              gif: data["gif"],
              seconds: data["seconds"]
          );


          setState(() {
            allData.add(excerciesModel);
          });
        }

        print("total length is ${allData.length}");
      } else {
        showToast("Something went wrong!!!");
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Something is wrong $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercise App"),
      ),


      body: ModalProgressHUD(
        inAsyncCall: isLoading == true,
        progressIndicator: spinkit,
        child: Container(
          width: double.infinity,

          child: SingleChildScrollView(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Daily Fitness Application",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.black),),
                ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: allData.length,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage(
                            excerciesModel: allData[index],
                          )));
                        },
                        child: Container(
                          height: 170,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              children: [
                                Image.network("${allData[index].thumbnail}", width: double.infinity, fit: BoxFit.cover,),



                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 60,
                                    width: double.infinity,

                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                        Colors.black12,
                                        Colors.black54,
                                        Colors.black87,
                                        Colors.black
                                      ])
                                    ),


                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 14,left: 20),
                                      child: Text("${allData[index].title}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.white),),
                                    ),

                                  ),
                                )

                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),


        ),
      ),

    );
  }
}
