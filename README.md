# gluwasp
The **gl**obal **u**rban **wa**ter **s**u**p**ply database

# when adding a source
- write source up in `inst/extdata/sources.csv`
- keep strictly to format in original source... all manipulations and computation comment in code
- add all data in a table (it might be useful later)

# assumptions
- rev_source based on where the *bulk* of revenue is generated. For example, user_rates is applicable if if >50% of operating expense is recovered from user tariffs. If it's less than 100%, or if user rates don't pay back infrastructure financing, then cost_rec (full cost recovery) is marked as FALSE.
