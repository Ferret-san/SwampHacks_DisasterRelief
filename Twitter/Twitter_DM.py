# DM user after they use our hash tag
import time

import tweepy
credentials = {}
credentials["consumer_key"] = "7NTFSTNtTxGA76ODLqGIRHCpZ"
credentials["consumer_secret"] = "7ShuK7g0KtvKlVEECyMAY5E9k5cdNRYTGHb64FAtr9eNzzc5Nf"
credentials["access_token"] = "1223485018816692224-ye0Kcg3lKg2ZQOXsBliH9ICznSw0UT"
credentials["access_secret"] = "3vZP5VMwG34vr0t7OeYo0p7ZGhO6fujWYIeGj0eXqhTaa"
auth = tweepy.OAuthHandler(credentials["consumer_key"], credentials["consumer_secret"])
auth.set_access_token(credentials["access_token"], credentials["access_secret"])
api = tweepy.API(auth)

api.send_direct_message(1054197561463058434, "What are you experiencing?\n1) Fire\n2) Tornado\n"
                                             "3) Flood\n4) Heavy Storm\n5) Hurricane")

messages = api.list_direct_messages()



