from get_metadata import get_metadata

def get_legacy_key(keys):
	metadata = get_metadata(keys)
	return dict((k, v['legacy_key']) for k, v in metadata.items())