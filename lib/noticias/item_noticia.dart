import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:noticias/models/noticia.dart';

class ItemNoticia extends StatelessWidget {
  final Noticia noticia;
  ItemNoticia({Key key, @required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(6),
        child: Card(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              //DONE: cambiar image.network por Extended Image con place holder en caso de error o en caso de que esté cargando la imagen
              Expanded(
                flex: 1,
                child: ExtendedImage.network(
                  "${noticia.urlToImage}",
                  height: 100,
                  fit: BoxFit.cover,
                  loadStateChanged: (ExtendedImageState state) {
                    switch (state.extendedImageLoadState) {
                      case LoadState.loading:
                        return Image.asset(
                          "assets/loading.gif",
                          fit: BoxFit.cover,
                        );
                        break;
                      case LoadState.completed:
                        return Image.network(
                          "${noticia.urlToImage}",
                          height: 100,
                          fit: BoxFit.cover,
                        );
                        break;
                      case LoadState.failed:
                        return Image.asset(
                          "assets/fallar.png",
                          fit: BoxFit.fill,
                        );
                        break;
                    }
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${noticia.title}",
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "${noticia.publishedAt}",
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "${noticia.description ?? "Descripción no disponible"}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "${noticia.author ?? "Autor no disponible"}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
