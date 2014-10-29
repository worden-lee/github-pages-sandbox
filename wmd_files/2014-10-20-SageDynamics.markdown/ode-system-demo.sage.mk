ode-system-demo.sage.out : $(SageDynamics)/dynamicalsystems.py $(SageUtils)/latex_output.py
ode-system-demo.sage.out.tex ode-system-demo.png bifurcation-diagram.png : ode-system-demo.sage.out ;
