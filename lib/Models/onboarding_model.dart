class ObModel {
  final String title;
  final String description;
  final String image;

  ObModel({
    required this.title,
    required this.description,
    required this.image,
  });
}

List<ObModel> onboardingData = [
  ObModel(
    title: "Welcome to our app!",
    description: "Explore the amazing features of our app.",
    image: "assets/images/one.jpg",
  ),
  ObModel(
    title: "Track Your Tasks",
    description: "Manage your tasks and stay organized.",
    image: "assets/images/two.jpg",
  ),
  ObModel(
    title: "Get Started",
    description: "Join us and start your productive journey.",
    image: "assets/images/three.png",
  ),
];
