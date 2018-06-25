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

CREATE DATABASE "OHDSI"
WITH ENCODING='UTF8'
     OWNER=ohdsi_admin
     CONNECTION LIMIT=-1;
COMMENT ON DATABASE "OHDSI"
IS 'OHDSI database';
GRANT ALL ON DATABASE "OHDSI" TO GROUP ohdsi_admin;
GRANT CONNECT, TEMPORARY ON DATABASE "OHDSI" TO GROUP ohdsi_app;

\c OHDSI

CREATE SCHEMA webapi
     AUTHORIZATION ohdsi_admin;
COMMENT ON SCHEMA webapi
IS 'Schema containing tables to support WebAPI functionality';
GRANT USAGE ON SCHEMA webapi TO public;
GRANT ALL ON SCHEMA webapi TO GROUP ohdsi_admin;
GRANT USAGE ON SCHEMA webapi TO GROUP ohdsi_app;

ALTER DEFAULT PRIVILEGES IN SCHEMA webapi
  GRANT INSERT, SELECT, UPDATE, DELETE, REFERENCES, TRIGGER ON TABLES
  TO ohdsi_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA webapi
  GRANT SELECT, USAGE ON SEQUENCES
  TO ohdsi_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA webapi
  GRANT EXECUTE ON FUNCTIONS
  TO ohdsi_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA webapi
  GRANT USAGE ON TYPES
  TO ohdsi_app;
