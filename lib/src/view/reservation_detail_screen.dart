import 'package:flutter/material.dart';
import 'package:cinephoria_mobile/src/layout/header.dart';
import 'package:cinephoria_mobile/src/layout/footer.dart';
import 'package:intl/intl.dart';

class ReservationDetailScreen extends StatelessWidget {
  final dynamic reservation;

  const ReservationDetailScreen({Key? key, required this.reservation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Informations sur l'utilisateur
              Text(
                'Réservation de ${reservation['user_firstname']} ${reservation['user_lastname']}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                'Film: ${reservation['film']}',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                'Date: ${_formatDate(reservation['start_date'])} - ${_formatDate(reservation['end_date'])}',
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
              const SizedBox(height: 20),

              // QR code
              if (reservation['url'] != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Scannez votre QR Code',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    Image.network(
                      'https://cinephoria.ovh/${reservation['url']}',
                      height: 250,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Présentez ce QR code lors de l\'entrée.',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFF232526), // Fond sombre comme dans le login
      bottomNavigationBar: AppFooter(isHomeScreen: false),
    );
  }

  String _formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('dd MMM yyyy').format(dateTime);
  }
}
