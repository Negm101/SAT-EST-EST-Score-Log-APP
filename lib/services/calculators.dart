import 'package:flutter/cupertino.dart';

class Calculators {
  double sat1;
  double sat2;
  double gpa;
  double english;
  double math;
  double reading;
  int compositeScore;
  int compositeScoreSubject;
  int actSubjects;
  bool isPublic = true;

  Calculators.sat(this.sat1, this.sat2, this.gpa);

  Calculators.act(this.english, this.reading, this.math);

  double _getSat1() {
    if (sat1 > 1090 && isPublic) {
      return (sat1 / 1600) * 69;
    }
    if (sat1 > 1090 && !isPublic) {
      return (sat1 / 1600) * 75;
    }
    if (sat1 < 1090) {
      return (sat1 / 1600) * 60;
    } else {
      return -1;
    }
  }

  double _getSat2() {
    if ((sat2 >= 900 && !isPublic) || (sat2 >= 1100 && isPublic)) {
      return (sat2 / 1600) * 15;
    }
    if ((sat2 < 900 && !isPublic) || (sat2 < 1100 && isPublic)) {
      return 0;
    } else {
      return -1;
    }
  }

  void _actAverage() {
    this.compositeScore =
        ((this.english + this.math + this.reading) / 3).round().toInt();
    debugPrint(this.english.toString() +
        ' ' +
        this.math.toString() +
        ' ' +
        this.reading.toString());
    debugPrint(compositeScore.toString());
  }

  int convertActToSat1() {
    _actAverage();
    switch (compositeScore) {
      case 9:
        return 610;
        break;
      case 10:
        return 640;
        break;
      case 11:
        return 680;
        break;
      case 12:
        return 720;
        break;
      case 13:
        return 770;
        break;
      case 14:
        return 820;
        break;
      case 15:
        return 870;
        break;
      case 16:
        return 910;
        break;
      case 17:
        return 950;
        break;
      case 18:
        return 980;
        break;
      case 19:
        return 1020;
        break;
      case 20:
        return 1050;
        break;
      case 21:
        return 1090;
        break;
      case 22:
        return 1120;
        break;
      case 23:
        return 1150;
        break;
      case 24:
        return 1190;
        break;
      case 25:
        return 1220;
        break;
      case 26:
        return 1240;
        break;
      case 27:
        return 1290;
        break;
      case 28:
        return 1320;
        break;
      case 29:
        return 1350;
        break;
      case 30:
        return 1380;
        break;
      case 31:
        return 1410;
        break;
      case 32:
        return 1440;
        break;
      case 33:
        return 1480;
        break;
      case 34:
        return 1520;
        break;
      case 35:
        return 1560;
        break;
      case 36:
        return 1600;
        break;
      default:
        return -1;
        break;
    }
  }

  int convertActSubjectsToSat2() {
    switch (actSubjects) {
      case 10:
        return 260;
        break;
      case 11:
        return 280;
        break;
      case 12:
        return 310;
        break;
      case 13:
        return 330;
        break;
      case 14:
        return 360;
        break;
      case 15:
        return 400;
        break;
      case 16:
        return 430;
        break;
      case 17:
        return 470;
        break;
      case 18:
        return 500;
        break;
      case 19:
        return 510;
        break;
      case 20:
        return 520;
        break;
      case 21:
        return 530;
        break;
      case 22:
        return 540;
        break;
      case 23:
        return 560;
        break;
      case 24:
        return 580;
        break;
      case 25:
        return 590;
        break;
      case 26:
        return 610;
        break;
      case 27:
        return 640;
        break;
      case 28:
        return 660;
        break;
      case 29:
        return 680;
        break;
      case 30:
        return 700;
        break;
      case 31:
        return 710;
        break;
      case 32:
        return 720;
        break;
      case 33:
        return 740;
        break;
      case 34:
        return 760;
        break;
      case 35:
        return 780;
        break;
      case 36:
        return 800;
        break;
      default:
        return -1;
        break;
    }
  }

  String getTansikScore() {
    double score = _getSat1() + _getSat2() + gpa;
    return score.toString();
  }
}
