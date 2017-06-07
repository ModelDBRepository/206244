This directory contains the NEURON CA1 pyramidal cell model described in 

Muellner FE, Wierenga C, Bonhoeffer T (2015) Precision of inhibition:
Dendritic inhibition by individual GABAergic synapses is confined in
space and time. Neuron 87: 576-589

It is based on the CA1 pyramidal cell model described in:

1. Poirazi P, Brannon T, Mel BW (2003a) Arithmetic of subthreshold
synaptic summation in a model CA1 pyramidal cell. Neuron 37:977-987
2. Poirazi P, Brannon T, Mel BW (2003b) Pyramidal Neuron as Two-Layer
Neural Network. Neuron 37:989-999
3. Poirazi P, Brannon T, Mel BW (2003ab-sup) Online Supplement: About
the Model Neuron 37 Online:1-20

Original readme: see below.

To run the simulation (auto-launch if browser configured or):
(see https://senselab.med.yale.edu/ModelDB/NEURON_DwnldGuide.html for
more help)
(1) run mknrndll (windows or mac) or nrnivmodl(linux) on the folder
..\CA1_multi\mechanism
(2) copy nrnmech.dll from ..\mechanism to ..\experiment
(3) run LoadModel.hoc by double clicking in windows explorer (windows)
or drag and dropping onto the nrngui icon (mac) or running "nrngui
LoadModel.hoc" on the command line (unix/linux).

This loads the standard cell morphology and inserts all passive and
active mechanisms.

Model variants:

"LoadModel_mul2" loads the model with geometry and all length
constants scaled by the factor 2.

"LoadModel_div2" loads the model with geometry and all length
constants scaled by the factor 0.5.

"LoadModel_WithSpine" loads the default model with a spine added at
the location defined by the variables "dendr" and "spinepos".



The following modifications were implemented in the current model:

(*) All R-type Ca2+-channels (car) were removed since they behave very
unphysiologically by opening at voltage-step OFFset, not ONset, due to
a much faster inactivation than activation time constant (possibly a
typo?). Compare dynamics e.g. to Randall & Tsien 1997, "Contrasting
Biophysical and Pharmacological Properties of T-type and R-type
Calcium Channels".
(*) In the cat-mechanism (T-type channels), the dummy-ion Ca was
replaced by the ion ca, which updates cai.
(*) ek = -80mV was set uniformly (previously was -77mV for some
mechanisms and -80mV for others); this minimally reduces Vrest.
(*) The cad-mechanism was modified to correct the
surface-volume-ratio, which should vary with dendrite diameter (see
Anwar et. al. 2014, "Dendritic diameters affect the spatial
variability of intracellular calcium dynamics in computer models");
this has an effect on Ca2+-amplitudes, but not Ca2+-inhibition.
(*) The density of the LH-channels (calH) was modified to linearly
increase along the first 50um apical dendritic tree (it had increased
step-wise before).
(*) The linear function increasing the Na+ spike attenuation variable
ar2_hha_old with distance was modified to remove abrupt steps in
current density.
(*) The medium Ca2+-dependent K+-current density (mykca_init) was
increased 3x, to prevent Ca2+-spikes in terminal branches, which have
not been observed in the experiments.
(*) The function "current-balance.hoc" was switched off, which forces
e_pas to arbitrarily negative potentials. E.g. when Ih density is
increased, this results in a paradoxical hyperpolarizing net-effect of
Ih.

(*) A finer segmentation was chosen (maximum segment length 5um).


Original readme.txt:
See note at bottom for version information.  FOR DETAILED INFORMATION
ABOUT THE ORIGINAL MODEL DISCRIPTION SEE Detailed Model Description,
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
