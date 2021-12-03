class Welcome {
  Welcome({
    required this.answered,
    required this.replyType,
    required this.link,
    required this.reply,
  });

  bool answered;
  String replyType;
  String link;
  String reply;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        answered: json["answered"],
        replyType: json["reply_type"],
        link: json["link"],
        reply: json["reply"],
      );

  Map<String, dynamic> toJson() => {
        "answered": answered,
        "reply_type": replyType,
        "link": link,
        "reply": reply,
      };
}
