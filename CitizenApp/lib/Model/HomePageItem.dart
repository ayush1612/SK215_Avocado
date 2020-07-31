class HomePageItem {
  final String id;
  final String name;
  final String description;
  final String routeId;

  const HomePageItem({this.id, this.name, this.description, this.routeId});
}

List<HomePageItem> items = [
  const HomePageItem(
    id: "1",
    name: "FIR",
    description: "Kow about the status of FIR",
    routeId: "firstatus",
  ),
  const HomePageItem(
    id: "2",
    name: "Missing",
    description: "Missing people information",
    routeId: "missing",
  ),
  const HomePageItem(
      id: "3",
      name: "Instant Help",
      description: "Helpline numbers",
      routeId: "help"),
  const HomePageItem(
      id: "4",
      name: "My Profile",
      description: "Visit your profile",
      routeId: "profile")
];
