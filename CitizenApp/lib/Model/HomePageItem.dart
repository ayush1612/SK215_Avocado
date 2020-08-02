class HomePageItem {
  final String id;
  final String name;
  final String description;
  final String icon;
  final String routeId;

  const HomePageItem(
      {this.id, this.name, this.description, this.icon, this.routeId});
}

List<HomePageItem> items = [
  const HomePageItem(
    id: "1",
    name: "FIR",
    description: "Kow about the status of FIR",
    icon: "assets/img/citizen-app.png",
    routeId: "firstatus",
  ),
  const HomePageItem(
    id: "2",
    name: "Missing",
    description: "Missing people information",
    icon: "assets/img/citizen-app.png",
    routeId: "missing",
  ),
  const HomePageItem(
    id: "3",
    name: "NOC Application",
    description: "Apply for NOC",
    icon: "assets/img/noc.png",
    routeId: "noc",
  ),
  const HomePageItem(
      id: "4",
      name: "Instant Help",
      description: "Helpline numbers",
      icon: "assets/img/citizen-app.png",
      routeId: "help"),
  const HomePageItem(
      id: "5",
      name: "My Profile",
      description: "Visit your profile",
      icon: "assets/img/citizen-app.png",
      routeId: "profile")
];
