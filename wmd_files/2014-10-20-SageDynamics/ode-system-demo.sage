# requires: $(SageDynamics)/dynamicalsystems.py $(SageUtils)/latex_output.py
# produces: ode-system-demo.sage.out.tex ode-system-demo.png bifurcation-diagram.png

# use the dynamicalsystems module from SageDynamics
sys.path.append( os.environ['SageDynamics'] )
from dynamicalsystems import *
# use the latex_output module from SageUtils
sys.path.append( os.environ['SageUtils'] )
from latex_output import *

# I'll use a simple competition model borrowed from 
# http://www.tiem.utk.edu/~gross/bioed/bealsmodules/competition.html

# make variables for easy use
N_1, N_2, r_1, r_2, K_1, K_2 = SR.var( 'N_1, N_2, r_1, r_2, K_1, K_2' )
# alpha variables have special latex formatting for the double subscripts
alpha_12 = SR.var( 'alpha_12', latex_name='\\alpha_{12}' )
alpha_21 = SR.var( 'alpha_21', latex_name='\\alpha_{21}' )

# create the competition model by providing flow equations and state variables
comp_system_generic = ODE_system(
    { N_1: r_1 * N_1 * (K_1 - N_1 - alpha_12 * N_2) / K_1,
      N_2: r_2 * N_2 * (K_2 - alpha_21 * N_1 - N_2) / K_2 },
    [ N_1, N_2 ] )

# write output into a tex file
ltx = latex_output( 'ode-system-demo.sage.out.tex' )

ltx.write( 'The generic competition model:' )
ltx.write_block( comp_system_generic )

# and create a specific instantiation of the model by binding parameters
# it has a nontrivial solution if K_1/alpha_12 > K_2 and K_2/alpha_21 > K_1
comp_system_stable = comp_system_generic.bind( {
  K_1 : 1, K_2 : 5/4, alpha_12 : 1/2, alpha_21 : 1/2,
  r_1 : 1, r_2 : 1 } )

ltx.write( 'The competition model with parameters bound to specific values:' )
ltx.write_block( comp_system_stable )

# find the equilibria
ltx.write( 'Equilibria of the generic model: ' )
ltx.write( '\n\\[ ',
	', '.join( latex( column_vector( [ eq[N_1], eq[N_2] ] ) )
		for eq in comp_system_generic.equilibria() ),
	'\n\\]' )

# and check stability of the bound ones
ltx.write( 'Stable equilibria of the bound model: ' )
ltx.write( '\n\\[',
	', '.join( latex( column_vector( [ eq[N_1], eq[N_2] ] ) )
		for eq in comp_system_stable.stable_equilibria() ),
	'\n\\]' )

# solve numerically given starting time and initial conditions
s = comp_system_stable.solve( [0, 0.05, 0.02] )

# plot the system as a vector field on the x-y plane
p = comp_system_stable.plot_vector_field( (N_1,0,1.3), (N_2,0,1.3), color='gray', figsize=(5,5) )
# plot population nullclines
# (there is a plot_ZNGIs method for this, but to use it I'd need to
# be using the PopulationDynamicsSystem subclass)
p += comp_system_stable.plot_isoclines( (N_1,0,1.3), (N_2,0,1.3), [(N_1,0),(N_2,0)], color='gray' )
# superimpose the numerically-solved trajectory onto the same plot
p += s.plot( N_1, N_2, color='red' )
p.axes_labels( [ '$N_1$', '$N_2$' ] )
# render the plot into a png file
p.save( 'ode-system-demo.png' )

# and now do bifurcation diagram

# bind all parameters except the bifurcation parameter
comp_system_b = comp_system_generic.bind( {
  K_1 : 1, K_2 : 5/4, alpha_21 : 1/2, # bind everything except alpha_12
  r_1 : 1, r_2 : 1 } )
# and do plot of equilibrium population as a function of varying parameter
# alpha_12, color coded by whether the equilibrium is stable
comp_system_b.plot_bifurcation_diagram( (alpha_12, -5, 5), (N_1 + N_2, -5, 5), filename='bifurcation-diagram.png', figsize=(5,5) )

# and close the latex output
ltx.close()
