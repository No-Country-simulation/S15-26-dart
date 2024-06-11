import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class FlutterMapZoomButtons extends StatelessWidget {
  final MapController mapController;
  final double minZoom;
  final double maxZoom;
  final bool mini;
  final double padding;
  final Alignment alignment;
  final Color? zoomInColor;
  final Color? zoomInColorIcon;
  final Color? zoomOutColor;
  final Color? zoomOutColorIcon;
  final IconData zoomInIcon;
  final IconData zoomOutIcon;

  const FlutterMapZoomButtons({
    super.key,
    required this.mapController,
    this.minZoom = 1,
    this.maxZoom = 18,
    this.mini = true,
    this.padding = 2.0,
    this.alignment = Alignment.topRight,
    this.zoomInColor,
    this.zoomInColorIcon,
    this.zoomInIcon = Icons.zoom_in,
    this.zoomOutColor,
    this.zoomOutColorIcon,
    this.zoomOutIcon = Icons.zoom_out,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.only(left: padding, top: padding, right: padding),
            child: FloatingActionButton(
              heroTag: 'zoomInButton',
              mini: mini,
              backgroundColor: zoomInColor ?? Theme.of(context).primaryColor,
              onPressed: () {
                var zoom = mapController.camera.zoom + 1;
                if (zoom > maxZoom) {
                  zoom = maxZoom;
                }
                mapController.move(mapController.camera.center, zoom);
              },
              child: Icon(
                zoomInIcon,
                color: zoomInColorIcon ?? IconTheme.of(context).color,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(padding),
            child: FloatingActionButton(
              heroTag: 'zoomOutButton',
              mini: mini,
              backgroundColor: zoomOutColor ?? Theme.of(context).primaryColor,
              onPressed: () {
                var zoom = mapController.camera.zoom - 1;
                if (zoom < minZoom) {
                  zoom = minZoom;
                }
                mapController.move(mapController.camera.center, zoom);
              },
              child: Icon(
                zoomOutIcon,
                color: zoomOutColorIcon ?? IconTheme.of(context).color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
