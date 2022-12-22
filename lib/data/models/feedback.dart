class FeedbackItem {
  int id;
  String comment;
  int? officeId;
  int? workplaceId;
  int? guiltyId;
  int userId;
  DateTime date;

  FeedbackItem(this.id, this.comment, this.officeId, this.workplaceId,
      this.guiltyId, this.userId, this.date);

  FeedbackItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        comment = json['comment'],
        officeId = json['officeId'],
        workplaceId = json['workplaceId'],
        guiltyId = json['guiltyId'],
        userId = json['userId'],
        date = DateTime.parse(json['date']);
}
