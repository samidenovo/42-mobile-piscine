import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http; //as http -> alias
import 'dart:convert'; //convert JSON
import 'package:geocoding/geocoding.dart';

void main() {
  runApp(const MyApp());
}

String getWeatherDescription(int code) {
  if (code == 0) return 'Clear sky';
  if (code <= 3) return 'Partly cloudy';
  if (code <= 48) return 'Foggy';
  if (code <= 57) return 'Drizzle';
  if (code <= 67) return 'Rainy';
  if (code <= 77) return 'Snowy';
  if (code <= 82) return 'Rain showers';
  if (code <= 86) return 'Snow showers';
  if (code <= 99) return 'Thunderstorm';
  return 'Unknown';
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}//MyApp

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late TabController  _tabController;
  late TextEditingController  _textController;
  Map<String, dynamic>? weatherData;
  Map<String, dynamic>? locationData;
  String  errorMessage = '';
  List<dynamic> suggestions = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _textController = TextEditingController();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textController.dispose();
    super.dispose();
  }

  //GPS current location
  Future<void> _getCurrentLocation() async {
    bool  serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        errorMessage = 'Location services not available.';
      });
      return ;
    }
    LocationPermission  permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied){
        setState(() {
          errorMessage = 'Location permissions are denied.';
        });
        return ;
      }
    }
    if (permission == LocationPermission.deniedForever){
      setState(() {
        errorMessage = 'Location permissions are permanently denied, we cannot request permission.';
        suggestions = [];
      });
      return ;
    }
    Position position = await Geolocator.getCurrentPosition();
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isEmpty) {
        throw Exception('No placemark found');
      }
      final place = placemarks.first;
      final cityLocation = {
        'name': place.locality
          ?? place.subAdministrativeArea
          ?? place.administrativeArea
          ?? place.street
          ?? 'Unknown',
        'admin1': place.administrativeArea ?? '',
        'country': place.country ?? '',
        'latitude': position.latitude,
        'longitude': position.longitude,
      };
      await fetchWeather(position.latitude, position.longitude, cityLocation);
    }
    catch (e) {
      await fetchWeather(
        position.latitude,
        position.longitude,
        {
          'name': 'My Location',
          'admin1': '',
          'country': '',
          'latitude': position.latitude,
          'longitude': position.longitude,
        },
      );
    }
  }
  //end of GPS current location
  //API Searcher

  Future<void>  searchCity(String query) async {
    if (query.isEmpty) {
      setState(() {
        suggestions = [];
      });
      return;
    }
    try {
      final response = await http.get(Uri.parse(
        'https://geocoding-api.open-meteo.com/v1/search?name=$query&count=5'
      ));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          suggestions = data['results'] ?? [];
          if (suggestions.isEmpty) {
            errorMessage = 'Couldn\'t find any result';
          }
          else {
            errorMessage = '';
          }
        });
      }
    }
    catch (e) {
      setState(() {
        errorMessage = 'The service connection is lost, please check your internet connection or try again later.';
        suggestions = [];
      });
    }
  }
  //end of API Searcher

  void  selectCity(dynamic city) async {
    setState(() {
      suggestions = [];
      _textController.clear();
    });
    await fetchWeather(city['latitude'], city['longitude'], city);
  }
  //API Weather
  Future<void>  fetchWeather(double lat, double lon, dynamic city) async {
    try {
      final response = await http.get(Uri.parse(
        'https://api.open-meteo.com/v1/forecast'
        '?latitude=$lat&longitude=$lon'
        '&current=temperature_2m,wind_speed_10m,weather_code'
        '&hourly=temperature_2m,wind_speed_10m,weather_code'
        '&daily=temperature_2m_max,temperature_2m_min,weather_code'
        '&timezone=auto'
        '&forecast_days=7'
      ));
      if (response.statusCode == 200) {
        setState(() {
          weatherData = json.decode(response.body);
          locationData = city;
          errorMessage = '';
        });
      }
    }
    catch (e) {
      setState(() {
        errorMessage = 'Service connection lost.';
      });
    }
  }
  //Tab builders
  Widget _buildCurrently() {
    if (weatherData == null) {
      return Center(child: Text('Currently'));
    }
    final current = weatherData!['current'];
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(locationData!['name'] ?? '', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(locationData!['admin1'] ?? '', style: TextStyle(fontSize: 18)),
          Text(locationData!['country'] ?? '', style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          Text('${current['temperature_2m']}°C', style: TextStyle(fontSize: 48)),
          Text(getWeatherDescription(current['weather_code']), style: TextStyle(fontSize: 20)),
          Text('${current['wind_speed_10m']} km/h', style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }

  Widget  _buildToday() {
    if (weatherData == null) {
      return Center(child: Text('Today'));
    }
    final hourly = weatherData!['hourly'];
    final String today = DateTime.now().toIso8601String().substring(0, 10);
    List<int> todayIndexes = [];
    for (int i = 0; i < hourly['time'].length; i++) {
      if (hourly['time'][i].toString().startsWith(today)) {
        todayIndexes.add(i);
      }
    }
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Text(locationData!['name'] ?? '', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('${locationData!['admin1'] ?? ''}, ${locationData!['country'] ?? ''}', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: todayIndexes.length,
            itemBuilder: (context, index) {
              final i = todayIndexes[index];
              return ListTile(
                title: Text(hourly['time'][i].toString().substring(11, 16)),
                subtitle: Text(getWeatherDescription(hourly['weather_code'][i])),
                trailing: Text('${hourly['temperature_2m'][i]}°C  ${hourly['wind_speed_10m'][i]}km/h'),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget  _buildWeekly() {
    if (weatherData == null) {
      return Center(child: Text('Weekly'));
    }
    final daily = weatherData!['daily'];

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Text(locationData!['name'] ?? '', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('${locationData!['admin1'] ?? ''}, ${locationData!['country'] ?? ''}', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: daily['time'].length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(daily['time'][index]),
                subtitle: Text(getWeatherDescription(daily['weather_code'][index])),
                trailing: Text('${daily['temperature_2m_min'][index]}°C / ${daily['temperature_2m_max'][index]}°C'),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget  build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Search location...',
              border: InputBorder.none,
            ),
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {
                  errorMessage = '';
                  suggestions = [];
                });
              }
              else {
                searchCity(value);
              }
            },
            onSubmitted: (value) {
              searchCity(value);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                searchCity(_textController.text);
              },
            ),
            IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () {
                _getCurrentLocation();
              }
            ),
          ],
        ),//appBar
      body: Column(
        children: [
          if (suggestions.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final city = suggestions[index];
                return ListTile(
                  title: Text(city['name'] ?? ''),
                  subtitle: Text('${city['admin1'] ?? ''}, ${city['country'] ?? ''}'),
                  onTap: () => selectCity(city),
                );
              },
            ),
          if(errorMessage.isNotEmpty)
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              )
            ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCurrently(),
                _buildToday(),
                _buildWeekly(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.wb_sunny),
              text: 'Currently'
            ),
            Tab(
              icon: Icon(Icons.today),
              text: 'Today',
            ),
            Tab(
              icon: Icon(Icons.calendar_view_week),
              text: 'Weekly',
            ),
          ],
        ),
      ),//bottomnavigationbar
      ),
    );
  }//build
}//_MyAppState