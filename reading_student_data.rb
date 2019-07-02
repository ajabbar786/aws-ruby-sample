 # v2: require 'aws-sdk'
require "aws-sdk"

Aws.config.update({
    region: "us-gov-west-1",
    endpoint: "http://dynamodb.us-gov-west-1.amazonaws.com"
  
  })

dynamodb = Aws::DynamoDB::Client.new

table_name = 'StudentData'

FanId = "5424892"
DB_Id = "252"

params = {
    table_name: table_name,
    key: {
        FanId: FanId,
        DB_Id: DB_Id
    }
}

begin
    result = dynamodb.get_item(params)
 #puts result.to_s
 #  output = Hash.new
output= result.item.select {|k,v| k != 'DB_Id'}
 puts output.to_s

rescue  Aws::DynamoDB::Errors::ServiceError => error
    puts "Unable to read item:"
    puts "#{error.message}"
end