import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_services.dart';
import 'event_detail_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  DateTime selectedDate = DateTime.now();
  List<Map<String, dynamic>> events = [];
  List<Map<String, dynamic>> births = [];
  List<Map<String, dynamic>> deaths = [];

  // Map of event keywords → image URLs
  final Map<String, String> eventImages = {
    'Mangalyaan':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTb0TpOX6OEHe3YH3ibqCYa-New8m4_511GXg&s',
    'Chandrayaan':
        'https://upload.wikimedia.org/wikipedia/commons/3/30/Chandrayaan-1_artist_impression.jpg',
    'Space Day':
        'https://upload.wikimedia.org/wikipedia/commons/9/9f/ISRO_logo.svg',
    'Independence':
        'https://upload.wikimedia.org/wikipedia/commons/4/41/Indian_flag.jpg',
    'Republic Day':
        'https://upload.wikimedia.org/wikipedia/commons/4/45/India_Republic_Day_Parade.jpg',
    'Gandhi':
        'https://upload.wikimedia.org/wikipedia/commons/d/d1/Mahatma-Gandhi%2C_studio%2C_1931.jpg',
    'Nehru':
        'https://upload.wikimedia.org/wikipedia/commons/3/32/Jawaharlal_Nehru.jpg',
    'Ambedkar':
        'https://upload.wikimedia.org/wikipedia/commons/4/4b/B.R._Ambedkar_photo.jpg',
    'Kargil':
        'https://upload.wikimedia.org/wikipedia/commons/2/23/Kargil_battle.jpg',
    'Jallianwala':
        'https://upload.wikimedia.org/wikipedia/commons/2/2f/Jallianwala_Bagh_memorial.jpg',
  };

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Process events without Wikipedia summary but with sample images
  Future<void> _processEvents(List<Map<String, dynamic>> rawList,
      List<Map<String, dynamic>> targetList) async {
    final results = rawList.map((e) {
      String text = e['text'] ?? '';
      String image = '';

      // Assign image if the event text contains a keyword
      eventImages.forEach((key, url) {
        if (text.toLowerCase().contains(key.toLowerCase())) {
          image = url;
        }
      });

      return {
        'year': e['year'],
        'text': text,
        'image': image,
      };
    }).toList();

    targetList
      ..clear()
      ..addAll(results);
  }

  Future<void> fetchData() async {
    setState(() => isLoading = true);

    try {
      // Fetch history data for selected date
      final data = await ApiServices.fetchHistory(
        month: selectedDate.month,
        day: selectedDate.day,
      );

      // Filter Indian-related events, births, and deaths
      final rawEvents = (ApiServices.filterIndianEvents(data['Events'] ?? []))
          .cast<Map<String, dynamic>>();
      final rawBirths = (ApiServices.filterIndianEvents(data['Births'] ?? []))
          .cast<Map<String, dynamic>>();
      final rawDeaths = (ApiServices.filterIndianEvents(data['Deaths'] ?? []))
          .cast<Map<String, dynamic>>();

      // Process events to assign images based on keywords
      await Future.wait([
        _processEvents(rawEvents, events),
        _processEvents(rawBirths, births),
        _processEvents(rawDeaths, deaths),
      ]);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1500),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
      fetchData();
    }
  }

  Widget buildSection(String title, List<Map<String, dynamic>> list,
      Color color, IconData icon) {
    if (list.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          "No major Indian $title found 🕰️",
          style: TextStyle(fontSize: 16, color: color),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.9,
          ),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final e = list[index];
            final imageUrl = e['image'] ?? '';

            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => EventDetailBottomSheet(
                    title: '${e['year']} – ${e['text']}',
                    description: '',
                    imageUrl: imageUrl,
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Container(
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 80,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          image: imageUrl.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(imageUrl),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: imageUrl.isEmpty
                            ? Center(child: Icon(icon, size: 40, color: color))
                            : null,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        e['year']?.toString() ?? 'Year?',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: color),
                      ),
                      const SizedBox(height: 4),
                      Expanded(
                        child: Text(
                          e['text'] ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MMMM dd').format(selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Today in History – India 🇮🇳'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: fetchData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '📅 $formattedDate',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit_calendar),
                          onPressed: pickDate,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    buildSection('Events', events, Colors.teal, Icons.history),
                    buildSection(
                        'Births', births, Colors.deepPurple, Icons.cake),
                    buildSection('Deaths', deaths, Colors.redAccent,
                        Icons.sentiment_dissatisfied),
                  ],
                ),
              ),
            ),
    );
  }
}
