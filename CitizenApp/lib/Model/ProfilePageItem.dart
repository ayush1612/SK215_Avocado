class ProfilePageItem {
  final String heading;
  final String data;
  final String icon;

  const ProfilePageItem({this.heading, this.data, this.icon});
}

List<ProfilePageItem> items = [
  const ProfilePageItem(
    heading: "Name",
    data: "Citizen",
    icon: "assets/img/name.png",
  ),
  const ProfilePageItem(
    heading: "Mobile No.",
    data: "1234567890",
    icon: "assets/img/mobileno.png",
  ),
  const ProfilePageItem(
    heading: "Email",
    data: "citizen@example.com",
    icon: "assets/img/email.png",
  ),
  const ProfilePageItem(
    heading: "City",
    data: "Bangalore",
    icon: "assets/img/city.png",
  ),
  const ProfilePageItem(
    heading: "State",
    data: "Karnataka",
    icon: "assets/img/state.png",
  ),
  const ProfilePageItem(
    heading: "Pincode",
    data: "560001",
    icon: "assets/img/pincode.png",
  ),
];
