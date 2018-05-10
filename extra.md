Presentation 
=============

So far, you have seen basic example for a few different types
of graph. Here I try to outline some more of the functionality I use
to make graphs.

Legends
-------
Legends are drawn dependent on the settings you use in the `aes` of your
graph. For example:
```
plot <- ggplot(data, aes(x=myX, y=myY, group=animal, colour=animal, shape=age))
```
In this case, the legend will be drawn for the two aesthetics we selected,
which are colour and shape. If these are not named the same, then there will be
two different legends plotted. Otherwise, the legends will be combined.

For example, the following will result in a separate legend for both Animal
and Age:
```
plot <- plot + scale_colour_discrete("Animal")
plot <- plot + scale_shape_discrete("Age")
```
However, this next example will have a combined legend, because we used the
same title for each of the aesthetics.
```
plot <- plot + scale_colour_discrete("Animal-Age")
plot <- plot + scale_shape_discrete("Animal-Age")
```

Colours
-------
Colour can be set using either the `colour()` or `fill()` approaches.
Colour generally refers to line colour (ie, the outline of an object) and
the fill refers to the internal colour. 
I get most of my colours from [FlatUIColors.](https://flatuicolors.com/)

Shapes
------
Point shapes come in a few different types, and are referred to by values
from 0 to 25 and 32 to 127. Shapes in the range [21, 25] can be *filled*
but all other shapes are solid. This guide can help with selection:
[Shape Guide.](http://sape.inf.usi.ch/quick-reference/ggplot2/shape)

Line Types
----------
There are around 10 valid line types.
[Line Guide.](http://sape.inf.usi.ch/quick-reference/ggplot2/linetype)

Fonts
-----
Fonts are a little tricky to get working. They depend on how your operating
system defines fonts (and so on). The provided examples all work on using
the Libertine font for my system, but it may have a different name for your
system.

```
jmac$ fc-list | grep "Libertine"
/usr/share/fonts/opentype/linux-libertine/LinLibertine_RB.otf: Linux Libertine O:style=Bold
/usr/share/fonts/opentype/linux-libertine/LinLibertine_RZI.otf: Linux Libertine O:style=Semibold Italic
/usr/share/fonts/opentype/linux-libertine/LinLibertine_I.otf: Linux Libertine Initials O:style=Initials
/usr/share/fonts/opentype/linux-libertine/LinLibertine_R.otf: Linux Libertine O:style=Regular
/usr/share/fonts/opentype/linux-libertine/LinLibertine_M.otf: Linux Libertine Mono O:style=Mono
/usr/share/fonts/opentype/linux-libertine/LinLibertine_DR.otf: Linux Libertine Display O:style=Regular
/usr/share/fonts/opentype/linux-libertine/LinLibertine_RI.otf: Linux Libertine O:style=Italic
/usr/share/fonts/opentype/linux-libertine/LinLibertine_RZ.otf: Linux Libertine O:style=Semibold
/usr/share/fonts/opentype/linux-libertine/LinLibertine_RBI.otf: Linux Libertine O:style=Bold Italic

```
I then use "Linux Libertine O" as my selected font, as follows:

```
plot <- plot + theme(text = element_text(family = "Linux Libertine O", size=25))
```

Labels
------
Labels are pretty straightforward. Let us discuss axis labels.
There are two main items to consider. First, there are `breaks`, which
correspond to where the line breaks in the axis will be. Then, there are
`labels` which label these breaks. If you provide them manually, then the
breaks and labels vectors need to be the same length. For example:
```
plot <- plot + scale_x_continuous("Axis Label", breaks=c(0,5,10), labels=c("0","5","10"))
```

Labels are more useful for when you have categorical data and you wish to override
the category name. Eg, assume you had a dataset like this:
```
animal,count
dog,10
cat,20
pig,30
```

If we didn't want 'dog', 'cat' or 'pig' as the labels, we could override them:
```
plot <- plot + scale_x_discrete("Animal", labels=c("Canine", "Feline", "Porcine"))
```

Facets
------
There are two approaches used for faceting. One is `facet_grid()` which takes
two parameters, the x and y of the facet. The other is `facet_wrap()` which
just takes a single parameter.

EG:
`plot <- plot + facet_wrap(~k)` and `plot <- plot + facet_grid(x ~ y)`

Facet grid can accept empty facet parameters using a fullstop as the parameter:
`plot <- plot + facet_grid(. ~ y)`

One other useful thing for faceting is to set the scales to be free from one
another. This can be achieved like: `facet_grid(x ~ y, scales="free")`.
You may also choose to just have one free scale, such as `scales="free_x"`


Miscellaneous
-------------
* Turn a plot on its side using `coord_flip()`
* More to come?

More Examples and Information
----------------------------

* [50 different plots](http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html)
* [Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf)
* [Official Documentation](http://ggplot2.tidyverse.org/reference/)
* [Bad Graphs - What not to do!](http://people.stat.sfu.ca/~cschwarz/Stat-650/Notes/PDF/ChapterBadgraphs.pdf)
* [Save the Pies for Dessert](https://courses.washington.edu/info424/2007/readings/Save%20the%20Pies%20for%20Dessert.pdf)
* [Some examples from "How to lie with Statistics"](https://shrineodreams.wordpress.com/2013/01/22/good-books-how-to-lie-with-statistics-darrell-huff/)
* [How to lie with statistics](https://en.wikipedia.org/wiki/How_to_Lie_with_Statistics)
* [A field guide to lies and statistics](https://en.wikipedia.org/wiki/A_Field_Guide_to_Lies)
