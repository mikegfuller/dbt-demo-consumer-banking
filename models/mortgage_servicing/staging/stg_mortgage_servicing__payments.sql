{{ config(materialized='view') }}

select
    payment_id,
    servicing_id,
    escrow_amount,
    payment_status,
    payment_amount,
    principal_amount,
    payment_date,
    interest_amount,
    _fivetran_deleted,
    _fivetran_synced
from {{ source('bankdemo_mortgage_servicing', 'payments') }}
