#!/usr/bin/env ruby
require "aws-sdk"

Aws.config.update({
  region: "us-gov-west-1",
  endpoint: "http://dynamodb.us-gov-west-1.amazonaws.com"

})


dynamodb = Aws::DynamoDB::Client.new
params = {

    table_name: "StudentData",

    key_schema: [

        {

            attribute_name: "FanId",

            key_type: "HASH"  #Partition key

        },

        {

            attribute_name: "DB_Id",

            key_type: "RANGE" #Sort key 

        }
    ],

    attribute_definitions: [

        {

            attribute_name: "FanId",

            attribute_type: "S"

        },

        {

            attribute_name: "DB_Id",

            attribute_type: "S"

        }
    ],

    provisioned_throughput: { 

        read_capacity_units: 5,

        write_capacity_units: 5

  }

}



begin

    result = dynamodb.create_table(params)

    puts "Created table. Status: " + 

        result.table_description.table_status



rescue  Aws::DynamoDB::Errors::ServiceError => error

    puts "Unable to create table:"

    puts "#{error.message}"

end

# snippet-end:[dynamodb.ruby.code_example.movies_create_table]