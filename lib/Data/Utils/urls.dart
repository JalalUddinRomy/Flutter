class Urls {
  static const String _baseUrl='https://task.teamrabbil.com/api/v1';
  static const String registration='$_baseUrl/registration';
  static const String login='$_baseUrl/login';
  static const String createTask='$_baseUrl/createTask';
  static const String getNewTask='$_baseUrl/listTaskByStatus/New';
  static const String completedTask='$_baseUrl/listTaskByStatus/Completed';
  static const String cancelledTask='$_baseUrl/listTaskByStatus/Cancelled';
  static const String progressTask='$_baseUrl/listTaskByStatus/Progress';
  static const String countTask='$_baseUrl/taskStatusCount';
  static const String updateProfile='$_baseUrl/profileUpdate';
  static const String resetPassword='$_baseUrl/RecoverResetPass';
  static String updateStatus(String taskId,String status)=> '$_baseUrl/updateTaskStatus/$taskId/$status';
  static String deleteStatus(String taskId)=> '$_baseUrl/deleteTask/$taskId';
  static String verifyEmail(String email)=> '$_baseUrl/RecoverVerifyEmail/$email';
  static String verifyOTP(String email,String verifyOtp)=> '$_baseUrl/RecoverVerifyOTP/$email/$verifyOtp';
}