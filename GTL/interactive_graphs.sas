/*CREATING INTERACTIVE GRAPHS*/


/*Creating a Graph with Data Tips in an HTML Page*/

proc template;
	define statgraph defaultdatatips;
		begingraph;
		entrytitle "Scatter Plot with Default Data Tips";
			layout overlay;
				scatterplot x=height y=weight / group=sex name="s";
				discretelegend "s";
			endlayout;
		endgraph;
	end;
run;
ods graphics / reset width=5in imagemap=on;
proc sgrender data=sashelp.class template=defaultdatatips;
run;
ods graphics / reset;


proc template;
	define statgraph defaultdatatips1;
		begingraph;
		entrytitle "Scatter Plot with Default Data Tips";
			layout overlay;
			/* scatter points have enhanced tooltips */
				scatterplot x=height y=weight / group=sex name="s"
									rolename=(tip1=name tip2=age)
									tip=(tip1 tip2 X Y GROUP)
									tiplabel=(tip1="Student Name")
									tipformat=(tip2=2.);
				discretelegend "s";
			endlayout;
		endgraph;
	end;
run;
ods graphics / reset imagemap=on;
proc sgrender data=sashelp.class template=defaultdatatips1;
run;
ods graphics / reset;


