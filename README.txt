#data1.csv: dataset used in analyses

eBird_Combined: string combining the species names for the pair
Sp1_eBird: latin name for species 1 (eBird taxonomy)
Sp2_eBird: latin name for species 2 (eBird taxonomy)
Passerine: =0 if nonpasserine, =1 if passerine
Hyb: =1 if species pair hybridises (in full analysis)
Hyb_ong: =1 if species pair hybridises frequently
log.Morpho.dist: morphometric dissimilarity
log.Colour_mahal.dist: plumage colour dissimilarity
log.Pattern_Euclid: plumage pattern dissimilarity
log.Song_avg_Euclid: vocalisation dissimilarity
Patristic.dist: patristic distance (= 2*tMRCA)
asin.sqrt.foraging.niche.overlap: foraging niche overlap
asin.sqrt.ebird.mean.syntopy: syntopy
asin.sqrt.ebird.mean.sympatry: sympatry
Either.Mig.L.dist: =1 if either species is a long-distance migrant, =0 if neither species is a long-distance migrant
Either.L.Term.Social.Bond: =1 if either species has long-term social bonds, =0 if neither species has long-term social bonds
Continent: whether pair in North America or Europe (as a random effect)
animal: random effect linking species pair to phylogeny
species1_ordered: random effect with species 1 ID
species2_ordered: random effect with species 2 ID


#Hybphylo_NAM_EUR_Comb.RData: phylogeny object for use in MCMCglmm

#script1.R: example model fitting script showing pipeline for fitting and collecting results from MCMCglmm fits