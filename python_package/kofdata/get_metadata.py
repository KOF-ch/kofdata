from requests import get

def get_metadata(keys, locale='en'):
	url = 'https://datenservice.kof.ethz.ch/api/v1/metadata?key={}&locale={}'
	
	if isinstance(keys, basestring):
		keys = [keys]
	
	metadata = dict()
	for key in keys:
		key_url = url.format(key, locale)
		meta = get(key_url).json()
		metadata[key] = meta
	return metadata