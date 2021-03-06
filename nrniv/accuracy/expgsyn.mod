NEURON {
	POINT_PROCESS ExpGSyn
	RANGE tau, e, i
	NONSPECIFIC_CURRENT i
}

UNITS {
	(nA) = (nanoamp)
	(mV) = (millivolt)
	(uS) = (microsiemens)
}

PARAMETER {
	tau = 0.1 (ms) <1e-9,1e9>
	e = 0	(mV)
}

ASSIGNED {
	v (mV)
	i (nA)
}

STATE {
	g (uS)
}

INITIAL {
	g=0
}

BREAKPOINT {
	SOLVE state METHOD cnexp
	i = g*(v - e)
:printf("BREAKPOINT t=%g g=%g v=%g i=%g\n", t, g, v, i)
}

DERIVATIVE state {
	g' = -g/tau
:printf("DERIVATIVE t=%g g=%g\n", t, g)
}

NET_RECEIVE(weight (uS)) {
:printf("NET_RECEIVE g = %g + weight=%g\n", g, weight)
	g = g + weight
}
