{{ config(materialized='ephemeral') }}

with loans as (
    select *
    from {{ ref('stg_mortgage_servicing__serviced_loans') }}
),

payments as (
    select *
    from {{ ref('stg_mortgage_servicing__payments') }}
)

select
    payments.payment_id,
    loans.servicing_id,
    loans.unpaid_principal_balance,
    loans.servicing_status,
    loans.customer_id,
    loans.boarding_date,
    loans.loan_id,
    loans._fivetran_deleted,
    loans._fivetran_synced,
    payments.escrow_amount,
    payments.payment_status,
    payments.payment_amount,
    payments.principal_amount,
    payments.interest_amount,
    payments.payment_date
from loans
inner join payments
    on loans.servicing_id = payments.servicing_id
