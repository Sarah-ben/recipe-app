import 'package:receipeapp/models/countryModel/country_model.dart';

class AppStates{}
class InitialApp extends AppStates{}
class ChangeAppTheme extends AppStates{}
class ChangeBottomNAvBarState extends AppStates{}
class GetDataSuccess extends AppStates{
  final CountryModel countryModel;
  GetDataSuccess( this.countryModel);
}
class GetDataLoading extends AppStates{}
class GetMealPerArea extends AppStates{}
class GetMealSuccess extends AppStates{}
class GetCategoriesSuccess extends AppStates{}
class AddToFav extends AppStates{}
class RemoveFromFav extends AppStates{}
class GetUserData extends AppStates{}
class SearchLoadingState extends AppStates{}
class SearchSuccessState extends AppStates{}
class SearchErrorState extends AppStates{}
class RatingState extends AppStates{}
class GetAllRates extends AppStates{}

