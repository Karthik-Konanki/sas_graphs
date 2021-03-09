/*LAYOUT GRIDDED STATEMENT*/

proc template;
	define statgraph intro;
		begingraph;
		entrytitle "Two-Cell Gridded Layout";
			layout gridded;
				barchart category=age;
				scatterplot x=height y=weight;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=intro;
run;


proc template;
	define statgraph celldefine;
		begingraph;
		entrytitle "Simple 3x2 Grid with Five Cells Populated";
			layout gridded / columns=3 rows=2;
			/* standalone plot statements define cells 1-3 */
				boxplot x=sex y=age;
				boxplot x=sex y=height;
				boxplot x=sex y=weight;
			/* overlay blocks define cells 4-5 */
			layout overlay;
				scatterplot y=weight x=height;
				pbsplineplot y=weight x=height;
				entry halign=right "Spline" / valign=bottom;
			endlayout;
			layout overlay;
				scatterplot y=weight x=height;
				loessplot y=weight x=height;
				entry halign=right "Loess " / valign=bottom;
			endlayout;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.class template=celldefine;
run;

/*Building a Table of Text*/
proc template;
	define statgraph inset2;
		begingraph;
		entrytitle "Auto-positioning the Inset Within the Plot Wall";
			layout overlay;
				histogram mrw;
			layout gridded / columns=1 border=true
						columngutter=5px
						autoalign=(topright topleft);
				entry halign=left "N" halign=right "5203";
				entry halign=left "Mean" halign=right "119.96";
				entry halign=left "Std Dev" halign=right "19.98";
			endlayout;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.heart template=inset2;
run;



/*Row and Column Sizes*/

proc template;
	define statgraph celldefine;
		begingraph;
		entrytitle "Simple 3x2 Grid";
			layout gridded / columns=3 rows=2 columngutter=10 rowgutter=10;
			/* standalone plot statements define cells 1-3 */
				boxplot x=sex y=age;
				boxplot x=sex y=height;
				boxplot x=sex y=weight;
/* overlay blocks define cells 4-5 */
			layout overlay;
				scatterplot y=weight x=height / group=sex name="scatter";
				pbsplineplot y=weight x=height;
				entry halign=right "Spline" / valign=bottom;
			endlayout;
			layout overlay;
				scatterplot y=weight x=height / group=sex;
				loessplot y=weight x=height;
				entry halign=right "Loess " / valign=bottom;
			endlayout;
				discretelegend "scatter" / title="Sex";
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=celldefine;
run;



proc template;
	define statgraph fitcompare;
		begingraph / designwidth=495 designheight=220;
		entrytitle "Comparison of Fit Lines";
			layout gridded / columngutter=5 columns=3 rows=1;
			/* Cell 1 */
			layout overlay;
				entry "Spline" / location=outside valign=top;
				scatterplot x=weight y=mpg_city /
								markerattrs=(size=3px symbol=circlefilled color=gray )
								datatransparency=.7;
				pbsplineplot x=weight y=mpg_city;
			endlayout;
			/* Cell 2 */
			layout overlay;
				entry "Loess" / location=outside valign=top;
				scatterplot x=weight y=mpg_city /
							markerattrs=(size=3px symbol=circlefilled color=gray)
							datatransparency=.7;
				loessplot x=weight Y=mpg_city;
			endlayout;
			/* Cell 3 */
			layout overlay;
				entry "Regression" / location=outside valign=top;
				scatterplot x=weight y=mpg_city /
							markerattrs=(size=3px symbol=circlefilled color=gray)
							datatransparency=.7;
				regressionplot x=weight y=mpg_city;
			endlayout;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.cars template=fitcompare;
run;


