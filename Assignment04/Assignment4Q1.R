data(college_recent_grads)
> dim(college_recent_grads)
[1] 173  21
> data(college_grad_students)
> college_grad_students
# A tibble: 173 x 22
major_code                                    major
<int>                                    <chr>
  1       5601                    Construction Services
2       6004        Commercial Art And Graphic Design
3       6211                   Hospitality Management
4       2201   Cosmetology Services And Culinary Arts
5       2001               Communication Technologies
6       3201                          Court Reporting
7       6206         Marketing And Marketing Research
8       1101    Agriculture Production And Management
9       2101 Computer Programming And Data Processing
10       1904         Advertising And Public Relations
# ... with 163 more rows, and 20 more variables:
#   major_category <chr>, grad_total <int>,
#   grad_sample_size <int>, grad_employed <int>,
#   grad_employed_fulltime_yearround <int>,
#   grad_unemployed <int>, grad_unemployment_rate <dbl>,
#   grad_p25th <dbl>, grad_median <dbl>,
#   grad_p75th <int>, nongrad_total <int>,
#   nongrad_employed <int>,
#   nongrad_employed_fulltime_yearround <int>,
#   nongrad_unemployed <int>,
#   nongrad_unemployment_rate <dbl>,
#   nongrad_p25th <dbl>, nongrad_median <dbl>,
#   nongrad_p75th <dbl>, grad_share <dbl>,
#   grad_premium <dbl>
> dim(college_grad_students)
[1] 173  22
> head(college_grad_students)
# A tibble: 6 x 22
major_code                                  major
<int>                                  <chr>
  1       5601                  Construction Services
2       6004      Commercial Art And Graphic Design
3       6211                 Hospitality Management
4       2201 Cosmetology Services And Culinary Arts
5       2001             Communication Technologies
6       3201                        Court Reporting
# ... with 20 more variables: major_category <chr>,
#   grad_total <int>, grad_sample_size <int>,
#   grad_employed <int>,
#   grad_employed_fulltime_yearround <int>,
#   grad_unemployed <int>, grad_unemployment_rate <dbl>,
#   grad_p25th <dbl>, grad_median <dbl>,
#   grad_p75th <int>, nongrad_total <int>,
#   nongrad_employed <int>,
#   nongrad_employed_fulltime_yearround <int>,
#   nongrad_unemployed <int>,
#   nongrad_unemployment_rate <dbl>,
#   nongrad_p25th <dbl>, nongrad_median <dbl>,
#   nongrad_p75th <dbl>, grad_share <dbl>,
#   grad_premium <dbl>
> 
  
  > colnames(college_grad_students)
[1] "major_code"                          "major"                               "major_category"                     
[4] "grad_total"                          "grad_sample_size"                    "grad_employed"                      
[7] "grad_employed_fulltime_yearround"    "grad_unemployed"                     "grad_unemployment_rate"             
[10] "grad_p25th"                          "grad_median"                         "grad_p75th"                         
[13] "nongrad_total"                       "nongrad_employed"                    "nongrad_employed_fulltime_yearround"
[16] "nongrad_unemployed"                  "nongrad_unemployment_rate"           "nongrad_p25th"                      
[19] "nongrad_median"                      "nongrad_p75th"                       "grad_share"                         
[22] "grad_premium"                       
> 