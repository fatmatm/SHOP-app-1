import '../../models/favioritesModel.dart';

abstract class shopStates {}
class shopIntialState extends shopStates{}
class shopchangeBottomNavBar extends shopStates{}

class shopLoadingState extends shopStates{}
class shopSucessState extends shopStates{}
class shoperrorState extends shopStates{}
class shopSucessCategoriesState extends shopStates{}
class shoperrorCategoriesState extends shopStates{}

class shopLoadingFavvorietsState extends shopStates{}
class shopSucessFavvorietsState extends shopStates{
  late final ChangeFavoriets model;

  shopSucessFavvorietsState(this.model);


}
class shoperrorFavvorietsState extends shopStates{}

class shopChangeFavvorietsState extends shopStates{}

class shopSucessFavState extends shopStates{}
class shoperrorFavState extends shopStates{}

class GetUserDataSucsess_state extends shopStates{

}
class GetUserDataLoading_state extends shopStates{

}
class GetUserDataError_state extends shopStates{

}