# Test count and running sum transformed counts for 
# Fagan 2002 (see ESA Ecological Archives A014-023-S1 
# and Ecological Archives E083-047-S1 respectively)

Rmodtst <- data.frame(dataset=ordds, Rnfpval=numeric(nods), Rtrendp=numeric(nods), Rautocp=numeric(nods), Rddpval=numeric(nods), Routliners=numeric(nods), Rclrsq=numeric(nods), Rclpval=numeric(nods))

# Run Tests
	lenN<-length(N)
	Nlogratios<-log(N[2:lenN]/N[1:(lenN-1)])
    # indices where Nlogratios is not zero; need for trend test
    Nlogratiosyrs<-(1:length(Nlogratios))[is.finite(Nlogratios)]
    # chuck cases where N is zero 
    Nlogratios<-Nlogratios[is.finite(Nlogratios)] 
    
    lenR <- length(rscount)

# Test 1: for normality using a Kolmogorov-Smirnov test
	Nnfpval <- Nnormfit$p.value
	
	Rnormfit<-ks.test(Rlogratios,y="pnorm")
	Rnfpval <- Rnormfit$p.value
		
# Test 2: check for trends in data
	
	Rtrendstat <- ls.print(lsfit(Rlogratiosyrs,Rlogratios),print.it=F)
	 # ratios in t with ratio at t+1		
	# corresponding ratios in t+1	
	Ny <- Nlogratiodetrend[2:lenNlogs] 
	Nacpval <- Ntmpacf$p.value
	
	lenRlogs <- length(Rlogratios)
	 # ratios in t with ratio at t+1		
	# corresponding ratios in t+1	
	Ry <- Rlogratiodetrend[2:lenRlogs] 
	Racpval <- Rtmpacf$p.value
			    
# Test 4: check for denisity-dependance
	Nddpval <- Nlcntdiag$coef[2,4]
	
	Rlcntfit <- lm(Rlogratios~rscount[1:(lenR-1)])	
	Rddpval <- Rlcntdiag$coef[2,4]
	
# Test 5: check for outliers in the logratios
	# Size adjusted cut-off = 2*sqrt(num parameters/num observations) 
	# re Belsley, Kuh, and Welsch (1980) 
    
	outliercutoff <- 2 # values larger are influential
    
	Nmulsfit <- lsfit(rep(1,(lenN-1)),Nlogratios,intercept=F)
	Noutliers <- prod(Nmudfits)

	Routliers <- prod(Rmudfits)
	
# Test 6: check if the sigma regression is bad
	rclrsq <- lmsigma2sum$r.squared
	rclpval <- lmsigma2sum$coef[2,4]	
	
	
	Rmodtst[j,2:8] <- data.frame(Rnfpval, Rtrendpval, Racpval, Rddpval, Routliers, rclrsq, rclpval)
           
fileoutnm <- paste("./output/", "Rmodtst.csv", sep = "")