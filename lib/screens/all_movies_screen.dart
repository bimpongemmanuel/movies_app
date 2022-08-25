import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:my_movie_app/Models/movies_models.dart';
import 'package:my_movie_app/network/all_movies_network.dart';
import 'package:my_movie_app/screens/movie_details_screen.dart';

class AllMoviesScreen extends StatefulWidget {
  const AllMoviesScreen({Key? key}) : super(key: key);

  @override
  State<AllMoviesScreen> createState() => _AllMoviesScreenState();
}

class _AllMoviesScreenState extends State<AllMoviesScreen> {

  final AllMoviesNetwork _allMoviesNetwork = AllMoviesNetwork();

  Future<List<MoviesModel>>? getMovies;

  @override
  void initState() {
   getMovies = _allMoviesNetwork.getAllMovies();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE8E7E7),
      appBar: allMoviesAppBar(context),
      body: FutureBuilder<List<MoviesModel>>(
        future: getMovies,
        builder: (context,AsyncSnapshot <List<MoviesModel>> snapshot) {
          if(snapshot.hasData){
              return ListView.builder(
            itemCount:snapshot.data!.length,
            itemBuilder:(context,index) {
              return GestureDetector(
                child: MyMoviesCard(
                allMovies:snapshot.data![index],
                ),
                onTap: (){
                  Navigator.push(
                    context,
                     MaterialPageRoute(
                      builder: (context) {
                    return MovieDetailsScreen(
                      currentIndex: index,
                      );
                  },));
                },
                );
            }
          );
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          
        }
      ),
    );
  }

  AppBar allMoviesAppBar(BuildContext context) {
    return AppBar(
      title:Text( 'Timeline',
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),),
      backgroundColor: Colors.grey.withOpacity(0.5),
      elevation: 0,
      );
  }
}

class MyMoviesCard extends StatelessWidget {
   MyMoviesCard({
    Key? key, this.allMovies
  }) : super(key: key);
      
      MoviesModel? allMovies;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: MediaQuery.of(context).size.height/2.5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Text(allMovies!.title!),
                  Icon(Icons.more_horiz)
                ],
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(allMovies!.movieBanner!,),
                    fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(20),
                     color: Colors.grey[200],
                     boxShadow:[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 5,
                        spreadRadius: 5,
                        offset: const Offset(0,5),
                      )
                     ],
                  ),
                ),
              ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: const [
                  Icon(FeatherIcons.heart),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(FeatherIcons.messageCircle),
                  ),
                  Icon(FeatherIcons.cornerUpRight)
                ],),
                Row(children: [
                  const Icon(FeatherIcons.star),
                  Text(allMovies!.rtScore!)
                ],)
              ],
             )
            ],
          ),
        ),
      ),
    );
  }
}