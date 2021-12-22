

class Project {
  int? projectId;
  String projectName;
  String? clientName;
  int hourRate;

  Project({this.projectId, required this.projectName, this.clientName, this.hourRate=0});

  Project.fromMap(Map<String, dynamic> res)
      : this(
    projectName: res["projectName"],
    projectId: res["projectId"],
    clientName: res["clientName"],
    hourRate: res["hourRate"],
  );

  Map<String, dynamic> toMap() {
    return {
      "projectId": projectId,
      "projectName": projectName,
      "clientName": clientName,
      "hourRate": hourRate,
    };
  }
}