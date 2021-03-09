proc template;
	define statgraph carsprofile;
		begingraph;
			entrytitle "Model Weight by Height";
				layout overlay;
					scatterplot x=height y=weight;
					regressionplot x=height y=weight /
									cli="cli";
					modelband "cli";
				endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=carsprofile;
run;




proc template;
	define statgraph carsprofile;
		begingraph;
			entrytitle "Model Weight by Height";
				layout overlay;
					scatterplot x=height y=weight;
					regressionplot x=height y=weight /
									cli="cli";
					modelband "cli"/ datatransparency=0.8 fillattrs=(transparency=0.6);
				endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=carsprofile;
run;
