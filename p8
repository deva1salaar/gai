import os
from langchain_cohere import ChatCohere
from langchain_core.prompts import PromptTemplate
file_path=r"Text1.txt"
with open(file_path,'r',encoding='utf-8')as file:
 document_text=file.read()
print("Original document:\n",document_text)
os.environ["COHERE_API_KEY"]="your api key"
llm=ChatCohere()
prompt=PromptTemplate(
    input_variables=["document"],
    template="""
    You are a helpful assistant.
    Given the following documents,summarize it in bullet points,
    {document}
    Summary:
    """
)
chain=prompt|llm
response=chain.invoke({"document":document_text})
print("\nSummary:\n",response.content)
