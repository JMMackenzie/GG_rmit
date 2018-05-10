Point & Line Plots
===================
Point and line graphs are used in many situations.
For example, plotting every `x,y` point (a scatter plot) 
can be used to show the relationship between x and y.

It's also useful to plot lines to show the impact on some variable (y)
when varying some parameter (x).

Note that to remove the points, you can simply remove the `geom_point()`,
and to remove the line, remove the `geom_line()` part.

Data
----
The provided data has for each system/k value/query length, the mean timing.
Suppose we are interested to see the impact that both query length and k has
on the timing for the provided algorithms.
