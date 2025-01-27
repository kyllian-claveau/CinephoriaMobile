import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cinephoria_mobile/src/api/reservations_api.dart';
import 'package:cinephoria_mobile/src/layout/header.dart';
import 'package:cinephoria_mobile/src/layout/footer.dart';
import 'package:cinephoria_mobile/src/view/reservation_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const route = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> reservations = [];

  @override
  void initState() {
    super.initState();
    fetchReservations();
  }

  void fetchReservations() async {
    try {
      List<dynamic> fetchedReservations = await ReservationAPI.fetchReservations();
      setState(() {
        reservations = fetchedReservations;
      });
    } catch (e) {
      print('Error fetching reservations: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Échec de la récupération des réservations : $e')),
      );
    }
  }

  String _formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF232526), Color(0xFF414345)], // Dégradé subtil pour le fond
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Liste des Réservations',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Texte blanc
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: reservations.isEmpty
                  ? const Center(
                child: Text(
                  'Aucune réservation trouvée.',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )
                  : ListView.builder(
                itemCount: reservations.length,
                itemBuilder: (context, index) {
                  var reservation = reservations[index];
                  var now = DateTime.now();
                  var nextAvailableTime = DateTime(now.year, now.month, now.day, 10, 0, 0);
                  if (now.isAfter(nextAvailableTime)) {
                    nextAvailableTime = nextAvailableTime.add(Duration(days: 1));
                  }
                  var timeLeft = nextAvailableTime.difference(now);
                  return InkWell(
                    onTap: () {
                      // Naviguer vers la page de détails de la réservation
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReservationDetailScreen(reservation: reservation),
                        ),
                      );
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Color(0xFFEAB308), // Jaune
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(15),
                        title: Text(
                          'Réservation de ${reservation['user_firstname']} ${reservation['user_lastname']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            Text('Film: ${reservation['film']}',
                                style: const TextStyle(fontSize: 16, color: Colors.black)),
                            const SizedBox(height: 3),
                            Text('Date : ${_formatDate(reservation['start_date'])} - ${_formatDate(reservation['end_date'])}',
                                style: const TextStyle(fontSize: 16, color: Colors.black)),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const AppFooter(isHomeScreen: true),
          ],
        ),
      ),
    );
  }
}
