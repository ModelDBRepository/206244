This directory contains the NEURON CA1 pyramidal cell model described in 
---------------
Muellner FE, Wierenga C, Bonhoeffer T (2015) Precision of inhibition: Dendritic inhibition by individual GABAergic synapses is confined in space and time. Neuron 87: 576-589
---------------

It is based on the CA1 pyramidal cell model described in:
1. Poirazi P, Brannon T, Mel BW (2003a) Arithmetic of subthreshold synaptic summation in a model CA1 pyramidal cell. Neuron 37:977-987
2. Poirazi P, Brannon T, Mel BW (2003b) Pyramidal Neuron as Two-Layer Neural Network. Neuron 37:989-999
3. Poirazi P, Brannon T, Mel BW (2003ab-sup) Online Supplement: About the Model Neuron 37 Online:1-20

---------------
Original readme: see below.
---------------

For questions, please email: fiona.muellner at gmail.com

---------------

To run the simulation on windows:
(1) run mknrndll.exe on the folder ..\CA1_multi\mechanism
(2) copy nrnmech.dll from ..\mechanism to ..\experiment
(3) run LoadModel_*.hoc
This loads the standard cell morphology and inserts all passive and active mechanisms.


---------------
Model variants:

"LoadModel_mul2" loads the model with geometry and all length constants scaled by the factor 2.

"LoadModel_div2" loads the model with geometry and all length constants scaled by the factor 0.5.

"LoadModel_WithSpine" loads the default model with a spine added at the location defined by the variables "dendr" and "spinepos".

---------------


The following modifications were implemented in the current model:
(*) All R-type Ca2+-channels (car) were removed since they behave very unphysiologically by opening at voltage-step OFFset,  not ONset, due to a much faster inactivation than activation time constant (possibly a typo?). Compare dynamics e.g. to Randall & Tsien 1997, "Contrasting Biophysical and Pharmacological Properties of T-type and R-type Calcium Channels".
(*) In the cat-mechanism (T-type channels), the dummy-ion Ca was replaced by the ion ca, which updates cai.
(*) ek = -80mV was set uniformly (previously was -77mV for some mechanisms and -80mV for others); this minimally reduces Vrest.
(*) The cad-mechanism was modified to correct the surface-volume-ratio, which should vary with dendrite diameter (see Anwar et. al. 2014, "Dendritic diameters affect the spatial variability of intracellular calcium dynamics in computer models"); this has an effect on Ca2+-amplitudes, but not Ca2+-inhibition. 
(*) The density of the LH-channels (calH) was modified to linearly increase along the first 50um apical dendritic tree (it had increased step-wise before).
(*) The linear function increasing the Na+ spike attenuation variable ar2_hha_old with distance was modified to remove abrupt steps in current density.
(*) The medium Ca2+-dependent K+-current density (mykca_init) was increased 3x, to prevent Ca2+-spikes in terminal branches, which have not been observed in the experiments.
(*) The function "current-balance.hoc" was switched off, which forces e_pas to arbitrarily negative potentials. E.g. when Ih density is increased, this results in a paradoxical hyperpolarizing net-effect of Ih. 
(*) A finer segmentation was chosen (maximum segment length 5um).

---------------

The following folders contain the .hoc code for simulations shown in the paper:
(1) regular: simulations for the standard model.
(2) mul2: simulations for the enlarged model, scaled by factor 2 in size.
(3) div2: simulations for the shrinked model, scaled by factor 0.5 in size.
(4) vclamp: simulations replacing the synapse by a dendritic voltage clamp
(5) smalltau: simulations with faster synapse kinetics
(6) spine: simulations comparing spine and shaft transients
(7) branchpoint+: simulations varying the distance of the synapse from the next branchpoint
(8) spinesadded: simulations with spines added
(9) triple: simulations for triple action-potentials
(10) triple_tau3: simulations for triple action-potentials with tau=3ms


---------------

To run an experiment:
(1) Copy nrnmech.dll to the respective folder.
(2) Doubleclick on each EperimentX.hoc (X=1,...,15) to run the simulation with the inhibitory synapse placed at one of the 15  positions that were randomly selected.
(3) Results will be saved in simulationData_X.dat, with parameters saved in simulationData_param_X.dat as defined in ExpProcedure.hoc.


To process and plot the data in Matlab:
(4) Define the global variable rootfolder = '...' which contains your "CA1_multi" folder. 
(5) Change to the respective experiment folder, e.g. cd(sprintf('%s\\CA1_multi\\experiment\\regular',rootfolder))
(6) Add the folder 'CA1_multi\matlabcode' to your Matlab path.
(7) Convert all .dat files to .mat by running LoadAndSaveAll.m.


The figures of the publication can then be reproduced running the following Matlab functions:

Fig. 4E: 	VClamp.m
Fig. 4F: 	ConductanceSim.m
Fig. 5D+E: 	CompareLengthConstants.m
Fig. 6C: 	BranchpointAnalysis.m
Fig. 7B-E:	SpineVsShaft.m
Fig. 8A+B:	CompareTemporalProfiles.m
Fig. 8E:	SpatioTemporalProfile.m	
Fig. S3B: 	LargeConductance.m


To process the data without Matlab:

simulationData_X.dat is an MxN matrix containing the simulated voltage and calcium transients at all recorded locations (chan), for all spike-timing delays (time) and all conductances (cond). 

Channel 1: voltage at the soma
Channel 2 - nchan/2: voltage at the dendritic locations
Channel nchan/2: calcium at the soma
Channel nchan/2+1 - nchan: calcium at the dendritic locations 

E.g. data recorded for the 9th of ni channels, the 3rd of nj spike-timings, the 4th of nk conductances and the 7th position will be recorded in column 9 + (3-1)*ni + (4-1)*nj*ni + (7-1)*nk*nj*ni.

column N-3: the vector of sampling timepoints
column N-2: the distances of each recording location from the soma
column N-1: how the recording location relates to the synapse location (-1: proximal location, +1: distal location, z: located on neighboring branch with branchpoint at distance z from soma).

simulationData_param_X.dat is an PxQ matrix containing:
row 1: time of backpropagating action-potential stimulation
row 2: distance of the synapse from the soma
row 3: time of synaptic stimulation
row 4: conductances

E.g. parameters for the 3rd of nj spike-timings, the 4th of nk conductances and the 7th position will be saved in column (3-1) + (4-1)*nj + (7-1)*nk*nj.

column Q-1: 
row 1: number of channels
row 2: number of synapse positions
row 3: number of spike-timing delays
row 4: number of conductances

---------------

Original readme.txt:
See note at bottom for version information.
FOR DETAILED INFORMATION ABOUT THE ORIGINAL MODEL DISCRIPTION SEE Detailed Model Description, 
Model DB accession # 20212 at senselab.med.yale.edu

Following is a brief overview of the contents of this directory:

(1) lib: 		This directory contains all the library functions called
			in the setup of the CA1 model cell as well as functions used in
			the experiments. Each of the functions is described in detail
			within the respective *.hoc file. 

(2) morphology: 	This directory contains the morphology of the cell
			as well as various lists of dendritic compartments used in the
			model setup and the experiments (files are in subdirectory n123).
			
(3) template:		This directory contains a few files that define
			templates used in the model setup and experiments. Templates
			are described in the .hoc files. 

(4) experiment: 	This directory contains a selected set of experiments as described 
			in the aforementioned publications. Within each subdirectory, the 
			*.hoc files contain the NEURON code for the experiment while the 
			run_* files are the executables used by the user to run the experiment. 
			Each experiment is described in detail in the respective .hoc files. Briefly:
			

!!!Clarification change!!!: The conductance value for the h current has been scaled by a factor of 1000 in cell-setup.hoc in order to eliminate this scaling 
factor from the h.mod file and correct the reported value which appeared to be very high in the Online Supplement. This does not alter the current in the 
model at all. The correction is in the reported conductance value which becomes 0.1872 mS/cm^2 and not 18.72 mS/cm^2 as was reported in the Online Supplement.


!!! Bug Report !!!  There was a typo in the nap.mod file pointed out by Michele Migliore which has now been corrected. It did not appear to have any significant 
effect on the model behavior and results.

If you have any problems using the model, please feel free to
contact me at poirazi@imbb.forth.gr.

Hope this is helpful! Good luck,

Yiota Poirazi
December 4th, 2003


-------
6/22/2004 Version: In addition to the above bug report, these files were modified to run on mswin and 
updated to work with the very most recent (alpha version) of NEURON (request a replacement mos2nrn1.sh if you
want to autolaunch this model on mswin or install the alpha version
ftp://www.neuron.yale.edu/neuron/versions/alpha/nrn5.7.10setup.exe
available from neuron web site.)
If you have an earlier 5.x version of neuron on mswin you can use these files by 
by cd'ing to the mechanisms directory and compiling the mod files there and then starting up 
mosinit.hoc in the mechanisms directory (double clicking in mswin).
20120112 Version: the euler methods in cad.mod and gabab.mod were updated to
derivimplicit and cnexp as per
http://www.neuron.yale.edu/phpbb/viewtopic.php?f=28&t=592
20170607 An update from Fiona Muellner with added hoc and matlab code
to reproduce all the figures in the paper.
