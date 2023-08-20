import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class KakaoMapPage extends StatefulWidget {
  final String? title;

  KakaoMapPage({Key? key, this.title}) : super(key: key);

  @override
  _KakaoMapPageState createState() => _KakaoMapPageState();
}

class _KakaoMapPageState extends State<KakaoMapPage> {
  KakaoMapController? mapController;

  Set<Circle> circles = {};
  Set<Polyline> polylines = {};
  Set<Polygon> polygons = {};
  Set<Rectangle> rectangles = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? 'Selected Title'),
      ),
      body: KakaoMap(
        onMapCreated: ((controller) async {
          mapController = controller;

          // ... Add your Circle, Polyline, Polygon, and Rectangle configurations here ...
          circles.add(
            Circle(
              circleId: circles.length.toString(),
              center: LatLng(33.450701, 126.570667),
              strokeWidth: 5,
              strokeColor: Colors.red,
              strokeOpacity: 0.5,
              strokeStyle: StrokeStyle.longDashDotDot,
              fillColor: Colors.black,
              fillOpacity: 0.7,
              radius: 50,
            ),
          );

          polylines.add(
            Polyline(
              polylineId: 'polyline_${polylines.length}',
              points: [
                LatLng(33.452344169439975, 126.56878163224233),
                LatLng(33.452739313807456, 126.5709308145358),
                LatLng(33.45178067090639, 126.5726886938753)
              ],
              strokeColor: Colors.purple,
            ),
          );

          polygons.add(
            Polygon(
              polygonId: 'polygon_${polygons.length}',
              points: [
                LatLng(33.45133510810506, 126.57159381623066),
                LatLng(33.44955812811862, 126.5713551811832),
                LatLng(33.449986291544086, 126.57263296172184),
                LatLng(33.450682513554554, 126.57321034054742),
                LatLng(33.451346760004206, 126.57235740081413)
              ],
              strokeWidth: 4,
              strokeColor: Colors.blue,
              strokeOpacity: 1,
              strokeStyle: StrokeStyle.shortDashDot,
              fillColor: Colors.black,
              fillOpacity: 0.3,
            ),
          );

          rectangles.add(
            Rectangle(
              rectangleId: 'rectangle_${rectangles.length}',
              rectangleBounds: LatLngBounds(
                LatLng(33.42133510810506, 126.53159381623066),
                LatLng(33.44955812811862, 126.5713551811832),
              ),
              strokeWidth: 6,
              strokeColor: Colors.blue,
              strokeOpacity: 1,
              strokeStyle: StrokeStyle.dot,
              fillColor: Colors.black,
              fillOpacity: 0.7,
            ),
          );
          setState(() {});
        }),
        circles: circles.toList(),
        polylines: polylines.toList(),
        polygons: polygons.toList(),
        rectangles: rectangles.toList(),
        center: LatLng(33.450701, 126.570667),
      ),
    );
  }
}
