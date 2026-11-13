{{ config(materialized='view') }}

select
    servicing_id,
    unpaid_principal_balance,
    servicing_status,
    customer_id,
    boarding_date,
    loan_id,
    _fivetran_deleted,
    _fivetran_synced
from {{ source('bankdemopg_mortgage_servicing', 'serviced_loans') }}
