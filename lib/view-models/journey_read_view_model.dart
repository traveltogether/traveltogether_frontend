class JourneyReadViewModel{
  int id;
  int userId;
  String startAddress;
  String endAddress;
  String approximateStartAddress;
  String approximateEndAddress;
  int departureTime;
  int arrivalTime;
  String note;
  bool isOpenForRequests;
  List<int> pendingUserIds;
  List<int> acceptedUserIds;
  List<int> declinedUserIds;
}