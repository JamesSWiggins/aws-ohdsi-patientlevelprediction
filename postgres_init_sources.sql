/*
# Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. 
# A copy of the License is located at
#    http://aws.amazon.com/apache2.0/
# or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, 
# either express or implied. See the License for the specific language governing permissions and limitations under the License.
*/

INSERT INTO webapi.source (source_id, source_name, source_key, source_connection, source_dialect) VALUES (1, 'CMS DE-SynPUF', 'SynPUF', 'jdbc:redshift://REDSHIFT_ENDPOINT:5439/mycdm?user=master&password=DATABASE_PASSWORD', 'redshift');
INSERT INTO webapi.source_daimon (source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (1,1,0, 'public', 0);
INSERT INTO webapi.source_daimon (source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (2,1,1, 'public', 0);
INSERT INTO webapi.source_daimon (source_daimon_id, source_id, daimon_type, table_qualifier, priority) VALUES (3,1,2, 'results', 0);