{{ config(materialized='table') }}

-- Preserve the existing relation and semantic model interface.
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
from {{ ref('mart_mortgage_loan_payments') }}
order by servicing_id, payment_id
