class AppUrl{
  // static const port = '3004';
  static const port = '3003';

  // static const hostedip = '52.66.145.37';

  // static const hostedip = 'test.apis.dr1.co.in';

  static const hostedip = '13.232.117.141';


  // static var baseUrl = 'http://${hostedip}:${port}';
  // static var baseUrl = 'https://${hostedip}/medone';
  static var baseUrl = 'http://${hostedip}:${port}/medone';

  static var login = '$baseUrl/userLogin';

  static var addingDetails = '$baseUrl/addUserData';

  static var addingRoutine = '$baseUrl/addRoutine';

  static var editRoutine = '$baseUrl/editroutine';

  static var gettingRoutine = '$baseUrl/getUserRoutine';

  static var getMedicine = '$baseUrl/getmedicine';

  static var addMedcineSchedule = '$baseUrl/addMedicineSchedule';

  static var addNewMedcine = '$baseUrl/addnewmedicine';

  static var fetchProfile = '$baseUrl/userprofile';

  static var editProfile = '$baseUrl/edituserprofile';

  static var notifyMedicineSchedule = '$baseUrl/notifymedicineschedule';

  static var statusChanging = '$baseUrl/addStatus';

  static var refilNotification = '$baseUrl/refillnotification';

  static var getNotification = '$baseUrl/getnotification';

  static var getmyMedicine = '$baseUrl/getMedicineAddedByUser';

  static var addingFeedback = '$baseUrl/addFeedback';

  static var getAddedFeedback = '$baseUrl/getAddedFeedback';

  static var changingNotificationStatus = '$baseUrl/addSeenStatus';

  static var medicationHistory = '$baseUrl/medicationhistory';

  static var chatbot = '$baseUrl/updatedchat';

  static var addtoken = '$baseUrl/addToken';

  static var firebaseNotification = 'http://13.232.117.141:3003/send-notification';

}