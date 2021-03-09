data temps;
input City $1-11 Country :$9. Fahrenheit;
Celsius= (fahrenheit-32)*(5/9);
cards;
New York USA 52
Sydney Australia 53
Mexico City Mexico 64
Paris France 47
Tokyo Japan 43
;
run;

proc template;
	define statgraph axesXY;
		begingraph;
			entrytitle "X and Y Axes";
				layout overlay;
					scatterplot x=City y=Fahrenheit;
				endlayout;
		endgraph;
	end;
run;
proc sgrender data=temps template=axesXY;
run;

/* Explicitly called X and Y axis */ 

proc template;
	define statgraph axesXY;
		begingraph;
			entrytitle "X and Y Axes";
				layout overlay;
					scatterplot x=City y=Fahrenheit/xaxis=x yaxis=y;
				endlayout;
		endgraph;
	end;
run;
proc sgrender data=temps template=axesXY;
run;

/* Explicitly called X2 and Y2 axis */ 

proc template;
	define statgraph axesXY;
		begingraph;
			entrytitle "X and Y Axes";
				layout overlay;
					scatterplot x=City y=Fahrenheit/xaxis=x2 yaxis=y2;
				endlayout;
		endgraph;
	end;
run;
proc sgrender data=temps template=axesXY;
run;

/*Y and Y2 Axes Use Different Data*/

proc template;
	define statgraph axesXY;
		begingraph;
			entrytitle "Y and Y2 Axes with different data";
				layout overlay / yaxisopts=(griddisplay=on);
					scatterplot x=City y=Fahrenheit;
					scatterplot x=City y=Celsius / datatransparency=1 yaxis=y2;
				endlayout;
		endgraph;
	end;
run;
proc sgrender data=temps template=axesXY;
run;





proc template;
	define statgraph overlayaxes.axesYY2;
		begingraph;
			entrytitle "Y and Y2 Axes Use Different Data";
				layout overlay / cycleattrs=true xaxisopts=(display=(tickvalues))
						y2axisopts=( offsetmin=0 label="Volume (millions of shares)");
					seriesplot x=date y=close / lineattrs=(pattern=solid thickness=2);
					needleplot x=date y=eval(volume/10**6) /
							lineattrs=(pattern=solid thickness=2) yaxis=y2;
				endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.stocks template=overlayaxes.axesYY2;
	where year(date)=2005 and Stock="IBM";
	format volume 3.;
	label close="Price";
run;



/* USE OF PRIMARY = TRUE */
proc template;
	define statgraph classprofile;
		begingraph;
			entrytitle "Model Weight by Height";
				layout overlay;
					scatterplot x=age y=weight;
					barchart category=age y=weight / 
						fillattrs = (transparency = 0.7) 
						primary = true;
				endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=classprofile;
run;


proc template;
	define statgraph classprofile;
		begingraph;
			entrytitle "Model Weight by Height";
				layout overlay/xaxisopts = (type = discrete);
					scatterplot x=age y=weight;
					barchart category=age y=weight / 
						fillattrs = (transparency = 0.7);
				endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=classprofile;
run;


/*AXIS LINE VERSUS WALL OUTLINE*/

/* Specify a path for the ODS output */
filename odsout "D:\SAS\SASUniversityEdition\myfolders\sas_graph\GTL";
proc template;
	define style Styles.axis_wall_style;
		parent=styles.htmlblue;
			style graphwalls from graphwalls /
				frameborder=on
				linestyle=1
				linethickness=2px
				backgroundcolor=GraphColors("gwalls")
				contrastcolor= orange;
			style graphaxislines from graphaxislines /
				linestyle=1
				linethickness=2px
				contrastcolor=blue;
			style GraphWalls from GraphWalls /
				frameborder=off;
	end;
run;

ods _all_ close;
ods html path=odsout file="AxisWallStyle.html" style=axis_wall_style;

proc template;
	define statgraph axis_wall1;
		begingraph / border=true;
			entrytitle textattrs=(color=blue) "Axis Line "
					   textattrs=(color=orange) "Wall Outline";
				layout overlay / walldisplay=(fill outline);
					scatterplot x=City y=Fahrenheit / datatransparency=.5;
			entry textattrs=(color=green) "( Wall Area )";
				endlayout;
		endgraph;
	end;
run;

proc sgrender data=temps template=axis_wall1;
run;

ods html close;
ods html; /* Not required in SAS Studio */


/*IF DO NOT WANT GRAPH WALL*/

/* Specify a path for the ODS output */
filename odsout "D:\SAS\SASUniversityEdition\myfolders\sas_graph\GTL";
proc template;
	define style Styles.axis_wall_style;
		parent=styles.htmlblue;
/*			style graphwalls from graphwalls /*/
/*				frameborder=on*/
/*				linestyle=1*/
/*				linethickness=2px*/
/*				backgroundcolor=GraphColors("gwalls")*/
/*				contrastcolor= orange;*/
/*			style graphaxislines from graphaxislines /*/
/*				linestyle=1*/
/*				linethickness=2px*/
/*				contrastcolor=blue;*/
			style GraphWalls from GraphWalls /
				frameborder=off;
	end;
run;

ods _all_ close;
ods html path=odsout file="AxisWallStyle.html" style=axis_wall_style;

proc template;
	define statgraph axis_wall1;
		begingraph / border=true;
			entrytitle textattrs=(color=blue) "Axis Line "
					   textattrs=(color=orange) "Wall Outline";
				layout overlay / walldisplay=(fill);
					scatterplot x=City y=Fahrenheit / datatransparency=.5;
			entry textattrs=(color=green) "( Wall Area )";
				endlayout;
		endgraph;
	end;
run;

proc sgrender data=temps template=axis_wall1;
run;

ods html close;
ods html; /* Not required in SAS Studio */



/*SPECIFY AXIS OPTIONS*/

proc template;
	define statgraph DisplayOpts;
		begingraph;
		entrytitle "Restrict Display of Axis Features";
			layout overlay / xaxisopts=(display=(label tickvalues line));
				barchartparm x=City y=Fahrenheit / orient=vertical;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=temps template=DisplayOpts;
run;


proc template;
	define statgraph DisplayOpts;
		begingraph;
		entrytitle "Restrict Display of Axis Features";
			layout overlay / yaxisopts=( displaysecondary=standard );
				barchartparm category=city response=fahrenheit;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=temps template=DisplayOpts;
run;



proc template;
	define statgraph DisplayOpts;
		begingraph;
		entrytitle "Restrict Display of Axis Features";
			layout overlay / xaxisopts=( display=( line label tickvalues ) )
							 yaxisopts=( displaysecondary=( ticks tickvalues line )
							 griddisplay=on );
				barchartparm category=city response=fahrenheit;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=temps template=DisplayOpts;
run;

/*AXIS TYPE*/

/*	The BARCHART is considered the primary plot because it is the 
  	first stand-alone plot that is specified in the layout and no
	other plot has been set as the primary plot.
*/
proc template;
	define statgraph DisplayOpts;
		begingraph;
		entrytitle "Axis Type";
			layout overlay;
				barchart category=quarter response=actualSales;
				seriesplot x=quarter y=predictedSales;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.prdsal2 template=DisplayOpts;
run;




proc template;
	define statgraph DisplayOpts;
		begingraph;
		entrytitle "Axis Type";
			layout overlay;
				seriesplot x=quarter y=predictedSales;
				seriesplot x=quarter y=actualSales;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.prdsal3 template=DisplayOpts;
run;





proc template;
	define statgraph DisplayOpts;
		begingraph;
		entrytitle "Axis Type";
			layout overlay / xaxisopts=(type=discrete);
				seriesplot x=quarter y=predictedSales;
				barchart category=quarter response=actualSales;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.prdsal3 template=DisplayOpts;
run;





proc template;
	define statgraph DisplayOpts;
		begingraph;
		entrytitle "Axis Type";
			layout overlay;
				seriesplot x=quarter y=predictedSales;
				barchart category=quarter response=actualSales;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.prdsal3 template=DisplayOpts;
run;

/*AXIS LABELS*/

/*Default Axis Labels*/

data growth;
	do hours=1 to 5 by .1;
		growth = 10**hours;
		bacteria = 1000*10**( sqrt(hours ));
		virus = 1000*10**(log(hours));
		label bacteria = "Bacteria Growth" virus="Virus Growth";
		output;
	end;
run;


proc template;
	define statgraph axislabeldefault1;
		begingraph;
		entrytitle "Default X and Y Linear Axes";
			layout overlay / cycleattrs=true;
				seriesplot x=Hours y=Bacteria/ curvelabel="Bacteria";
				seriesplot x=Hours y=Virus / curvelabel="Virus";
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=growth template=axislabeldefault1;
run;




proc template;
	define statgraph axislabeldefault1;
		begingraph;
		entrytitle "Default X and Y Linear Axes";
			layout overlay / cycleattrs=true;
				seriesplot x=Hours y=Bacteria/ curvelabel="Bacteria";
				seriesplot x=Hours y=Virus / curvelabel="Virus" primary=true;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=growth template=axislabeldefault1;
run;



proc template;
	define statgraph axislabeldefault1;
		begingraph;
		entrytitle "Default X and Y Linear Axes";
			layout overlay / cycleattrs=true
						yaxisopts=(label="Growth of Virus and Bateria Cultures");
				seriesplot x=Hours y=Bacteria/ curvelabel="Bacteria";
				seriesplot x=Hours y=Virus / curvelabel="Virus";
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=growth template=axislabeldefault1;
run;


proc template;
	define statgraph axislabeldefault3;
		begingraph;
		entrytitle "Default Axis Label for a Computed Column";
			layout overlay;
				histogram eval(weight*height);
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=axislabeldefault3;
run;

/*Overriding the Default Axis Label*/



proc template;
	define statgraph axislabeldefault3;
		begingraph;
		entrytitle "Default Axis Label for a Computed Column";
			layout overlay / xaxisopts=(label="WEIGHT (*ESC*){unicode '00D7'x} HEIGHT");
				histogram eval(weight*height);
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=axislabeldefault3;
run;


/*Making Long Axis Labels Fit*/

proc template;
	define statgraph shortaxislabel;
		begingraph;
		entrytitle "Short Label Substitution";
			layout overlay / cycleattrs=true
							yaxisopts=(label="Growth of Virus and Bacteria Cultures"
							shortlabel="Growth");
				seriesplot x=Hours y=Bacteria/ curvelabel="Bacteria";
				seriesplot x=Hours y=Virus / curvelabel="Virus";
			endlayout;
		endgraph;
	end;
run;
ods graphics / width=320px;
proc sgrender data=growth template=shortaxislabel;
run;
ods graphics / reset=width;





proc template;
	define statgraph shortaxislabel;
		begingraph;
		entrytitle "Short Label Substitution";
			layout overlay / cycleattrs=true
					yaxisopts=(label="Growth of Virus and Bacteria Cultures"
					labelfitpolicy=split);
				seriesplot x=Hours y=Bacteria/ curvelabel="Bacteria";
				seriesplot x=Hours y=Virus / curvelabel="Virus";
			endlayout;
		endgraph;
	end;
run;
ods graphics / width=320px;
proc sgrender data=growth template=shortaxislabel;
run;
ods graphics / reset=width;

/*POSITIONING THE AXIS LABELS*/

proc template;
	define statgraph axislabeldefault2;
		begingraph;
		entrytitle "Y-Axis Label TOP, X-Axis Label RIGHT";
			layout overlay / cycleattrs=true
						xaxisopts=(labelposition=right)
						yaxisopts=(labelposition=top);
				seriesplot x=Hours y=Bacteria/ curvelabel="Bacteria";
				seriesplot x=Hours y=Virus / curvelabel="Virus" primary=true;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=growth template=axislabeldefault2;
run;



/*AXIS THRESHOLDS*/

proc template;
	define statgraph axisThreshold1;
		begingraph;
		entrytitle "Assuring Equivalent Ticks on Independent Axes";
			layout overlay /
						yaxisopts=(griddisplay=on linearopts=(integer=true
						thresholdmin=0 thresholdmax=0))
						y2axisopts=(linearopts=(integer=true
						thresholdmin=0 thresholdmax=0));
				scatterplot x=City y=Fahrenheit;
				scatterplot x=City y=Celsius / yaxis=y2;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=temps template=axisThreshold1;
run;


proc template;
	define statgraph axisThreshold1;
		begingraph;
		entrytitle "Assuring Equivalent Ticks on Independent Axes";
			layout overlay /
						yaxisopts= (griddisplay=on
						linearopts=(integer=true thresholdmin=0 thresholdmax=0
						viewmin=32 viewmax=86))
						y2axisopts= (linearopts=(integer=true thresholdmin=0 thresholdmax=0
						viewmin=0 viewmax=30));
				scatterplot x=City y=Fahrenheit;
				scatterplot x=City y=Celsius / yaxis=y2;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=temps template=axisThreshold1;
run;



proc template;
	define statgraph overlayaxes.axisthreshold3;
		begingraph;
		entrytitle "Assuring Equivalent Ticks on Independent Axes";
			layout overlay /
						yaxisopts=(linearopts=(thresholdmin=0 thresholdmax=0))
						y2axisopts=(linearopts=(thresholdmin=0 thresholdmax=0));
				histogram mrw / scale=percent;
				histogram mrw / yaxis=y2 scale=count;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.heart template=overlayaxes.axisthreshold3;
run;

/*AXIS OFFSETS*/

proc template;
	define statgraph overlayaxes.axisoffsets1;
		begingraph;
		entrytitle "Default Axis Offsets";
			layout overlay;
				contourplotparm x=height y=weight z=density;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.gridded template=overlayaxes.axisoffsets1;
run;



proc template;
	define statgraph overlayaxes.axisoffsets1;
		begingraph;
		entrytitle "Default Axis Offsets";
			layout overlay /
						xaxisopts=(offsetmin=0 offsetmax=0
						linearopts=(thresholdmin=0 thresholdmax=0))
						yaxisopts=(offsetmin=0 offsetmax=0
						linearopts=(thresholdmin=0 thresholdmax=0));
				contourplotparm x=height y=weight z=density;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.gridded template=overlayaxes.axisoffsets1;
run;

/*LINEAR AXES*/

/*Setting the Data Range and Tick Values on a Linear Axis*/
proc template;
	define statgraph heightchart;
		begingraph;
		entrytitle "Specifying Tick Values for Linear Axes";
			layout overlay /
							xaxisopts=(type=linear griddisplay=on
							gridattrs=(pattern=dot color=lightgray)
							linearopts=(minorticks=true))
							yaxisopts=(type=linear tickvaluehalign=left
							griddisplay=on gridattrs=(pattern=dot color=lightgray)
							linearopts=(viewmin=48 viewmax=78
							tickvaluelist=(48 54 60 66 72 78)
							minorticks=true));
				scatterplot x=weight y=height;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.class template=heightchart;
run;



proc template;
	define statgraph heightchart;
		begingraph;
			entrytitle "Specifying Tick Display Values for Linear Axes";
			layout overlay /
							xaxisopts=(type=linear griddisplay=on
							gridattrs=(pattern=dot color=lightgray)
							linearopts=(minorticks=true))
							yaxisopts=(type=linear tickvaluehalign=left
							griddisplay=on gridattrs=(pattern=dot color=lightgray)
							linearopts=(tickvaluepriority=true minorticks=true
							tickvaluelist=(48 54 60 66 72 78)
							tickdisplaylist=("4 ft" "4.5 ft" "5 ft" "5.5 ft"
											 "6 ft" "6.5 ft")));
				scatterplot x=weight y=height;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.class template=heightchart;
run;

/*Formatting the Tick Values on a Linear Axis*/

proc template;
	define statgraph barchart;
		begingraph;
		entrytitle "Monthly Stock Performance in 2001";
			layout overlay /
							xaxisopts=(griddisplay=on gridattrs=(pattern=dot)
							timeopts=(tickvalueformat=monname3. viewmax='01DEC2001'd))
							yaxisopts=(griddisplay=on gridattrs=(pattern=dot)
							label="Closing Value (U.S. Dollars)"
							linearopts=(tickvalueformat=5.0));
				seriesplot x=date y=close / name="scatter"
							display=all group=stock groupdisplay=cluster;
				discretelegend "scatter";
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.stocks template=barchart;
	where year(date) = 2001;
run;

/*Scaling the Tick Values on a Linear Axis*/

data growth15hr;
	do Hours=1 to 15 by .1;
		growth = 10**hours;
		bacteria = 1000*10**( sqrt(hours ));
		virus = 1000*10**(log(hours));
		label bacteria = "Bacteria Growth" 
			  virus = "Virus Growth";
		output;
	end;
run;

proc template;
	define statgraph axisdefaultscale;
		begingraph;
		entrytitle "Tick Value Default Scaling";
			layout overlay / cycleattrs=true
							 yaxisopts=(label="Growth of Virus and Bacteria Cultures"
							 shortlabel="Growth"
							 linearopts=(tickvalueformat=(extractscale=true)));
				seriesplot x=Hours y=Bacteria/ curvelabel="Bacteria";
				seriesplot x=Hours y=Virus / curvelabel="Virus";
			endlayout;
		endgraph;
	end;
run;

ods graphics / width=320px;
proc sgrender data=growth15hr template=axisdefaultscale;
run;
ods graphics / reset=width;

/*Creating a Broken Linear Axis*/
proc template;
	define statgraph scatterplot;
		begingraph;
		entrytitle "Plot of Weight and Height";
		entryfootnote "Data from Height 60 to 65 is not shown.";
			layout overlay / xaxisopts=(
							 linearopts=(includeranges=(50-60 65-72)));
				scatterplot x=height y=weight / name="scatter" group=sex;
				discretelegend "scatter";
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.class template=scatterplot;
run;


/*DISCRETE AXES*/

/*Setting the Tick Values on a Discrete Axis*/

/* Create a test data set of annual failure data */
data failrate;
	do month=1 to 12 by 1;
		failures=2*ranuni(12345);
		label failures = "Failure Rate (Percentage)"
			  month = "Month";
		output;
	end;
run;
/* Create a template to display the first six months of data */
proc template;
	define statgraph firsthalf;
		begingraph;
		entrytitle "Unit Failure Rate in First Half";
			layout overlay /
							xaxisopts=(
							discreteopts=(tickvaluelist=("1" "2" "3" "4" "5" "6")));
				barchart category=month response=failures;
			endlayout;
		endgraph;
	end;
run;
/* Plot the data */
proc sgrender data=failrate template=firsthalf;
run;

/*Formatting the Tick Values on a Discrete Axis*/

/* Create the survey data set */
data ZOR327A_survey;
input category $1-17 result;
datalines;
Age 20 to 29: 0
Yes1 0.41
No1 0.59
Age 30 to 39: 0
Yes2 0.53
No2 0.47
Age 40 to 49: 0
Yes3 0.59
No3 0.41
Age 50 and Over: 0
Yes4 0.63
No4 0.37
;
run;
/* Create a format for the category tick values */
proc format;
value $catTickValues
		"Yes1", "Yes2", "Yes3", "Yes4" = "Y"
		"No1", "No2", "No3", "No4" = "N"
		"Age 20 to 29:" = "20 (*ESC*){unicode '2264'x} 29:"
		"Age 30 to 39:" = "30 (*ESC*){unicode '2264'x} 39:"
		"Age 40 to 49:" = "40 (*ESC*){unicode '2264'x} 49:"
		"Age 50 and Over:" = "(*ESC*){unicode '2265'x} 50:";
run;
/* Define the template for the graph */
proc template;
	define statgraph barchart;
		begingraph;
		entrytitle "Ordinance ZOR327A Support By Age Group";
			layout overlay /
							xaxisopts=(label="Percentage of Group Respondents"
							griddisplay=on linearopts=(minorgrid=true minortickcount=3))
							yaxisopts=(display=(label tickvalues) reverse=true
							label="Age Group Response"
							discreteopts=(tickvalueformat=$catTickValues. /*supports from SAS 9.4M3*/));
				barchartparm category=category response=result /
								orient=horizontal;
			endlayout;
		endgraph;
	end;
run;
/* Render the graph */
proc sgrender data=ZOR327A_survey template=barchart;
format result percent.;
run;

/*Extracting Discrete Axis Tick Values into a Legend*/

proc template;
	define statgraph discretefitpolicyextract;
		begingraph / border=false designwidth=450px designheight=400px;
		entrytitle "Average MPG City by Make: Trucks";
			Layout overlay /
							yaxisopts=(label="Average MPG")
							xaxisopts=(label="Make"
							name="axisvalues"
							tickvalueattrs=(size=9pt)
							discreteopts=(tickvaluefitpolicy=extract));
				barchart category=make response=mpg_city/orient=vertical
							stat=mean;
				axislegend "axisvalues" / pad=(top=5 bottom=5) title="Makes";
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.cars template=discretefitpolicyextract;
where type="Truck";

/*Setting Alternating Wall Color Bands for Discrete Intervals*/

proc template;
	define statgraph colorbands;
		begingraph;
		entrytitle "MPG City - European Makes";
			layout overlay /
							xaxisopts=(griddisplay=on)
							yaxisopts=(type=discrete offsetmin=0.07 offsetmax=0.07
							discreteopts=(colorbands=EVEN
							colorbandsattrs=(transparency=0.6 color=lightgray)));
				scatterplot y=make x=mpg_city / name="sp"
							group=type groupdisplay=cluster;
				discretelegend "sp" / title="Vehicle Type";
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.cars template=colorbands;
where origin="Europe";
run;

/*Offsetting Graph Elements from the Category Midpoint*/

/* Extract the sales data for each country from SASHELP.PRDSALE. */
data sales;
	set sashelp.prdsale(keep=country actual product);
	if (country eq "CANADA") then canada=actual;
	else if (country eq "GERMANY") then germany=actual;
	else if (country eq "U.S.A.") then usa=actual;
run;
/* Create the graph template. */
proc template;
	define statgraph offset;
		begingraph;
		entrytitle "Product Sales by Country";
			layout overlay / cycleattrs=true
							 xaxisopts=(display=(tickvalues)) yaxisopts=(label="Sales");
				barchart category=product response=canada / stat=sum name="canada"
							legendlabel="Canada" dataskin=sheen datatransparency=0.1
							barwidth=0.25 discreteoffset=-0.25;
				barchart category=product response=germany / stat=sum name="germany"
							legendlabel="Germany" dataskin=sheen datatransparency=0.1
							barwidth=0.25;
				barchart category=product response=usa / stat=sum name="usa"
							legendlabel="U.S.A." dataskin=sheen datatransparency=0.1
				barwidth=0.25 discreteoffset=0.25;
							discretelegend "canada" "germany" "usa" / title="Country:"
							location=outside;
			endlayout;
		endgraph;
	end;
run;
/* Generate the graph. */
proc sgrender data=sales template=offset;
run;


/*TIME AXES*/

proc template;
	define statgraph timeaxis1;
		begingraph;
		entrytitle "Default Time Axis";
			layout overlay;
				seriesplot x=date y=close;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.stocks template=timeaxis1;
	where stock="IBM" and
			date between "1jan2004"d and "31dec2005"d;
run;


/*Setting the Tick Values on a Time Axis*/

proc template;
	define statgraph timeaxis1;
		begingraph;
		entrytitle "Default Time Axis";
			layout overlay / xaxisopts=(timeopts=(interval=quarter));
				seriesplot x=date y=close;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.stocks template=timeaxis1;
	where stock="IBM" and
			date between "1jan2004"d and "31dec2005"d;
run;



proc template;
	define statgraph timeaxis1;
		begingraph;
		entrytitle "Default Time Axis";
			layout overlay / xaxisopts=(timeopts=(interval=quarter
					splittickvalue=false));
				seriesplot x=date y=close;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.stocks template=timeaxis1;
	where stock="IBM" and
			date between "1jan2004"d and "31dec2005"d;
run;


/*Formatting the Tick Values on a Time Axis*/


proc template;
	define statgraph timeaxis1;
		begingraph;
		entrytitle "Default Time Axis";
			layout overlay / xaxisopts=(timeopts=(interval=semiyear
							tickvalueformat=monyy.));
				seriesplot x=date y=close;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.stocks template=timeaxis1;
	where stock="IBM" and
			date between "1jan2004"d and "31dec2005"d;
run;


/*Fitting the Tick Values on a Time Axis*/

proc template;
	define statgraph timeaxis1;
		begingraph;
		entrytitle "Default Time Axis";
			layout overlay / xaxisopts=(timeopts=(interval=month
					splittickvalue=false tickvaluefitpolicy=rotate));
				seriesplot x=date y=close;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sashelp.stocks template=timeaxis1;
	where stock="IBM" and
			date between "1jan2004"d and "31dec2005"d;
run;

/*Setting the Data Range on a Time Axis*/

proc template;
	define statgraph timeaxis1;
		begingraph;
		entrytitle "TICKVALUELIST=(values), VIEWMIN=value, VIEWMAX=value";
			layout overlay / xaxisopts=(timeopts=(tickvalueformat=data
							viewmin="31Dec2002"d viewmax="31Dec2004"d
							tickvaluelist=("31Dec2002"d "30Jun2003"d
							"31Dec2003"d "30Jun2004"d "31Dec2004"d)));
				seriesplot x=date y=close;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.stocks template=timeaxis1;
where stock="IBM" and date between "1dec2002"d and "31dec2005"d;
run;


/*Creating a Broken Time Axis*/

proc template;
	define statgraph stockplot;
		begingraph;
		entrytitle "Stock Trends";
		entryfootnote "Data from 1990 to 1995 is not shown.";
			layout overlay /
							xaxisopts=(timeopts=(includeranges=(
							'01jan1986'd-'31dec1989'd '01jan1996'd-'31dec2005'd)
							tickvalueformat=year4.));
				seriesplot x=date y=close / name="series" group=stock;
				discretelegend "series";
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.stocks template=stockplot;
run;


/*LOG AXES*/

proc template;
	define statgraph overlayaxes.logaxis1;
		begingraph;
		entrytitle "Linear Y-Axis";
			layout overlay;
				seriesplot x=Hours y=growth;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=growth template=overlayaxes.logaxis1;
run;



proc template;
	define statgraph overlayaxes.logaxis1;
		begingraph;
		entrytitle "Linear Y-Axis";
			layout overlay/yaxisopts=(type=log);
				seriesplot x=Hours y=growth;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=growth template=overlayaxes.logaxis1;
run;


proc template;
	define statgraph overlayaxes.logaxis1;
		begingraph;
		entrytitle "Linear Y-Axis";
			layout overlay/yaxisopts=(type=log logopts=(base=2));
				seriesplot x=Hours y=growth;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=growth template=overlayaxes.logaxis1;
run;


proc template;
	define statgraph overlayaxes.logaxis1;
		begingraph;
		entrytitle "Linear Y-Axis";
			layout overlay/yaxisopts=(type=log logopts=(base=e));
				seriesplot x=Hours y=growth;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=growth template=overlayaxes.logaxis1;
run;


/*Setting the Tick Intervals on a Log Axis*/

proc template;
	define statgraph overlayaxes.logaxis1;
		begingraph;
		entrytitle "Linear Y-Axis";
			layout overlay / yaxisopts=(type=log label="Growth (Powers of 10)"
							logopts=(base=10 tickintervalstyle=logexponent));
				seriesplot x=Hours y=growth;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=growth template=overlayaxes.logaxis1;
run;


proc template;
	define statgraph overlayaxes.logaxis1;
		begingraph;
		entrytitle "Linear Y-Axis";
			layout overlay / yaxisopts=(type=log griddisplay=on
							logopts=(base=10 tickintervalstyle=linear));
				seriesplot x=Hours y=growth;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=growth template=overlayaxes.logaxis1;
run;


proc template;
	define statgraph overlayaxes.logaxis1;
		begingraph;
		entrytitle "Linear Y-Axis";
			layout overlay / yaxisopts=(type=log griddisplay=on
							logopts=(base=10 tickintervalstyle=logexpand
							minorticks=true minorgrid=true));
				seriesplot x=Hours y=growth;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=growth template=overlayaxes.logaxis1;
run;


proc template;
	define statgraph overlayaxes.logaxis1;
		begingraph;
		entrytitle "Linear Y-Axis";
			layout overlay;
				seriesplot x=Hours y=eval(log10(growth));
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=growth template=overlayaxes.logaxis1;
run;


/*Setting the Tick Values on a Log Axis*/


proc template;
	define statgraph overlayaxes.logaxis1;
		begingraph;
		entrytitle "Linear Y-Axis";
			layout overlay /
							yaxisopts=(griddisplay=on type=log
							logopts=(base=10 tickvaluepriority=true
							tickintervalstyle=logexpand
							tickvaluelist=(1 10 100 1000 10000 100000)
							minorticks=true));
				seriesplot x=Hours y=growth;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=growth template=overlayaxes.logaxis1;
run;


proc template;
	define statgraph overlayaxes.logaxis1;
		begingraph;
		entrytitle "Linear Y-Axis";
			layout overlay /
							yaxisopts=(griddisplay=on type=log
							logopts=(base=10 tickvaluepriority=true
							tickintervalstyle=logexpand
							valuestype=exponent
							tickvaluelist=(0 1 2 3 4 5)
							minorticks=true));
				seriesplot x=Hours y=growth;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=growth template=overlayaxes.logaxis1;
run;


/*Formatting the Tick Values on a Log Axis*/

proc template;
	define statgraph overlayaxes.logaxis1;
		begingraph;
		entrytitle "Linear Y-Axis";
			layout overlay /
							yaxisopts=(griddisplay=on type=log
							logopts=(base=10 tickintervalstyle=logexpand
							tickvalueformat=comma7. /*Supports from SAS 9.4M3 */
							minorticks=true));
				seriesplot x=Hours y=growth;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=growth template=overlayaxes.logaxis1;
run;



/*AVOIDING PLOT DATA CONFLICTS*/

/*Graph not generated*/
proc template;
	define statgraph test;
		begingraph;
			layout overlay;
				histogram sex;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=test;
run;


/*Graph generated*/
proc template;
	define statgraph test;
		begingraph;
			layout overlay;
				barchart category=age / group=gender;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=test;
run;

/*VERTICAL AND HORIZONTAL BAR-LINE CHARTS*/

/*BAR-LINE CHARTS*/

proc template;
	define statgraph barline;
		begingraph;
		entrytitle "Overlay of REFERENCELINE, BARCHARTPARM and SERIESPLOT";
			layout overlay;
				referenceline y=25000000 / curvelabel="Target";
				barchartparm category=year response=retail / dataskin=matte
								fillattrs=(transparency=0.5)
								fillpatternattrs=(pattern=R1 color=lightgray);
				seriesplot x=year y=profit / name="series";
				discretelegend "series";
			endlayout;
		endgraph;
	end;
run;
/* compute sums for each product line */
proc summary data=sashelp.orsales nway;
	class year;
	var total_retail_price profit;
	output out=orsales sum=Retail Profit;
run;
/* generate the graph */
proc sgrender data=orsales template=barline;
	format retail profit comma12.;
run;


/*HORIZONTAL BAR CHARTS*/

proc template;
	define statgraph barline2;
		begingraph;
		entrytitle "Overlay of REFERENCELINE, BARCHARTPARM and SERIESPLOT";
			layout overlay;
				referenceline x=25000000 / curvelabel="Target";
				barchartparm category=year response=retail / orient=horizontal
								dataskin=matte fillattrs=(transparency=0.5)
								fillpatternattrs=(pattern=R1 color=lightgray);
				seriesplot x=profit y=year / name="series"
				legendlabel="Profit in USD";
				discretelegend "series";
			endlayout;
		endgraph;
	end;
run;
/* compute sums for each product line */
proc summary data=sashelp.orsales nway;
	class year;
	var total_retail_price profit;
	output out=orsales sum=Retail Profit;
run;
/* generate the graph */
proc sgrender data=orsales template=barline2;
	format retail profit comma12.;
run;


/*Plot with Multiple Axes*/

data temps;
input City $1-11 Celsius;
datalines;
New York    11
Sydney      12
Mexico City 18
Paris       8
Tokyo       6
;
run;
proc template;
	define statgraph Y2axis;
		begingraph;
		entrytitle "Overlay of NEEDLEPLOT and SCATTERPLOT";
		entrytitle "SCATTERPLOT uses Y2 axis";
			layout overlay /
							xaxisopts=(display=(tickvalues))
							yaxisopts=(griddisplay=on offsetmin=0
							linearopts=(viewmin=0 viewmax=20
							thresholdmin=0 thresholdmax=0))
							y2axisopts=(label="Fahrenheit" offsetmin=0
							linearopts=(viewmin=32 viewmax=68
							thresholdmin=0 thresholdmax=0));
				needleplot x=City y=Celsius;
				scatterplot x=City y=eval(32+(9*Celsius/5)) / yaxis=y2
								markerattrs=(symbol=circlefilled);
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=temps template=y2axis;
run;

/*Plot with Fit Line*/

proc template;
	define statgraph modelfit;
		begingraph;
		entrytitle "Regression Fit Plot";
			layout overlay;
				scatterplot x=height y=weight / primary=true;
				regressionplot x=height y=weight;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=modelfit;
run;

/*Plot with Fit Line with Confidence Bands*/

proc template;
	define statgraph modelfit;
		begingraph;
		entrytitle "Regression Fit Plot";
			layout overlay;
				modelband "myclm";
				scatterplot x=height y=weight /
				primary=true;
				regressionplot x=height y=weight /
								alpha=.01 clm="myclm";
			endlayout;;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=modelfit;
run;


proc reg data=sashelp.class noprint;
model weight=height / alpha=.01;
output out=predict predicted=p lclm=lclm uclm=uclm;
run;
quit;


proc template;
	define statgraph fit;
		begingraph;
		entrytitle "Regression Fit Plot";
			layout overlay;
				bandplot x=height
						limitupper=uclm
						limitlower=lclm /
						connectorder=axis
						fillattrs=GraphConfidence;
				scatterplot x=height y=weight /
							primary=true;
				seriesplot x=height y=p /
							lineattrs=GraphFit;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=predict template=fit;
run;

/*Plot of Grouped Data*/

proc template;
	define statgraph seriesgroup;
		begingraph;
		entrytitle "Overlay of SERIESPLOTs with GROUP=";
			layout overlay;
				seriesplot x=date y=close / group=stock name="s";
				discretelegend "s";
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.stocks template=seriesgroup;
	where date between "1jan2002"d and "31dec2005"d;
run;


/*Using Overlays to Graph Multiple Response Variables*/

proc template;
	define statgraph series;
		begingraph;
		entrytitle "Overlay of Multiple SERIESPLOTs";
			layout overlay / yaxisopts=(label="IBM Stock Price");
				seriesplot x=date y=high / curvelabel="High";
				seriesplot x=date y=low / curvelabel="Low";
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.stocks template=series;
	where date between "1jan2002"d and "31dec2005"d
		and stock="IBM";
run;

/*Plot Appearance*/

proc template;
	define statgraph series;
		begingraph;
		entrytitle "Overlay of Multiple SERIESPLOTs";
			layout overlay / yaxisopts=(label="IBM Stock Price");
				seriesplot x=date y=high / curvelabel="High"
						lineattrs=GraphData1
						curvelabelattrs=GraphData1;
				seriesplot x=date y=low / curvelabel="Low"
					lineattrs=GraphData2
					curvelabelattrs=GraphData2;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.stocks template=series;
	where date between "1jan2002"d and "31dec2005"d
		and stock="IBM";
run;



proc template;
	define statgraph series;
		begingraph;
		entrytitle "Overlay of Multiple SERIESPLOTs";
			layout overlay / yaxisopts=(label="IBM Stock Price") cycleattrs=true;
				seriesplot x=date y=high / curvelabel="High";
				seriesplot x=date y=low / curvelabel="Low";
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.stocks template=series;
	where date between "1jan2002"d and "31dec2005"d
		and stock="IBM";
run;
