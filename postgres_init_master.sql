/*********************************************************************************
# Copyright 2017 Observational Health Data Sciences and Informatics
#
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
********************************************************************************/

CREATE ROLE ohdsi_admin
CREATEDB
 VALID UNTIL 'infinity';
COMMENT ON ROLE ohdsi_admin
IS 'Administration group for OHDSI applications';

CREATE ROLE ohdsi_app
 VALID UNTIL 'infinity';
COMMENT ON ROLE ohdsi_app
IS 'Application groupfor OHDSI applications';

CREATE ROLE ohdsi_admin_user LOGIN ENCRYPTED PASSWORD 'md58d34c863380040dd6e1795bd088ff4a9'
 VALID UNTIL 'infinity';
-- password is admin1
GRANT ohdsi_admin TO ohdsi_admin_user;
COMMENT ON ROLE ohdsi_admin_user
IS 'Admin user account for OHDSI applications';

CREATE ROLE ohdsi_app_user LOGIN ENCRYPTED PASSWORD 'md55cc9d81d14edce93a4630b7c885c6410'
 VALID UNTIL 'infinity';
 -- password is app1
GRANT ohdsi_app TO ohdsi_app_user;
COMMENT ON ROLE ohdsi_app_user
IS 'Application user account for OHDSI applications';

ALTER USER ohdsi_admin_user CREATEDB;
