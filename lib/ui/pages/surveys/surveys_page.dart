import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fordev/ui/helpers/helpers.dart';

import 'components/surveys_components.dart';

class SurveysPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(R.strings.surveys),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: CarouselSlider(
            options: CarouselOptions(
              enlargeCenterPage: true,
              aspectRatio: 1,
            ),
            items: [
              SurveyItem(),
              SurveyItem(),
            ],
          ),
        ));
  }
}
