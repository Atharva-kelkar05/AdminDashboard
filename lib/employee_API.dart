import 'dart:convert';
import 'package:http/http.dart' as http;
// There is a problem with the given API endpoint. It is not returning the data in the correct format,i.e., the data is not in the form of a list of maps. So, we will have to make some changes to the fetchEmployees() function. Let's update the fetchEmployees() function in employee_API.dart as follows:
// Hence I am not using the API call in this projecta and giving the data directly in the form of a list of maps.

class EmployeeAPI {
  static Future<List<Map<String, dynamic>>> fetchEmployees() async {
    final response = await http.get(
      Uri.parse('https://geektrust.s3-ap-southeast-1.amazonaws.com/adminui-problem/members.json'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load employees');
    }
  }
}
