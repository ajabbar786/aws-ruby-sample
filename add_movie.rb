# v2: require 'aws-sdk'
require 'aws-sdk-dynamodb'  

# Create dynamodb client in us-west-2 region
Aws.config.update({

    region: "us-gov-west-1",
  
    endpoint: "http://dynamodb.us-gov-west-1.amazonaws.com"
  
  })
  
  dynamodb = Aws::DynamoDB::Client.new

item = {
    year: 2015,
    title: 'The Big New Movie',
    info: {
        plot: 'Nothing happens at all.',
        rating: 0
    }
}

params = {
    table_name: 'Movies',
    item: item
}

begin
  dynamodb.put_item(params)
 # puts 'Added movie: '+ year.to_i.to_s + ' - ' + title
rescue  Aws::DynamoDB::Errors::ServiceError => error
  puts 'Unable to add movie:'
  puts error.message
end