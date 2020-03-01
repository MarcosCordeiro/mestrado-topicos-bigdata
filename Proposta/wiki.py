import json
from sseclient import SSEClient as EventSource

url = 'https://stream.wikimedia.org/v2/stream/recentchange'
for event in EventSource(url):
    
    if event.event == 'message':
        try:
            change = json.loads(event.data)
        except ValueError:
            pass
        else:
            if(change['meta']['domain']=='pt.wikipedia.org' and change['bot']==True):
                print(event)
                print('{user} ----- edited {title}'.format(**change))