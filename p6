
from transformers import pipeline
sentiment_pipeline = pipeline("sentiment-analysis")
reviews = [
 "The product quality is amazing! I'm really happy with my purchase.",
 "Terrible customer service. I will not buy from here again.",
 "It was okay, not great but not terrible either.",
 "Absolutely love it! Fast shipping and great packaging.",
 "The item arrived broken and the support team was unhelpful."
]

results = sentiment_pipeline(reviews)

for review, result in zip(reviews, results):
 print(f"Review: {review}")
 print(f"Sentiment: {result['label']}, Confidence: {result['score']:.2f}\n")
