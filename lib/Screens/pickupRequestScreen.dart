import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khanintlexpress/Global/global.dart';
import 'package:khanintlexpress/Screens/homeScreen.dart';

import '../Api/sheets/user_sheets_api.dart';
import '../AppBar/customAppBar.dart';
import '../Widgets/FromHelper.dart';
import '../Widgets/loading_dialog.dart';
import '../Widgets/progress_dialog.dart';

TextEditingController nameTextEditingController = new TextEditingController();
TextEditingController addressTextEditingController = new TextEditingController();
TextEditingController weightTextEditingController = new TextEditingController();

String? country;

double final_value = 0.0;

final value = new NumberFormat("#,##0", "en_US");

class PickupRequestScreen extends StatefulWidget {
  const PickupRequestScreen({Key? key}) : super(key: key);

  @override
  State<PickupRequestScreen> createState() => _PickupRequestScreenState();
}

class _PickupRequestScreenState extends State<PickupRequestScreen> {
  @override
  Widget build(BuildContext context) {
    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    if(FirebaseAuth.instance.currentUser == null){
      return Scaffold(
        appBar: CustomAppBar(),
        body: Center(
          child: Text(
            'Please login to send pickup request',
          ),
        ),
      );
    }
    else {
      return Scaffold(
        appBar: CustomAppBar(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return const PickupRequestMobile();
            } else
            if (constraints.maxWidth > 600 && constraints.maxWidth < 900) {
              return const PickupRequestMobile();
            } else {
              return const PickupRequestDesktop();
            }
          },
        ),
      );
    }
  }
}

class PickupRequestMobile extends StatefulWidget {
  const PickupRequestMobile({Key? key}) : super(key: key);

  @override
  State<PickupRequestMobile> createState() => _PickupRequestMobileState();
}

class _PickupRequestMobileState extends State<PickupRequestMobile> {

  String dropdownvalue = '';

// List of items in our dropdown menu
  var items = [
    '3 to 4 working days',
    '4 to 5 working days',
  ];

  List<dynamic> dhl_countries = [];
  List<dynamic> fedex_countries = [];
  List<dynamic> weights = [];
  String? dhl_countryId;
  String? fedex_countryId;
  String? weightId;

  int _value = 0;
  //String _country = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    UserSheetsApi.init();

    getFedexCountries();

    getDhlCountries();
  }

  void getDhlCountries() {
    dhl_countries.add({"id": 1, "country": "Afghanistan"});
    dhl_countries.add({"id": 2, "country": "Albania"});
    dhl_countries.add({"id": 3, "country": "Algeria"});
    dhl_countries.add({"id": 4, "country": "American Samoa"});
    dhl_countries.add({"id": 5, "country": "Andorra"});
    dhl_countries.add({"id": 6, "country": "Angola"});
    dhl_countries.add({"id": 7, "country": "Anguilla"});
    dhl_countries.add({"id": 8, "country": "Antigua"});
    dhl_countries.add({"id": 9, "country": "Argentina"});
    dhl_countries.add({"id": 10, "country": "Armenia"});
    dhl_countries.add({"id": 11, "country": "Aruba"});
    dhl_countries.add({"id": 12, "country": "Australia"});
    dhl_countries.add({"id": 13, "country": "Austria"});
    dhl_countries.add({"id": 14, "country": "Azerbaijan"});
    dhl_countries.add({"id": 15, "country": "Bahamas"});
    dhl_countries.add({"id": 16, "country": "Bahrain"});
    dhl_countries.add({"id": 17, "country": "Barbados"});
    dhl_countries.add({"id": 18, "country": "Belarus"});
    dhl_countries.add({"id": 19, "country": "Belgium"});
    dhl_countries.add({"id": 20, "country": "Belize"});
    dhl_countries.add({"id": 21, "country": "Benin"});
    dhl_countries.add({"id": 22, "country": "Bermuda"});
    dhl_countries.add({"id": 23, "country": "Bhutan"});
    dhl_countries.add({"id": 24, "country": "Bolivia"});
    dhl_countries.add({"id": 25, "country": "Bonaire"});
    dhl_countries.add({"id": 26, "country": "Bosnia and Herzegovina"});
    dhl_countries.add({"id": 27, "country": "Botswana"});
    dhl_countries.add({"id": 28, "country": "Brazil"});
    dhl_countries.add({"id": 29, "country": "Brunei"});
    dhl_countries.add({"id": 30, "country": "Bulgaria"});
    dhl_countries.add({"id": 31, "country": "Burkina Faso"});
    dhl_countries.add({"id": 32, "country": "Burundi"});
    dhl_countries.add({"id": 33, "country": "Cambodia"});
    dhl_countries.add({"id": 34, "country": "Cameroon"});
    dhl_countries.add({"id": 35, "country": "Canada"});
    dhl_countries.add({"id": 36, "country": "Canary Islands"});
    dhl_countries.add({"id": 37, "country": "Cape Verde"});
    dhl_countries.add({"id": 38, "country": "Cayman Islands"});
    dhl_countries.add({"id": 39, "country": "Central African Republic"});
    dhl_countries.add({"id": 40, "country": "Chad"});
    dhl_countries.add({"id": 41, "country": "Chile"});
    dhl_countries.add({"id": 42, "country": "China, People's Republic"});
    dhl_countries.add({"id": 43, "country": "Colombia"});
    dhl_countries.add({"id": 44, "country": "Mariana Islands"});
    dhl_countries.add({"id": 45, "country": "Comoros"});
    dhl_countries.add({"id": 46, "country": "Congo"});
    dhl_countries.add({"id": 47, "country": "Congo, The Democratic Republic"});
    dhl_countries.add({"id": 48, "country": "Cook Islands"});
    dhl_countries.add({"id": 49, "country": "Costa Rica"});
    dhl_countries.add({"id": 50, "country": "Cote d'Ivoire"});
    dhl_countries.add({"id": 51, "country": "Croatia"});
    dhl_countries.add({"id": 52, "country": "Cuba"});
    dhl_countries.add({"id": 53, "country": "Curacao"});
    dhl_countries.add({"id": 54, "country": "Cyprus"});
    dhl_countries.add({"id": 55, "country": "Czech Republic"});
    dhl_countries.add({"id": 56, "country": "Denmark"});
    dhl_countries.add({"id": 57, "country": "Djibouti"});
    dhl_countries.add({"id": 58, "country": "Dominica"});
    dhl_countries.add({"id": 59, "country": "Dominican Republic"});
    dhl_countries.add({"id": 60, "country": "East Timor"});
    dhl_countries.add({"id": 61, "country": "Ecuador"});
    dhl_countries.add({"id": 62, "country": "Egypt"});
    dhl_countries.add({"id": 63, "country": "El Salvador"});
    dhl_countries.add({"id": 64, "country": "Eritrea"});
    dhl_countries.add({"id": 65, "country": "Estonia"});
    dhl_countries.add({"id": 66, "country": "Ethiopia"});
    dhl_countries.add({"id": 67, "country": "Falkland Islands"});
    dhl_countries.add({"id": 68, "country": "Faroe Islands"});
    dhl_countries.add({"id": 69, "country": "Fiji"});
    dhl_countries.add({"id": 70, "country": "Finland"});
    dhl_countries.add({"id": 71, "country": "France"});
    dhl_countries.add({"id": 72, "country": "French Guyana"});
    dhl_countries.add({"id": 73, "country": "Gabon"});
    dhl_countries.add({"id": 74, "country": "Gambia"});
    dhl_countries.add({"id": 75, "country": "Georgia"});
    dhl_countries.add({"id": 76, "country": "Germany"});
    dhl_countries.add({"id": 77, "country": "Ghana"});
    dhl_countries.add({"id": 78, "country": "Gibraltar"});
    dhl_countries.add({"id": 79, "country": "Greece"});
    dhl_countries.add({"id": 80, "country": "Greenland"});
    dhl_countries.add({"id": 81, "country": "Grenada"});
    dhl_countries.add({"id": 82, "country": "Guadeloupe"});
    dhl_countries.add({"id": 83, "country": "Guam"});
    dhl_countries.add({"id": 84, "country": "Guatemala"});
    dhl_countries.add({"id": 85, "country": "Guernsey"});
    dhl_countries.add({"id": 86, "country": "Guinea Republic"});
    dhl_countries.add({"id": 87, "country": "Guinea-Bissau"});
    dhl_countries.add({"id": 88, "country": "Guinea-Equatorial"});
    dhl_countries.add({"id": 89, "country": "Guyana (British)"});
    dhl_countries.add({"id": 90, "country": "Haiti"});
    dhl_countries.add({"id": 91, "country": "Honduras"});
    dhl_countries.add({"id": 92, "country": "Hong Kong"});
    dhl_countries.add({"id": 93, "country": "Hungary"});
    dhl_countries.add({"id": 94, "country": "Iceland"});
    dhl_countries.add({"id": 95, "country": "India"});
    dhl_countries.add({"id": 96, "country": "Indonesia"});
    dhl_countries.add({"id": 97, "country": "Iran"});
    dhl_countries.add({"id": 98, "country": "Iraq"});
    dhl_countries.add({"id": 99, "country": "Ireland"});
    dhl_countries.add({"id": 100, "country": "Israel"});
    dhl_countries.add({"id": 101, "country": "Italy"});
    dhl_countries.add({"id": 102, "country": "Ivory Coast"});
    dhl_countries.add({"id": 103, "country": "Jamaica"});
    dhl_countries.add({"id": 104, "country": "Japan"});
    dhl_countries.add({"id": 105, "country": "Jersey"});
    dhl_countries.add({"id": 106, "country": "Jordan"});
    dhl_countries.add({"id": 107, "country": "Kazakhstan"});
    dhl_countries.add({"id": 108, "country": "Kenya"});
    dhl_countries.add({"id": 109, "country": "Kiribati"});
    dhl_countries.add({"id": 110, "country": "Korea, D.P.R."});
    dhl_countries.add({"id": 111, "country": "Korea, Republic"});
    dhl_countries.add({"id": 112, "country": "KOSOVO"});
    dhl_countries.add({"id": 113, "country": "Kuwait"});
    dhl_countries.add({"id": 114, "country": "Kyrgyzstan"});
    dhl_countries.add({"id": 115, "country": "Lao People's Democratic Republic"});
    dhl_countries.add({"id": 116, "country": "Latvia"});
    dhl_countries.add({"id": 117, "country": "Lebanon"});
    dhl_countries.add({"id": 118, "country": "Lesotho"});
    dhl_countries.add({"id": 119, "country": "Liberia"});
    dhl_countries.add({"id": 120, "country": "Libya"});
    dhl_countries.add({"id": 121, "country": "Liechtenstein"});
    dhl_countries.add({"id": 122, "country": "Lithuania"});
    dhl_countries.add({"id": 123, "country": "Luxembourg"});
    dhl_countries.add({"id": 124, "country": "Macau"});
    dhl_countries.add({"id": 125, "country": "Macedonia"});
    dhl_countries.add({"id": 126, "country": "Madagascar"});
    dhl_countries.add({"id": 127, "country": "Malawi"});
    dhl_countries.add({"id": 128, "country": "Malaysia"});
    dhl_countries.add({"id": 129, "country": "Maldives"});
    dhl_countries.add({"id": 130, "country": "Mali"});
    dhl_countries.add({"id": 131, "country": "Malta"});
    dhl_countries.add({"id": 132, "country": "Marshall Islands"});
    dhl_countries.add({"id": 133, "country": "Martinique"});
    dhl_countries.add({"id": 134, "country": "Mauritania"});
    dhl_countries.add({"id": 135, "country": "Mauritius"});
    dhl_countries.add({"id": 136, "country": "Mayotte"});
    dhl_countries.add({"id": 137, "country": "Mexico"});
    dhl_countries.add({"id": 138, "country": "MICRONESIA"});
    dhl_countries.add({"id": 139, "country": "Moldova"});
    dhl_countries.add({"id": 140, "country": "Monaco"});
    dhl_countries.add({"id": 141, "country": "Mongolia"});
    dhl_countries.add({"id": 142, "country": "Montserrat"});
    dhl_countries.add({"id": 143, "country": "Morocco"});
    dhl_countries.add({"id": 144, "country": "Mozambique"});
    dhl_countries.add({"id": 145, "country": "Myanmar"});
    dhl_countries.add({"id": 146, "country": "Namibia"});
    dhl_countries.add({"id": 147, "country": "Nauru"});
    dhl_countries.add({"id": 148, "country": "Nepal"});
    dhl_countries.add({"id": 149, "country": "NETHERLANDS ANTILLES"});
    dhl_countries.add({"id": 150, "country": "Netherlands"});
    dhl_countries.add({"id": 151, "country": "Nevis"});
    dhl_countries.add({"id": 152, "country": "New Caledonia"});
    dhl_countries.add({"id": 153, "country": "New Zealand"});
    dhl_countries.add({"id": 154, "country": "Nicaragua"});
    dhl_countries.add({"id": 155, "country": "Niger"});
    dhl_countries.add({"id": 156, "country": "Nigeria"});
    dhl_countries.add({"id": 157, "country": "Niue"});
    dhl_countries.add({"id": 158, "country": "Norway"});
    dhl_countries.add({"id": 159, "country": "North macedonia(mk)"});
    dhl_countries.add({"id": 160, "country": "Oman"});
    dhl_countries.add({"id": 161, "country": "Pakistan"});
    dhl_countries.add({"id": 162, "country": "PALAU"});
    dhl_countries.add({"id": 163, "country": "Panama"});
    dhl_countries.add({"id": 164, "country": "Papua New Guinea"});
    dhl_countries.add({"id": 165, "country": "Paraguay"});
    dhl_countries.add({"id": 166, "country": "Peru"});
    dhl_countries.add({"id": 167, "country": "Philippines"});
    dhl_countries.add({"id": 168, "country": "Poland"});
    dhl_countries.add({"id": 169, "country": "Portugal"});
    dhl_countries.add({"id": 170, "country": "Puerto Rico"});
    dhl_countries.add({"id": 171, "country": "Qatar"});
    dhl_countries.add({"id": 172, "country": "Reunion, Island"});
    dhl_countries.add({"id": 173, "country": "Romania"});
    dhl_countries.add({"id": 174, "country": "Russian Federation"});
    dhl_countries.add({"id": 175, "country": "Rwanda"});
    dhl_countries.add({"id": 176, "country": "Saipan"});
    dhl_countries.add({"id": 177, "country": "Samoa"});
    dhl_countries.add({"id": 178, "country": "SAN MARINO"});
    dhl_countries.add({"id": 179, "country": "Sao Tome & Principe"});
    dhl_countries.add({"id": 180, "country": "Saudi Arabia"});
    dhl_countries.add({"id": 181, "country": "Senegal"});
    dhl_countries.add({"id": 182, "country": "Serbia & Montenegro"});
    dhl_countries.add({"id": 183, "country": "Seychelles"});
    dhl_countries.add({"id": 184, "country": "Sierra Leone"});
    dhl_countries.add({"id": 185, "country": "Singapore"});
    dhl_countries.add({"id": 186, "country": "Slovakia"});
    dhl_countries.add({"id": 187, "country": "Slovenia"});
    dhl_countries.add({"id": 188, "country": "Solomon Islands"});
    dhl_countries.add({"id": 189, "country": "Somalia"});
    dhl_countries.add({"id": 190, "country": "Somaliland"});
    dhl_countries.add({"id": 191, "country": "South Africa"});
    dhl_countries.add({"id": 192, "country": "Spain"});
    dhl_countries.add({"id": 193, "country": "Sri Lanka"});
    dhl_countries.add({"id": 194, "country": "St Helena"});
    dhl_countries.add({"id": 195, "country": "St. Barthelemy"});
    dhl_countries.add({"id": 196, "country": "St. Eustatius"});
    dhl_countries.add({"id": 197, "country": "St. Kitts"});
    dhl_countries.add({"id": 198, "country": "St. Lucia"});
    dhl_countries.add({"id": 199, "country": "St. Maarten"});
    dhl_countries.add({"id": 200, "country": "St. Vincent"});
    dhl_countries.add({"id": 201, "country": "Sudan"});
    dhl_countries.add({"id": 202, "country": "Suriname"});
    dhl_countries.add({"id": 203, "country": "Swaziland"});
    dhl_countries.add({"id": 204, "country": "Sweden"});
    dhl_countries.add({"id": 205, "country": "Switzerland"});
    dhl_countries.add({"id": 206, "country": "Syria"});
    dhl_countries.add({"id": 207, "country": "Tahiti"});
    dhl_countries.add({"id": 208, "country": "Taiwan"});
    dhl_countries.add({"id": 209, "country": "Tajikistan"});
    dhl_countries.add({"id": 210, "country": "Tanzania"});
    dhl_countries.add({"id": 211, "country": "Thailand"});
    dhl_countries.add({"id": 212, "country": "Togo"});
    dhl_countries.add({"id": 213, "country": "Tonga"});
    dhl_countries.add({"id": 214, "country": "Trinidad and Tobago"});
    dhl_countries.add({"id": 215, "country": "Tunisia"});
    dhl_countries.add({"id": 216, "country": "Turkey"});
    dhl_countries.add({"id": 217, "country": "Turkmenistan"});
    dhl_countries.add({"id": 218, "country": "Turks and Caicos Islands"});
    dhl_countries.add({"id": 219, "country": "Tuvalu"});
    dhl_countries.add({"id": 220, "country": "Uganda"});
    dhl_countries.add({"id": 221, "country": "Ukraine"});
    dhl_countries.add({"id": 222, "country": "U.A.E"});
    dhl_countries.add({"id": 223, "country": "United Kingdom"});
    dhl_countries.add({"id": 224, "country": "U.S.A"});
    dhl_countries.add({"id": 225, "country": "Uruguay"});
    dhl_countries.add({"id": 226, "country": "Uzbekistan"});
    dhl_countries.add({"id": 227, "country": "Vanuatu"});
    dhl_countries.add({"id": 228, "country": "Vatican city"});
    dhl_countries.add({"id": 229, "country": "Venezuela"});
    dhl_countries.add({"id": 230, "country": "Vietnam"});
    dhl_countries.add({"id": 231, "country": "Virgin Islands (British)"});
    dhl_countries.add({"id": 232, "country": "Virgin Islands (US)"});
    dhl_countries.add({"id": 233, "country": "Yemen"});
    dhl_countries.add({"id": 234, "country": "Zambia"});
    dhl_countries.add({"id": 235, "country": "Zimbabwe"});
  }

  void getFedexCountries() {
    fedex_countries.add({"id": 1, "country": "Afghanistan"});
    fedex_countries.add({"id": 2, "country": "Albania"});
    fedex_countries.add({"id": 3, "country": "Algeria"});
    fedex_countries.add({"id": 4, "country": "American Samoa"});
    fedex_countries.add({"id": 5, "country": "Andorra"});
    fedex_countries.add({"id": 6, "country": "Angola"});
    fedex_countries.add({"id": 7, "country": "Anguilla"});
    fedex_countries.add({"id": 8, "country": "Antigua"});
    fedex_countries.add({"id": 9, "country": "Argentina"});
    fedex_countries.add({"id": 10, "country": "Armenia"});
    fedex_countries.add({"id": 11, "country": "Aruba"});
    fedex_countries.add({"id": 13, "country": "Austria"});
    fedex_countries.add({"id": 14, "country": "Azerbaijan"});
    fedex_countries.add({"id": 12, "country": "Australia"});
    fedex_countries.add({"id": 15, "country": "Bahamas"});
    fedex_countries.add({"id": 16, "country": "Bahrain"});
    fedex_countries.add({"id": 17, "country": "Barbados"});
    fedex_countries.add({"id": 18, "country": "Belarus"});
    fedex_countries.add({"id": 19, "country": "Belgium"});
    fedex_countries.add({"id": 20, "country": "Belize"});
    fedex_countries.add({"id": 21, "country": "Benin"});
    fedex_countries.add({"id": 22, "country": "Bermuda"});
    fedex_countries.add({"id": 23, "country": "Bhutan"});
    fedex_countries.add({"id": 24, "country": "Bolivia"});
    fedex_countries.add({"id": 25, "country": "Bosnia"});
    fedex_countries.add({"id": 26, "country": "Botswana"});
    fedex_countries.add({"id": 27, "country": "Brazil"});
    fedex_countries.add({"id": 28, "country": "British Virgin Is."});
    fedex_countries.add({"id": 29, "country": "Brunei"});
    fedex_countries.add({"id": 30, "country": "Bulgaria"});
    fedex_countries.add({"id": 31, "country": "Burkina Faso"});
    fedex_countries.add({"id": 32, "country": "Burundi"});
    fedex_countries.add({"id": 33, "country": "Cambodia"});
    fedex_countries.add({"id": 34, "country": "Cameroon"});
    fedex_countries.add({"id": 35, "country": "Canada"});
    fedex_countries.add({"id": 36, "country": "Cape Verde"});
    fedex_countries.add({"id": 37, "country": "Cayman Islands"});
    fedex_countries.add({"id": 38, "country": "Cent Afr Rep"});
    fedex_countries.add({"id": 39, "country": "Chad"});
    fedex_countries.add({"id": 40, "country": "Chile"});
    fedex_countries.add({"id": 41, "country": "China"});
    fedex_countries.add({"id": 42, "country": "Colombia"});
    fedex_countries.add({"id": 43, "country": "Congo"});
    fedex_countries.add({"id": 44, "country": "Cook Islands"});
    fedex_countries.add({"id": 45, "country": "Costa Rica"});
    fedex_countries.add({"id": 46, "country": "Croatia"});
    fedex_countries.add({"id": 47, "country": "Cyprus"});
    fedex_countries.add({"id": 48, "country": "Czech Republic"});
    fedex_countries.add({"id": 49, "country": "Democratic Republic Of C"});
    fedex_countries.add({"id": 50, "country": "Denmark"});
    fedex_countries.add({"id": 51, "country": "Djibouti"});
    fedex_countries.add({"id": 52, "country": "Dominica"});
    fedex_countries.add({"id": 53, "country": "Dominican Republic"});
    fedex_countries.add({"id": 54, "country": "East Timor"});
    fedex_countries.add({"id": 55, "country": "Ecuador"});
    fedex_countries.add({"id": 56, "country": "Egypt"});
    fedex_countries.add({"id": 57, "country": "El Salvador"});
    fedex_countries.add({"id": 58, "country": "Equatorial Guinea"});
    fedex_countries.add({"id": 59, "country": "Eritrea"});
    fedex_countries.add({"id": 60, "country": "Estonia"});
    fedex_countries.add({"id": 61, "country": "Ethiopia"});
    fedex_countries.add({"id": 62, "country": "Fiji"});
    fedex_countries.add({"id": 63, "country": "Finland"});
    fedex_countries.add({"id": 64, "country": "France"});
    fedex_countries.add({"id": 65, "country": "French Guiana"});
    fedex_countries.add({"id": 66, "country": "French Polynesia"});
    fedex_countries.add({"id": 67, "country": "Gabon"});
    fedex_countries.add({"id": 68, "country": "Gambia"});
    fedex_countries.add({"id": 69, "country": "Georgia"});
    fedex_countries.add({"id": 70, "country": "Germany"});
    fedex_countries.add({"id": 71, "country": "Ghana"});
    fedex_countries.add({"id": 72, "country": "Gibraltar"});
    fedex_countries.add({"id": 73, "country": "Greece"});
    fedex_countries.add({"id": 74, "country": "Grenada"});
    fedex_countries.add({"id": 75, "country": "Guadeloupe"});
    fedex_countries.add({"id": 76, "country": "Guam"});
    fedex_countries.add({"id": 77, "country": "Guatemala"});
    fedex_countries.add({"id": 78, "country": "Guinea Bissau"});
    fedex_countries.add({"id": 79, "country": "Guinea"});
    fedex_countries.add({"id": 80, "country": "Guyana"});
    fedex_countries.add({"id": 81, "country": "Haiti"});
    fedex_countries.add({"id": 82, "country": "Honduras"});
    fedex_countries.add({"id": 83, "country": "Hong Kong"});
    fedex_countries.add({"id": 84, "country": "Hungary"});
    fedex_countries.add({"id": 85, "country": "Iceland"});
    fedex_countries.add({"id": 86, "country": "India"});
    fedex_countries.add({"id": 87, "country": "Indonesia"});
    fedex_countries.add({"id": 88, "country": "Iraq Republic"});
    fedex_countries.add({"id": 89, "country": "Ireland"});
    fedex_countries.add({"id": 90, "country": "Israel"});
    fedex_countries.add({"id": 91, "country": "Italy"});
    fedex_countries.add({"id": 92, "country": "Ivory Coast"});
    fedex_countries.add({"id": 93, "country": "Jamaica"});
    fedex_countries.add({"id": 94, "country": "Japan"});
    fedex_countries.add({"id": 95, "country": "Jordan"});
    fedex_countries.add({"id": 96, "country": "Kazakhstan"});
    fedex_countries.add({"id": 97, "country": "Kenya"});
    fedex_countries.add({"id": 98, "country": "Kuwait"});
    fedex_countries.add({"id": 99, "country": "Kyrgyzstan"});
    fedex_countries.add({"id": 100, "country": "Laos"});
    fedex_countries.add({"id": 101, "country": "Latvia"});
    fedex_countries.add({"id": 102, "country": "Lebanon"});
    fedex_countries.add({"id": 103, "country": "Lesotho"});
    fedex_countries.add({"id": 104, "country": "Liberia"});
    fedex_countries.add({"id": 105, "country": "Libya"});
    fedex_countries.add({"id": 106, "country": "Liechtenstein"});
    fedex_countries.add({"id": 107, "country": "Lithuania"});
    fedex_countries.add({"id": 108, "country": "Luxembourg"});
    fedex_countries.add({"id": 109, "country": "Macau"});
    fedex_countries.add({"id": 110, "country": "Macedonia"});
    fedex_countries.add({"id": 111, "country": "Madagascar"});
    fedex_countries.add({"id": 112, "country": "Malawi"});
    fedex_countries.add({"id": 113, "country": "Malaysia"});
    fedex_countries.add({"id": 114, "country": "Maldives"});
    fedex_countries.add({"id": 115, "country": "Mali"});
    fedex_countries.add({"id": 116, "country": "Malta"});
    fedex_countries.add({"id": 117, "country": "Marshall Islands"});
    fedex_countries.add({"id": 118, "country": "Martinique"});
    fedex_countries.add({"id": 119, "country": "Mauritania"});
    fedex_countries.add({"id": 120, "country": "Mauritius"});
    fedex_countries.add({"id": 121, "country": "Mexico"});
    fedex_countries.add({"id": 122, "country": "Micronesia"});
    fedex_countries.add({"id": 123, "country": "Moldova"});
    fedex_countries.add({"id": 124, "country": "Monaco"});
    fedex_countries.add({"id": 125, "country": "Mongolia"});
    fedex_countries.add({"id": 126, "country": "Montenegro"});
    fedex_countries.add({"id": 127, "country": "Montserrat"});
    fedex_countries.add({"id": 128, "country": "Morocco"});
    fedex_countries.add({"id": 129, "country": "Mozambique"});
    fedex_countries.add({"id": 130, "country": "Myanmar"});
    fedex_countries.add({"id": 131, "country": "Namibia"});
    fedex_countries.add({"id": 132, "country": "Nepal"});
    fedex_countries.add({"id": 133, "country": "Netherlands"});
    fedex_countries.add({"id": 134, "country": "New Caledonia"});
    fedex_countries.add({"id": 135, "country": "New Zealand"});
    fedex_countries.add({"id": 136, "country": "Nicaragua"});
    fedex_countries.add({"id": 137, "country": "Niger"});
    fedex_countries.add({"id": 138, "country": "Nigeria"});
    fedex_countries.add({"id": 139, "country": "Nl. Antilles"});
    fedex_countries.add({"id": 140, "country": "Norway"});
    fedex_countries.add({"id": 141, "country": "Oman"});
    fedex_countries.add({"id": 142, "country": "Pakistan"});
    fedex_countries.add({"id": 143, "country": "Palau"});
    fedex_countries.add({"id": 144, "country": "Palestine Authority"});
    fedex_countries.add({"id": 145, "country": "Panama"});
    fedex_countries.add({"id": 146, "country": "Papua New Guinea"});
    fedex_countries.add({"id": 147, "country": "Paraguay"});
    fedex_countries.add({"id": 148, "country": "Peru"});
    fedex_countries.add({"id": 149, "country": "Philippines"});
    fedex_countries.add({"id": 150, "country": "Poland"});
    fedex_countries.add({"id": 151, "country": "Portugal"});
    fedex_countries.add({"id": 152, "country": "Qatar"});
    fedex_countries.add({"id": 153, "country": "Reunion Island"});
    fedex_countries.add({"id": 154, "country": "Romania"});
    fedex_countries.add({"id": 155, "country": "Russia"});
    fedex_countries.add({"id": 156, "country": "Rwanda"});
    fedex_countries.add({"id": 157, "country": "Saipan"});
    fedex_countries.add({"id": 158, "country": "Samoa"});
    fedex_countries.add({"id": 159, "country": "Saudi Arabia"});
    fedex_countries.add({"id": 160, "country": "Senegal"});
    fedex_countries.add({"id": 161, "country": "Serbia And Montenegro"});
    fedex_countries.add({"id": 162, "country": "Serbia"});
    fedex_countries.add({"id": 163, "country": "Seychelles"});
    fedex_countries.add({"id": 164, "country": "Sierra Leone"});
    fedex_countries.add({"id": 165, "country": "Singapore"});
    fedex_countries.add({"id": 166, "country": "Slovak Republic"});
    fedex_countries.add({"id": 167, "country": "Slovenia"});
    fedex_countries.add({"id": 168, "country": "Somalia"});
    fedex_countries.add({"id": 169, "country": "South Africa"});
    fedex_countries.add({"id": 170, "country": "South Korea"});
    fedex_countries.add({"id": 171, "country": "Spain"});
    fedex_countries.add({"id": 172, "country": "Sri Lanka"});
    fedex_countries.add({"id": 173, "country": "St Kitts & Nevis"});
    fedex_countries.add({"id": 174, "country": "St. Lucia"});
    fedex_countries.add({"id": 175, "country": "St. Vincent"});
    fedex_countries.add({"id": 176, "country": "Sudan"});
    fedex_countries.add({"id": 177, "country": "Suriname"});
    fedex_countries.add({"id": 178, "country": "Swaziland"});
    fedex_countries.add({"id": 179, "country": "Sweden"});
    fedex_countries.add({"id": 180, "country": "Switzerland"});
    fedex_countries.add({"id": 181, "country": "Syria"});
    fedex_countries.add({"id": 182, "country": "Taiwan"});
    fedex_countries.add({"id": 183, "country": "Tanzania"});
    fedex_countries.add({"id": 184, "country": "Thailand"});
    fedex_countries.add({"id": 185, "country": "Togo"});
    fedex_countries.add({"id": 186, "country": "Tonga"});
    fedex_countries.add({"id": 187, "country": "Trinidad & Tobag"});
    fedex_countries.add({"id": 188, "country": "Tunisia"});
    fedex_countries.add({"id": 189, "country": "Turkey"});
    fedex_countries.add({"id": 190, "country": "Turkmenistan"});
    fedex_countries.add({"id": 191, "country": "Turks & Caicos I"});
    fedex_countries.add({"id": 192, "country": "U.A.E"});
    fedex_countries.add({"id": 193, "country": "U.S.A"});
    fedex_countries.add({"id": 194, "country": "Uganda"});
    fedex_countries.add({"id": 195, "country": "Ukraine"});
    fedex_countries.add({"id": 196, "country": "United Kingdom"});
    fedex_countries.add({"id": 197, "country": "Uruguay"});
    fedex_countries.add({"id": 198, "country": "Uzbekistan"});
    fedex_countries.add({"id": 199, "country": "Vanuatu"});
    fedex_countries.add({"id": 210, "country": "Vatican City"});
    fedex_countries.add({"id": 201, "country": "Venezuela"});
    fedex_countries.add({"id": 202, "country": "Vietnam"});
    fedex_countries.add({"id": 203, "country": "Virgin Islands"});
    fedex_countries.add({"id": 204, "country": "Wallis & Futuna"});
    fedex_countries.add({"id": 205, "country": "Yemen"});
    fedex_countries.add({"id": 206, "country": "Yugoslavia"});
    fedex_countries.add({"id": 207, "country": "Zaire"});
    fedex_countries.add({"id": 208, "country": "Zambia"});
    fedex_countries.add({"id": 209, "country": "Zimbabwe"});
  }

  Future<void> getData() async {
    print("Receiver Name: ${nameTextEditingController.text}");
    print("Address: ${addressTextEditingController.text}");
    print("Number of days: $dropdownvalue");
    print("Country: $dhl_countryId");
    print("Country: $fedex_countryId");
    print("Weight: ${weightTextEditingController.text}");
    if(dropdownvalue == '3 to 4 working days'){
      final dhlZone = await UserSheetsApi.getById_Dhl_zone(int.parse(this.dhl_countryId!));

      print("Zone of Dhl: $dhlZone");

      var dhl_zone = dhlZone!.toJson()["Zone"];

      country = dhlZone.toJson()["Country"];

      print("Zone of Dhl: $dhl_zone");

      final dhl_ess_fuel_dollar = await UserSheetsApi.getById_Dhl_Ess(1);
      double ess = dhl_ess_fuel_dollar!.toJson()["ess"];
      double fuel = dhl_ess_fuel_dollar.toJson()["fuel"];
      double dollar = dhl_ess_fuel_dollar.toJson()["dollar"];
      double profit = dhl_ess_fuel_dollar.toJson()["profit"];

      print("Ess: $ess");
      print("Fuel: $fuel");
      print("Dollar: $dollar");
      print("Profit: $profit");

      double final_value = 0.0;

      //print(this.weightId);

      //Weight from the value
      double weight = double.parse(weightTextEditingController.text);
      print('Weight: $weight');

      //Weight in whole number
      int whole_weight = weight.toInt();
      print('Whole weight: $whole_weight');

      //Decimal values of weight
      double weight_decimals = weight - whole_weight;
      print('Decimal of weight: $weight_decimals');

      var value1 = 0.0;
      var value2 = 0.0;
      var value3 = 0.0;
      var value4 = 0.0;

      double final_weight = 0;

      if(weight_decimals == 0){
        final_weight = weight;
      }
      else if(weight <= 0.5){
        final_weight = whole_weight + 0.5;
      }
      else {
        if(weight_decimals < 0.5){
          final_weight = whole_weight + 0.5;
        }
        else if(weight_decimals == 0.5) {
          final_weight = weight;
        }
        else if(weight_decimals > 0.5) {
          final_weight = whole_weight + 1;
        }
      }
      print('Final Weight: ${final_weight}');

      int final_weight_above30 = final_weight.ceil();

      print('Final weight above 30: $final_weight_above30');

      if(final_weight <= 30) {
        //Fetching rate from google sheet
        final dhl_rate = await UserSheetsApi.getById_Dhl_rate(final_weight);
        var final_dhl_rate = dhl_rate!.toJson()["Zone $dhl_zone"];
        print("Final rate: $final_dhl_rate");


        value1 = final_dhl_rate + (ess * final_weight);
        value2 = value1 + value1 * fuel/100;
        value3 = value2 * dollar;
        value4 = value3 + value3 * profit/100;
        final_value = value4;
      }

      else if(final_weight > 30) {
        //Fetching rate from google sheet
        final dhl_rate = await UserSheetsApi.getById_Dhl_rate(31);
        var final_dhl_rate = dhl_rate!.toJson()["Zone $dhl_zone"];
        print("Final rate: $final_dhl_rate");

        value1 = final_dhl_rate + ess;
        value2 = value1 + value1 * fuel/100;
        value3 = value2 * dollar * final_weight_above30;
        value4 = value3 + value3 * profit/100;
        final_value = value4;
      }

      print("Final Value in taka: ${final_value.toInt()}");

      setState(() {
        _value = final_value.toInt();
      });
    }
    else if(dropdownvalue == '4 to 5 working days') {
      final fedexZone = await UserSheetsApi.getById_Fedex_zone(this.fedex_countryId!);

      var fedex_zone = fedexZone!.toJson()["Zone"];

      country = fedexZone.toJson()["Country"];

      print("Fedex zone: $fedex_zone");

      double ess;

      //Ess_Fuel_dollar
      final fedex_ess_fuel_dollar = await UserSheetsApi.getById_Fedex_Ess(1);
      if(fedex_zone == 'G'){
        ess = 0.77;
      }
      else if(fedex_zone == 'H'){
        ess = 2;
      }
      else if(fedex_zone == 'I'){
        ess = 0.77;
      }
      else {
        ess = fedex_ess_fuel_dollar!.toJson()["ess"];
      }
      double fuel = fedex_ess_fuel_dollar!.toJson()["fuel"];
      double dollar = fedex_ess_fuel_dollar.toJson()["dollar"];
      double profit = fedex_ess_fuel_dollar.toJson()["profit"];

      print("Ess: $ess");
      print("Fuel: $fuel");
      print("Dollar: $dollar");
      print("Profit: $profit");

      double final_value = 0.0;

      //print(this.weightId);

      //Weight from the value
      double weight = double.parse(weightTextEditingController.text);
      print('Weight: $weight');

      //Weight in whole number
      int whole_weight = weight.toInt();
      print('Whole weight: $whole_weight');

      //Decimal values of weight
      double weight_decimals = weight - whole_weight;
      print('Decimal of weight: $weight_decimals');

      var value1 = 0.0;
      var value2 = 0.0;
      var value3 = 0.0;
      var value4 = 0.0;

      double final_weight = 0;

      if(weight_decimals == 0){
        final_weight = weight;
      }
      else if(weight <= 0.5){
        final_weight = whole_weight + 0.5;
      }
      else {
        if(weight_decimals < 0.5){
          final_weight = whole_weight + 0.5;
        }
        else if(weight_decimals == 0.5) {
          final_weight = weight;
        }
        else if(weight_decimals > 0.5) {
          final_weight = whole_weight + 1;
        }
      }
      print('Final Weight: ${final_weight}');

      int final_weight_above20 = final_weight.ceil();

      print('Final weight above 30: $final_weight_above20');

      if(final_weight <= 20) {
        //Fetching rate from google sheet
        final fedex_rate = await UserSheetsApi.getById_Fedex_rate(final_weight);
        var final_fedex_rate = fedex_rate!.toJson()["Zone $fedex_zone"];
        print("Final rate: $final_fedex_rate");


        value1 = final_fedex_rate + (ess * final_weight);
        value2 = value1 + value1 * fuel/100;
        value3 = value2 * dollar;
        value4 = value3 + value3 * profit/100;
        final_value = value4;
      }

      else if(final_weight > 20 && final_weight <= 30) {
        //Fetching rate from google sheet
        final fedex_rate = await UserSheetsApi.getById_Fedex_rate(21);
        var final_fedex_rate = fedex_rate!.toJson()["Zone $fedex_zone"];
        print("Final rate: $final_fedex_rate");

        value1 = final_fedex_rate + ess;
        value2 = value1 + value1 * fuel/100;
        value3 = value2 * dollar * final_weight_above20;
        value4 = value3 + value3 * profit/100;
        final_value = value4;
      }

      else if(final_weight > 30) {
        //Fetching rate from google sheet
        final fedex_rate = await UserSheetsApi.getById_Fedex_rate(31);
        var final_fedex_rate = fedex_rate!.toJson()["Zone $fedex_zone"];
        print("Final rate: $final_fedex_rate");

        value1 = final_fedex_rate + ess;
        value2 = value1 + value1 * fuel/100;
        value3 = value2 * dollar * final_weight_above20;
        value4 = value3 + value3 * profit/100;
        final_value = value4;
      }

      print("Final Value in taka: ${final_value.toInt()}");

      setState(() {
        _value = final_value.toInt();
      });
    }
  }

  formValidation(){
    if(nameTextEditingController.text.isNotEmpty
        && addressTextEditingController.text.isNotEmpty
        && weightTextEditingController.text.isNotEmpty
        && dropdownvalue != null
        && country != null
    ){
      //print("Baal Saal");
      DocumentReference reference = FirebaseFirestore.instance.collection("pickupRequest").doc();
      reference.set({
        "uid": reference.id,
        "date": DateTime.now(),
        "sender_uid": userModelCurrentInfo!.uid,
        "sender_name": userModelCurrentInfo!.name,
        "sender_address": userModelCurrentInfo!.address,
        "sender_phone": userModelCurrentInfo!.phone,
        "sender_email": userModelCurrentInfo!.email,
        "receiver_name": nameTextEditingController.text.trim(),
        "receiver_address": addressTextEditingController.text.trim(),
        "number_of_days": dropdownvalue.toString(),
        "country": country,
        "weight": weightTextEditingController.text.trim(),
        "amount": value.format(_value).toString(),
      });

      Navigator.push(context, MaterialPageRoute(builder: (c) => HomeScreen()));

    }
    else {
      showDialog(context: context, builder: (c)
      {
        return LoadingDialogWidget(
          message: "Some fields are empty",
        );
      }
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          //color: Colors.white,
          color: darkTheme ? Colors.black45 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Request Pickup",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkTheme ? Colors.amberAccent.shade400 : Colors.black,
                  ),
                ),

                SizedBox(height: 10,),

                const Text(
                  'Pickup is only available in Dhaka City.'
                      '\nThere will be pickup charge depending on the location and size of the shipment.'
                      '\nBut will be no pickup charge if you drop shipment to our office.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20,),

                Container(
                  width: MediaQuery.of(context).size.width > 300 ? 400 : 300,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2,color: darkTheme ? Colors.amberAccent.shade400 : Colors.blue),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: nameTextEditingController,
                        decoration: InputDecoration(
                          hintText: 'Receiver Name',
                          hintStyle: TextStyle(
                            color: darkTheme ? Colors.grey : Colors.grey,
                          ),
                          filled: true,
                          fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          //border: InputBorder.none,
                          prefixIcon: Icon(Icons.email, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                        ),
                      ),

                      const SizedBox(height: 20,),

                      TextField(
                        controller: addressTextEditingController,
                        decoration: InputDecoration(
                          hintText: 'Receiver Full Address',
                          hintStyle: TextStyle(
                            color: darkTheme ? Colors.grey : Colors.grey,
                          ),
                          filled: true,
                          fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          //border: InputBorder.none,
                          prefixIcon: Icon(Icons.email, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                        ),
                      ),

                      const SizedBox(height: 20,),

                      // TextField(
                      //   obscureText: true,
                      //   decoration: InputDecoration(
                      //     hintText: 'Password',
                      //     hintStyle: TextStyle(
                      //       color: darkTheme ? Colors.grey : Colors.grey,
                      //     ),
                      //     filled: true,
                      //     fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(40),
                      //       borderSide: const BorderSide(
                      //         width: 0,
                      //         style: BorderStyle.none,
                      //       ),
                      //     ),
                      //     //border: InputBorder.none,
                      //     prefixIcon: Icon(Icons.lock, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                      //   ),
                      // ),
                      //
                      // const SizedBox(height: 20,),

                      DropdownButtonFormField(
                          decoration: InputDecoration(
                            hintText: 'Select number of days',
                            prefixIcon: Icon(Icons.map,color: darkTheme ? Colors.amber : Colors.grey,),
                            filled: true,
                            fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                              print('$dropdownvalue');
                            });
                          }
                      ),

                      SizedBox(height: 20,),

                      //Dhl Dropdown country
                      Visibility(
                        visible: dropdownvalue == '' ? false : dropdownvalue == '3 to 4 working days' ? true : false,
                        child: Column(
                          children: [
                            FormHelper.dropDownWidgetCountry(
                              context,
                              "Select Country",
                              this.dhl_countryId,
                              this.dhl_countries,
                                  (onChangedVal) {
                                this.dhl_countryId = onChangedVal;
                                print("Selected Country ID: $onChangedVal");
                              },
                                  (onValidateVal) {
                                if(onValidateVal == null) {
                                  return 'Please Select Country';
                                }
                                return null;
                              },
                              optionValue: "id",
                              optionLabel: "country",
                            ),

                            SizedBox(height: 20,),

                            TextField(
                              controller: weightTextEditingController,
                              decoration: InputDecoration(
                                hintText: 'Weight',
                                hintStyle: TextStyle(
                                  color: darkTheme ? Colors.grey : Colors.grey,
                                ),
                                filled: true,
                                fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                //border: InputBorder.none,
                                prefixIcon: Icon(Icons.line_weight, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Fedex dropdown country
                      Visibility(
                        visible: dropdownvalue == '' ? false : dropdownvalue == '4 to 5 working days' ? true : false,
                        child: Column(
                          children: [
                            FormHelper.dropDownWidgetCountry(
                              context,
                              "Select Country",
                              this.fedex_countryId,
                              this.fedex_countries,
                                  (onChangedVal) {
                                this.fedex_countryId = onChangedVal;
                                print("Selected Country ID: $onChangedVal");
                              },
                                  (onValidateVal) {
                                if(onValidateVal == null) {
                                  return 'Please Select Country';
                                }
                                return null;
                              },
                              optionValue: "id",
                              optionLabel: "country",
                            ),

                            SizedBox(height: 20,),

                            TextField(
                              controller: weightTextEditingController,
                              decoration: InputDecoration(
                                hintText: 'Weight',
                                hintStyle: TextStyle(
                                  color: darkTheme ? Colors.grey : Colors.grey,
                                ),
                                filled: true,
                                fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                //border: InputBorder.none,
                                prefixIcon: Icon(Icons.line_weight, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20,),

                      // FormHelper.dropDownWidgetWeight(
                      //   context,
                      //   "Select Weight",
                      //   this.weightId,
                      //   this.weights,
                      //       (onChangedVal) {
                      //     this.weightId = onChangedVal;
                      //     print("Selected Weight: $onChangedVal");
                      //   },
                      //       (onValidateVal) {
                      //     if(onValidateVal == null) {
                      //       return 'Please Select Weight';
                      //     }
                      //     return null;
                      //   },
                      //   optionValue: "id",
                      //   optionLabel: "weight",
                      // ),

                      // SizedBox(height: 20,),

                      // DropdownButtonFormField(
                      //   decoration: InputDecoration(
                      //     hintText: 'Select Country',
                      //     prefixIcon: Icon(Icons.map,color: Colors.amber,),
                      //     filled: true,
                      //     fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(40),
                      //       borderSide: const BorderSide(
                      //         width: 0,
                      //         style: BorderStyle.none,
                      //       ),
                      //     ),
                      //   ),
                      //   items: items.map((String items) {
                      //     return DropdownMenuItem(
                      //       value: items,
                      //       child: Text(items),
                      //     );
                      //   }).toList(),
                      //   onChanged: (String? newValue) {
                      //     setState(() {
                      //       dropdownvalue = newValue!;
                      //       // print('$dropdownvalue');
                      //     });
                      //   }
                      // ),

                      // SizedBox(height: 20,),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: darkTheme ? Colors.amberAccent.shade400 : Colors.blue,
                          onPrimary: darkTheme ? Colors.black : Colors.white,
                          shadowColor: Colors.greenAccent,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          minimumSize: const Size(100, 40), //////// HERE
                        ),
                        onPressed: () async {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext c){
                                return ProgressDialog(message: "Calculating amount, Please wait...",);
                              }
                          );
                          //getData();
                          await Future.delayed(Duration(seconds: 2)).then((value) => getData());
                          // Navigator.pop(context);
                          showDialog(context: context,
                              builder: (context){
                                return Dialog(
                                  child: Container(
                                    margin: const EdgeInsets.all(8),
                                    padding: EdgeInsets.all(20),
                                    width: double.infinity,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Center(
                                          child: new Text("Total Amount",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 23,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: new Text(
                                            '৳ ${value.format(_value)}',
                                            style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              icon: Icon(Icons.cancel,color: Colors.white,),
                                              label: Text('Cancel',style: TextStyle(color: Colors.white,),),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.red,
                                              ),
                                            ),

                                            const SizedBox(width: 25.0),

                                            ElevatedButton.icon(
                                              onPressed: () {
                                                print("saal baal");
                                                formValidation();
                                              },
                                              icon: Icon(Icons.check,color: Colors.white,),
                                              label: Text('confirm',style: TextStyle(color: Colors.white,),),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                );
                              }
                          );
                        },
                        child: const Text('Submit'),
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 20,),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     TextButton(
                //       onPressed: () {
                //       },
                //       child: Text(
                //         "Doesn't have an account? Register",
                //         style: TextStyle(
                //           color: darkTheme ? Colors.amberAccent.shade400 : Colors.blue,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PickupRequestDesktop extends StatefulWidget {
  const PickupRequestDesktop({Key? key}) : super(key: key);

  @override
  State<PickupRequestDesktop> createState() => _PickupRequestDesktopState();
}

class _PickupRequestDesktopState extends State<PickupRequestDesktop> {

  String dropdownvalue = '';

// List of items in our dropdown menu
  var items = [
    '3 to 4 working days',
    '4 to 5 working days',
  ];

  List<dynamic> dhl_countries = [];
  List<dynamic> fedex_countries = [];
  List<dynamic> weights = [];
  String? dhl_countryId;
  String? fedex_countryId;
  String? weightId;

  int _value = 0;
  //String _country = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    UserSheetsApi.init();

    getFedexCountries();

    getDhlCountries();

    // this.weights.add({"id": 1, "weight": "1"});
    // this.weights.add({"id": 2, "weight": "2"});
    // this.weights.add({"id": 3, "weight": "3"});
    // this.weights.add({"id": 4, "weight": "4"});
    // this.weights.add({"id": 5, "weight": "5"});
    // this.weights.add({"id": 6, "weight": "6"});
    // this.weights.add({"id": 7, "weight": "7"});
    // this.weights.add({"id": 8, "weight": "8"});
    // this.weights.add({"id": 9, "weight": "9"});
    // this.weights.add({"id": 10, "weight": "10"});
  }

  void getDhlCountries() {
    dhl_countries.add({"id": 1, "country": "Afghanistan"});
    dhl_countries.add({"id": 2, "country": "Albania"});
    dhl_countries.add({"id": 3, "country": "Algeria"});
    dhl_countries.add({"id": 4, "country": "American Samoa"});
    dhl_countries.add({"id": 5, "country": "Andorra"});
    dhl_countries.add({"id": 6, "country": "Angola"});
    dhl_countries.add({"id": 7, "country": "Anguilla"});
    dhl_countries.add({"id": 8, "country": "Antigua"});
    dhl_countries.add({"id": 9, "country": "Argentina"});
    dhl_countries.add({"id": 10, "country": "Armenia"});
    dhl_countries.add({"id": 11, "country": "Aruba"});
    dhl_countries.add({"id": 12, "country": "Australia"});
    dhl_countries.add({"id": 13, "country": "Austria"});
    dhl_countries.add({"id": 14, "country": "Azerbaijan"});
    dhl_countries.add({"id": 15, "country": "Bahamas"});
    dhl_countries.add({"id": 16, "country": "Bahrain"});
    dhl_countries.add({"id": 17, "country": "Barbados"});
    dhl_countries.add({"id": 18, "country": "Belarus"});
    dhl_countries.add({"id": 19, "country": "Belgium"});
    dhl_countries.add({"id": 20, "country": "Belize"});
    dhl_countries.add({"id": 21, "country": "Benin"});
    dhl_countries.add({"id": 22, "country": "Bermuda"});
    dhl_countries.add({"id": 23, "country": "Bhutan"});
    dhl_countries.add({"id": 24, "country": "Bolivia"});
    dhl_countries.add({"id": 25, "country": "Bonaire"});
    dhl_countries.add({"id": 26, "country": "Bosnia and Herzegovina"});
    dhl_countries.add({"id": 27, "country": "Botswana"});
    dhl_countries.add({"id": 28, "country": "Brazil"});
    dhl_countries.add({"id": 29, "country": "Brunei"});
    dhl_countries.add({"id": 30, "country": "Bulgaria"});
    dhl_countries.add({"id": 31, "country": "Burkina Faso"});
    dhl_countries.add({"id": 32, "country": "Burundi"});
    dhl_countries.add({"id": 33, "country": "Cambodia"});
    dhl_countries.add({"id": 34, "country": "Cameroon"});
    dhl_countries.add({"id": 35, "country": "Canada"});
    dhl_countries.add({"id": 36, "country": "Canary Islands"});
    dhl_countries.add({"id": 37, "country": "Cape Verde"});
    dhl_countries.add({"id": 38, "country": "Cayman Islands"});
    dhl_countries.add({"id": 39, "country": "Central African Republic"});
    dhl_countries.add({"id": 40, "country": "Chad"});
    dhl_countries.add({"id": 41, "country": "Chile"});
    dhl_countries.add({"id": 42, "country": "China, People's Republic"});
    dhl_countries.add({"id": 43, "country": "Colombia"});
    dhl_countries.add({"id": 44, "country": "Mariana Islands"});
    dhl_countries.add({"id": 45, "country": "Comoros"});
    dhl_countries.add({"id": 46, "country": "Congo"});
    dhl_countries.add({"id": 47, "country": "Congo, The Democratic Republic"});
    dhl_countries.add({"id": 48, "country": "Cook Islands"});
    dhl_countries.add({"id": 49, "country": "Costa Rica"});
    dhl_countries.add({"id": 50, "country": "Cote d'Ivoire"});
    dhl_countries.add({"id": 51, "country": "Croatia"});
    dhl_countries.add({"id": 52, "country": "Cuba"});
    dhl_countries.add({"id": 53, "country": "Curacao"});
    dhl_countries.add({"id": 54, "country": "Cyprus"});
    dhl_countries.add({"id": 55, "country": "Czech Republic"});
    dhl_countries.add({"id": 56, "country": "Denmark"});
    dhl_countries.add({"id": 57, "country": "Djibouti"});
    dhl_countries.add({"id": 58, "country": "Dominica"});
    dhl_countries.add({"id": 59, "country": "Dominican Republic"});
    dhl_countries.add({"id": 60, "country": "East Timor"});
    dhl_countries.add({"id": 61, "country": "Ecuador"});
    dhl_countries.add({"id": 62, "country": "Egypt"});
    dhl_countries.add({"id": 63, "country": "El Salvador"});
    dhl_countries.add({"id": 64, "country": "Eritrea"});
    dhl_countries.add({"id": 65, "country": "Estonia"});
    dhl_countries.add({"id": 66, "country": "Ethiopia"});
    dhl_countries.add({"id": 67, "country": "Falkland Islands"});
    dhl_countries.add({"id": 68, "country": "Faroe Islands"});
    dhl_countries.add({"id": 69, "country": "Fiji"});
    dhl_countries.add({"id": 70, "country": "Finland"});
    dhl_countries.add({"id": 71, "country": "France"});
    dhl_countries.add({"id": 72, "country": "French Guyana"});
    dhl_countries.add({"id": 73, "country": "Gabon"});
    dhl_countries.add({"id": 74, "country": "Gambia"});
    dhl_countries.add({"id": 75, "country": "Georgia"});
    dhl_countries.add({"id": 76, "country": "Germany"});
    dhl_countries.add({"id": 77, "country": "Ghana"});
    dhl_countries.add({"id": 78, "country": "Gibraltar"});
    dhl_countries.add({"id": 79, "country": "Greece"});
    dhl_countries.add({"id": 80, "country": "Greenland"});
    dhl_countries.add({"id": 81, "country": "Grenada"});
    dhl_countries.add({"id": 82, "country": "Guadeloupe"});
    dhl_countries.add({"id": 83, "country": "Guam"});
    dhl_countries.add({"id": 84, "country": "Guatemala"});
    dhl_countries.add({"id": 85, "country": "Guernsey"});
    dhl_countries.add({"id": 86, "country": "Guinea Republic"});
    dhl_countries.add({"id": 87, "country": "Guinea-Bissau"});
    dhl_countries.add({"id": 88, "country": "Guinea-Equatorial"});
    dhl_countries.add({"id": 89, "country": "Guyana (British)"});
    dhl_countries.add({"id": 90, "country": "Haiti"});
    dhl_countries.add({"id": 91, "country": "Honduras"});
    dhl_countries.add({"id": 92, "country": "Hong Kong"});
    dhl_countries.add({"id": 93, "country": "Hungary"});
    dhl_countries.add({"id": 94, "country": "Iceland"});
    dhl_countries.add({"id": 95, "country": "India"});
    dhl_countries.add({"id": 96, "country": "Indonesia"});
    dhl_countries.add({"id": 97, "country": "Iran"});
    dhl_countries.add({"id": 98, "country": "Iraq"});
    dhl_countries.add({"id": 99, "country": "Ireland"});
    dhl_countries.add({"id": 100, "country": "Israel"});
    dhl_countries.add({"id": 101, "country": "Italy"});
    dhl_countries.add({"id": 102, "country": "Ivory Coast"});
    dhl_countries.add({"id": 103, "country": "Jamaica"});
    dhl_countries.add({"id": 104, "country": "Japan"});
    dhl_countries.add({"id": 105, "country": "Jersey"});
    dhl_countries.add({"id": 106, "country": "Jordan"});
    dhl_countries.add({"id": 107, "country": "Kazakhstan"});
    dhl_countries.add({"id": 108, "country": "Kenya"});
    dhl_countries.add({"id": 109, "country": "Kiribati"});
    dhl_countries.add({"id": 110, "country": "Korea, D.P.R."});
    dhl_countries.add({"id": 111, "country": "Korea, Republic"});
    dhl_countries.add({"id": 112, "country": "KOSOVO"});
    dhl_countries.add({"id": 113, "country": "Kuwait"});
    dhl_countries.add({"id": 114, "country": "Kyrgyzstan"});
    dhl_countries.add({"id": 115, "country": "Lao People's Democratic Republic"});
    dhl_countries.add({"id": 116, "country": "Latvia"});
    dhl_countries.add({"id": 117, "country": "Lebanon"});
    dhl_countries.add({"id": 118, "country": "Lesotho"});
    dhl_countries.add({"id": 119, "country": "Liberia"});
    dhl_countries.add({"id": 120, "country": "Libya"});
    dhl_countries.add({"id": 121, "country": "Liechtenstein"});
    dhl_countries.add({"id": 122, "country": "Lithuania"});
    dhl_countries.add({"id": 123, "country": "Luxembourg"});
    dhl_countries.add({"id": 124, "country": "Macau"});
    dhl_countries.add({"id": 125, "country": "Macedonia"});
    dhl_countries.add({"id": 126, "country": "Madagascar"});
    dhl_countries.add({"id": 127, "country": "Malawi"});
    dhl_countries.add({"id": 128, "country": "Malaysia"});
    dhl_countries.add({"id": 129, "country": "Maldives"});
    dhl_countries.add({"id": 130, "country": "Mali"});
    dhl_countries.add({"id": 131, "country": "Malta"});
    dhl_countries.add({"id": 132, "country": "Marshall Islands"});
    dhl_countries.add({"id": 133, "country": "Martinique"});
    dhl_countries.add({"id": 134, "country": "Mauritania"});
    dhl_countries.add({"id": 135, "country": "Mauritius"});
    dhl_countries.add({"id": 136, "country": "Mayotte"});
    dhl_countries.add({"id": 137, "country": "Mexico"});
    dhl_countries.add({"id": 138, "country": "MICRONESIA"});
    dhl_countries.add({"id": 139, "country": "Moldova"});
    dhl_countries.add({"id": 140, "country": "Monaco"});
    dhl_countries.add({"id": 141, "country": "Mongolia"});
    dhl_countries.add({"id": 142, "country": "Montserrat"});
    dhl_countries.add({"id": 143, "country": "Morocco"});
    dhl_countries.add({"id": 144, "country": "Mozambique"});
    dhl_countries.add({"id": 145, "country": "Myanmar"});
    dhl_countries.add({"id": 146, "country": "Namibia"});
    dhl_countries.add({"id": 147, "country": "Nauru"});
    dhl_countries.add({"id": 148, "country": "Nepal"});
    dhl_countries.add({"id": 149, "country": "NETHERLANDS ANTILLES"});
    dhl_countries.add({"id": 150, "country": "Netherlands"});
    dhl_countries.add({"id": 151, "country": "Nevis"});
    dhl_countries.add({"id": 152, "country": "New Caledonia"});
    dhl_countries.add({"id": 153, "country": "New Zealand"});
    dhl_countries.add({"id": 154, "country": "Nicaragua"});
    dhl_countries.add({"id": 155, "country": "Niger"});
    dhl_countries.add({"id": 156, "country": "Nigeria"});
    dhl_countries.add({"id": 157, "country": "Niue"});
    dhl_countries.add({"id": 158, "country": "Norway"});
    dhl_countries.add({"id": 159, "country": "North macedonia(mk)"});
    dhl_countries.add({"id": 160, "country": "Oman"});
    dhl_countries.add({"id": 161, "country": "Pakistan"});
    dhl_countries.add({"id": 162, "country": "PALAU"});
    dhl_countries.add({"id": 163, "country": "Panama"});
    dhl_countries.add({"id": 164, "country": "Papua New Guinea"});
    dhl_countries.add({"id": 165, "country": "Paraguay"});
    dhl_countries.add({"id": 166, "country": "Peru"});
    dhl_countries.add({"id": 167, "country": "Philippines"});
    dhl_countries.add({"id": 168, "country": "Poland"});
    dhl_countries.add({"id": 169, "country": "Portugal"});
    dhl_countries.add({"id": 170, "country": "Puerto Rico"});
    dhl_countries.add({"id": 171, "country": "Qatar"});
    dhl_countries.add({"id": 172, "country": "Reunion, Island"});
    dhl_countries.add({"id": 173, "country": "Romania"});
    dhl_countries.add({"id": 174, "country": "Russian Federation"});
    dhl_countries.add({"id": 175, "country": "Rwanda"});
    dhl_countries.add({"id": 176, "country": "Saipan"});
    dhl_countries.add({"id": 177, "country": "Samoa"});
    dhl_countries.add({"id": 178, "country": "SAN MARINO"});
    dhl_countries.add({"id": 179, "country": "Sao Tome & Principe"});
    dhl_countries.add({"id": 180, "country": "Saudi Arabia"});
    dhl_countries.add({"id": 181, "country": "Senegal"});
    dhl_countries.add({"id": 182, "country": "Serbia & Montenegro"});
    dhl_countries.add({"id": 183, "country": "Seychelles"});
    dhl_countries.add({"id": 184, "country": "Sierra Leone"});
    dhl_countries.add({"id": 185, "country": "Singapore"});
    dhl_countries.add({"id": 186, "country": "Slovakia"});
    dhl_countries.add({"id": 187, "country": "Slovenia"});
    dhl_countries.add({"id": 188, "country": "Solomon Islands"});
    dhl_countries.add({"id": 189, "country": "Somalia"});
    dhl_countries.add({"id": 190, "country": "Somaliland"});
    dhl_countries.add({"id": 191, "country": "South Africa"});
    dhl_countries.add({"id": 192, "country": "Spain"});
    dhl_countries.add({"id": 193, "country": "Sri Lanka"});
    dhl_countries.add({"id": 194, "country": "St Helena"});
    dhl_countries.add({"id": 195, "country": "St. Barthelemy"});
    dhl_countries.add({"id": 196, "country": "St. Eustatius"});
    dhl_countries.add({"id": 197, "country": "St. Kitts"});
    dhl_countries.add({"id": 198, "country": "St. Lucia"});
    dhl_countries.add({"id": 199, "country": "St. Maarten"});
    dhl_countries.add({"id": 200, "country": "St. Vincent"});
    dhl_countries.add({"id": 201, "country": "Sudan"});
    dhl_countries.add({"id": 202, "country": "Suriname"});
    dhl_countries.add({"id": 203, "country": "Swaziland"});
    dhl_countries.add({"id": 204, "country": "Sweden"});
    dhl_countries.add({"id": 205, "country": "Switzerland"});
    dhl_countries.add({"id": 206, "country": "Syria"});
    dhl_countries.add({"id": 207, "country": "Tahiti"});
    dhl_countries.add({"id": 208, "country": "Taiwan"});
    dhl_countries.add({"id": 209, "country": "Tajikistan"});
    dhl_countries.add({"id": 210, "country": "Tanzania"});
    dhl_countries.add({"id": 211, "country": "Thailand"});
    dhl_countries.add({"id": 212, "country": "Togo"});
    dhl_countries.add({"id": 213, "country": "Tonga"});
    dhl_countries.add({"id": 214, "country": "Trinidad and Tobago"});
    dhl_countries.add({"id": 215, "country": "Tunisia"});
    dhl_countries.add({"id": 216, "country": "Turkey"});
    dhl_countries.add({"id": 217, "country": "Turkmenistan"});
    dhl_countries.add({"id": 218, "country": "Turks and Caicos Islands"});
    dhl_countries.add({"id": 219, "country": "Tuvalu"});
    dhl_countries.add({"id": 220, "country": "Uganda"});
    dhl_countries.add({"id": 221, "country": "Ukraine"});
    dhl_countries.add({"id": 222, "country": "U.A.E"});
    dhl_countries.add({"id": 223, "country": "United Kingdom"});
    dhl_countries.add({"id": 224, "country": "U.S.A"});
    dhl_countries.add({"id": 225, "country": "Uruguay"});
    dhl_countries.add({"id": 226, "country": "Uzbekistan"});
    dhl_countries.add({"id": 227, "country": "Vanuatu"});
    dhl_countries.add({"id": 228, "country": "Vatican city"});
    dhl_countries.add({"id": 229, "country": "Venezuela"});
    dhl_countries.add({"id": 230, "country": "Vietnam"});
    dhl_countries.add({"id": 231, "country": "Virgin Islands (British)"});
    dhl_countries.add({"id": 232, "country": "Virgin Islands (US)"});
    dhl_countries.add({"id": 233, "country": "Yemen"});
    dhl_countries.add({"id": 234, "country": "Zambia"});
    dhl_countries.add({"id": 235, "country": "Zimbabwe"});
  }

  void getFedexCountries() {
    fedex_countries.add({"id": 1, "country": "Afghanistan"});
    fedex_countries.add({"id": 2, "country": "Albania"});
    fedex_countries.add({"id": 3, "country": "Algeria"});
    fedex_countries.add({"id": 4, "country": "American Samoa"});
    fedex_countries.add({"id": 5, "country": "Andorra"});
    fedex_countries.add({"id": 6, "country": "Angola"});
    fedex_countries.add({"id": 7, "country": "Anguilla"});
    fedex_countries.add({"id": 8, "country": "Antigua"});
    fedex_countries.add({"id": 9, "country": "Argentina"});
    fedex_countries.add({"id": 10, "country": "Armenia"});
    fedex_countries.add({"id": 11, "country": "Aruba"});
    fedex_countries.add({"id": 13, "country": "Austria"});
    fedex_countries.add({"id": 14, "country": "Azerbaijan"});
    fedex_countries.add({"id": 12, "country": "Australia"});
    fedex_countries.add({"id": 15, "country": "Bahamas"});
    fedex_countries.add({"id": 16, "country": "Bahrain"});
    fedex_countries.add({"id": 17, "country": "Barbados"});
    fedex_countries.add({"id": 18, "country": "Belarus"});
    fedex_countries.add({"id": 19, "country": "Belgium"});
    fedex_countries.add({"id": 20, "country": "Belize"});
    fedex_countries.add({"id": 21, "country": "Benin"});
    fedex_countries.add({"id": 22, "country": "Bermuda"});
    fedex_countries.add({"id": 23, "country": "Bhutan"});
    fedex_countries.add({"id": 24, "country": "Bolivia"});
    fedex_countries.add({"id": 25, "country": "Bosnia"});
    fedex_countries.add({"id": 26, "country": "Botswana"});
    fedex_countries.add({"id": 27, "country": "Brazil"});
    fedex_countries.add({"id": 28, "country": "British Virgin Is."});
    fedex_countries.add({"id": 29, "country": "Brunei"});
    fedex_countries.add({"id": 30, "country": "Bulgaria"});
    fedex_countries.add({"id": 31, "country": "Burkina Faso"});
    fedex_countries.add({"id": 32, "country": "Burundi"});
    fedex_countries.add({"id": 33, "country": "Cambodia"});
    fedex_countries.add({"id": 34, "country": "Cameroon"});
    fedex_countries.add({"id": 35, "country": "Canada"});
    fedex_countries.add({"id": 36, "country": "Cape Verde"});
    fedex_countries.add({"id": 37, "country": "Cayman Islands"});
    fedex_countries.add({"id": 38, "country": "Cent Afr Rep"});
    fedex_countries.add({"id": 39, "country": "Chad"});
    fedex_countries.add({"id": 40, "country": "Chile"});
    fedex_countries.add({"id": 41, "country": "China"});
    fedex_countries.add({"id": 42, "country": "Colombia"});
    fedex_countries.add({"id": 43, "country": "Congo"});
    fedex_countries.add({"id": 44, "country": "Cook Islands"});
    fedex_countries.add({"id": 45, "country": "Costa Rica"});
    fedex_countries.add({"id": 46, "country": "Croatia"});
    fedex_countries.add({"id": 47, "country": "Cyprus"});
    fedex_countries.add({"id": 48, "country": "Czech Republic"});
    fedex_countries.add({"id": 49, "country": "Democratic Republic Of C"});
    fedex_countries.add({"id": 50, "country": "Denmark"});
    fedex_countries.add({"id": 51, "country": "Djibouti"});
    fedex_countries.add({"id": 52, "country": "Dominica"});
    fedex_countries.add({"id": 53, "country": "Dominican Republic"});
    fedex_countries.add({"id": 54, "country": "East Timor"});
    fedex_countries.add({"id": 55, "country": "Ecuador"});
    fedex_countries.add({"id": 56, "country": "Egypt"});
    fedex_countries.add({"id": 57, "country": "El Salvador"});
    fedex_countries.add({"id": 58, "country": "Equatorial Guinea"});
    fedex_countries.add({"id": 59, "country": "Eritrea"});
    fedex_countries.add({"id": 60, "country": "Estonia"});
    fedex_countries.add({"id": 61, "country": "Ethiopia"});
    fedex_countries.add({"id": 62, "country": "Fiji"});
    fedex_countries.add({"id": 63, "country": "Finland"});
    fedex_countries.add({"id": 64, "country": "France"});
    fedex_countries.add({"id": 65, "country": "French Guiana"});
    fedex_countries.add({"id": 66, "country": "French Polynesia"});
    fedex_countries.add({"id": 67, "country": "Gabon"});
    fedex_countries.add({"id": 68, "country": "Gambia"});
    fedex_countries.add({"id": 69, "country": "Georgia"});
    fedex_countries.add({"id": 70, "country": "Germany"});
    fedex_countries.add({"id": 71, "country": "Ghana"});
    fedex_countries.add({"id": 72, "country": "Gibraltar"});
    fedex_countries.add({"id": 73, "country": "Greece"});
    fedex_countries.add({"id": 74, "country": "Grenada"});
    fedex_countries.add({"id": 75, "country": "Guadeloupe"});
    fedex_countries.add({"id": 76, "country": "Guam"});
    fedex_countries.add({"id": 77, "country": "Guatemala"});
    fedex_countries.add({"id": 78, "country": "Guinea Bissau"});
    fedex_countries.add({"id": 79, "country": "Guinea"});
    fedex_countries.add({"id": 80, "country": "Guyana"});
    fedex_countries.add({"id": 81, "country": "Haiti"});
    fedex_countries.add({"id": 82, "country": "Honduras"});
    fedex_countries.add({"id": 83, "country": "Hong Kong"});
    fedex_countries.add({"id": 84, "country": "Hungary"});
    fedex_countries.add({"id": 85, "country": "Iceland"});
    fedex_countries.add({"id": 86, "country": "India"});
    fedex_countries.add({"id": 87, "country": "Indonesia"});
    fedex_countries.add({"id": 88, "country": "Iraq Republic"});
    fedex_countries.add({"id": 89, "country": "Ireland"});
    fedex_countries.add({"id": 90, "country": "Israel"});
    fedex_countries.add({"id": 91, "country": "Italy"});
    fedex_countries.add({"id": 92, "country": "Ivory Coast"});
    fedex_countries.add({"id": 93, "country": "Jamaica"});
    fedex_countries.add({"id": 94, "country": "Japan"});
    fedex_countries.add({"id": 95, "country": "Jordan"});
    fedex_countries.add({"id": 96, "country": "Kazakhstan"});
    fedex_countries.add({"id": 97, "country": "Kenya"});
    fedex_countries.add({"id": 98, "country": "Kuwait"});
    fedex_countries.add({"id": 99, "country": "Kyrgyzstan"});
    fedex_countries.add({"id": 100, "country": "Laos"});
    fedex_countries.add({"id": 101, "country": "Latvia"});
    fedex_countries.add({"id": 102, "country": "Lebanon"});
    fedex_countries.add({"id": 103, "country": "Lesotho"});
    fedex_countries.add({"id": 104, "country": "Liberia"});
    fedex_countries.add({"id": 105, "country": "Libya"});
    fedex_countries.add({"id": 106, "country": "Liechtenstein"});
    fedex_countries.add({"id": 107, "country": "Lithuania"});
    fedex_countries.add({"id": 108, "country": "Luxembourg"});
    fedex_countries.add({"id": 109, "country": "Macau"});
    fedex_countries.add({"id": 110, "country": "Macedonia"});
    fedex_countries.add({"id": 111, "country": "Madagascar"});
    fedex_countries.add({"id": 112, "country": "Malawi"});
    fedex_countries.add({"id": 113, "country": "Malaysia"});
    fedex_countries.add({"id": 114, "country": "Maldives"});
    fedex_countries.add({"id": 115, "country": "Mali"});
    fedex_countries.add({"id": 116, "country": "Malta"});
    fedex_countries.add({"id": 117, "country": "Marshall Islands"});
    fedex_countries.add({"id": 118, "country": "Martinique"});
    fedex_countries.add({"id": 119, "country": "Mauritania"});
    fedex_countries.add({"id": 120, "country": "Mauritius"});
    fedex_countries.add({"id": 121, "country": "Mexico"});
    fedex_countries.add({"id": 122, "country": "Micronesia"});
    fedex_countries.add({"id": 123, "country": "Moldova"});
    fedex_countries.add({"id": 124, "country": "Monaco"});
    fedex_countries.add({"id": 125, "country": "Mongolia"});
    fedex_countries.add({"id": 126, "country": "Montenegro"});
    fedex_countries.add({"id": 127, "country": "Montserrat"});
    fedex_countries.add({"id": 128, "country": "Morocco"});
    fedex_countries.add({"id": 129, "country": "Mozambique"});
    fedex_countries.add({"id": 130, "country": "Myanmar"});
    fedex_countries.add({"id": 131, "country": "Namibia"});
    fedex_countries.add({"id": 132, "country": "Nepal"});
    fedex_countries.add({"id": 133, "country": "Netherlands"});
    fedex_countries.add({"id": 134, "country": "New Caledonia"});
    fedex_countries.add({"id": 135, "country": "New Zealand"});
    fedex_countries.add({"id": 136, "country": "Nicaragua"});
    fedex_countries.add({"id": 137, "country": "Niger"});
    fedex_countries.add({"id": 138, "country": "Nigeria"});
    fedex_countries.add({"id": 139, "country": "Nl. Antilles"});
    fedex_countries.add({"id": 140, "country": "Norway"});
    fedex_countries.add({"id": 141, "country": "Oman"});
    fedex_countries.add({"id": 142, "country": "Pakistan"});
    fedex_countries.add({"id": 143, "country": "Palau"});
    fedex_countries.add({"id": 144, "country": "Palestine Authority"});
    fedex_countries.add({"id": 145, "country": "Panama"});
    fedex_countries.add({"id": 146, "country": "Papua New Guinea"});
    fedex_countries.add({"id": 147, "country": "Paraguay"});
    fedex_countries.add({"id": 148, "country": "Peru"});
    fedex_countries.add({"id": 149, "country": "Philippines"});
    fedex_countries.add({"id": 150, "country": "Poland"});
    fedex_countries.add({"id": 151, "country": "Portugal"});
    fedex_countries.add({"id": 152, "country": "Qatar"});
    fedex_countries.add({"id": 153, "country": "Reunion Island"});
    fedex_countries.add({"id": 154, "country": "Romania"});
    fedex_countries.add({"id": 155, "country": "Russia"});
    fedex_countries.add({"id": 156, "country": "Rwanda"});
    fedex_countries.add({"id": 157, "country": "Saipan"});
    fedex_countries.add({"id": 158, "country": "Samoa"});
    fedex_countries.add({"id": 159, "country": "Saudi Arabia"});
    fedex_countries.add({"id": 160, "country": "Senegal"});
    fedex_countries.add({"id": 161, "country": "Serbia And Montenegro"});
    fedex_countries.add({"id": 162, "country": "Serbia"});
    fedex_countries.add({"id": 163, "country": "Seychelles"});
    fedex_countries.add({"id": 164, "country": "Sierra Leone"});
    fedex_countries.add({"id": 165, "country": "Singapore"});
    fedex_countries.add({"id": 166, "country": "Slovak Republic"});
    fedex_countries.add({"id": 167, "country": "Slovenia"});
    fedex_countries.add({"id": 168, "country": "Somalia"});
    fedex_countries.add({"id": 169, "country": "South Africa"});
    fedex_countries.add({"id": 170, "country": "South Korea"});
    fedex_countries.add({"id": 171, "country": "Spain"});
    fedex_countries.add({"id": 172, "country": "Sri Lanka"});
    fedex_countries.add({"id": 173, "country": "St Kitts & Nevis"});
    fedex_countries.add({"id": 174, "country": "St. Lucia"});
    fedex_countries.add({"id": 175, "country": "St. Vincent"});
    fedex_countries.add({"id": 176, "country": "Sudan"});
    fedex_countries.add({"id": 177, "country": "Suriname"});
    fedex_countries.add({"id": 178, "country": "Swaziland"});
    fedex_countries.add({"id": 179, "country": "Sweden"});
    fedex_countries.add({"id": 180, "country": "Switzerland"});
    fedex_countries.add({"id": 181, "country": "Syria"});
    fedex_countries.add({"id": 182, "country": "Taiwan"});
    fedex_countries.add({"id": 183, "country": "Tanzania"});
    fedex_countries.add({"id": 184, "country": "Thailand"});
    fedex_countries.add({"id": 185, "country": "Togo"});
    fedex_countries.add({"id": 186, "country": "Tonga"});
    fedex_countries.add({"id": 187, "country": "Trinidad & Tobag"});
    fedex_countries.add({"id": 188, "country": "Tunisia"});
    fedex_countries.add({"id": 189, "country": "Turkey"});
    fedex_countries.add({"id": 190, "country": "Turkmenistan"});
    fedex_countries.add({"id": 191, "country": "Turks & Caicos I"});
    fedex_countries.add({"id": 192, "country": "U.A.E"});
    fedex_countries.add({"id": 193, "country": "U.S.A"});
    fedex_countries.add({"id": 194, "country": "Uganda"});
    fedex_countries.add({"id": 195, "country": "Ukraine"});
    fedex_countries.add({"id": 196, "country": "United Kingdom"});
    fedex_countries.add({"id": 197, "country": "Uruguay"});
    fedex_countries.add({"id": 198, "country": "Uzbekistan"});
    fedex_countries.add({"id": 199, "country": "Vanuatu"});
    fedex_countries.add({"id": 210, "country": "Vatican City"});
    fedex_countries.add({"id": 201, "country": "Venezuela"});
    fedex_countries.add({"id": 202, "country": "Vietnam"});
    fedex_countries.add({"id": 203, "country": "Virgin Islands"});
    fedex_countries.add({"id": 204, "country": "Wallis & Futuna"});
    fedex_countries.add({"id": 205, "country": "Yemen"});
    fedex_countries.add({"id": 206, "country": "Yugoslavia"});
    fedex_countries.add({"id": 207, "country": "Zaire"});
    fedex_countries.add({"id": 208, "country": "Zambia"});
    fedex_countries.add({"id": 209, "country": "Zimbabwe"});
  }

  Future<void> getData() async {

    if(dropdownvalue == '3 to 4 working days'){
      print("Baal Saal5");
      final dhlZone = await UserSheetsApi.getById_Dhl_zone(int.parse(this.dhl_countryId!));

      var dhl_zone = dhlZone!.toJson()["Zone"];

      print("Zone of Dhl: $dhl_zone");

      final dhl_ess_fuel_dollar = await UserSheetsApi.getById_Dhl_Ess(1);
      double ess = dhl_ess_fuel_dollar!.toJson()["ess"];
      double fuel = dhl_ess_fuel_dollar.toJson()["fuel"];
      double dollar = dhl_ess_fuel_dollar.toJson()["dollar"];
      double profit = dhl_ess_fuel_dollar.toJson()["profit"];

      print("Ess: $ess");
      print("Fuel: $fuel");
      print("Dollar: $dollar");
      print("Profit: $profit");

      //print(this.weightId);

      //Weight from the value
      double weight = double.parse(weightTextEditingController.text);
      print('Weight: $weight');

      //Weight in whole number
      int whole_weight = weight.toInt();
      print('Whole weight: $whole_weight');

      //Decimal values of weight
      double weight_decimals = weight - whole_weight;
      print('Decimal of weight: $weight_decimals');

      var value1 = 0.0;
      var value2 = 0.0;
      var value3 = 0.0;
      var value4 = 0.0;

      double final_weight = 0;

      if(weight_decimals == 0){
        final_weight = weight;
      }
      else if(weight <= 0.5){
        final_weight = whole_weight + 0.5;
      }
      else {
        if(weight_decimals < 0.5){
          final_weight = whole_weight + 0.5;
        }
        else if(weight_decimals == 0.5) {
          final_weight = weight;
        }
        else if(weight_decimals > 0.5) {
          final_weight = whole_weight + 1;
        }
      }
      print('Final Weight: ${final_weight}');

      int final_weight_above30 = final_weight.ceil();

      print('Final weight above 30: $final_weight_above30');

      if(final_weight <= 30) {
        //Fetching rate from google sheet
        final dhl_rate = await UserSheetsApi.getById_Dhl_rate(final_weight);
        var final_dhl_rate = dhl_rate!.toJson()["Zone $dhl_zone"];
        print("Final rate: $final_dhl_rate");


        value1 = final_dhl_rate + (ess * final_weight);
        value2 = value1 + value1 * fuel/100;
        value3 = value2 * dollar;
        value4 = value3 + value3 * profit/100;
        final_value = value4;
      }

      else if(final_weight > 30) {
        //Fetching rate from google sheet
        final dhl_rate = await UserSheetsApi.getById_Dhl_rate(31);
        var final_dhl_rate = dhl_rate!.toJson()["Zone $dhl_zone"];
        print("Final rate: $final_dhl_rate");

        value1 = final_dhl_rate + ess;
        value2 = value1 + value1 * fuel/100;
        value3 = value2 * dollar * final_weight_above30;
        value4 = value3 + value3 * profit/100;
        final_value = value4;
      }

      print("Final Value in taka: ${final_value.toInt()}");

      setState(() {
        _value = final_value.toInt();
      });
    }else if(dropdownvalue == '4 to 5 working days') {
      final fedexZone = await UserSheetsApi.getById_Fedex_zone(this.fedex_countryId!);

      var fedex_zone = fedexZone!.toJson()["Zone"];

      print("Fedex zone: $fedex_zone");

      double ess;

      //Ess_Fuel_dollar
      final fedex_ess_fuel_dollar = await UserSheetsApi.getById_Fedex_Ess(1);
      if(fedex_zone == 'G'){
        ess = 0.77;
      }
      else if(fedex_zone == 'H'){
        ess = 2;
      }
      else if(fedex_zone == 'I'){
        ess = 0.77;
      }
      else {
        ess = fedex_ess_fuel_dollar!.toJson()["ess"];
      }
      double fuel = fedex_ess_fuel_dollar!.toJson()["fuel"];
      double dollar = fedex_ess_fuel_dollar.toJson()["dollar"];
      double profit = fedex_ess_fuel_dollar.toJson()["profit"];

      print("Ess: $ess");
      print("Fuel: $fuel");
      print("Dollar: $dollar");
      print("Profit: $profit");

      double final_value = 0.0;

      //print(this.weightId);

      //Weight from the value
      double weight = double.parse(weightTextEditingController.text);
      print('Weight: $weight');

      //Weight in whole number
      int whole_weight = weight.toInt();
      print('Whole weight: $whole_weight');

      //Decimal values of weight
      double weight_decimals = weight - whole_weight;
      print('Decimal of weight: $weight_decimals');

      var value1 = 0.0;
      var value2 = 0.0;
      var value3 = 0.0;
      var value4 = 0.0;

      double final_weight = 0;

      if(weight_decimals == 0){
        final_weight = weight;
      }
      else if(weight <= 0.5){
        final_weight = whole_weight + 0.5;
      }
      else {
        if(weight_decimals < 0.5){
          final_weight = whole_weight + 0.5;
        }
        else if(weight_decimals == 0.5) {
          final_weight = weight;
        }
        else if(weight_decimals > 0.5) {
          final_weight = whole_weight + 1;
        }
      }
      print('Final Weight: ${final_weight}');

      int final_weight_above20 = final_weight.ceil();

      print('Final weight above 30: $final_weight_above20');

      if(final_weight <= 20) {
        //Fetching rate from google sheet
        final fedex_rate = await UserSheetsApi.getById_Fedex_rate(final_weight);
        var final_fedex_rate = fedex_rate!.toJson()["Zone $fedex_zone"];
        print("Final rate: $final_fedex_rate");


        value1 = final_fedex_rate + (ess * final_weight);
        value2 = value1 + value1 * fuel/100;
        value3 = value2 * dollar;
        value4 = value3 + value3 * profit/100;
        final_value = value4;
      }

      else if(final_weight > 20 && final_weight <= 30) {
        //Fetching rate from google sheet
        final fedex_rate = await UserSheetsApi.getById_Fedex_rate(21);
        var final_fedex_rate = fedex_rate!.toJson()["Zone $fedex_zone"];
        print("Final rate: $final_fedex_rate");

        value1 = final_fedex_rate + ess;
        value2 = value1 + value1 * fuel/100;
        value3 = value2 * dollar * final_weight_above20;
        value4 = value3 + value3 * profit/100;
        final_value = value4;
      }

      else if(final_weight > 30) {
        //Fetching rate from google sheet
        final fedex_rate = await UserSheetsApi.getById_Fedex_rate(31);
        var final_fedex_rate = fedex_rate!.toJson()["Zone $fedex_zone"];
        print("Final rate: $final_fedex_rate");

        value1 = final_fedex_rate + ess;
        value2 = value1 + value1 * fuel/100;
        value3 = value2 * dollar * final_weight_above20;
        value4 = value3 + value3 * profit/100;
        final_value = value4;
      }

      print("Final Value in taka: ${final_value.toInt()}");

      setState(() {
        _value = final_value.toInt();
      });
    }
  }

  formValidation(){
    if(nameTextEditingController.text.isNotEmpty
        && addressTextEditingController.text.isNotEmpty
        && weightTextEditingController.text.isNotEmpty
        && dropdownvalue != null
        && country != null
    ){
      //print("Baal Saal");
      DocumentReference reference = FirebaseFirestore.instance.collection("pickupRequest").doc();
      reference.set({
        "uid": reference.id,
        "date": DateTime.now(),
        "sender_uid": userModelCurrentInfo!.uid,
        "sender_name": userModelCurrentInfo!.name,
        "sender_address": userModelCurrentInfo!.address,
        "sender_phone": userModelCurrentInfo!.phone,
        "sender_email": userModelCurrentInfo!.email,
        "receiver_name": nameTextEditingController.text.trim(),
        "receiver_address": addressTextEditingController.text.trim(),
        "number_of_days": dropdownvalue.toString(),
        "country": country,
        "weight": weightTextEditingController.text.trim(),
        "amount": value.format(_value).toString(),
      });

      Navigator.push(context, MaterialPageRoute(builder: (c) => HomeScreen()));

    }
    else {
      showDialog(context: context, builder: (c)
      {
        return LoadingDialogWidget(
          message: "Some fields are empty",
        );
      }
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width > 900 ? 700 : 500,
        decoration: BoxDecoration(
          //color: Colors.white,
          color: darkTheme ? Colors.black45 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Request Pickup',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkTheme ? Colors.amberAccent.shade400 : Colors.black,
                  ),
                ),

                SizedBox(height: 10,),

                const Text(
                  'Pickup is only available in Dhaka City.'
                      '\nThere will be pickup charge depending on the location and size of the shipment.'
                      '\nBut will be no pickup charge if you drop shipment to our office.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20,),

                Container(
                  width: MediaQuery.of(context).size.width > 300 ? 400 : 300,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2,color: darkTheme ? Colors.amberAccent.shade400 : Colors.blue),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Receiver Name',
                          hintStyle: TextStyle(
                            color: darkTheme ? Colors.grey : Colors.grey,
                          ),
                          filled: true,
                          fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          //border: InputBorder.none,
                          prefixIcon: Icon(Icons.email, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                        ),
                      ),

                      const SizedBox(height: 20,),

                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Receiver Full Address',
                          hintStyle: TextStyle(
                            color: darkTheme ? Colors.grey : Colors.grey,
                          ),
                          filled: true,
                          fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          //border: InputBorder.none,
                          prefixIcon: Icon(Icons.email, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                        ),
                      ),

                      const SizedBox(height: 20,),

                      // TextField(
                      //   obscureText: true,
                      //   decoration: InputDecoration(
                      //     hintText: 'Password',
                      //     hintStyle: TextStyle(
                      //       color: darkTheme ? Colors.grey : Colors.grey,
                      //     ),
                      //     filled: true,
                      //     fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(40),
                      //       borderSide: const BorderSide(
                      //         width: 0,
                      //         style: BorderStyle.none,
                      //       ),
                      //     ),
                      //     //border: InputBorder.none,
                      //     prefixIcon: Icon(Icons.lock, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                      //   ),
                      // ),
                      //
                      // const SizedBox(height: 20,),

                      DropdownButtonFormField(
                          decoration: InputDecoration(
                            hintText: 'Select number of days',
                            prefixIcon: Icon(Icons.map,color: darkTheme ? Colors.amber : Colors.grey,),
                            filled: true,
                            fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                              print('$dropdownvalue');
                            });
                          }
                      ),

                      SizedBox(height: 20,),

                      //Dhl Dropdown country
                      Visibility(
                        visible: dropdownvalue == '' ? false : dropdownvalue == '3 to 4 working days' ? true : false,
                        child: Column(
                          children: [
                            FormHelper.dropDownWidgetCountry(
                              context,
                              "Select Country",
                              this.dhl_countryId,
                              this.dhl_countries,
                                  (onChangedVal) {
                                this.dhl_countryId = onChangedVal;
                                print("Selected Country ID: $onChangedVal");
                              },
                                  (onValidateVal) {
                                if(onValidateVal == null) {
                                  return 'Please Select Country';
                                }
                                return null;
                              },
                              optionValue: "id",
                              optionLabel: "country",
                            ),

                            SizedBox(height: 20,),

                            TextField(
                              controller: weightTextEditingController,
                              decoration: InputDecoration(
                                hintText: 'Weight',
                                hintStyle: TextStyle(
                                  color: darkTheme ? Colors.grey : Colors.grey,
                                ),
                                filled: true,
                                fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                //border: InputBorder.none,
                                prefixIcon: Icon(Icons.line_weight, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Fedex dropdown country
                      Visibility(
                        visible: dropdownvalue == '' ? false : dropdownvalue == '4 to 5 working days' ? true : false,
                        child: Column(
                          children: [
                            FormHelper.dropDownWidgetCountry(
                              context,
                              "Select Country",
                              this.fedex_countryId,
                              this.fedex_countries,
                                  (onChangedVal) {
                                this.fedex_countryId = onChangedVal;
                                print("Selected Country ID: $onChangedVal");
                              },
                                  (onValidateVal) {
                                if(onValidateVal == null) {
                                  return 'Please Select Country';
                                }
                                return null;
                              },
                              optionValue: "id",
                              optionLabel: "country",
                            ),

                            SizedBox(height: 20,),

                            TextField(
                              controller: weightTextEditingController,
                              decoration: InputDecoration(
                                hintText: 'Weight',
                                hintStyle: TextStyle(
                                  color: darkTheme ? Colors.grey : Colors.grey,
                                ),
                                filled: true,
                                fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                //border: InputBorder.none,
                                prefixIcon: Icon(Icons.line_weight, color: darkTheme ? Colors.amberAccent.shade400 : Colors.grey,),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20,),

                      // FormHelper.dropDownWidgetWeight(
                      //   context,
                      //   "Select Weight",
                      //   this.weightId,
                      //   this.weights,
                      //       (onChangedVal) {
                      //     this.weightId = onChangedVal;
                      //     print("Selected Weight: $onChangedVal");
                      //   },
                      //       (onValidateVal) {
                      //     if(onValidateVal == null) {
                      //       return 'Please Select Weight';
                      //     }
                      //     return null;
                      //   },
                      //   optionValue: "id",
                      //   optionLabel: "weight",
                      // ),

                      // SizedBox(height: 20,),

                      // DropdownButtonFormField(
                      //   decoration: InputDecoration(
                      //     hintText: 'Select Country',
                      //     prefixIcon: Icon(Icons.map,color: Colors.amber,),
                      //     filled: true,
                      //     fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(40),
                      //       borderSide: const BorderSide(
                      //         width: 0,
                      //         style: BorderStyle.none,
                      //       ),
                      //     ),
                      //   ),
                      //   items: items.map((String items) {
                      //     return DropdownMenuItem(
                      //       value: items,
                      //       child: Text(items),
                      //     );
                      //   }).toList(),
                      //   onChanged: (String? newValue) {
                      //     setState(() {
                      //       dropdownvalue = newValue!;
                      //       // print('$dropdownvalue');
                      //     });
                      //   }
                      // ),

                      // SizedBox(height: 20,),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: darkTheme ? Colors.amberAccent.shade400 : Colors.blue,
                          onPrimary: darkTheme ? Colors.black : Colors.white,
                          shadowColor: Colors.greenAccent,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          minimumSize: const Size(100, 40), //////// HERE
                        ),
                        onPressed: () async {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext c){
                                return ProgressDialog(message: "Calculating amount, Please wait...",);
                              }
                          );
                          await Future.delayed(Duration(seconds: 1)).then((value) => getData());
                          Navigator.pop(context);
                          showDialog(context: context,
                              builder: (context){
                                return Dialog(
                                  child: Container(
                                    margin: const EdgeInsets.all(8),
                                    padding: EdgeInsets.all(20),
                                    width: MediaQuery.of(context).size.width > 900 ? 700 : 500,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Center(
                                          child: new Text("Total Amount",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 23,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: new Text(
                                            '৳ ${value.format(_value)}',
                                            style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              icon: Icon(Icons.cancel,color: Colors.white,),
                                              label: Text('Cancel',style: TextStyle(color: Colors.white,),),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.red,
                                              ),
                                            ),

                                            const SizedBox(width: 25.0),

                                            ElevatedButton.icon(
                                              onPressed: () {
                                                formValidation();
                                              },
                                              icon: Icon(Icons.check,color: Colors.white,),
                                              label: Text('confirm',style: TextStyle(color: Colors.white,),),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                );
                              }
                          );
                        },
                        child: const Text('Submit'),
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 20,),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     TextButton(
                //       onPressed: () {
                //       },
                //       child: Text(
                //         "Doesn't have an account? Register",
                //         style: TextStyle(
                //           color: darkTheme ? Colors.amberAccent.shade400 : Colors.blue,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}