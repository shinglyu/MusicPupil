from time import gmtime, strftime

import config

def printDebug(string):
   if config.DEBUG:
      print(strftime("%Y-%m-%d %H:%M:%S ", gmtime())),
      print("[DEBUG]"),
      print(string)

