
class Project {
  String projectName;
  String? clientName;
  double hourRate;

  static final dummyProjects = [
    new Project("Toggl Clone", hourRate: 100),
    new Project("Stock Market Analyzer", hourRate: 150),
    new Project("Scratch Clone", hourRate: 150),
  ];

  Project(this.projectName, {this.clientName, this.hourRate=0});

}