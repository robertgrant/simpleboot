simpleboot<-function(x,stat,reps=1000) {
	cat("Bootstrapping can go wrong!\n")
	cat("This simple function will not show you warning messages.\n")
	cat("Check results closely and be prepared to consult a statistician.\n")
	if(stat=="max" | stat=="min") {
		warning("Bootstrap is likely to fail for minima and maxima")
	}
	require(boot)
	eval(parse(text=eval(substitute(paste("p.func<-function(x,i) ",
							  stat,
							  "(x[i])",sep=""),
						  list(stat=stat)))))
	myboots<-boot(x,statistic=p.func,R=reps,stype="i")
	hist(bmed$t,breaks=25,main="EDF from bootstrap",
		xlab=stat)
	suppressWarnings(return(list(replicates=iter,point.estimate=myboots$t0,
			normal.ci=c(boot.ci(myboots)$normal[2],boot.ci(myboots)$normal[3]),
			percent.ci=c(boot.ci(myboots)$percent[4],boot.ci(myboots)$percent[5]),
			bca.ci=c(boot.ci(myboots)$bca[4],boot.ci(myboots)$bca[5]))))
}
