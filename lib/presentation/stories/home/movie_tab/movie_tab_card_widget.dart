import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:popcorn/common/constants/route_constants.dart';
import 'package:popcorn/common/constants/size_constants.dart';
import 'package:popcorn/common/extensions/size_extension.dart';
import 'package:popcorn/common/extensions/string_extension.dart';
import 'package:popcorn/data/core/api_constants.dart';
import 'package:popcorn/presentation/stories/movie_detail.dart/movie_detail_arguments.dart';
import 'package:popcorn/presentation/stories/movie_detail.dart/movie_detail_screen.dart';

class MovieTabCard extends StatelessWidget {
  final int movieId;
  final String title;
  final  String  posterPath;

  const MovieTabCard({Key? key,
  required  this.movieId,
  required  this.title,
  required  this.posterPath}) :
  assert(movieId !=null,'movieId shouldnt be null'),
  assert(title !=null,'title shouldnt be null'),
  assert(posterPath !=null,'posterpath shouldnt be null'),

   super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
            Navigator.of(context).pushNamed(RouteList.movieDetail,arguments: MovieDetailArguments(movieId));
      },
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       Expanded(child: ClipRRect(
         borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
         child: CachedNetworkImage(imageUrl: '${ApiConstants.BASE_IMAGE_URL}$posterPath',fit:BoxFit.cover,),
         
       ),
       ),
      
       Padding(padding: EdgeInsets.only(top:Sizes.dimen_4.h),
       child: Text(
         title.intelliTrim(),
         maxLines: 1,
         textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyText2,
       ),)

      ],  
        
      ),
    );
  }
}