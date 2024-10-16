class AppUrl{
  static const port = '3004';

  // static const hostedip = '52.66.145.37';

  static const hostedip = 'test.apis.dr1.co.in';

  // static const localip = '192.168.1.10';


  // static var baseUrl = 'http://${hostedip}:${port}';
  static var baseUrl = 'https://${hostedip}/medone';

  static var login = '$baseUrl/userLogin';
  static var addingDetails = '$baseUrl/addUserData';
  static var addingRoutine = '$baseUrl/addRoutine';

  static var getMedicine = '$baseUrl/getmedicine';

  static var addMedcineSchedule = '$baseUrl/addMedicineSchedule';
}