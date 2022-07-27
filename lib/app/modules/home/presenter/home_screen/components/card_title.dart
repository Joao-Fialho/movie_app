import 'package:flutter/material.dart';

import '../../../../../../core/app_colors.dart';
import '../../../../../../core/app_image.dart';
import '../../../../../../core/app_strings.dart';
import '../../../../../../core/formatted_date.dart';
import '../../../../../../core/themes/app_text_theme.dart';

class CardTitle extends StatefulWidget {
  final String posterURL;
  final String releaseDate;
  final String mediaType;
  final String title;
  final double averageScore;

  const CardTitle({
    Key? key,
    required this.posterURL,
    required this.releaseDate,
    this.mediaType = '',
    required this.title,
    required this.averageScore,
  }) : super(key: key);

  @override
  State<CardTitle> createState() => _CardTitleState();
}

class _CardTitleState extends State<CardTitle> {
  bool isFavorite = false;
  bool isMediaType = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context).colorScheme;
    if (widget.mediaType == 'movie' || widget.mediaType == 'tv') {
      isMediaType = true;
    } else {
      isMediaType = false;
    }

    return Container(
      height: size.width * 0.46,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Poster Do Filme/Serie
          SizedBox(
            width: size.width * 0.3,
            height: size.width * 0.46,
            child: Image.network(
              '${AppImage.posterMoviesAndSeries}${widget.posterURL}',
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    color: theme.onPrimary,
                  ),
                );
              },
              fit: BoxFit.cover,
            ),
          ),

          //Titulo do Movie/Serie, Data de Lançamento
          SizedBox(
            width: size.width * 0.37,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontSize: size.width * 0.04),
                ),

                Text(
                  '${AppStrings.release}${FormattedDate.dateFormatter(widget.releaseDate)}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: size.width * 0.04),
                ),

                //Tipo de Midia no All
                isMediaType == true
                    ? Icon(
                        widget.mediaType == 'tv'
                            ? Icons.live_tv_rounded
                            : Icons.local_movies_outlined,
                        color: theme.onPrimary,
                      )
                    : Container(),
              ],
            ),
          ),

          //Favorite e Score do filme ou da serie
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.width * 0.05),
                child: IconButton(
                  iconSize: size.width * 0.082,
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  splashColor: Colors.transparent,
                  icon: Icon(
                    isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: isFavorite ? theme.onSecondary : theme.onPrimary,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: size.width * 0.11,
                width: size.width * 0.16,
                decoration: BoxDecoration(
                  color: theme.secondary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Text(
                  widget.averageScore.toStringAsFixed(1),
                  style:
                      appTextTheme.titleSmall?.copyWith(color: theme.onSurface),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
