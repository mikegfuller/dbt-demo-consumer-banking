-- Compare full rows and their multiplicities against the original source query.
with original as (
    select
        payments.payment_id,
        loans.*,
        payments.escrow_amount,
        payments.payment_status,
        payments.payment_amount,
        payments.principal_amount,
        payments.interest_amount,
        payments.payment_date
    from {{ source('bankdemopg_mortgage_servicing', 'serviced_loans') }} as loans
    inner join {{ source('bankdemo_mortgage_servicing', 'payments') }} as payments
        on loans.servicing_id = payments.servicing_id
),

original_counts as (
    select *, count(*) as row_multiplicity
    from original
    group by all
),

actual_counts as (
    select *, count(*) as row_multiplicity
    from {{ ref('mortgage_loan_payments') }}
    group by all
),

missing_or_changed as (
    select * from original_counts
    except
    select * from actual_counts
),

extra_or_changed as (
    select * from actual_counts
    except
    select * from original_counts
)

select 'missing_or_changed' as difference, * from missing_or_changed
union all
select 'extra_or_changed' as difference, * from extra_or_changed
