import os
import httpx
from groq import Groq
from g4f.client import Client
import google.generativeai as genai
import openai

def req_groq(content, model, tokens, temp):
  """groq 요청"""
  try:
    client = Groq(api_key = os.environ.get("GROQ_API_KEY"),)
    completion = client.chat.completions.create(
      model = model,
      messages = [{"role": "user", "content": content,}],
      max_tokens=tokens,
      temperature=temp,
    )
    return completion.choices[0].message.content
  except Exception as e:
    print(e)

def req_g4f(content, model, tokens, temp):
  """g4f 요청"""
  try:
    client = Client(base_url = "http://host.docker.internal:1337/v1",)
    completion = client.chat.completions.create(
        model=model,
        messages=[{"role": "user", "content": content,}],
        max_tokens=tokens,
        temperature=temp,
    )
    return completion.choices[0].message.content
  except Exception as e:
    print(e)

def req_gemini(content, model, tokens, temp):
  """gemini 요청"""
  try:  
    genai.configure(api_key = os.environ.get("GEMINI_API_KEY"),)
    completion = genai.GenerativeModel(model).generate_content(
      content,
      generation_config=genai.types.GenerationConfig(
        max_output_tokens=tokens,
        temperature=temp,
      ),
    )
    return completion.text
  except Exception as e:
    print(e)

def req_pawan(content, model, tokens, temp):
  """pawan 요청"""
  try:  
    proxy_host     = os.environ.get("PROXY_HOST")
    proxy_port = int(os.environ.get("PROXY_PORT"))
    proxy_addr = f"http://{proxy_host}:{proxy_port}"
    openai.api_key = os.environ.get("PAWAN_API_KEY")
    openai.base_url = f"https://api.pawan.krd/{model}/v1"
    openai.http_client = httpx.Client(proxies = proxy_addr)
    completion = openai.chat.completions.create(
      model = "gpt-3.5-turbo",
      messages=[{"role": "user", "content": content,}],
      max_tokens=tokens,
      temperature=temp,
    )
    return completion.choices[0].message.content
  except Exception as e:
    print(e)

def req_com(content, model):
  """공통 요청"""
  if model == "gemma2-9b-it":
    res = req_groq(content, model, 8192, 0.1)
  elif model == "llama3-groq-70b-8192-tool-use-preview":
    res = req_groq(content, model, 8192, 0.1)
  elif model == "llama-3.1-70b-versatile":
    res = req_groq(content, model, 8000, 0.1)
  elif model == "llama-3.2-90b-text-preview":
    res = req_groq(content, model, 8192, 0.1)
  elif model == "llama3-70b-8192":
    res = req_groq(content, model, 8192, 0.1)
  elif model == "mixtral-8x7b-32768":
    res = req_groq(content, model, 32768, 0.1)
  elif model == "gpt-4o-mini":
    res = req_g4f(content, model, 8192, 0.1)
  elif model == "gpt-3.5-turbo":
    res = req_g4f(content, model, 8000, 0.1)
  elif model == "gemini-1.5-flash":
    res = req_gemini(content, model, 8192, 0.1)
  elif model == "cosmosrp":
    res = req_pawan(content, model, 16384, 0.1)
  elif model == "cosmosrp-it":
    res = req_pawan(content, model, 16384, 0.1)
  return res