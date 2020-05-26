import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/keys.dart';

class WeatherModel {
  double latitude;
  double longitude;

  Future getLocation() async {
    Location _loc = Location();
    await _loc.getCurrentLocation();
    latitude = _loc.latitude;
    longitude = _loc.longitude;
    NetworkHelper _network = NetworkHelper(
        url: 'https://api.openweathermap.org/data/2.5/weather?'
            'lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');

    var decodedData = await _network.getData();

    return decodedData;
  }

  Future getCityLocation(String city) async {
    Location _loc = Location();
    NetworkHelper _network = NetworkHelper(
        url: 'https://api.openweathermap.org/data/2.5/weather?'
            'q=$city&appid=$apiKey&units=metric');

    var decodedData = await _network.getData();

    return decodedData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
