## Covid API
import pandas as pd
from requests import get
import json

country = 'Thailand'

url = f"https://covid-api.mmediagroup.fr/v1/cases?country={country}"
response = get(url=url)
j = response.json()['All']
j

df = pd.DataFrame(
    {"Country" : j['country'],
     "Population" : j['population'],
     "Deaths" : j['deaths'],
     "Updated" : [j['updated']]}  
   
)

df

## GOT Character API
import random

Names = []
Gender = []
Culture = []

base_url = "https://anapioficeandfire.com/api/characters/"

for i in range(20):
    url = base_url + str(i + 1)
    response = get(url)
    j = response.json()
    Names.append(j['name'])
    Gender.append(j['gender'])
    Culture.append(j['culture'])

pd.DataFrame(
    {"NAME": Names,
     "Gemder": Gender,
     "Culture": Culture}
)
