#!/usr/bin/python
def memorize(function):
  memo = {}
  def wrapper(*args):
    if args in memo:
      print "returning %s from cache" % memo[args]
      return memo[args]
    else:
      rv = function(*args)
      memo[args] = rv
      return rv
  return wrapper

@memorize
def fibonacci(n):
   "Return the nth fibonacci number."
   from time import sleep
   sleep(1)
   if n in (0, 1):
      return n
   return fibonacci(n-1) + fibonacci(n-2)

def fibonacciPlusOne(n):
   fib=fibonacci(n)
   return fib+1

print "working out fibonacci(10)..."
print fibonacci(10)
print fibonacciPlusOne(10)

