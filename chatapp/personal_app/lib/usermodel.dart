List<Users> users = [
  Users(
      id: "j157uP7gR5vfE9Ay19E2",
      name: "zizo",
      url:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHcCNWGMFoFQjmku__TIZZ9hPbplfneqQzw4htJfFgkHUUJZ8XxWEDo5MLTvPdeKSCes4&usqp=CAU")
];

class Users {
  String? name;
  String? url;
  String? id;
  Users({
    required this.name,
    required this.url,
    required this.id,
  });
}
