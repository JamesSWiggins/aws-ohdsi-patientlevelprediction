/*
# Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. 
# A copy of the License is located at
#    http://aws.amazon.com/apache2.0/
# or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, 
# either express or implied. See the License for the specific language governing permissions and limitations under the License.
*/

COPY CONCEPT_ANCESTOR FROM 's3://ohdsi-sample-data/vocab/CONCEPT_ANCESTOR.csv.bz2' WITH DELIMITER '\t' CSV REGION 'us-east-1' bzip2 IGNOREHEADER 1 QUOTE '\b' emptyasnull blanksasnull iam_role 'RS_ROLE_ARN';
COPY CONCEPT_CLASS FROM 's3://ohdsi-sample-data/vocab/CONCEPT_CLASS.csv.bz2' WITH DELIMITER '\t' CSV REGION 'us-east-1' bzip2 IGNOREHEADER 1 QUOTE '\b' emptyasnull blanksasnull iam_role 'RS_ROLE_ARN';
COPY CONCEPT FROM 's3://ohdsi-sample-data/vocab/CONCEPT.csv.bz2' WITH DELIMITER '\t' CSV REGION 'us-east-1' bzip2 IGNOREHEADER 1 QUOTE '\b' DATEFORMAT AS 'YYYYMMDD' emptyasnull blanksasnull iam_role 'RS_ROLE_ARN';
COPY CONCEPT_RELATIONSHIP FROM 's3://ohdsi-sample-data/vocab/CONCEPT_RELATIONSHIP.csv.bz2' WITH DELIMITER '\t' CSV REGION 'us-east-1' bzip2 IGNOREHEADER 1 QUOTE '\b' emptyasnull blanksasnull DATEFORMAT AS 'YYYYMMDD' iam_role 'RS_ROLE_ARN';
COPY CONCEPT_SYNONYM FROM 's3://ohdsi-sample-data/vocab/CONCEPT_SYNONYM.csv.bz2' WITH DELIMITER '\t' CSV REGION 'us-east-1' bzip2 IGNOREHEADER 1 QUOTE '\b' iam_role 'RS_ROLE_ARN';
COPY DOMAIN FROM 's3://ohdsi-sample-data/vocab/DOMAIN.csv.bz2' WITH DELIMITER '\t' CSV REGION 'us-east-1' bzip2 IGNOREHEADER 1 QUOTE '\b' emptyasnull blanksasnull iam_role 'RS_ROLE_ARN';
COPY RELATIONSHIP FROM 's3://ohdsi-sample-data/vocab/RELATIONSHIP.csv.bz2' WITH DELIMITER '\t' CSV REGION 'us-east-1' bzip2 IGNOREHEADER 1 QUOTE '\b' emptyasnull blanksasnull iam_role 'RS_ROLE_ARN';
COPY VOCABULARY FROM 's3://ohdsi-sample-data/vocab/VOCABULARY.csv.bz2' WITH DELIMITER '\t' CSV REGION 'us-east-1' bzip2 IGNOREHEADER 1 QUOTE '\b' DATEFORMAT AS 'YYYYMMDD' emptyasnull blanksasnull iam_role 'RS_ROLE_ARN';
