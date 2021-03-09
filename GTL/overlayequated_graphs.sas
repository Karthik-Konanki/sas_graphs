/*OVERLAYEQUATED Layouts*/

/*Types of Equated Axes*/

proc template;
	define statgraph mpg;
		mvar TYPE;
		begingraph;
		entrytitle "Comparison of " TYPE " Vehicle Mileage by Origin";
		entryfootnote halign=right "SASHELP.CARS";
			layout overlayequated / equatetype=fit;
				scatterplot x=mpg_city y=mpg_highway / group=origin
							name="s" markerattrs=(size=7px);
				referenceline x=eval(mean(mpg_city)) /
							curvelabel=eval(put(mean(mpg_city),4.1));
				referenceline y=eval(mean(mpg_highway)) /
							curvelabel=eval(put(mean(mpg_highway),4.1));
				discretelegend "s";
			layout gridded / columns=1 halign=right valign=bottom;
		entry "Reference lines at";
		entry "average overall city";
		entry "and highway mileages";
			endlayout;
			endlayout;
		endgraph;
	end;
run;
%let type=SUV;
proc sgrender data=sashelp.cars template=mpg;
where type="&type";
run;



ods graphics on;
proc univariate data=sashelp.heart;
	var weight;
	ppplot / normal square;
run;
quit;



proc template;
	define statgraph pp_plot;
		begingraph;
		entrytitle "P-P Plot for Weight";
		entryfootnote halign=right "Derived from PPPLOT template";
			layout overlayequated / equatetype=square
									xaxisopts=(label="Normal(Mu=153.09 Sigma=28.915)"
									thresholdmin=1 thresholdmax=1)
									yaxisopts=(label="Cumulative Distribution of Weight"
									thresholdmin=1 thresholdmax=1)
									commonaxisopts=(viewmin=0.0 viewmax=1.0);
				scatterplot x=Theoretical y=Empirical;
				lineparm x=0 y=0 slope=1 / lineattrs=GraphFit;
			endlayout;
		endgraph;
	end;
run;

ods graphics on;
ods select ppplot;
ods output ppplot=ppdata;
proc univariate data=sashelp.heart;
	var weight;
	ppplot / normal square;
	run;
quit;
proc sgrender data=ppdata
	template=pp_plot;
run;



proc template;
	define statgraph pp_plot;
		begingraph;
		entrytitle "P-P Plot for Weight";
		entryfootnote halign=right "Derived from PPPLOT template";
			layout overlayequated / equatetype=square
									xaxisopts=(label="Normal(Mu=153.09 Sigma=28.915)"
									thresholdmin=1 thresholdmax=1
									tickvalueformat=3.2
									display=(label tickvalues)
									displaysecondary=(tickvalues)
									griddisplay=on)
									yaxisopts=(label="Cumulative Distribution of Weight"
									thresholdmin=1 thresholdmax=1
									tickvalueformat=3.2
									display=(label tickvalues)
									displaysecondary=(tickvalues)
									griddisplay=on)
									commonaxisopts=(viewmin=0.0 viewmax=1.0
									tickvaluesequence=(start=0 end=1 increment=.25));
				scatterplot x=Theoretical y=Empirical;
				lineparm x=0 y=0 slope=1 / lineattrs=GraphFit;
			endlayout;
		endgraph;
	end;
run;

ods graphics on;
ods select ppplot;
ods output ppplot=ppdata;
proc univariate data=sashelp.heart;
	var weight;
	ppplot / normal square;
	run;
quit;
proc sgrender data=ppdata
	template=pp_plot;
run;
