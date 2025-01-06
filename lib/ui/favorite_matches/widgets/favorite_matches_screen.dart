import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/favorites_helper.dart';
import '../../../utils/responsive.dart';
import '../../../utils/strings.dart';
import '../../core/ui/shared_widgets/cached_avatar_widget.dart';
import '../view_model/favorite_bloc.dart';
import '../view_model/favorite_state.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isTablet = ResponsiveHelper.isTablet();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
          centerTitle: true,
        ),
        body: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoaded) {
              if (state.favorites.isEmpty) {
                return Center(child: Text(AppStrings.noFavorites));
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ListView.builder(
                  itemCount: state.favorites.length,
                  itemBuilder: (context, index) {
                    final favotireMatch = state.favorites[index];
                    return InkWell(
                      onDoubleTap: () => handleFavorites(context, favotireMatch),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: ResponsiveHelper.height(isTablet ? 75 : 60),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.2),
                                  blurRadius: ResponsiveHelper.width(10),
                                  offset: Offset(0, ResponsiveHelper.height(5)),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        spacing: 5,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              favotireMatch.eventHomeTeam ?? "Home Team",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: ResponsiveHelper.fontSize(13),
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.clip,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          CachedAvatar(
                                            radius: ResponsiveHelper.width(isTablet ? 15 : 18),
                                            imageUrl: favotireMatch.homeTeamLogo.toString(),
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      spacing: ResponsiveHelper.width(1),
                                      children: [
                                        Center(
                                          child: Text(
                                            favotireMatch.eventHalftimeResult == ''
                                                ? 'vs'
                                                : favotireMatch.eventFinalResult != "-"
                                                    ? favotireMatch.eventFinalResult!
                                                    : favotireMatch.eventHalftimeResult!,
                                            style: TextStyle(
                                              color: Color(0xff820002),
                                              fontWeight: FontWeight.w700,
                                              fontSize: ResponsiveHelper.fontSize(15),
                                            ),
                                          ),
                                        ),
                                        favotireMatch.eventStatus == ""
                                            ? SizedBox()
                                            : Center(
                                                child: Text(
                                                  "${favotireMatch.eventStatus}'",
                                                  style: TextStyle(
                                                    color: Colors.black.withOpacity(0.7),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: ResponsiveHelper.fontSize(12),
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        spacing: 5,
                                        children: [
                                          CachedAvatar(
                                            imageUrl: favotireMatch.awayTeamLogo.toString(),
                                            radius: ResponsiveHelper.width(isTablet ? 15 : 18),
                                          ),
                                          Flexible(
                                            child: Text(
                                              favotireMatch.eventAwayTeam.toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: ResponsiveHelper.fontSize(13),
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.clip,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
