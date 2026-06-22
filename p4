import cohere
import nltk
import string
import gensim.downloader as api
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize

nltk.download('punkt', quiet=True)
nltk.download('stopwords', quiet=True)
nltk.download('punkt_tab', quiet=True)

COHERE_API_KEY = 'api key'  

word_vectors = api.load('glove-wiki-gigaword-50')
co = cohere.ClientV2(COHERE_API_KEY)
stop_words = set(stopwords.words('english'))

def get_similar_words(prompt, top_n=3):
    words = [w for w in word_tokenize(prompt.lower()) if w not in stop_words and w not in string.punctuation]
    enriched = []
    for w in words:
        if w in word_vectors.key_to_index:
            enriched.extend([t[0] for t in word_vectors.most_similar(w, topn=top_n)])
    return ' '.join(set(enriched))

def get_response(prompt):
    try:
        r = co.chat(model='command-a-03-2025',
                    messages=[{'role': 'user', 'content': prompt}],
                    max_tokens=200, temperature=0.7)
        return r.message.content[0].text
    except Exception as e:
        return f'Error: {e}'

original = 'Describe the future of artificial intelligence in education.'
enriched = original + ' ' + get_similar_words(original)

print('Original Prompt:', original)
print('\nOriginal Response:\n', get_response(original))
print('\nEnriched Prompt:', enriched)
print('\nEnriched Response:\n', get_response(enriched))
