simpleboot<-function(x,y=NULL,stat,reps=1000) {
  cat("Bootstrapping can go wrong!\n")
  cat("This simple function will not show you warning messages.\n")
  cat("Check results closely and be prepared to consult a statistician.\n")
  if(stat=="max" | stat=="min") { warning("Bootstrap is likely to be incorrect for minima and maxima") }
  if(stat!="mean" & stat!="median" & stat!="p25" & stat!="p75" & stat!="iqr" & 
     stat!="sd" & stat!="pearson" & stat!="spearman" & stat!="meandiff" & stat!="mediandiff") {
        warning("Simpleboot is only programmed to work with stat set to one of: mean, median, sd, iqr, p25, p75, pearson, spearman, meandiff, mediandiff. Other functions might work, but there's no guarantee!")
  }
  require(boot)
  if(stat=="p25") {
    eval(parse(text=eval(substitute(paste("p.func<-function(x,i) quantile(x[i],probs=0.25,na.rm=TRUE)",sep=""),list(stat=stat)))))
  }
  else if(stat=="p75") {
    eval(parse(text=eval(substitute(paste("p.func<-function(x,i) quantile(x[i],probs=0.75,na.rm=TRUE)",sep=""),list(stat=stat)))))
  }
  else if(stat=="iqr") {
    eval(parse(text=eval(substitute(paste("p.func<-function(x,i) quantile(x[i],probs=0.75,na.rm=TRUE)-quantile(x[i],probs=0.25,na.rm=TRUE)",sep=""),list(stat=stat)))))
  }
  else if(stat=="pearson" | stat=="spearman") {
    x<-matrix(c(x,y),ncol=2)[(!is.na(x))&(!is.na(y)),]
    eval(parse(text=eval(substitute(paste("p.func<-function(x,i) cor(x[i,],use='complete',method='",stat,"')[1,2]",sep=""),list(stat=stat)))))
  }
  else if(stat=="meandiff"){
    eval(parse(text=eval(substitute(paste("p.func<-function(x,i) mean(x[i])-mean(y[i])",sep=""),list(stat=stat)))))
  }
  else if(stat=="mediandiff"){
    eval(parse(text=eval(substitute(paste("p.func<-function(x,i) median(x[i])-median(y[i])",sep=""),list(stat=stat)))))
  }
  else {
    eval(parse(text=eval(substitute(paste("p.func<-function(x,i) ",stat,"(x[i],na.rm=TRUE)",sep=""),list(stat=stat)))))
  }
  bootsy<-boot(x,statistic=p.func,R=reps,stype="i")
  hist(bootsy$t,breaks=25,main="EDF from bootstrap",xlab=stat)
  suppressWarnings(return(list(replicates=reps,point.estimate=bootsy$t0,normal.ci=c(boot.ci(bootsy)$normal[2],boot.ci(bootsy)$normal[3]),
                               percent.ci=c(boot.ci(bootsy)$percent[4],boot.ci(bootsy)$percent[5]),
                               bca.ci=c(boot.ci(bootsy)$bca[4],boot.ci(bootsy)$bca[5]))))
}
