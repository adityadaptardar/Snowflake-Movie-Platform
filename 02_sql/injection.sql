create or replace storage integration adls_int
type = external_stage
storage_provider = azure
enabled = true
AZURE_TENANT_ID = '33b7e5c4-f95f-40e1-a9ab-fa68482cb25b'
STORAGE_ALLOWED_LOCATIONS = (
   'azure://ottanalyticsdl01.dfs.blob.windows.net/ott-landing/'
);

DESC INTEGRATION adls_int;

CREATE or replace STAGE RAW.adls_stage
--STORAGE_INTEGRATION = adls_int
CREDENTIALS=(AZURE_SAS_TOKEN='<token>')
URL='azure://ottanalyticsdl01.blob.core.windows.net/ott-landing';


DESC STAGE raw.adls_stage;

LIST @raw.adls_stage;


CREATE TABLE raw.raw_users (
    user_id STRING,
    gender STRING,
    age STRING,
    occupation STRING,
    zip_code STRING,
    country STRING,
    primary_device STRING,
    signup_date DATE,
    source_file STRING,
    load_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);

CREATE TABLE raw.raw_movies (
    movie_id STRING,
    title STRING,
    genres STRING,
    source_file STRING,
    load_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);

CREATE TABLE raw.raw_subscriptions (
    subscription_id STRING,
    user_id STRING,
    plan_type STRING,
    start_date DATE,
    end_date DATE,
    status STRING,
    source_file STRING,
    load_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);

CREATE TABLE raw.raw_view_events (
    raw_record VARIANT,
    source_file STRING,
    load_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);


show tables;

CREATE FILE FORMAT ff_csv_std
TYPE = CSV
FIELD_OPTIONALLY_ENCLOSED_BY = '"'
SKIP_HEADER = 1
NULL_IF = ('NULL','');

CREATE FILE FORMAT ff_json_std
TYPE = JSON;


desc table
raw.raw_users;

COPY INTO raw.raw_users
(
    user_id,
    gender,
    age,
    occupation,
    zip_code,
    country,
    primary_device,
    signup_date,
    source_file
)

FROM (
    SELECT $1,$2,$3,$4,$5,$6,$7,$8,METADATA$FILENAME
    FROM @raw.adls_stage/users/
)
FILE_FORMAT = ff_csv_std;





COPY INTO raw.raw_movies
(
MOVIE_ID
,TITLE
,GENRES
,SOURCE_FILE
)
FROM (
    SELECT $1,$2,$3,METADATA$FILENAME
    FROM @raw.adls_stage/movies/
)
FILE_FORMAT = ff_csv_std;


COPY INTO raw.raw_subscriptions
(
SUBSCRIPTION_ID
,USER_ID
,PLAN_TYPE
,START_DATE
,END_DATE
,STATUS
,SOURCE_FILE
)
FROM (
    SELECT $1,$2,$3,$4,$5,$6,METADATA$FILENAME
    FROM @raw.adls_stage/subscriptions/
)
FILE_FORMAT = ff_csv_std;


COPY INTO raw.raw_view_events(raw_record, source_file)
FROM (
    SELECT $1, METADATA$FILENAME
    FROM @raw.adls_stage/view_events/view_events_ndjson.json
)
FILE_FORMAT = ff_json_std
PATTERN = '.*\\.json';

CREATE VIEW raw.v_view_events_parsed AS
SELECT
    raw_record:event_id::STRING               AS event_id,
    raw_record:user_id::STRING                AS user_id,
    raw_record:movie_id::STRING               AS movie_id,
    raw_record:watch_start_time::TIMESTAMP    AS watch_start_time,
    raw_record:watch_duration_minutes::NUMBER AS watch_duration_minutes,
    raw_record:device_type::STRING            AS device_type,
    raw_record:rating::NUMBER                 AS rating,
    source_file                               AS source_file,
    load_ts                                   AS ingestion_ts
FROM raw.raw_view_events;


