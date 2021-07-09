## Note! I no longer use Github. This repo may be out of date.

All my ex-Github repos are now stored and maintained at [my personal website](http://www.robertgrantstats.co.uk/code.html).

Why did I leave Github? Because I consider the compulsory imposition of 2-factor authentication to be inappropriate for people writing software, including cryptography, which can attract severe punishments in certain jurisdictions. We all know that the organisations that hold the 2nd factors (mobile telephony providers, tech companies) are compromised, willingly or otherwise, in their relationships with security agencies, benign or otherwise.

Why not just close it down? Because you might use it programmatically, via http or API, and I don't want to hurt you (by breaking your code) while trying to help you (by raising issues of privacy and confidentiality).



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

Missing data are ignored, which is to say that I impose the R option `na.rm=TRUE`. If you don't know what this means, don't worry about it!

Also, I added some that are not functions in base R:
`simpleboot(Mydata$Income,Mydata$Anxiety,"pearson")`
`simpleboot(Mydata$Income,Mydata$Anxiety,"spearman")`
`simpleboot(Mydata$Income,"p25")`
`simpleboot(Mydata$Income,"p75")`
`simpleboot(Mydata$Income,"iqr")`
`simpleboot(Mydata$Income,"quantile", probs = 0.2)`
`simpleboot(Mydata$Income,Mydata$Anxiety,"meandiff")`
`simpleboot(Mydata$Income,Mydata$Anxiety,"mediandiff")`

Thanks @jarvisc1 for contributing the differences and quantiles.

That gives you the Pearson correlation, the Spearman correlation, the 1st and 3rd quartiles, the inter-quartile range (which just duplicates IQR()), any quantile (in this example the 20th percentile or 0.2 quantile), the difference in means and the difference in medians. Note that the differences are not 'paired', that's to say it is the mean of x minus the mean of y, so missing data are removed individually and not pairwise. If you want it paired, make a new variable that is the difference and then use mean or median on that.

You might not notice if you use this inside R Commander, but a histogram of the empirical distribution function is drawn in the R window.

More esoteric stuff (beginners can skip this)
-------------------------
The `all.cis` option returns normal approximation, percentile, and BCa confidence intervals if TRUE, which is the default. Setting it to FALSE will give you the percentile only.

The `ncpus` option (1 by default) turns on the boot::boot multicore functionality if greater than 1. It should be a natural number.

**test.R** is a unit testing script, which you might want to adapt if you fork this repo. Otherwise, you can safely ignore it.

To-Do List
----------

* Perhaps include some asymptotic formulas too
* Then wrap it all up in a Rcmdr plug-in
