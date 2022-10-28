import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExistingBooking extends StatelessWidget {
  const ExistingBooking({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Flexible(
                 child: Image.asset("assets/map.png"),
              ),
              Card(
                color: Color.fromARGB(255, 246, 246, 246),
                shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        width: 0.3, color: Color.fromARGB(255, 229, 229, 229)),
                    borderRadius: BorderRadius.circular(16.0)),
                child:Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Text("Переговорная комната #1",style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.black,fontSize: 24, fontWeight: FontWeight.w400)),
                        ),

                        Padding(
                           padding: const EdgeInsets.symmetric(vertical: 5.0),
                           child: Container(
                              child: Text("Фио",style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.black54,fontSize: 30, fontWeight: FontWeight.w300)),
                              width: 290,

                           ),
                         ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Container(
                            height: 0.3,
                            color: Colors.black54,
                          ),
                        ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Container(
                  width: 300,
                  child:Text("И.В. Морозов",style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.black,fontSize: 24)),),
              ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Container(
                            child: Text("Офис",style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.black54,fontSize: 30, fontWeight: FontWeight.w300)),
                            width: 290,

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Container(
                            height: 0.3,
                            color: Colors.black54,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Container(
                            width: 300,
                            child:Text("Г. Владивосток, ул Светланская 56",style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.black,fontSize: 24)),),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Container(
                            child: Text("Дата",style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.black54,fontSize: 30, fontWeight: FontWeight.w300)),
                            width: 290,

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Container(
                            height: 0.3,
                            color: Colors.black54,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Container(
                            width: 300,
                            child:Text("26.10.2022",style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.black,fontSize: 24)),),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Container(
                            child: Text("Время",style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.black54,fontSize: 30, fontWeight: FontWeight.w300)),
                            width: 290,

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Container(
                            height: 0.3,
                            color: Colors.black54,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Container(
                            width: 300,
                            child:Text("10:30 - 16:30",style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.black,fontSize: 24)),),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: TextButton(
                          onPressed: () {},
                          child:
                          Container(
                            // decoration: BoxDecoration(
                            //   color: Colors.redAccent,
                            //   border: Border.all(
                            //     width: 0.1,
                            //   ),
                            //   borderRadius: BorderRadius.circular(12),
                            // ),
                            child: Center(child: Text("Отменить",style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),)),
                          width: 260,
                          height: 60,
                          ),
                        ),
                      ),
                    ),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(0xFF0D47A1),
                                    Color(0xFF1976D2),
                                    Color(0xFF42A5F5),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(16.0),
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: () {},
                            child: const Text('Gradient'),
                          ),
                        ],
                      ),
                    ),
                  ],

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
