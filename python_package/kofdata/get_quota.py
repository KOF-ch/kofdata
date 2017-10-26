from requests import get
from errors import KofdataError

def get_quota(api_key):
	url = 'https://datenservice.kof.ethz.ch/api/v1/main/remainingquota?apikey={}'.format(api_key)
	response = get(url)
	
	if(response.status_code == 200):
		return response.json()["quota"]
	else:
		raise KofdataError('The API returned a status code of {}. Are you sure you provided a valid API key?'.format(response.status_code))