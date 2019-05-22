CloudFormation do

  S3_Bucket('s3bucket') do
    BucketName 'devdogsdevops'
    VersioningConfiguration(Status: 'Suspended')
    WebsiteConfiguration(
      ErrorDocument: 'error.html',
      IndexDocument: 'index.html'
    )
  end
  BucketPolicy('s3bucketPolicy')do
    Bucket(Ref: 's3bucket')
    PolicyDocument(
      Statement:[
        {
          Sid: 'PublicReadForGetBucketObjects',
          Effect: 'Allow',
          Principal: '*',
          Action: 's3:GetObject',
          Resource: { "Fn::Join": [ "",[ "arn:aws:s3:::", { "Ref": "s3bucket" }, "/*" ] ] }
        },
        {
          Sid: 'AllowUserDevinToUpload',
          Effect: 'Allow',
          Principal: {'AWS': 'arn:aws:iam::972539100667:user/devin'},
          Action: 's3:PutObject',
          Resource: { "Fn::Join": [ "",[ "arn:aws:s3:::", { "Ref": "s3bucket" }, "/*" ] ] }
        }
      ]
    )
  end
  Output('URL') do
    Description 'The URL of the website'
    Value FnJoin('', ['http://', FnGetAtt('s3bucket', 'WebsiteURL')])
  end

end
