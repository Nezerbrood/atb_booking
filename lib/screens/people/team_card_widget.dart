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
          Image.asset(
              "assets/team_card.png",
              alignment: Alignment.center,
              height: 200,
              fit: BoxFit.fill),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Text(
              "Team Cringers",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.black),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Text(
              "Офис: г. Владивосток, ул Алеутская 24",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.black45),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Text(
              "Мы делаем вид что работаем в банке, но на самом деле мы скрываемся от миграционной полиции, чтобы нас не отправили назад в Уганду",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.black54),
            ),
          )
        ],
      ),
    );
  }

}