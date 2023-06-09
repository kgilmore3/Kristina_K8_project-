import csv
import requests

# Define the API endpoint URL
url = 'https://swapi.dev/api/planets/'

# Read data from the CSV file
planets = []
with open('planets.csv', 'r') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        planets.append(row)

# Process the data and make API calls
for planet in planets:
    # Check if the planet exists in the API
    response = requests.get(url, params={'search': planet['name']})
    data = response.json()
    if len(data['results']) > 0:
        # Update the existing planet using PATCH
        planet_url = data['results'][0]['url']
        patch_data = {
            'name': planet['name'],
            'diameter': planet['diameter'],
            'population': planet['population']
        }
        response = requests.patch(planet_url, json=patch_data)
        print('Updated planet:', planet['name'])
    else:
        # Add the new planet using POST
        post_data = {
            'name': planet['name'],
            'diameter': planet['diameter'],
            'population': planet['population']
        }
        response = requests.post(url, json=post_data)
        print('Added planet:', planet['name'])

#where:
#api enpoint url is 'https://swapi.dev/api/planets/'
#read the data from csv file using csv.DictReader stored in list called "planets"
#search through each planet in the planets list and check if it already exists in the API using a GET request with a search parameter set to the planet's name
#if it exists, update using PATCH request to URL returned by API
#if it does not exist, add it by using a POST request to main API endpont URL 
