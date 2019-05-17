CloudFormation do
  S3_Bucket('s3bucket') do
    BucketName 'staticWebsite'
    VersioningConfiguration(Status: 'Disabled')
    WebsiteConfiguration(
      ErrorDocument: 'error.html',
      IndexDocument: 'index.html'
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
          Resource: { "Fn::Join": [ "",[ "arn:aws:s3:::", { "Ref": "S3Bucket" }, "/*" ] ] }
        },
        {
          Sid: 'AllowUploadWebContent',
          Effect: 'Allow',
          Principal: 'arn:aws:iam::972539100667:user/devin',
          Action: 's3:PutObject',
          Resource: { "Fn::Join": [ "",[ "arn:aws:s3:::", { "Ref": "S3Bucket" }, "/*" ] ] }
        }
      ]
    )
  end
  Output('URL') do
    Description 'The URL of the website'
    Value FnJoin('', ['http://', FnGetAtt('s3bucket', 'WebsiteURL')])
  end

end
