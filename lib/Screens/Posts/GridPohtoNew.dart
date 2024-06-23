import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridNewPhoto extends StatefulWidget {
  const GridNewPhoto({super.key, required this.photoMulti2});
final photoMulti2;
  @override
  State<GridNewPhoto> createState() => _GridNewPhotoState();
}

class _GridNewPhotoState extends State<GridNewPhoto> {
  @override
  Widget build(BuildContext context) {
    return  StaggeredGrid.count(
          crossAxisCount: 12,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          children: [
                              for (var i = 0; i < widget.photoMulti2.length; i++)

              StaggeredGridTile.count(
                crossAxisCellCount: i == 0 ? 8: 4,
                mainAxisCellCount: i == 0 ? 8 : 4,
                child: Center(
                  child: i < widget.photoMulti2.length? Image.network(
                    widget.photoMulti2[i]['image'],
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ):Tile(index: i++),
                ),
              ),
          ],
        );
  }
}


class Tile extends StatelessWidget {
  final int index;

  const Tile({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Center(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text('$index'),
        ),
      ),
    );
  }
}