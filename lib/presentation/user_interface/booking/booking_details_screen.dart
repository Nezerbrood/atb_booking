import 'package:flutter/material.dart';

import '../../widgets/elevated_button.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Бронь"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Flexible(
                child: Image.asset("assets/map.png"),
              ),
              SizedBox(
                width: double.infinity,
                //height: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 0.3,
                          color: Color.fromARGB(255, 229, 229, 229)),
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 5),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Text("Место",
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            color: Colors.black54,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w300)),
                              ),
                              Container(
                                height: 0.3,
                                color: Colors.black54,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Text("Переговорная №1, 3 этаж",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            color: Colors.black, fontSize: 23)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 5),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Text("Фио",
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            color: Colors.black54,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w300)),
                              ),
                              Container(
                                height: 0.3,
                                color: Colors.black54,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Text("И.В. Морозов",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            color: Colors.black, fontSize: 24)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 5),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Text("Офис",
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            color: Colors.black54,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w300)),
                              ),
                              Container(
                                height: 0.3,
                                color: Colors.black54,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                    "Г. Владивосток, ул. Светланская 56",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            color: Colors.black, fontSize: 24)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 5),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Text("Дата",
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            color: Colors.black54,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w300)),
                              ),
                              Container(
                                height: 0.3,
                                color: Colors.black54,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Text("26 Октября 2022",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            color: Colors.black, fontSize: 24)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 5),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Text("Время",
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            color: Colors.black54,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w300)),
                              ),
                              Container(
                                height: 0.3,
                                color: Colors.black54,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Text("10:30 - 16:30",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            color: Colors.black, fontSize: 24)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 5),
                            child: AtbElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              text: "Отменить",
                            )),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
