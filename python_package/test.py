import pandas as pd

keys = ['ch.kof.globidx.v2017.index.atg', 'ch.kof.globidx.v2017.index.che', 'ch.kof.globidx.v2017.index.deu']
url = 'https://datenservice.kof.ethz.ch/api/v1/public/ts?keys={}&mime=csv'.format(','.join(keys))

ts = pd.read_csv(url, index_col='date', parse_dates=True)

print('As data frame:')
print(ts)

ts_dict = ts.to_dict(orient='series')

def ts_trim(ts):
	return ts.loc[ts.first_valid_index():]

ts_dict = dict((k, ts_trim(v)) for k, v in ts_dict.items())

print('')
print('')
print('As dict of Series:')
print(ts_dict)