from requests import get
from errors import KofdataError

def ts_trim(ts):
	ts = ts.loc[ts.first_valid_index():]
	return ts.loc[:ts.last_valid_index()]
	
def get_cdc_files(username, api_key):
	url = 'https://datenservice.kof.ethz.ch/api/v1/user/{}/datasets?apikey={}'.format(username, api_key)
	
	listing = get(url)
	
	if(listing.status_code == 200):
		return listing.json()
	elif(listing.status_code == 403):
		raise KofdataError('Could not authenticate. Please check your API key!')
	elif(listing.status_code == 404):
		raise KofdataError('Could not find endpoint. Please check your user name!')
	#else:
		# other