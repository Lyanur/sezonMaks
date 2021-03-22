String API_KEY = "vkrvekrvbwqlwkdnlkfnrfjRFWSVSFBF1257886DSAWF";
String URL_SERVER = "app.sezon.online";
String FULL_URL_SERVER = "https://app.sezon.online";

//Логин: exchange
//Пароль: bonusexchange
//
//1. ЗапуститьПроверкуПосредствомСМС, параметры (ФИО, Телефон)
//2. ДайКарту, параметры (УИД карты)
//3. ДайКлиентов, параметры (Телефон)

List<String> bonusTitle = [
  'НОВИЧОК',
  'ПОСЕТИТЕЛЬ',
  'ЛЮБИТЕЛЬ',
  'ОБОЖАТЕЛЬ',
  'ЗНАТОК',
  'ЦЕНИТЕЛЬ',
  'ВДОХНОВИТЕЛЬ',
  'ЭКСПЕРТ',
  'ПРОФЕССИОНАЛ',
  'ШОПОГОЛИК',
];

const String URL_GOOGLE_GEOCODE = "https://maps.googleapis.com/maps/api/geocode/json?";
const String URL_GOOGLE_DIRECTIONS = "https://maps.googleapis.com/maps/api/directions/json?";
const String Google_Server_Key = "AIzaSyBHehpY-pV-MILYoM3w0fVMTwFKvjF67d4";
const String phonePrefix = "7";

enum PermissionName {
  // iOS
  Internet,
  // both
  Calendar,
  // both
  Camera,
  // both
  Contacts,
  // both
  Microphone,
  // both
  Location,
  // Android
  Phone,
  // Android
  Sensors,
  // Android
  SMS,
  // Android
  Storage
}