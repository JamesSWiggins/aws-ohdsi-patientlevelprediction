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

CREATE SCHEMA results;
SET search_path to results;


CREATE TABLE cohort (
    cohort_definition_id integer NOT NULL,
    subject_id bigint NOT NULL,
    cohort_start_date date NOT NULL,
    cohort_end_date date NOT NULL
);



CREATE TABLE cohort_features (
    cohort_definition_id bigint,
    covariate_id bigint,
    sum_value bigint,
    average_value double precision
);


CREATE TABLE cohort_features_analysis_ref (
    cohort_definition_id bigint,
    analysis_id integer,
    analysis_name character varying(1000),
    domain_id character varying(100),
    start_day integer,
    end_day integer,
    is_binary character(1),
    missing_means_zero character(1)
);


CREATE TABLE cohort_features_dist (
    cohort_definition_id bigint,
    covariate_id bigint,
    count_value double precision,
    min_value double precision,
    max_value double precision,
    average_value double precision,
    standard_deviation double precision,
    median_value double precision,
    p10_value double precision,
    p25_value double precision,
    p75_value double precision,
    p90_value double precision
);



CREATE TABLE cohort_features_ref (
    cohort_definition_id bigint,
    covariate_id bigint,
    covariate_name character varying(1000),
    analysis_id integer,
    concept_id integer
);



CREATE TABLE cohort_inclusion (
    cohort_definition_id integer NOT NULL,
    rule_sequence integer NOT NULL,
    name character varying(255),
    description character varying(1000)
);



CREATE TABLE cohort_inclusion_result (
    cohort_definition_id integer NOT NULL,
    inclusion_rule_mask bigint NOT NULL,
    person_count bigint NOT NULL
);



CREATE TABLE cohort_inclusion_stats (
    cohort_definition_id integer NOT NULL,
    rule_sequence integer NOT NULL,
    person_count bigint NOT NULL,
    gain_count bigint NOT NULL,
    person_total bigint NOT NULL
);




CREATE TABLE cohort_summary_stats (
    cohort_definition_id integer NOT NULL,
    base_count bigint NOT NULL,
    final_count bigint NOT NULL
);




CREATE TABLE feas_study_index_stats (
    study_id integer NOT NULL,
    person_count bigint NOT NULL,
    match_count bigint NOT NULL
);




CREATE TABLE feas_study_result (
    study_id integer NOT NULL,
    inclusion_rule_mask bigint NOT NULL,
    person_count bigint NOT NULL
);




CREATE TABLE heracles_analysis (
    analysis_id integer,
    analysis_name character varying(255),
    stratum_1_name character varying(255),
    stratum_2_name character varying(255),
    stratum_3_name character varying(255),
    stratum_4_name character varying(255),
    stratum_5_name character varying(255),
    analysis_type character varying(255)
);




CREATE TABLE heracles_heel_results (
    cohort_definition_id integer,
    analysis_id integer,
    heracles_heel_warning character varying(255)
);




CREATE TABLE heracles_results (
    cohort_definition_id integer,
    analysis_id integer,
    stratum_1 character varying(255),
    stratum_2 character varying(255),
    stratum_3 character varying(255),
    stratum_4 character varying(255),
    stratum_5 character varying(255),
    count_value bigint,
    last_update_time timestamp DEFAULT now()
);




CREATE TABLE heracles_results_dist (
    cohort_definition_id integer,
    analysis_id integer,
    stratum_1 character varying(255),
    stratum_2 character varying(255),
    stratum_3 character varying(255),
    stratum_4 character varying(255),
    stratum_5 character varying(255),
    count_value bigint,
    min_value double precision,
    max_value double precision,
    avg_value double precision,
    stdev_value double precision,
    median_value double precision,
    p10_value double precision,
    p25_value double precision,
    p75_value double precision,
    p90_value double precision,
    last_update_time timestamp DEFAULT now()
);




CREATE TABLE heracles_visualization_data (
    id integer NOT NULL,
    cohort_definition_id integer NOT NULL,
    source_id integer NOT NULL,
    visualization_key character varying(300) NOT NULL,
    drilldown_id integer,
    data text NOT NULL,
    end_time timestamp NOT NULL
);




CREATE TABLE ir_analysis_dist (
    analysis_id integer NOT NULL,
    target_id integer NOT NULL,
    outcome_id integer NOT NULL,
    strata_sequence integer,
    dist_type integer NOT NULL,
    total bigint NOT NULL,
    avg_value double precision NOT NULL,
    std_dev double precision NOT NULL,
    min_value integer NOT NULL,
    p10_value integer NOT NULL,
    p25_value integer NOT NULL,
    median_value integer NOT NULL,
    p75_value integer NOT NULL,
    p90_value integer NOT NULL,
    max_value integer
);


CREATE TABLE ir_analysis_result (
    analysis_id integer NOT NULL,
    target_id integer NOT NULL,
    outcome_id integer NOT NULL,
    strata_mask bigint NOT NULL,
    person_count bigint NOT NULL,
    time_at_risk bigint NOT NULL,
    cases bigint NOT NULL
);



CREATE TABLE ir_analysis_strata_stats (
    analysis_id integer NOT NULL,
    target_id integer NOT NULL,
    outcome_id integer NOT NULL,
    strata_sequence integer NOT NULL,
    person_count bigint NOT NULL,
    time_at_risk bigint NOT NULL,
    cases bigint NOT NULL
);


CREATE TABLE ir_strata (
    analysis_id integer NOT NULL,
    strata_sequence integer NOT NULL,
    name character varying(255),
    description character varying(1000)
);