 # v2: require 'aws-sdk'
require 'aws-sdk-dynamodb' 
require 'json'


# Create dynamodb client in us-west-2 region
Aws.config.update({

    region: "us-gov-west-1",
  
    endpoint: "http://dynamodb.us-gov-west-1.amazonaws.com"
  
  })
  
  dynamodb = Aws::DynamoDB::Client.new

file = File.read('orig_json_sample.json')
movies = JSON.parse(file)
movies.each{|stu|

  params = {
      table_name: 'StudentData',
      item: stu
  }

  begin
    dynamodb.put_item(params)
    puts 'Added Student: ' + stu['SocialSecurityNumber'].to_i.to_s  + ' - ' + stu['DateOfBirth']

  rescue  Aws::DynamoDB::Errors::ServiceError => error
    puts 'Unable to add movie:'
    puts error.message
  end
}