# Twitter search for hash-tags
from twython import Twython
from Twitter_Search import search_twitter
import tweepy
import Twitter_DM
# Gather Credentials
credentials = {}
credentials["consumer_key"] = "7NTFSTNtTxGA76ODLqGIRHCpZ"
credentials["consumer_secret"] = "7ShuK7g0KtvKlVEECyMAY5E9k5cdNRYTGHb64FAtr9eNzzc5Nf"
credentials["access_token"] = "1223485018816692224-g6hB4YGbBsBx6p2Yyy2p6pFFiOqgab"
credentials["access_secret"] = "vBI3EEdxbRFUpqJ7Stxe7O5kcSp6KyGCmdaASmxa00dzW"

# Twython access
t = Twython(app_key=credentials["consumer_key"],
            app_secret=credentials["consumer_secret"],
            oauth_token=credentials["access_token"],
            oauth_token_secret=credentials["access_secret"]
            )
# Tweepy access
auth = tweepy.OAuthHandler(credentials["consumer_key"], credentials["consumer_secret"])
auth.set_access_token(credentials["access_token"], credentials["access_secret"])
api = tweepy.API(auth)

tweets = search_twitter("#code", t)
