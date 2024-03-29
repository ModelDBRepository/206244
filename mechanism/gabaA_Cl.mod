COMMENT

Synaptic GABAergic mechanism, adapted by Fiona Muellner 2015 from Jedlicka et al. 2011, "Activity-dependent intracellular chloride accumulation and diffusion controls GABA(A) receptor-mediated synaptic transmission."

Reversal potential Egaba is changing according to [Cl-]i change (due to Cl- influx, which we hypothesize to be significant). Bicarbonate (HCO3) flows through the GABAR too, and therefore Egaba is also [HCO3]i/[HCO3]o -dependent
igaba = icl + ihco3 (we assume icl and ihco3 to be mutually independent)

Kinetics are described by an alpha synapse defined by
        i = g * (v - e)     
        where
        g = 0 for t < onset and
        g = gmax * (t - onset)/tau * exp(-(t - onset - tau)/tau)for t > onset
The maximum value is gmax and occurs at t = delay + tau.


ENDCOMMENT


TITLE GABAergic conductance with changing Cl- concentration

NEURON {
	POINT_PROCESS gaba

	USEION cl READ ecl WRITE icl VALENCE -1

	NONSPECIFIC_CURRENT ihco3
	RANGE onset, tau, gmax 
	RANGE P, HCO3e, HCO3i, i

	RANGE icl, ihco3, ehco3, e
}

UNITS {	
	(mA)    = (milliamp)
	(nA)    = (nanoamp)
	(mV)    = (millivolt)
	(uS)  = (micromho)
	(mM)    = (milli/liter)
	F = (faraday) (coulombs)
	R = (k-mole)  (joule/degC)
}

PARAMETER {
	onset=0 	(ms)
	tau=.5 (ms)	<1e-3,1e6>
	gmax=0 	(uS)	<0,1e9>

	HCO3e   = 26	(mM)	: extracellular HCO3- concentration
	HCO3i   = 16	(mM)	: intracellular HCO3- concentration			
	P       = 0.18		: HCO3/Cl relative permeability

	celsius = 34    (degC)
}

ASSIGNED {
	v	(mV)		: postsynaptic voltage 

	icl	(nA)		: chloride current = (1-P)*g*(v - ecl)
	ihco3	(nA)		: bicarb current = P*g*(v - ehco3)
	i	(nA)		: total current generated by this mechanism 
				: = icl + ihco3
	g 	(uS)		: total conductance, split between bicarb (P*g)
				: and chloride ((1-P)*g)

	ecl	(mV)		: equilibrium potential for Cl-
	ehco3	(mV)		: equilibrium potential for HCO3-
		
	e	(mV)		: reversal potential for GABAR			
}


INITIAL { 
	
	ehco3 = log(HCO3i/HCO3e)*(1000)*(celsius + 273.15)*R/F
	e = P*ehco3 + (1-P)*ecl
}

BREAKPOINT {
	
	if (gmax) { at_time(onset) }
	
	g = gmax * alphasyn(t - onset)
	
	icl = (1-P)*g*(v-ecl)

	ihco3 = P*g*(v-ehco3)
	i = icl + ihco3
	e = P*ehco3 + (1-P)*ecl

}

FUNCTION alphasyn(x) {
	if (x < 0 || x > (10 * tau)) {
		alphasyn = 0
	}else{
		alphasyn = x/tau * exp(-(x - tau)/tau)
	}
}

