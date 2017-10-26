import pandas as pd
from helpers import ts_trim
from requests import get
import StringIO
from errors import KofdataError

def get_time_series(keys, api_key=None, as_data_frame=False, ):
	if not isinstance(keys, basestring):
		keys = ','.join(keys)

	url = 'https://datenservice.kof.ethz.ch/api/v1/{}/ts?mime=csv&keys={}'
	if(not api_key is None):
		url = url.format('main', keys) + '&apikey={}'.format(api_key)
	else:
		url = url.format('public', keys)

	response = get(url)
	
	if(response.status_code == 200):
		sio = StringIO.StringIO(response.text)
		ts = pd.read_csv(sio, index_col='date', parse_dates=True)

		if not as_data_frame:
			ts = ts.to_dict(orient='series')
			ts = dict((k, ts_trim(v)) for k, v in ts.items())
			
		return ts
	elif(response.status_code == 403):
		raise KofdataError('Could not authenticate. Please check your API key!')
	elif(response.status_code == 412):
		missing_keys = response.json()['message']
		raise KofdataError('The API responded with {}. Are you sure the requested series are all {}?'.format(missing_keys, 'public' if api_key is None else 'non-public'))
	#else:
		# Raise exception