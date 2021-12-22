
class Project {
  Project({
    required this.clientName,
    required this.hourRate,
    required this.projectId,
    required this.projectName,
    required this.userId,
  });

  String clientName;
  int hourRate;
  int projectId;
  String projectName;
  int userId;

  Project.fromJson(Map<String, dynamic> json) : this(
    clientName: json["clientName"],
    hourRate: json["hourRate"],
    projectId: json["projectId"],
    projectName: json["projectName"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "clientName": clientName,
    "hourRate": hourRate,
    "projectId": projectId,
    "projectName": projectName,
    "userId": userId,
  };
}