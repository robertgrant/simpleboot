simpleboot
==========

Easy bootstrap confidence intervals for learners
------------------------------------------------

**simpleboot** is an extremely basic and pared-down R function to provide bootstrap confidence intervals for teaching purposes. I assume little or no R awareness at this stage in an introductory stats course. Following the [GAISE guidelines](http://www.amstat.org/education/gaise/GaiseCollege_Full.pdf), I use bootstrapping and randomisation tests to introduce inference right at the beginning. These are not advanced topics, though they may appear in the later parts of a traditional textbook because they are more recently implemented than asymptotic "shortcut" formulas. Nevertheless, there's nothing new about them. Randomisation goes back to Ronald Fisher between the two world wars, while bootstrapping was mathematically formalised by Brad Efron in 1979.

Syntax
------

If you have a data frame called Mydata, and you want the CI around the mean of Income:
`simpleboot(Mydata$Income , "mean")`

This works for any R function that takes a single argument and returns a single value. (but see To-Do List below) In my experience, students will use this for means, medians, standard deviations, etc. So, these are the functions available to you:
`simpleboot(Mydata$Income , "mean")`
`simpleboot(Mydata$Income , "median")`
`simpleboot(Mydata$Income , "sd")`
`simpleboot(Mydata$Income , "IQR")`

Missing data are ignored, which is to say that I impose the R option na.rm=TRUE. If you don't know what this means, don't worry about it!

Also, I added some that are not functions in base R:
`simpleboot(Mydata$Income,Mydata$Anxiety,"pearson")`
`simpleboot(Mydata$Income,Mydata$Anxiety,"spearman")`
`simpleboot(Mydata$Income,"p25")`
`simpleboot(Mydata$Income,"p75")`
`simpleboot(Mydata$Income,"iqr")`
`simpleboot(Mydata$Income,"quantile", probs = 0.2)`
`simpleboot(Mydata$Income,Mydata$Anxiety,"meandiff")`
`simpleboot(Mydata$Income,Mydata$Anxiety,"mediandiff")`

That gives you the Pearson correlation, the Spearman correlation, the 1st and 3rd quartiles, the inter-quartile range (which just duplicates IQR()), the 20th percentile (0.2 quantile), the difference in means and the difference in medians.

You might not notice if you use this inside R Commander, but a histogram of the empirical distribution function is drawn in the R window.

To-Do List
----------

* Perhaps include some asymptotic formulas too
* Then wrap it all up in a Rcmdr plug-in
