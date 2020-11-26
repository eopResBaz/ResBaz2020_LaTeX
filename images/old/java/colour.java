final Engine engine = Engine
    .builder(Colours::colourFitness, CODEC) 
    .constraint(ColourRetryConstraint.of(Colours::colourGenerator)) 
    .populationSize(1000)
    .alterers(
        new Mutator<>(0.115),
        new SinglePointCrossover<>(0.12))
    .optimize(Optimize.MAXIMUM)
    .build();

Phenotype<AnyGene<Genotype>, Integer>  best = (Phenotype)engine 
    .stream()
    .limit( Limits.bySteadyFitness(1000) ) 
    .peek(stats)
    .collect(EvolutionResult.toBestPhenotype());

Genotype best = anyBest.getGenotype().getChromosome().getGene().getAllele();
System.out.println(best);
System.out.println("Score: " + fitness(best));
