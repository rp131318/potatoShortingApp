import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nexus/Widgets/new_button.dart';
import 'package:nexus/api/local_storage.dart';
import 'package:nexus/globalVariable.dart';
import 'package:nexus/main.dart';
import 'package:nexus/util/constants.dart';
import 'package:nexus/util/text_styles.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../util/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<double> sliderValueArray = [0, 102, 110, 112, 180, 254, 254];

  bool isStart = false;

  List<String> titleList = ["Area", "Active Area", "Colors", "Params"];
  List<IconData> titleListIcon = [
    Icons.app_registration,
    Icons.area_chart_rounded,
    Icons.color_lens,
    Icons.compare_arrows
  ];

  bool showOptions = false;

  int selected = 100;

  ///Area
  SfRangeValues areaValues = const SfRangeValues(40.0, 80.0);

  ///Active Area
  SfRangeValues activeAreaValues = const SfRangeValues(40.0, 80.0);

  ///Colors
  SfRangeValues redColorValue = const SfRangeValues(40.0, 80.0);
  SfRangeValues greenColorValue = const SfRangeValues(40.0, 80.0);
  SfRangeValues blueColorValue = const SfRangeValues(40.0, 80.0);

  ///Params
  List<String> paramsTitleList = ["LH", "LS", "LV", "UH", "US", "UV"];
  List<double> paramsSliderValue = [0, 0, 0, 0, 0, 0];
  List<double> paramsSliderMaxValue = [180, 255, 255, 180, 255, 255];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    customPrint(
        "Link Ip :: ${prefs.getString(LocalStorage.enterLink) ?? "NA"}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 255.h,
                        child: WebView(
                          initialUrl:
                              'http://${prefs.getString(LocalStorage.enterLink) ?? ""}/video_feed',
                          // initialUrl: 'https://theanantkaal.com/',
                          javascriptMode: JavascriptMode.unrestricted,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 255.h,
                        child: WebView(
                          initialUrl:
                              'http://${prefs.getString(LocalStorage.enterLink) ?? ""}/video_feed1',
                          javascriptMode: JavascriptMode.unrestricted,
                        ),
                      ),
                    ],
                  ),
                ),
                showOptions
                    ? showOptionsUI()
                    : MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: Flexible(
                          child: GridView.count(
                              padding: const EdgeInsets.only(
                                  left: constants.defaultPadding,
                                  right: constants.defaultPadding,
                                  bottom: constants.defaultPadding * 2,
                                  top: constants.defaultPadding),
                              crossAxisSpacing: constants.defaultPadding,
                              mainAxisSpacing: constants.defaultPadding,
                              crossAxisCount: 2,
                              children: List.generate(
                                titleList.length,
                                (index) => InkWell(
                                  onTap: () {
                                    setState(() {
                                      selected = index;
                                      showOptions = true;
                                    });
                                  },
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    semanticContainer: true,
                                    elevation: 6,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: constants.borderRadius),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            titleListIcon[index],
                                            size: 33,
                                            color: colorDark,
                                          ),
                                          const SizedBox(
                                            height:
                                                constants.defaultPadding / 2,
                                          ),
                                          Text(
                                            titleList[index],
                                            style: textStyle.heading.copyWith(
                                                color: colorHeadingText),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ),
                Container(
                  color: colorWhite,
                  child: NewButton(
                      margin: const EdgeInsets.only(
                          left: constants.defaultPadding,
                          right: constants.defaultPadding,
                          bottom: constants.defaultPadding,
                          top: constants.defaultPadding),
                      context: context,
                      buttonText: isStart ? "Stop Machine" : "Start Machine",
                      color: isStart ? colorError : colorSuccess,
                      function: () {
                        setState(() {
                          isStart = !isStart;
                        });
                      }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget paramsUI() {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.only(
            left: constants.defaultPadding,
            right: constants.defaultPadding,
            top: constants.defaultPadding,
            bottom: constants.defaultPadding * 2),
        semanticContainer: true,
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: colorSubHeadingText, width: 0.4),
            borderRadius: constants.borderRadius),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: constants.defaultPadding,
                    top: constants.defaultPadding / 2),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          setState(() {
                            showOptions = false;
                          });
                        },
                        child: const Icon(Icons.arrow_back_rounded)),
                    const SizedBox(
                      width: constants.defaultPadding / 2,
                    ),
                    Text(
                      titleList[selected],
                      style:
                          textStyle.heading.copyWith(color: colorHeadingText),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 0.4,
                color: colorSubHeadingText,
              ),
              Column(
                children: List.generate(paramsTitleList.length, (index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: constants.defaultPadding * 2),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            paramsTitleList[index],
                            style: textStyle.smallTextColorDark,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Slider(
                              min: 0,
                              max: paramsSliderMaxValue[index],
                              value: paramsSliderValue[index],
                              onChanged: (value) {
                                setState(() {
                                  paramsSliderValue[index] = value;
                                });
                                String link =
                                    "params?lh=${paramsSliderValue[0]}&ls=${paramsSliderValue[1]}"
                                    "&lv=${paramsSliderValue[2]}&uh=${paramsSliderValue[3]}&us="
                                    "${paramsSliderValue[4]}&uv=${paramsSliderValue[5]}";
                                updateParameterDetails(link);
                              },
                            ),
                          ),
                          Text(
                            paramsSliderValue[index].toStringAsFixed(2),
                            style: textStyle.smallText
                                .copyWith(color: colorHeadingText),
                          ),
                          const SizedBox(
                            width: constants.defaultPadding * 2,
                          ),
                        ],
                      ),
                      Divider(
                        thickness: index == paramsSliderValue.length - 1
                            ? 0.00001
                            : 0.4,
                        height: index == paramsSliderValue.length - 1
                            ? 0
                            : constants.defaultPadding,
                        color: colorSubHeadingText,
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget areaUI() {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.only(
            left: constants.defaultPadding,
            right: constants.defaultPadding,
            top: constants.defaultPadding,
            bottom: constants.defaultPadding * 2),
        semanticContainer: true,
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: colorSubHeadingText, width: 0.4),
            borderRadius: constants.borderRadius),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: constants.defaultPadding,
                    top: constants.defaultPadding / 2),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          setState(() {
                            showOptions = false;
                          });
                        },
                        child: const Icon(Icons.arrow_back_rounded)),
                    const SizedBox(
                      width: constants.defaultPadding / 2,
                    ),
                    Text(
                      titleList[selected],
                      style:
                          textStyle.heading.copyWith(color: colorHeadingText),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 0.4,
                color: colorSubHeadingText,
              ),
              Center(
                child: SfRangeSlider(
                  min: 0.0,
                  max: 50000.0,
                  values: areaValues,
                  interval: 1000,
                  showTicks: true,
                  enableTooltip: true,
                  onChanged: (SfRangeValues values) {
                    setState(() {
                      areaValues = values;
                    });
                    String link =
                        "area?minarea=${areaValues.start}&maxarea=${areaValues.end}";
                    updateParameterDetails(link);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: constants.defaultPadding * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Min : 0",
                      style: textStyle.smallTextColorDark
                          .copyWith(color: colorHeadingText),
                    ),
                    Text(
                      "Min : 50,000",
                      style: textStyle.smallTextColorDark
                          .copyWith(color: colorHeadingText),
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

  updateParameterDetails(String link) async {
    await Dio()
        .get("http://${prefs.getString(LocalStorage.enterLink)}/$link")
        .then((value) {
      customPrint("updateParameterDetails :: ${value.data}");
    });
  }

  showOptionsUI() {
    switch (titleList[selected]) {
      case "Area":
        return areaUI();
      case "Active Area":
        return activeAreaUI();
      case "Colors":
        return colorsUI();
      case "Params":
        return paramsUI();
    }
  }

  activeAreaUI() {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.only(
            left: constants.defaultPadding,
            right: constants.defaultPadding,
            top: constants.defaultPadding,
            bottom: constants.defaultPadding * 2),
        semanticContainer: true,
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: colorSubHeadingText, width: 0.4),
            borderRadius: constants.borderRadius),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: constants.defaultPadding,
                    top: constants.defaultPadding / 2),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          setState(() {
                            showOptions = false;
                          });
                        },
                        child: const Icon(Icons.arrow_back_rounded)),
                    const SizedBox(
                      width: constants.defaultPadding / 2,
                    ),
                    Text(
                      titleList[selected],
                      style:
                          textStyle.heading.copyWith(color: colorHeadingText),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 0.4,
                color: colorSubHeadingText,
              ),
              Center(
                child: SfRangeSlider(
                  min: 0.0,
                  max: 480.0,
                  values: activeAreaValues,
                  interval: 10,
                  showTicks: true,
                  enableTooltip: true,
                  onChanged: (SfRangeValues values) {
                    setState(() {
                      activeAreaValues = values;
                    });
                    String link =
                        "activearea?low=${activeAreaValues.start}&high=${activeAreaValues.end}";
                    updateParameterDetails(link);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: constants.defaultPadding * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Low : 0",
                      style: textStyle.smallTextColorDark
                          .copyWith(color: colorHeadingText),
                    ),
                    Text(
                      "High : 480",
                      style: textStyle.smallTextColorDark
                          .copyWith(color: colorHeadingText),
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

  colorsUI() {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.only(
            left: constants.defaultPadding,
            right: constants.defaultPadding,
            top: constants.defaultPadding,
            bottom: constants.defaultPadding * 2),
        semanticContainer: true,
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: colorSubHeadingText, width: 0.4),
            borderRadius: constants.borderRadius),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: constants.defaultPadding,
                    top: constants.defaultPadding / 2),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          setState(() {
                            showOptions = false;
                          });
                        },
                        child: const Icon(Icons.arrow_back_rounded)),
                    const SizedBox(
                      width: constants.defaultPadding / 2,
                    ),
                    Text(
                      titleList[selected],
                      style:
                          textStyle.heading.copyWith(color: colorHeadingText),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 0.4,
                color: colorSubHeadingText,
              ),
              Center(
                child: SfRangeSlider(
                  min: 0.0,
                  max: 255.0,
                  activeColor: colorError,
                  values: redColorValue,
                  interval: 10,
                  showTicks: true,
                  enableTooltip: true,
                  onChanged: (SfRangeValues values) {
                    setState(() {
                      redColorValue = values;
                    });
                    String link =
                        "color?rl=${redColorValue.start}&rh=${redColorValue.end}&gl=${greenColorValue.start}&gh=${greenColorValue.end}"
                        "&bl=${blueColorValue.start}&bh=${blueColorValue.end}";
                    updateParameterDetails(link);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: constants.defaultPadding * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Low : 0",
                      style: textStyle.smallTextColorDark
                          .copyWith(color: colorHeadingText),
                    ),
                    Text(
                      "High : 255",
                      style: textStyle.smallTextColorDark
                          .copyWith(color: colorHeadingText),
                    ),
                  ],
                ),
              ),
              Center(
                child: SfRangeSlider(
                  min: 0.0,
                  max: 255.0,
                  values: greenColorValue,
                  activeColor: colorSuccess,
                  interval: 10,
                  showTicks: true,
                  enableTooltip: true,
                  onChanged: (SfRangeValues values) {
                    setState(() {
                      greenColorValue = values;
                    });
                    String link =
                        "color?rl=${redColorValue.start}&rh=${redColorValue.end}&gl=${greenColorValue.start}&gh=${greenColorValue.end}"
                        "&bl=${blueColorValue.start}&bh=${blueColorValue.end}";
                    updateParameterDetails(link);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: constants.defaultPadding * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Low : 0",
                      style: textStyle.smallTextColorDark
                          .copyWith(color: colorHeadingText),
                    ),
                    Text(
                      "High : 255",
                      style: textStyle.smallTextColorDark
                          .copyWith(color: colorHeadingText),
                    ),
                  ],
                ),
              ),
              Center(
                child: SfRangeSlider(
                  min: 0.0,
                  max: 255.0,
                  values: blueColorValue,
                  activeColor: Colors.blue,
                  interval: 10,
                  showTicks: true,
                  enableTooltip: true,
                  onChanged: (SfRangeValues values) {
                    setState(() {
                      blueColorValue = values;
                    });
                    String link =
                        "color?rl=${redColorValue.start}&rh=${redColorValue.end}&gl=${greenColorValue.start}&gh=${greenColorValue.end}"
                        "&bl=${blueColorValue.start}&bh=${blueColorValue.end}";
                    updateParameterDetails(link);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: constants.defaultPadding * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Low : 0",
                      style: textStyle.smallTextColorDark
                          .copyWith(color: colorHeadingText),
                    ),
                    Text(
                      "High : 255",
                      style: textStyle.smallTextColorDark
                          .copyWith(color: colorHeadingText),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
