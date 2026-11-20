#example script for model fitting approach


require(MCMCglmm)


data1<-read.csv("data1.csv")
Hybphylo_NAM_EUR_Comb<-readRDS("Hybphylo_NAM_EUR_Comb.RData") 
prior<-list(G=list(G1=list(V=1,nu=0.002),G2=list(V=1,nu=0.002),G3=list(V=1,nu=0.002),G4=list(V=1,nu=0.002)),B=list(mu=c(rep(0,11)),V=diag(11)*(1+pi^2/3)),R=list(V=1,fix=1))

#fit the model four times
for(l in 1:4){
	eval(parse(text=paste0("PHC_M1.",l,"<-MCMCglmm(factor(Hyb) ~ scale(log.Morpho.dist) + scale(log.Colour_mahal.dist) + scale(log.Pattern_Euclid)+ scale(log.Song_avg_Euclid) + scale(Patristic.dist) +scale(asin.sqrt.foraging.niche.overlap) + scale(asin.sqrt.ebird.mean.syntopy) + scale(asin.sqrt.ebird.mean.sympatry) + factor(Either.Mig.L.dist) + factor(Either.L.Term.Social.Bond), random = ~ Continent + animal + species1_ordered + species2_ordered, data=HANHP_data_for_models, family = 'categorical', ginverse = list(animal = Hybphylo_NAM_EUR_Comb$Ainv),prior=prior,nitt=2000000,burnin=20000,thin=1000,verbose=TRUE)")))
	eval(parse(text=paste0("summary(PHC_M1.",l,")")))
	eval(parse(text=paste0("save(PHC_M1.",l,",file='PHC_M1.",l,".RData')")))
}

PHC_M1_combined<- mcmc.list(PHC_M1.1$Sol,PHC_M1.2$Sol,PHC_M1.3$Sol,PHC_M1.4$Sol)

#assess convergence
gelman.diag(PHC_M1_combined)


#combine results
results_PHC_M1_combined <- as.data.frame(summary(PHC_M1_combined)$quantiles)
results_PHC_M1_combined$effects <- factor(rownames(results_PHC_M1_combined),levels=rownames(results_PHC_M1_combined))
results_PHC_M1_combined$col<-ifelse(sign(results_PHC_M1_combined[,1])==sign(results_PHC_M1_combined[,5]),"red","black")
colnames(results_PHC_M1_combined)[c(1,3,5)] <- c("lowerCI","post.median","upperCI")
results_PHC_M1_combined$effects<- c("(Intercept)","Morphometric dissimilarity","Colour dissimilarity","Pattern dissimilarity","Vocalisation dissimilarity","Patristic distance","Foraging niche overlap","Syntopy","Sympatry","Either long-distance migrant","Either have long-term social bonds")


#calculate lambda (phylogenetic signal)
lambda_PHC_M1.1<-PHC_M1.1$VCV[,'animal']/(rowSums(PHC_M1.1$VCV)+(pi^2/3))
lambda_PHC_M1.2<-PHC_M1.2$VCV[,'animal']/(rowSums(PHC_M1.2$VCV)+(pi^2/3))
lambda_PHC_M1.3<-PHC_M1.3$VCV[,'animal']/(rowSums(PHC_M1.3$VCV)+(pi^2/3))
lambda_PHC_M1.4<-PHC_M1.4$VCV[,'animal']/(rowSums(PHC_M1.4$VCV)+(pi^2/3))

lambda_PHC_M1<- c(as.vector(lambda_PHC_M1.1),as.vector(lambda_PHC_M1.2),as.vector(lambda_PHC_M1.3),as.vector(lambda_PHC_M1.4))
mean(lambda_PHC_M1)
quantile(lambda_PHC_M1,c(0.025,0.975))

