CloudFormation do
  S3_Bucket('s3bucket') do
    BucketName 'staticWebsite'
    VersioningConfiguration(Status: 'Enabled')
    WebsiteConfiguration(
      ErrorDocument: 'error.html',
      IndexDocument: 'index.html',
      RoutingRules: [
        {
          RoutingRuleCondition: {
            HttpErrorCodeReturnedEquals: '404',
            KeyPrefixEquals: 'out1/'
          }
        }
      ]
    )
  end
  BucketPolicy('s3bucketPolicy')do
    Bucket(Ref: 's3bucket')
    PolicyDocument(
      id: 'MyPolicy',
      version: '2012-10-17',
      statement:[
        {
          Sid: 'PublicReadForGetBucketObjects',
          Effect: 'Allow',
          Principal: '*',
          Action: 's3:GetObject',
         "Resource": {
             "Fn::Join": [
                 "",
                 [
                     "arn:aws:s3:::",
                     {
                         "Ref": "S3Bucket"
                     },
                     "/*"
                 ]
             ]
         }
        }
      ]
    )
  end
  Output('URL') do
    Description 'The URL of the website'
    Value FnJoin('', ['http://', FnGetAtt('s3bucket', 'WebsiteURL')])
  end

end
