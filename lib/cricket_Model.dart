class CricketScore {
  final String ModelId;
  final String TeamOneName;
  final String TeamTwoName;
  final int TeamOneScore;
  final int TeamTwoScore;
  final bool isMatchRunning;
  final String winningTeam;

  CricketScore({
    required this.ModelId,
    required this.TeamOneName,
    required this.TeamTwoName,
    required this.TeamOneScore,
    required this.TeamTwoScore,
    required this.isMatchRunning,
    required this.winningTeam,
  });

  factory CricketScore.fromJson(String id, Map<String, dynamic> json) =>
      CricketScore(
        ModelId:id,
        TeamOneName:json['TeamOne'],
        TeamTwoName: json['TeamTwo'],
        TeamOneScore: json['TeamOneScore'],
        TeamTwoScore: json['TeamTwoScore'],
        isMatchRunning: json['isMatchRunning'],
        winningTeam:json['WinnerTeam'],
      );
  Map<String,dynamic> toJson(){
   return {
     'TeamOne':TeamOneName,
     'TeamTwo':TeamTwoName,
     'TeamOneScore':TeamOneScore,
     'TeamTwoScore':TeamTwoScore,
     'isMatchRunning':isMatchRunning,
     'WinnerTeam':winningTeam,
   };
  }
}
