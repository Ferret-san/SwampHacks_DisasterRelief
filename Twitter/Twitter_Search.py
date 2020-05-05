# Function to search information


def search_twitter(search, login, count=None):
    if count is not None:
        num = count
    else:
        num = 10
    query = {'q': search,
             'count': num,
             'lang': 'en'
             }

    dict_tweets = {}
    search = login.search(**query)['statuses']
    x = 0
    for status in search:
        print(status)
        x = x + 1
        dict_tweets[str(x)] = {'user': status['user']['screen_name'],
                               'name': status['user']['name'],
                               'location': status['user']['location'],
                               'date': status['created_at'],
                               'text': status['text'],
                               'profile_pic': status['profile_image_url']
                               }

    return dict_tweets
