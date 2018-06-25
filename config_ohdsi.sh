#!/bin/bash
# Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. 
# A copy of the License is located at
#    http://aws.amazon.com/apache2.0/
# or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, 
# either express or implied. See the License for the specific language governing permissions and limitations under the License.
#
#
#  This script configures the CFN deployed environment for OHDSI WebAPI and Atlas
#
#  Requirements: 
#  $RDS_ENDPOINT must contain the endpoint of the Postgres Aurora RDS environment to be used to store the WebAPI application data
#  $EB_ENDPOINT must contain the endpoint of the Elastic Beanstalk Tomcat environment
#  $REDSHIFT_ENDPOINT must contain the endpoint of the Redshift Cluster used for OMOP CDM and Vocabulary
#  $ACCT_ID must contain the AWS Account ID for the account in which this environment is being deployed
#  $BUCKET_NAME must contain the s3 bucket name in which Elastic Beanstalk will look for the ohdsi-webapi-atlas.zip file
#  $DATABASE_PASSWORD must contain the password that was used for the master accounts for Redshift and RDS Aurora Postgres

echo "RDS_ENDPOINT=" $RDS_ENDPOINT
echo "EB_ENDPOINT=" $EB_ENDPOINT
echo "REDSHIFT_ENDPOINT=" $REDSHIFT_ENDPOINT
echo "ACCT_ID=" $ACCT_ID
echo "BUCKET_NAME=" $BUCKET_NAME
echo "DATABASE_PASSWORD=" $DATABASE_PASSWORD
export AWS_DEFAULT_REGION=$(echo $EB_ENDPOINT | cut -d . -f2)

sudo yum install -y postgresql
export PGPASSWORD=$DATABASE_PASSWORD
psql -d postgres --host=$RDS_ENDPOINT --port=5432 -U master -a -f postgres_init_master.sql 
export PGPASSWORD="admin1"
psql -d postgres --host=$RDS_ENDPOINT --port=5432 -U ohdsi_admin_user -a -f postgres_init_ohdsi.sql


#Download build tools and compile WebAPI
sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven
sudo yum install -y java-1.8.0
sudo yum install -y java-1.8.0-openjdk-devel
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk
sed -i '7s/.*/      <datasource.url>jdbc:postgresql:\/\/'$RDS_ENDPOINT':5432\/OHDSI?ssl=true\&amp\;sslfactory=org.postgresql.ssl.NonValidatingFactory<\/datasource.url>/' settings.xml
mv settings.xml ./WebAPI/
cd WebAPI
mvn clean package -s settings.xml -P webapi-postgresql
cd ..
cp ./WebAPI/target/WebAPI.war .
#update the WAR file with my modified SqlRender that includes some additional replacementPatterns.csv entries
jar xvf WebAPI.war WEB-INF/lib/SqlRender-1.4.6.jar
cp ./SqlRender-1.4.6/SqlRender-1.4.6.jar WEB-INF/lib/SqlRender-1.4.6.jar 
jar uf WebAPI.war WEB-INF/lib/SqlRender-1.4.6.jar


#Build Atlas "war" file to put at the root URL of the Tomcat server
sed -i '6s!.*!                url: \x27http://'$EB_ENDPOINT'\/WebAPI\/\x27!' config-local.js
mv config-local.js ./Atlas/js/
cd Atlas
zip -r ../ROOT.war * 
cd ..

zip -r ohdsi-webapi-atlas.zip ROOT.war WebAPI.war .ebextensions
aws s3 mb s3://$BUCKET_NAME 
aws s3 cp ohdsi-webapi-atlas.zip s3://$BUCKET_NAME 