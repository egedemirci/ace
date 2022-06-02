import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/add_post.dart';
import 'package:project_ace/page_routes/feed.dart';
import 'package:project_ace/page_routes/messages.dart';
import 'package:project_ace/page_routes/own_profile_view.dart';
import 'package:project_ace/page_routes/profile_view.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/templates/searchResults.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:provider/provider.dart';

class FirestoreSearch extends StatefulWidget {
  const FirestoreSearch({Key? key, required this.analytics}) : super(key: key);

  static const String routeName = "/firestore_search";
  final FirebaseAnalytics analytics;

  @override
  State<FirestoreSearch> createState() => _FirestoreSearchState();
}

class _FirestoreSearchState extends State<FirestoreSearch> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    setCurrentScreen(widget.analytics, "Search View", "search.dart");
    setUserId(widget.analytics, user!.uid);
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: AppColors.welcomeScreenBackgroundColor,
          child: SizedBox(
            height: 78, //screenHeight(context) * 0.25,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    tooltip: "Messages",
                    iconSize: screenWidth(context) * 0.08,
                    icon: const Icon(
                      Icons.email,
                      color: AppColors.bottomNavigationBarIconOutlineColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, MessageScreen.routeName);
                    },
                    splashRadius: screenWidth(context) * 0.07,
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: "Search",
                    iconSize: screenWidth(context) * 0.08,
                    icon: const Icon(
                      Icons.search,
                      color: AppColors.bottomNavigationBarIconOutlineColor,
                    ),
                    onPressed: () {},
                    splashRadius: screenWidth(context) * 0.07,
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: "Home",
                    iconSize: screenWidth(context) * 0.08,
                    icon: const Icon(
                      Icons.home,
                      color: AppColors.bottomNavigationBarIconOutlineColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Feed.routeName, (route) => false);
                    },
                    splashRadius: screenWidth(context) * 0.07,
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: "Add Post",
                    iconSize: screenWidth(context) * 0.08,
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: AppColors.bottomNavigationBarIconOutlineColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, AddPost.routeName);
                    },
                    splashRadius: screenWidth(context) * 0.07,
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: "Profile",
                    iconSize: screenWidth(context) * 0.08,
                    icon: const Icon(
                      Icons.person_outline,
                      color: AppColors.bottomNavigationBarIconOutlineColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, OwnProfileView.routeName, (route) => false);
                    },
                    splashRadius: screenWidth(context) * 0.07,
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: AppColors.searchScreenBackground,
        body: FirestoreSearchScaffold(
          searchIconColor: AppColors.profileScreenTextColor,
          appBarTitle: "Search",
          backButtonColor: AppColors.profileScreenTextColor,
          searchBodyBackgroundColor: AppColors.searchScreenBackground,
          appBarBackgroundColor: AppColors.searchScreenBackground,
          appBarTitleColor: AppColors.profileScreenTextColor,
          firestoreCollectionName: 'Users',
          searchBy: 'usernameLower',
          scaffoldBody: Container(
              color: AppColors.searchScreenBackground,
              child: const Center(
                  child: Text("Relevant topics will be shown here."))),
          dataListFromSnapshot: SearchResults().dataListFromSnapshot,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<SearchResults>? dataList = snapshot.data;
              if (dataList!.isEmpty) {
                return const Center(
                  child: Text('No Results Returned'),
                );
              }
              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    final SearchResults data = dataList[index];
                    return OutlinedButton(
                      onPressed: () {
                        if (data.userId! == user.uid) {
                          Navigator.pushNamedAndRemoveUntil(context,
                              OwnProfileView.routeName, (route) => false);
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileView(
                                      userId: data.userId!,
                                      analytics: widget.analytics)));
                        }
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: CircleAvatar(
                              radius: screenHeight(context) * 0.05,
                              backgroundImage: NetworkImage(data.avatarURL !=
                                      "default"
                                  ? data.avatarURL!
                                  : "https://minervastrategies.com/wp-content/uploads/2016/03/default-avatar.jpg"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "${data.fullName}",
                              style: searchResults,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "${data.username}",
                              style: searchResults,
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (!snapshot.hasData) {
                return const Center(
                  child: Text('No Results Returned'),
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
