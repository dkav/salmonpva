# Calculates basic probability of extinction using 
	# Probability calcs
	 # set probability of reaching a lower extinction threshold
		probext[probext>1] <- 1 # cannot be more probable than 1
	}	

	# Confidence intervals calcs -		
	 # set distributions of µ and σ2 for 
	rmcp <- riskmcp(nc,mu,sigmasq,L)
		
	# set probability of reaching a lower extinction threshold	
    probextcl <- (exth/pops)^(2*murnds/s2slprnds)
	probextcl[murnds<0] <- 1  # negative growth = eventual extinction
	probextcl[probextcl>1] <- 1 # cannot be more probable than 1

	# set parameters
	cfyr <- 1 # count of current future year
 		
		# Calculate risk of ultimate extinction	
 		 # calculate conditional extinction time CDF
		risk[risk>1] <- 1 # cannot become more extinct
		
		 # calculate conditional extinction time CDF
				Gcl <- pnorm( (-log(pops/exth) + abs(murnds)*cfyr)/sqrt(s2slprnds*cfyr) ) + ( exp(2*log(pops/exth)*abs(murnds)/s2slprnds)*pnorm( (-log(pops/exth) - abs(murnds)*cfyr)/sqrt(s2slprnds*cfyr) ) )
				
		Gcl[is.na(Gcl)] <- 0 # when NA's present set to zero
		
		# set probability of ultimate extinction
		