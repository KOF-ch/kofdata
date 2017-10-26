from errors import KofdataError
from helpers import get_cdc_files
from requests import get
import os

def get_cached_data(username, api_key, file, target=None):
    # Check credentials by making listing call...
	get_cdc_files(username, api_key)
	
	if( target is None ):
		target = os.path.join(os.getcwd(), file)
	
	url = 'https://datenservice.kof.ethz.ch/api/v1/user/{}/datasets/{}?apikey={}'.format(username, file, api_key)
	
	f = get(url, stream=True)
	
	print(f.status_code)
	
	if(f.status_code == 200):
		with open(target, 'wb') as fd:
			for chunk in f.iter_content(chunk_size=128):
				fd.write(chunk)
	elif(f.status_code == 404):
		raise KofdataError('Could not find file "{}"!'.format(file))
	#else:
		# Raise generic exception