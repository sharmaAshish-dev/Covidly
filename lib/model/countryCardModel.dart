class CountryModel {
  String countryName;
  String countryCode;
  int totalCases;
  String flagPath;
  String countrySlug;

  CountryModel({this.countrySlug, this.flagPath, this.totalCases, this.countryName, this.countryCode});
}
