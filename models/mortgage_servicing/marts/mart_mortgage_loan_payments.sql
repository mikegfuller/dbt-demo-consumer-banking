{{ config(materialized='view') }}

select
    payment_id,
    servicing_id,
    unpaid_principal_balance,
    servicing_status,
    customer_id,
    boarding_date,
    loan_id,
    _fivetran_deleted,
    _fivetran_synced,
    escrow_amount,
    payment_status,
    payment_amount,
    principal_amount,
    interest_amount,
    payment_date
from {{ ref('int_mortgage_servicing__loan_payments') }}
