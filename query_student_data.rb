# v2: require 'aws-sdk'
require "aws-sdk"

Aws.config.update({
    region: "us-gov-west-1",
    endpoint: "http://dynamodb.us-gov-west-1.amazonaws.com"
  
  })


dynamodb = Aws::DynamoDB::Client.new

table_name = "StudentData"

params = {
    table_name: table_name,
 #   projection_expression: "FanId, DB_Id, Student",
    key_condition_expression: "FanId = :v1",
    expression_attribute_values: {
        ":v1" => "5424892"
    }
}


# params = {
#     table_name: table_name,,
#     "IndexName": "PostedBy-Index",
#     "Limit": 3,
#     "ConsistentRead": true,
#     "ProjectionExpression": "Id, PostedBy, ReplyDateTime",
#     "KeyConditionExpression": "Id = :v1 AND PostedBy BETWEEN :v2a AND :v2b",
#     "ExpressionAttributeValues": {
#         ":v1": {"S": "Amazon DynamoDB#DynamoDB Thread 1"},
#         ":v2a": {"S": "User A"},
#         ":v2b": {"S": "User C"}
#     },
#     "ReturnConsumedCapacity": "TOTAL"
# }

begin
    result = dynamodb.query(params)
    puts "Query succeeded."
    #  puts "Querying for fanId 5424892.";

    puts result.items

    # result.items.each{|movie|
    #      puts "#{movie["year"].to_i} #{movie["title"]}"
    # }

rescue  Aws::DynamoDB::Errors::ServiceError => error
    puts "Unable to query table:"
    puts "#{error.message}"
end