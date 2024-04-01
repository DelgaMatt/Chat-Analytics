class Analysis {
  const Analysis({
    required this.title,
    required this.response,
  });

  // final String id;
  final String title;
  final String response;
}

const pseudoData = [
  Analysis(
      title: "Quotes Reflecting Attitudes Towards Me",
      response:
          "John is always willing to lend a helping hand. He's such a kind-hearted person."
          "I admire John's positive attitude and enthusiasm. He's a pleasure to work with."),
  Analysis(
      title: "Conclusion",
      response:
          "In conclusion, the sentiment analysis conducted on the dataset reveals insightful patterns regarding public opinion. The majority of the data exhibits a positive sentiment, indicating a favorable perception of the subject matter. However, a notable portion of the dataset expresses negative sentiment, suggesting areas for improvement or concerns within the topic. Overall, this sentiment analysis provides valuable insights into the prevailing attitudes and emotions surrounding the subject, which can inform decision-making and strategic planning."),
  Analysis(
      title: "Favorite topics and interests",
      response:
          "Topics related to travel and exploration elicited mixed sentiments among users, with a balance between positive and negative reactions. While some users shared exciting travel experiences and breathtaking landscapes, others expressed concerns about travel restrictions and safety issues."),
  Analysis(
      title: "Least favorite topics and interests",
      response:
          "Despite the importance of health and wellness, discussions in this category often generated negative sentiments due to concerns about illness, healthcare challenges, and lifestyle-related issues. Posts related to mental health struggles and medical emergencies also contributed to the negative sentiment.")
];
