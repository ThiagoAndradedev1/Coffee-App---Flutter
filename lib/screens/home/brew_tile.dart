import 'package:brew_crew/models/brew.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;
  BrewTile({this.brew});

  String coffeeStrength(int strength) {
    if (strength >= 100 && strength <= 400) {
      return 'Weak';
    }
    if (strength >= 500 && strength <= 700) {
      return 'Medium';
    }
    return 'Strong';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 45.0,
                backgroundColor: Colors.brown[brew.strength],
                backgroundImage: NetworkImage(
                    'https://media0.giphy.com/media/g0HiibIiGp2oWQjMy5/giphy.gif'),
              ),
              Column(
                children: [
                  Text(
                    brew.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Takes ${brew.sugars} sugar(s)'),
                ],
              ),
              Text(
                coffeeStrength(brew.strength),
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
