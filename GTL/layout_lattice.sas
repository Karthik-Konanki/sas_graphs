/*LAYOUT LATTICE STATEMENT*/

proc template;
	define statgraph intro;
		begingraph;
		entrytitle "Two-Cell Lattice Layout";
			layout lattice;
				barchart category=age;
				scatterplot x=height y=weight;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=intro;
run;


/*Populating Cells*/
proc template;
	define statgraph lattice;
		begingraph;
		entrytitle "Simple 3x2 Lattice with Five Cells Populated";
			layout lattice / columns=3 rows=2 columngutter=10 rowgutter=10;
			/* stand-alone plot statements define cells 1-3 */
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
proc sgrender data=sashelp.class template=lattice;
run;


proc template;
	define statgraph lattice2;
		begingraph / designwidth=495px designheight=230px;
		entrytitle "Simple 3x1 Lattice with Cell Headers";
			layout lattice / columns=3 rows=1 columngutter=5;
			/* cell blocks cells 1-3 */
				cell;
					cellheader;
						entry "Spline Fit";
					endcellheader;
			layout overlay;
				scatterplot y=weight x=height;
				pbsplineplot y=weight x=height;
			endlayout;
				endcell;
				cell;
					cellheader;
						entry "Loess Fit";
					endcellheader;
			layout overlay;
				scatterplot y=weight x=height;
				loessplot y=weight x=height;
			endlayout;
				endcell;
				cell;
					cellheader;
						entry "Regression Fit";
					endcellheader;
			layout overlay;
				scatterplot y=weight x=height;
				regressionplot y=weight x=height;
			endlayout;
				endcell;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=lattice2;
run;


/*Managing Axes in LATTICE Layouts*/

/*Internal Axes*/

proc template;
	define statgraph internalaxes;
		begingraph;
		entrytitle "Internal (cell-defined) Axes";
			layout lattice / columns=2 columngutter=5px;
				histogram mpg_city;
				histogram mpg_highway;
			endlayout;
		endgraph;
	end;
run;
ods graphics / reset width=495px height=250px;
proc sgrender data=sashelp.cars template=internalaxes;
run;

/*Uniform Axis Ranges*/

proc template;
	define statgraph internalaxes;
		begingraph;
		entrytitle "Unioned Axes";
			layout lattice / columns=2 columngutter=5px
						columndatarange=unionall
						rowdatarange=union;
				histogram mpg_city;
				histogram mpg_highway;
			endlayout;
		endgraph;
	end;
run;
ods graphics / reset width=495px height=250px;
proc sgrender data=sashelp.cars template=internalaxes;
run;


/*Specifying Row and Column Axes*/

proc template;
	define statgraph internalaxes;
		begingraph;
		entrytitle "Unioned Axes";
			layout lattice / columns=2 columngutter=5px
							columndatarange=unionall
							rowdatarange=union;
				histogram mpg_city;
				histogram mpg_highway;
				rowaxes;
					rowaxis / griddisplay=on;
				endrowaxes;
			endlayout;
		endgraph;
	end;
run;
ods graphics / reset width=495px height=250px;
proc sgrender data=sashelp.cars template=internalaxes;
run;
ods graphics /reset;

/*Displaying Row and Column Secondary Axes*/


proc template;
	define statgraph internalaxes;
		begingraph;
		entrytitle "Secondary Axes";
			layout lattice / columns=2 columngutter=5px
							columndatarange=unionall
							rowdatarange=union;
				histogram mpg_city;
				histogram mpg_highway;
				rowaxes;
					rowaxis / griddisplay=on displaysecondary=(ticks tickvalues);
				endrowaxes;
			endlayout;
		endgraph;
	end;
run;
ods graphics / reset width=495px height=250px;
proc sgrender data=sashelp.cars template=internalaxes;
run;
ods graphics /reset;

/*External Axes and Empty Cells*/

proc template;
	define statgraph skipemptycells1;
		begingraph;
		entrytitle "External Axes and Empty Cells";
			layout lattice / columns=2 rows=2
							rowgutter=5px columngutter=5px
							rowdatarange=unionall columndatarange=unionall;
			/* cell blocks cells 1-3 */
			layout overlay;
				entry "Spline Fit" / valign=top;
				scatterplot y=weight x=height;
				pbsplineplot y=weight x=height;
			endlayout;
			layout overlay;
				entry "Loess Fit" / valign=top;
				scatterplot y=weight x=height;
				loessplot y=weight x=height;
			endlayout;
			layout overlay;
				entry "Regression Fit" / valign=top;
				scatterplot y=weight x=height;
				regressionplot y=weight x=height;
			endlayout;
			rowaxes;
			rowaxis;
			rowaxis;
			endrowaxes;
			columnaxes;
			columnaxis;
			columnaxis;
			endcolumnaxes;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=skipemptycells1;
run;




proc template;
	define statgraph skipemptycells1;
		begingraph;
		entrytitle "External Axes and Empty Cells with skipemptycells = True";
			layout lattice / columns=2 rows=2
							rowgutter=5px columngutter=5px
							rowdatarange=unionall columndatarange=unionall
							skipemptycells=true;
			/* cell blocks cells 1-3 */
			layout overlay;
				entry "Spline Fit" / valign=top;
				scatterplot y=weight x=height;
				pbsplineplot y=weight x=height;
			endlayout;
			layout overlay;
				entry "Loess Fit" / valign=top;
				scatterplot y=weight x=height;
				loessplot y=weight x=height;
			endlayout;
			layout overlay;
				entry "Regression Fit" / valign=top;
				scatterplot y=weight x=height;
				regressionplot y=weight x=height;
			endlayout;
			rowaxes;
			rowaxis;
			rowaxis;
			endrowaxes;
			columnaxes;
			columnaxis;
			columnaxis;
			endcolumnaxes;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=skipemptycells1;
run;



/*Adjusting the Graph Size*/

proc template;
	define statgraph graphsize2;
		begingraph;
		entrytitle "Comparison of Fit Lines";
			layout lattice / columns=3 rows=1 rowdatarange=union;
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
			/* Externalize the row axis */
			rowaxes;
			rowaxis;
			endrowaxes;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.cars template=graphsize2;
run;



proc template;
	define statgraph graphsize2;
		begingraph/designwidth=460px designheight=230px;
		entrytitle "Comparison of Fit Lines";
			layout lattice / columns=3 rows=1 rowdatarange=union;
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
			/* Externalize the row axis */
			rowaxes;
			rowaxis;
			endrowaxes;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.cars template=graphsize2;
run;



/*Example*/

data stock;
set sashelp.stocks;
where stock eq "Microsoft" and year(date) in (2004 2005);
format Date2004 Date2005 date.
Price2004 Price2005 dollar6.;
label Date2004="2004" Date2005="2005";
if year(date) = 2004 then do;
Date2004=date;
Vol2004=volume*10**-6;
Price2004=adjclose;
end;
else if year(date)=2005 then do;
Date2005=date;
Vol2005=volume*10**-6;
Price2005=adjclose;
end;
keep Date2004 Date2005 Vol2004
Vol2005 Price2004 Price2005;
run;

/*Creating the Basic Lattice*/

proc template;
	define statgraph latticebasic;
		begingraph;
		entrytitle "Microsoft Stock Performance";
			layout lattice / columns=2 rows=2;
/* define row 1 */
				seriesplot y=price2004 x=date2004 / lineattrs=GraphData1;
				seriesplot y=price2005 x=date2005 / lineattrs=GraphData1;
/* define row 2 */
				needleplot y=vol2004 x=date2004 /
							lineattrs=GraphData2(thickness=2px pattern=solid);
				needleplot y=vol2005 x=date2005 /
							lineattrs= GraphData2(thickness=2px pattern=solid);
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=stock template=latticebasic;
run;


/*Customizing the Cell Axes*/

proc template;
	define statgraph latticebasic;
		begingraph;
		entrytitle "Microsoft Stock Performance";
			layout lattice / columns=2 rows=2;
/* define row 1 */
/* overlay blocks define X-axis options for row 1 */
			layout overlay / xaxisopts=(display=none griddisplay=on);
				seriesplot x=date2004 y=price2004 / lineattrs=GraphData1;
			endlayout;
			layout overlay / xaxisopts=(display=none griddisplay=on);
				seriesplot x=date2005 y=price2005 / lineattrs=GraphData1;
			endlayout;
/* define row 2 */
/* overlay blocks define X-axis options for row 2 */
			layout overlay / xaxisopts=(display=(label tickvalues)
							timeopts=(tickvalueformat=monname1.));
				needleplot x=date2004 y=vol2004 /
							lineattrs=GraphData2(thickness=2px pattern=solid);
			endlayout;
			layout overlay / xaxisopts=(display=(label tickvalues)
							timeopts=(tickvalueformat=monname1.));
				needleplot x=date2005 y=vol2005 /
							lineattrs= GraphData2(thickness=2px pattern=solid);
			endlayout;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=stock template=latticebasic;
run;


/*Example 2: Lattice with Side Bars*/


proc template;
	define statgraph latticesidebar;
		begingraph;
			layout lattice / columns=2 rows=2
						rowdatarange=union columndatarange=union
						rowgutter=3px columngutter=3px;
			/* define row 1 */
				seriesplot x=date2004 y=price2004 / lineattrs=GraphData1
							name="series" legendlabel="Adjusted Close";
				seriesplot x=date2005 y=price2005 / lineattrs=GraphData1;
			/* define row 2 */
				needleplot x=date2004 y=vol2004 /
							lineattrs=GraphData2(thickness=2px pattern=solid)
							name="needle" legendlabel="Millions of Shares";
				needleplot x=date2005 y=vol2005 /
							lineattrs= GraphData2(thickness=2px pattern=solid);
				rowaxes;
					rowaxis / griddisplay=on display=(label tickvalues)
								label="Price" labelattrs=(weight=bold);
					rowaxis / griddisplay=on display=(label tickvalues)
								label="Volume" labelattrs=(weight=bold);
				endrowaxes;
				columnaxes;
					columnaxis / griddisplay=on display=(label tickvalues)
								labelattrs=(weight=bold) timeopts=(tickvalueformat=monname1.);
				columnaxis / griddisplay=on display=(label tickvalues)
								labelattrs=(weight=bold) timeopts=(tickvalueformat=monname1.);
				endcolumnaxes;
			/* Add top and bottom sidebars */
				sidebar / align=top;
					entry "Microsoft Stock Performance" /
									textattrs=GraphTitleText pad=(bottom=5px);
				endsidebar;
					sidebar / align=bottom;
					discretelegend "series" "needle" / border=off;
				endsidebar;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=stock template=latticesidebar;
run;


/*Example 3: Lattice with Row and Column Axes*/

proc template;
	define statgraph latticeexternalaxes;
		begingraph / designwidth=495px designheight=370px;
		entrytitle "Microsoft Stock Performance";
			layout lattice / columns=2 rows=2
							rowdatarange=union columndatarange=union
							rowgutter=3px columngutter=3px;
			/* define row 1 */
				seriesplot x=date2004 y=price2004 / lineattrs=GraphData1;
				seriesplot x=date2005 y=price2005 / lineattrs=GraphData1;
			/* define row 2 */
				needleplot x=date2004 y=vol2004 /
							lineattrs=GraphData2(thickness=2px pattern=solid);
				needleplot x=date2005 y=vol2005 /
							lineattrs= GraphData2(thickness=2px pattern=solid);
				rowaxes;
					rowaxis / griddisplay=on display=(label tickvalues)
								label="Price" labelattrs=(weight=bold);
					rowaxis / griddisplay=on display=(label tickvalues)
								label="Volume" labelattrs=(weight=bold);
				endrowaxes;
				columnaxes;
					columnaxis / griddisplay=on display=(label tickvalues)
								labelattrs=(weight=bold)
								timeopts=(tickvalueformat=monname1.);
					columnaxis / griddisplay=on display=(label tickvalues)
								labelattrs=(weight=bold)
								timeopts=(tickvalueformat=monname1.);
				endcolumnaxes;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=stock template=latticeexternalaxes;
run;


/*Lattice with Row Headers*/


proc template;
	define statgraph latticeexternalaxes;
		begingraph / designwidth=495px designheight=370px;
		entrytitle "Microsoft Stock Performance";
			layout lattice / columns=2 rows=2
							rowdatarange=union columndatarange=union
							rowgutter=3px columngutter=3px;
			/* define row 1 */
				seriesplot x=date2004 y=price2004 / lineattrs=GraphData1;
				seriesplot x=date2005 y=price2005 / lineattrs=GraphData1;
			/* define row 2 */
				needleplot x=date2004 y=vol2004 /
							lineattrs=GraphData2(thickness=2px pattern=solid);
				needleplot x=date2005 y=vol2005 /
							lineattrs= GraphData2(thickness=2px pattern=solid);
				rowaxes;
					rowaxis / griddisplay=on display=(tickvalues);
					rowaxis / griddisplay=on display=(tickvalues);
				endrowaxes;
				rowheaders;
					layout gridded / columns=1;
						entry "Price" / textattrs=GraphLabelText;
						entry "(Adjusted Close)" / textattrs=GraphValueText;
					endlayout;
					layout gridded / columns=1;
						entry "Volume" / textattrs=GraphLabelText;
						entry "(Millions of Shares)" / textattrs=GraphValueText;
						endlayout;
				endrowheaders;
				columnaxes;
					columnaxis / griddisplay=on display=(label tickvalues)
								labelattrs=(weight=bold)
								timeopts=(tickvalueformat=monname1.);
					columnaxis / griddisplay=on display=(label tickvalues)
								labelattrs=(weight=bold)
								timeopts=(tickvalueformat=monname1.);
				endcolumnaxes;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=stock template=latticeexternalaxes;
run;




proc template;
	define statgraph latticeexternalaxes;
		begingraph / designwidth=495px designheight=370px;
		entrytitle "Microsoft Stock Performance";
			layout lattice / columns=2 rows=2
							rowdatarange=union columndatarange=union
							rowgutter=3px columngutter=3px;
			/* define row 1 */
				seriesplot x=date2004 y=price2004 / lineattrs=GraphData1;
				seriesplot x=date2005 y=price2005 / lineattrs=GraphData1;
			/* define row 2 */
				needleplot x=date2004 y=vol2004 /
							lineattrs=GraphData2(thickness=2px pattern=solid);
				needleplot x=date2005 y=vol2005 /
							lineattrs= GraphData2(thickness=2px pattern=solid);
				rowaxes;
					rowaxis / griddisplay=on display=(tickvalues);
					rowaxis / griddisplay=on display=(tickvalues);
				endrowaxes;
				rowheaders;
					layout gridded / columns=2;
						entry "Price" / textattrs=GraphLabelText rotate=90;
						entry "(Adjusted Close)" / textattrs=GraphValueText rotate=90;
					endlayout;
					layout gridded / columns=2;
						entry "Volume" / textattrs=GraphLabelText rotate=90;
						entry "(Millions of Shares)" / textattrs=GraphValueText rotate=90;
					endlayout;
				endrowheaders;
				columnaxes;
					columnaxis / griddisplay=on display=(label tickvalues)
								labelattrs=(weight=bold)
								timeopts=(tickvalueformat=monname1.);
					columnaxis / griddisplay=on display=(label tickvalues)
								labelattrs=(weight=bold)
								timeopts=(tickvalueformat=monname1.);
				endcolumnaxes;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=stock template=latticeexternalaxes;
run;


/*Example 5: Lattice with Custom Row Sizing*/

proc template;
	define statgraph distribution;
		begingraph;
		entrytitle "Distribution of Cholesterol";
		entryfootnote halign=left
								"From Framingham Heart Study (SASHELP.HEART)";
			layout lattice / rowweights=PREFERRED
							columndatarange=union rowgutter=2px;
				columnaxes;
					columnaxis / display=(ticks tickvalues);
				endcolumnaxes;
			layout overlay / yaxisopts=(offsetmin=.04 griddisplay=auto_on);
				discretelegend "Normal" / location=inside
										autoalign=(topright topleft) opaque=true;
				histogram Cholesterol / scale=percent binaxis=false;
				densityplot Cholesterol / normal( ) name="Normal";
				fringeplot Cholesterol / datatransparency=.7;
			endlayout;
				boxplot y=Cholesterol / orient=horizontal boxwidth=.9;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.heart template=distribution;
run;
