import 'package:flutter/material.dart';

class TeamCard extends StatelessWidget {
  const TeamCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      semanticContainer: false,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: [
          // Image.asset(
          //     "assets/team_card.png",
          //     alignment: Alignment.center,
          //     height: 200,
          //     fit: BoxFit.fill),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: Text(
              "Team Cringers",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.black, fontSize: 30),
            ),
          ),
          // Container(
          //   padding: EdgeInsets.all(10),
          //   width: double.infinity,
          //   child: Text(
          //     "Офис: г. Владивосток, ул Алеутская 24",
          //     style: Theme.of(context)
          //         .textTheme
          //         .labelLarge
          //         ?.copyWith(color: Colors.black45),
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: Text(
              "Команда по разработке приложения для бронирования мест в офисе банка АТБ.\n Команда Cringers была основана при странном стечении обстоятельств. Два бэкэндера случайно нашли двух фронтэндеров =)",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.black54, fontSize: 18),
            ),
          )
        ],
      ),
    );
  }

}