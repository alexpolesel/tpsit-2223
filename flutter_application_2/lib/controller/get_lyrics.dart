import 'package:http/http.dart' as http;
import 'dart:convert';

class FetchLyrics {
  Future<String> getLyrics(String artist, String song) async {
    var url = Uri.https('api.musixmatch.com', '/ws/1.1/matcher.lyrics.get', {
    'apikey': '5a55214d4b1b8b815f9390350532c539',
    'q_artist': artist,
    'q_track':song
});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result != null && result['message'] != null && result['message']['body'] != null) {
        return result['message']['body']['lyrics']['lyrics_body'];
      }else{
         return "No lyrics found";
      }
    } else {
      return "Error";
    }
  }
}
