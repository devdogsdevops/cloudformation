CloudFormation do
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
          Resource: { "Fn::Join": [ "",[ "arn:aws:s3:::", { "Ref": "s3bucket" }, "/*" ] ] }
        }
      ]
    )
  end
end
