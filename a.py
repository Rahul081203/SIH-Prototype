import openai

API_KEY="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"

openai.api_key = API_KEY

response= openai.ChatCompletion.create(
    model="gpt-3.5-turbo",
    messages=[
        {"role":"user","content":"What is IPC Section 420?"}
        ])

print(response['choices'][0]['message']['content'])
