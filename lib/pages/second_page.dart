import 'package:flutter/material.dart';
import 'package:seip_day49/model/model.dart';
import 'package:seip_day49/pages/third_page.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class SecondPage extends StatefulWidget {
  SecondPage({Key? key,this.excerciesModel}) : super(key: key);

  ExcerciesModel? excerciesModel;
  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network("${widget.excerciesModel!.thumbnail}",height: double.infinity,width: double.infinity,fit: BoxFit.cover,),



          Positioned(
            bottom: 20,
            right: 0,
            left: 0,
            child: Column(
              children: [
                SleekCircularSlider(
                  innerWidget: (value) {
                    return Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text("${second.toStringAsFixed(0)} ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,),),
                          Text("S",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                        ],
                      ),


                      //Text("${second.toStringAsFixed(0)} S",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,),),
                    );
                  },
                  appearance: CircularSliderAppearance(
                      customWidths: CustomSliderWidths(progressBarWidth: 10)),
                  min: 1,
                  max: 30,
                  initialValue: second,
                  onChange: (value) {
                    setState(() {
                      second = value;
                    });
                  },
                ),


                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdPage(
                      excerciesModel: widget.excerciesModel,
                      second: second.toInt(),
                    )));
                  },
                  child: Container(
                    height: 45,
                    width: 300,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          colors: [
                            Colors.purpleAccent,
                            Colors.purple
                          ])
                    ),

                    child: Center(child: Text("Start Excercise",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.white),)),
                  ),
                ),

                // MaterialButton(
                //   onPressed: () {},
                //   color: Colors.orange,
                //   child: Text("Next"),
                // ),
              ],
            ),
          )

        ],
      ),
    );
  }


  double second = 1;
}
