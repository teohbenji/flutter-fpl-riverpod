import 'package:flutter/material.dart';

String getPlayerTeam(int index) {
    switch (index) {
      case 1:
        return 'Arsenal';
      case 2:
        return 'Aston Villa';
      case 3:
        return 'Bournemouth';
      case 4:
        return 'Brentford';
      case 5:
        return 'Brighton and Hove Albion';
      case 6:
        return 'Chelsea';
      case 7:
        return 'Crystal Palace';
      case 8:
        return 'Everton';
      case 9:
        return 'Fulham';
      case 10:
        return 'Ipswich Town';
      case 11:
        return 'Leicester City';
      case 12:
        return 'Liverpool';
      case 13:
        return 'Manchester City';
      case 14:
        return 'Manchester United';
      case 15:
        return 'Newcastle United';
      case 16:
        return 'Nottingham Forest';
      case 17:
        return 'Southampton';
      case 18:
        return 'Tottenham Hotspur';
      case 19:
        return 'West Ham United';
      case 20:
        return 'Wolverhampton Wanderers';
      default:
        return 'Unknown Team';
    }
  }