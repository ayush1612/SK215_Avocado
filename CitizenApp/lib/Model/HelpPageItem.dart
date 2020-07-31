class HelpPageItem {
  final String id;
  final String name;
  final int number;
  final String icon;

  const HelpPageItem({this.id, this.name, this.number, this.icon});
}

List<HelpPageItem> items = [
  const HelpPageItem(
    id: "1",
    name: "Dial 100",
    number: 100,
    icon: "assets/img/100.png",
  ),
  const HelpPageItem(
    id: "2",
    name: "National Emergency Number",
    number: 112,
    icon: "assets/img/emergency.png",
  ),
  const HelpPageItem(
    id: "3",
    name: "Women Helpline",
    number: 1091,
    icon: "assets/img/woman-1.png",
  ),
  const HelpPageItem(
    id: "4",
    name: "Domestic Abuse Helpline",
    number: 181,
    icon: "assets/img/domestic.png",
  ),
  const HelpPageItem(
    id: "5",
    name: "Missing Child and Women",
    number: 1094,
    icon: "assets/img/woman-2.png",
  ),
  const HelpPageItem(
    id: "6",
    name: "Senior Citizen Helpline",
    number: 1291,
    icon: "assets/img/senior.png",
  ),
  const HelpPageItem(
    id: "7",
    name: "Children In Difficult Situation",
    number: 1098,
    icon: "assets/img/child-1.png",
  )
];
