Bar Plots
===================
The bar graph is used to display the counts of
the number of items in a given category. They are often used for basic
representation of group/count data.

Data
----
Data for bar plots takes the form of `category,count` pairs or a single
long row of `category` values.
`barplot.csv` provides a small example of the former. 

Histograms/Density plots
============================
Unlike bar graphs, histograms can be used to plot *continuous* data, 
where the counts are taken on *bins* of data. Each bin can be defined
by the user. For example, assume we had the test scores of a number
of students. We may wish to bin students into ranges of 10. For
example, we count the number of studets with marks in the range
[0, 9], [10, 19], ..., [90, 100], and then we can plot the counts
of each of these bins.

The difference between histograms and barplots in ggplot land
-------------------------------------------------------------
An important distinction between these similar approaches is
how they manage the data input. If you pre-compute your bins
and counts, you **do not** want to use the histogram, but
rather the barplot. However, say you had a large *single
column* of data (such as test scores), you probably want to
be using the histogram/density. I have provided an example of
using both histogram or density plots for this sort of data.

My preference
------------
I generally prefer to compute the bins and counts myself offline, 
and then use the bar graph functionality mentioned above. The only
exception to this rule is if I am required to plot a *distribution*,
in which case I prefer to supply just the raw data and I then use
`geom_density`. I will now provide an example of this.

Data
----
`density.csv` provides an example for plotting a distribution. The data is
formatted simply as `dataset,value` pairs.
