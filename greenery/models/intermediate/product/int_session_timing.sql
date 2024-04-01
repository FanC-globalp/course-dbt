select
    session_id,
    min(created_at) as session_start_time,
    max(created_at) as session_end_time
from {{ref('stg_postgres_events')}}
group by 1