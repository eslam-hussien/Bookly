import 'dart:async';
import 'package:bookly_app/helper/helpers.dart';
import 'package:bookly_app/helper/valide_image.dart';
import 'package:bookly_app/models/bookly_model.dart';
import 'package:bookly_app/services/bookly_service.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../helper/image_slider.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart'
    as cirlcular;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BooklyModel? data;
  bool isFavorit = false;
  List<Marker> markers = [];
  var isValid = false;

  BooklyModel? eventData;
  Future getData() async {
    BooklyService service = BooklyService();
    eventData = await service.getApi();
  }

  @override
  void initState() {
    super.initState();

    getData().then((value) async {
      isValid = await Validator.validateImage(eventData!.trainerImg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child: getBody());
  }

  FutureBuilder getBody() {
    return FutureBuilder(
        future: getData(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
                actions: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.share_outlined)),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isFavorit = isFavorit ? false : true;
                            });
                          },
                          icon: isFavorit
                              ? const Icon(Icons.star_border)
                              : const Icon(Icons.star)),
                    ],
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    ImageSlider(eventData: eventData),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            eventData?.interest ?? 'nointerest',
                            style: const TextStyle(
                                fontSize: 18, fontFamily: 'Cairo'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            eventData?.title ?? 'notitle',
                            style: const TextStyle(
                                fontSize: 20,
                                color: Color(0xff9EA3B8),
                                fontFamily: 'Cairo'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Row(children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              color: Color(0xff9EA3B8),
                            ),
                            Container(
                              width: 8,
                            ),
                            Text(
                              DateConverter.dateTimeConverter(eventData!.date),
                              style: const TextStyle(
                                  fontSize: 16, fontFamily: 'Cairo'),
                            ),
                          ]),
                        ),
                        Row(children: [
                          Transform.rotate(
                              angle: 50 * math.pi / 180,
                              child: IconButton(
                                onPressed: () {
                                  addMarker();
                                  showDialog(
                                      context: (context),
                                      builder: (context) {
                                        return StatefulBuilder(
                                            builder: (context, newSetState) {
                                          return AlertDialog(
                                            title: const Text('Event Location'),
                                            content: GoogleMap(
                                              initialCameraPosition:
                                                  CameraPosition(
                                                      target: LatLng(
                                                          double.parse(
                                                              eventData!
                                                                  .latitude),
                                                          double.parse(
                                                              eventData!
                                                                  .longitude)),
                                                      zoom: 14),
                                              markers: markers.toSet(),
                                            ),
                                          );
                                        });
                                      });
                                },
                                icon: const Icon(Icons.push_pin_outlined,
                                    color: Color(0xff9EA3B8)),
                              )),
                          Text(
                            eventData?.address ?? 'noaddress',
                            style: const TextStyle(
                                fontSize: 16, fontFamily: 'Cairo'),
                          ),
                        ]),
                        const Divider(
                          color: Color(0xff9EA3B8),
                          height: 2,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Row(children: [
                           isValid ?
                           CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(eventData!.trainerImg),
                                  )
                                : const CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/lead1.png'),
                                  ),
                            Container(
                              width: 8,
                            ),
                            Text(
                              eventData?.trainerName ?? 'noname',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            eventData!.trainerInfo,
                            style: const TextStyle(
                                fontSize: 15, fontFamily: 'Cairo'),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(
                          color: Color(0xff9EA3B8),
                          height: 2,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Text(
                            'عن الدورة',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            eventData!.occasionDetail,
                            style: const TextStyle(
                                fontSize: 15, fontFamily: 'Cairo'),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(
                          color: Color(0xff9EA3B8),
                          height: 2,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Text(
                            'تكلفة الدورة',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (int x = 0;
                                  x < eventData!.reservationTypes.length;
                                  x++) ...[
                                Text(
                                  eventData!.reservationTypes[x]['name'],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                                Text(
                                  eventData!.reservationTypes[x]['price']
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 15, fontFamily: 'Cairo'),
                                ),
                              ]
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              bottomNavigationBar: SizedBox(
                height: 54,
                child: Container(
                  alignment: Alignment.center,
                  color: const Color(0xff703081),
                  child: const Text(
                    "قم بالحجز الآن",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                      fontSize: 18,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const cirlcular.SimpleCircularProgressBar();
          }
        });
  }

  void addMarker() => markers.add(Marker(
      markerId: const MarkerId('1'),
      position: LatLng(double.parse(eventData!.latitude),
          double.parse(eventData!.longitude)),
      infoWindow: InfoWindow(
        title: eventData!.address,
        snippet: 'Event Location',
      )));
}
