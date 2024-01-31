import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'KEVIN MORENO - ROBERTO CHACON';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              DestinationCard(
                name: 'Machu Picchu',
                location: 'Perú',
                image: 'lib/images/machu_picchu.jpg',
                description:
                    'Machu Picchu es una ciudadela inca ubicada en lo alto de los Andes en Perú.',
              ),
              DestinationCard(
                name: 'Cataratas del Iguazú',
                location: 'Argentina/Brasil',
                image: 'lib/images/iguazu_falls.jpg',
                description:
                    'Las Cataratas del Iguazú son una serie de cascadas en el río Iguazú en la frontera de Argentina y Brasil.',
              ),
              DestinationCard(
                name: 'Islas Galápagos',
                location: 'Ecuador',
                image: 'lib/images/galapagos_islands.jpg',
                description:
                    'Las Islas Galápagos son un archipiélago volcánico en el Océano Pacífico, conocido por su variada fauna.',
              ),
              DestinationCard(
                name: 'Salar de Uyuni',
                location: 'Bolivia',
                image: 'lib/images/salar_de_uyuni.jpg',
                description:
                    'El Salar de Uyuni es el salar más grande del mundo, ubicado en el suroeste de Bolivia.',
              ),
              DestinationCard(
                name: 'Río de Janeiro',
                location: 'Brasil',
                image: 'lib/images/rio_de_janeiro.jpg',
                description:
                    'Río de Janeiro es una ciudad vibrante conocida por sus icónicos puntos de referencia, incluida la estatua del Cristo Redentor.',
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}

class DestinationCard extends StatelessWidget {
  const DestinationCard({
    Key? key,
    required this.name,
    required this.location,
    required this.image,
    required this.description,
  }) : super(key: key);

  final String name;
  final String location;
  final String image;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageSection(image: image),
        TitleSection(name: name, location: location),
        ButtonSection(),
        TextSection(description: description),
      ],
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({
    Key? key,
    required this.name,
    required this.location,
  }) : super(key: key);

  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  location,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          FavoriteButton(),
        ],
      ),
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ButtonWithText(
            color: color,
            icon: Icons.call,
            label: 'CALL',
          ),
          ButtonWithText(
            color: color,
            icon: Icons.near_me,
            label: 'ROUTE',
          ),
          ButtonWithText(
            color: color,
            icon: Icons.share,
            label: 'SHARE',
          ),
        ],
      ),
    );
  }
}

class ButtonWithText extends StatelessWidget {
  const ButtonWithText({
    Key? key,
    required this.color,
    required this.icon,
    required this.label,
  }) : super(key: key);

  final Color color;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class TextSection extends StatelessWidget {
  const TextSection({
    Key? key,
    required this.description,
  }) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Text(
        description,
        softWrap: true,
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({Key? key, required this.image}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      width: 600,
      height: 240,
      fit: BoxFit.cover,
    );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool _isFavorited = true;
  int _favoriteCount = 41;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 24.0, end: 48.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;

      if (_isFavorited) {
        _favoriteCount += 1;
        _controller.forward();
      } else {
        _favoriteCount -= 1;
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggleFavorite,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(0),
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Icon(
                  _isFavorited ? Icons.star : Icons.star_border,
                  color: Colors.red[500],
                  size: _animation.value,
                );
              },
            ),
          ),
          SizedBox(
            width: 18,
            child: SizedBox(
              child: Text('$_favoriteCount'),
            ),
          ),
        ],
      ),
    );
  }
}
