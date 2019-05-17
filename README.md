# How to create/manage production cloudformation templates at scale

[AWS Cloudformation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/GettingStarted.html)templates are an incredibly powerful way to build sets of resources in Amazon's AWS environment. Unfortunately, because they are specified in JSON, they are also difficult to write and maintain.

This guide with the aid of [cfndsl])(https://github.com/devdogsdevops/cfndsl) will allow you to write equivalent templates in a more friendly language and generate the correct json templates by running ruby.

## Prerequisites
  - [install ruby](https://tecadmin.net/install-ruby-latest-stable-centos/) on your local machine .(my workstation runs centos7 )
  - install cfndsl gem
  ```bash
  source ~/.rvm/scripts/rvm
  rvm use 2.2.10
  gem install cfndsl
  ```
## Getting Started

   - clone this repository
   ```bash
     git clone https://github.com/devdogsdevops/cloudformation.git
   ```
   - create cfndsl ruby file : eg serverlessS3.rb within the cfndsl folder.

   ```bash
    vim serverlessS3.rb
   ```

   - Run the following command to generate JSON template from cfndsl .rb file.

   ```bash
   cfndsl -o ../template/serverlessS3.json -p serverlessS3.rb
   ```

   - Use aws cli and create-stack using json template generated:

   ```bash
   aws cloudformation create-stack --stack-name serverlessS3Bucket --template-body file://template/serverlessS3.json
   ```
