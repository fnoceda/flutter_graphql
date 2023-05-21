import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final String getAlbums = """
                                query getAlbums{
                                  albums(options:{
                                    paginate:{
                                      page:1, 
                                      limit: 10
                                    }
                                  }){
                                    data{
                                      id
                                      title
                                      user{
                                        name
                                        username
                                        email
                                      }
                                    }
                                  }
                                }
                            """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Query(
        options: QueryOptions(document: gql(getAlbums)),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            if (kDebugMode) print(result.exception.toString());
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          List? albums = result.data?['albums']['data'];

          if (kDebugMode) print(albums);

          if (albums == null) {
            return const Text('No repositories');
          }

          // return Container();

          return ListView.separated(
            key: const Key('ListView.key'),
            itemCount: albums.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final album = albums[index];

              return ListTile(
                key: Key('ListView.key.${album['id']}'),
                title: Text(album['title'] ?? 'name'),
              );
            },
          );
        },
      ),
    );
  }
}
