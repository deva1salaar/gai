import cohere
import gensim.downloader as api
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
import string
COHERE_API_KEY = '3AXoiH6YF5rSl9caQfZY5fKV5Q2MbHdusDSLJu00'
word_vectors = api.load("glove-wiki-gigaword-50")
def get_similar_words(prompt, top_n=3):
 stop_words = set(stopwords.words("english"))
 words = word_tokenize(prompt.lower())
 filtered_words = [
 word for word in words
 if word not in stop_words and word not in string.punctuation
 ]
 enriched_words = []
 for word in filtered_words:
 if word in word_vectors.key_to_index:
 try:
 similar_words = [
 tup[0] for tup in word_vectors.most_similar(word, topn=top_n)
 ]
 enriched_words.extend(similar_words)
 except KeyError:
 pass
Generative AI BAIL657C

Dept. of CSE (AI & ML), JSSATEB 2025-2026 Page 17
 return " ".join(set(enriched_words))
co = cohere.ClientV2(COHERE_API_KEY)
def generate_cohere_response(prompt):
 try:
 response = co.chat(
 model="command-a-03-2025",
 messages=[
 {"role": "user", "content": prompt}
 ],
 max_tokens=200,
 temperature=0.7
 )
 return response.message.content[0].text
 except Exception as e:
 print(f"Error generating response: {e}")
 return None

prompt = "What is the importance of artificial intelligence in modern society?"
response = generate_cohere_response(prompt)
print("\nCohere Response:\n", response)
original_prompt = "Describe the future of artificial intelligence in education."
similar_words = get_similar_words(original_prompt)
enriched_prompt = original_prompt + " " + similar_words
original_response = generate_cohere_response(original_prompt)
enriched_response = generate_cohere_response(enriched_prompt)
print("\nOriginal Prompt:", original_prompt)
print("\nGenerated Response (Original Prompt):\n", original_response)
print("\nEnriched Prompt:", enriched_prompt)
print("\nGenerated Response (Enriched Prompt):\n", enriched_response)
