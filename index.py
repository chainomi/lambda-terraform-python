def lambda_handler(event, context):
   message = 'Hello  there {} !'.format(event['key1'])
   return {
       'message' : message
   }