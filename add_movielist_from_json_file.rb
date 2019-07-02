 # v2: require 'aws-sdk'
require 'aws-sdk-dynamodb' 
require 'json'


# Create dynamodb client in us-west-2 region
Aws.config.update({

    region: "us-gov-west-1",
  
    endpoint: "http://dynamodb.us-gov-west-1.amazonaws.com"
  
  })
  
  dynamodb = Aws::DynamoDB::Client.new

file = File.read('movie_data.json')
movies = JSON.parse(file)
movies.each{|movie|

  params = {
      table_name: 'Movies',
      item: movie
  }

  begin
    dynamodb.put_item(params)
    puts 'Added movie: ' + movie['year'].to_i.to_s  + ' - ' + movie['title']

  rescue  Aws::DynamoDB::Errors::ServiceError => error
    puts 'Unable to add movie:'
    puts error.message
  end
}