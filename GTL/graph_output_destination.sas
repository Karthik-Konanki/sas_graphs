/*GRAPH OUTPUT DESTINATION*/

/*Using a Universal Printer with ODS PRINTER to Control the Image Format*/

/* Specify the path and name for the image output file */
filename imgout "D:\SAS\SAS Graphs\SAS\barchart.svg";
/* Create the graph template */
proc template;
	define statgraph barchart;
		begingraph;
		dynamic printer dev imagedpi;
		entrytitle "Average Mileage by Vehicle Type";
			layout overlay;
				barchart category=type response=mpg_highway /
										stat=mean orient=horizontal;
			endlayout;
		endgraph;
	end;
run;
/* Close the currently open ODS destinations */
ods _all_ close;
/* Open the ODS PRINTER destination */
ods printer printer=svg file=imgout;
/* Generate the graph */
proc sgrender data=sashelp.cars template=barchart;
run;
/* Close the ODS PRINTER destination */
ods printer close;
/* Open an ODS destination for subsequent programs. (Not
required in SAS Studio.) */
ods html;

/*Controlling the Location of the Image Output*/

ods graphics / reset imagename="graph";
/*ods _all_ close;*/
ods html style=statistical
path="D:\SAS\SAS Graphs\SAS\public_html"
gpath="D:\SAS\SAS Graphs\SAS\public_html" (url=none)
file="report.html";
/* Create the graph template */
proc template;
	define statgraph barchart;
		begingraph;
		dynamic mpgtype;
		entrytitle "Average " mpgtype " MPG by Vehicle Type";
			layout overlay;
			/* Generate graph based on MPG type */
				if (upcase(mpgtype) = "CITY")
					barchart category=type response=mpg_city /
											stat=mean orient=horizontal;
				else
					barchart category=type response=mpg_highway /
											stat=mean orient=horizontal;
				endif;
			endlayout;
		endgraph;
	end;
run;
/* Generate city MPG chart */
proc sgrender data=sashelp.cars template=barchart
	des="Average City MPG by Type";
	dynamic mpgtype="City";
run;
/* Generate highway MPG chart */
proc sgrender data=sashelp.cars template=barchart
	des="Average Highway MPG by Type";
	dynamic mpgtype="Highway";
run;
/*ods html close;*/
ods html; /* Not required in SAS Studio */


/*Scaling Graphs*/

proc template;
	define statgraph boxplot;
		dynamic title;
		begingraph / designwidth=640 designheight=480;
		entrytitle title;
			layout overlay;
				boxplot y=mrw x=bp_status / datalabel=deathcause labelfar=true;
			endlayout;
		endgraph;
	end;
run;
ods graphics / reset width=440px height=330px scale=on;
proc sgrender data=sashelp.heart template=boxplot;
	where status="Dead";
	dynamic title="SCALE=ON";
run;



/*Initializing Template Dynamic Variables and Macro Variables*/

proc template;
	define statgraph mygraphs.regfit;
		dynamic XVAR YVAR;
		mvar STUDY SYSDATE;
		begingraph;
		entrytitle "Regression fit for Model " YVAR " = " XVAR;
		entryfootnote halign=left STUDY halign=right SYSDATE;
			layout overlay;
				scatterplot X=XVAR Y=YVAR;
				regressionplot X=XVAR Y=YVAR;
			endlayout;
		endgraph;
	end;
run;

%let study = CLASS dataset;
proc sgrender data=sashelp.class template=mygraphs.regfit;
	dynamic xvar="height" yvar="weight";
run;

data _null_;
	if _n_=1 then call symput("study","CLASS data set");
	set sashelp.class;
	file print ods=( template="mygraphs.regfit"
	dynamic=( xvar="height" yvar="weight" ) );
	put _ods_;
run;

/*Managing the Output Data Object*/
/*Setting a Name and Label for the Output Data Object*/
/* Create the graph template */
proc template;
	define statgraph mygraphs.scatter;
		begingraph;
		entrytitle "Height and Weight by Sex";
			layout overlay;
				scatterplot x=height y=weight /
									group=sex name="scatter" datalabel=name;
				discretelegend "scatter";
			endlayout;
		endgraph;
	end;
run;
/* Set object name and label on PROC SGRENDER */
proc sgrender data=sashelp.class template=mygraphs.scatter
	object=Scatter1
	objectlabel="Scatter Plot 1";
run;



/* set object name and label on a DATA step */
data _null_;
	set sashelp.class;
	file print ods=( template="mygraphs.scatter"
	object=Scatter2
	objectlabel="Scatter Plot 2" );
	put _ods_;
run;


PROC TEMPLATE;
	DEFINE STATGRAPH template-name;
		DYNAMIC variable-1 <"text-1"> <…variable-n<"text-n">>;
		MVAR variable-1 <"text-1"> <…variable-n<"text-n">>;
		NMVAR variable-1 <"text-1"> <…variable-n<"text-n">>;
		BEGINGRAPH;
			GTL statements;
		ENDGRAPH;
	END;
RUN;



/*Special Dynamic Variables*/

/* Add a YEAR column to the data set. */
data stocks;
	set sashelp.stocks;
	year=year(date);
	label year="YEAR";
run;
/* Sort the data by YEAR. */
proc sort data=stocks;
	by year;
run;
/* Create the template for the graph. */
proc template;
	define statgraph seriesgroup;
		begingraph;
		/* Define the special variables that will be used. */
		dynamic _BYVAL_ _BYLINE_ _BYTITLE_ _BYFOOTNOTE_;
		/* If BYTITLE is set, put the BY line in the graph title. */
			if (_BYTITLE_)
				entrytitle "Monthly Closing Price";
				entrytitle "(" _BYLINE_ ")";
			else
			/* If BYFOOTNOTE is set, put the BY line in a footnote. */
			if (_BYFOOTNOTE_)
				entrytitle "Monthly Closing Price";
				entryfootnote halign=right "(" _BYLINE_ ")";
			else
			/* Otherwise, include _BYVAL_ in the title. */
				entrytitle "Monthly Closing Price In " _BYVAL_;
			endif;
			endif;
			layout overlay / xaxisopts=(label="Month" type=discrete
										griddisplay=on gridattrs=(pattern=dot))
							 yaxisopts=(griddisplay=on gridattrs=(pattern=dot));
				seriesplot x=eval(month(date)) y=close /
										group=stock name="s";
				discretelegend "s";
			endlayout;
		endgraph;
	end;
run;
/* Disable the default BY line. */
options nobyline;
/* Put the BY line in the graph title */
ods graphics / byline=title;
/* Generate the graph. */
proc sgrender data=stocks template=seriesgroup;
	by year;
	where year between 2000 and 2005;
run;



/*Nested Conditional logics*/

proc template;
	define statgraph conditional;
		dynamic NUMVAR "required" SCALE CURVE;
		begingraph;
		entrytitle "Distribution of " eval(colname(NUMVAR));
			if ( colname(NUMVAR) ne collabel(NUMVAR) )
				entrytitle "(" eval(collabel(NUMVAR)) ")";
			endif;
			layout overlay / xaxisopts=(display=(ticks tickvalues line));
				histogram NUMVAR / scale=SCALE;
					if ( upcase(CURVE) in ("ALL" "NORMAL" ) )
						densityplot NUMVAR / normal() name="N"
						lineattrs=GraphData1 legendlabel="Normal Distribution";
					endif;
					if ( upcase(CURVE) in ("ALL" "KDE" "KERNEL") )
						densityplot NUMVAR / kernel() name="K"
						lineattrs=GraphData2 legendlabel="Kernel Density Estimate";
					endif;
				discretelegend "N" "K";
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.heart template=conditional;
	dynamic numvar="mrw";
run;

proc sgrender data=sashelp.heart template=conditional;
dynamic numvar="cholesterol" curve="kde";
run;

proc sgrender data=sashelp.heart template=conditional;
	dynamic numvar="cholesterol" scale="count" curve="all";
run;



/*Examples of Using the IFC and IFN SAS Functions*/

data sales;
input empID totalSales salesUnit $18;
format totalSales dollar9.;
datalines;
112876 129489.44 P
112421 169842.97 S
115331 108763.51 S
110765 181009.22 P
113722 147688.78 P
;


proc template;
	define statgraph commission;
		begingraph;
		entrytitle "Sales-Based Commission";
			layout overlay /
								xaxisopts=(label="Employee ID")
								yaxisopts=(label="Total Sales")
								y2axisopts=(label="Commission"
								linearopts=(viewmax=15000 tickvalueformat=dollar9.));
			/* Generate the sales bar chart. */
				barchart category=empID response=totalSales /
										name="Sales" legendlabel="Total Sales" barwidth=0.3
										discreteoffset=-0.2 fillattrs=graphData1;
				/* Generate the commission bar chart. */
				barchart category=empID
				/* Use IFN to compute the commission. */
										response=eval(ifn(totalSales >= 120000,
										totalSales * 0.05, /* 5% if TRUE */
										totalSales * 0.025)) / /* 2.5% if FALSE */
										name="Commission" legendlabel="Commission"
										barwidth=0.3 yaxis=y2 discreteoffset=0.2
										fillattrs=graphData2;
				/* Add an axis table that shows the sales unit for each
				employee. */
				innermargin / align=bottom;
					axistable x=empID
				/* Use IFC to convert the codes to meaningful
				values. */
									value=eval(ifc(salesUnit = 'P',"Products",
									"Services")) / display=(values);
				endinnermargin;
				discretelegend "Sales" "Commission";
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=sales template=commission;
run;



/*Using the TYPEOF SAS Function*/


/* Define the graph template. */
proc template;
	define statgraph plot;
		dynamic cat resp; /* Category and response columns. */
		begingraph;
		entrytitle "Graph of " eval(collabel(resp)) " and "
		eval(collabel(cat));
			layout overlay;
				/* If cat and resp are numeric, then generate a scatter plot.
				Otherwise, generate a bar chart. */
				if (typeof(cat) = "N" and typeof(resp) = "N")
				scatterplot x=cat y=resp;
				else
				/* If cat is a character column, then generate a vertical bar
				chart. Otherwise, generate a horizontal bar chart. */
				if (typeof(cat) = "C")
					barchart category=cat response=resp / stat=mean;
				else
					barchart category=resp response=cat /
										stat=mean orient=horizontal;
				endif;
				endif;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.cars template=plot;
dynamic cat="MPG_CITY" resp="TYPE";
run;


/*GTL Summary Statistic Functions*/

proc template;
	define statgraph expression;
		dynamic NUMVAR "required";
		begingraph;
		entrytitle "Distribution of " eval(colname(NUMVAR));
			layout overlay / xaxisopts=(display=(ticks tickvalues line));
				histogram NUMVAR;
				/* create reference lines at computed positions */
				referenceline x=eval(mean(NUMVAR)+2*std(NUMVAR)) /
								lineattrs=(pattern=dash) curvelabel="+2 STD";
				referenceline x=eval(mean(NUMVAR)) /
								lineattrs=(thickness=2px) curvelabel="Mean";
				referenceline x=eval(mean(NUMVAR)-2*std(NUMVAR)) /
								lineattrs=(pattern=dash) curvelabel="-2 STD";
			/* create inset */
			layout gridded / columns=2 order=rowmajor
									autoalign=(topleft topright) border=true;
				entry halign=left "N";
				entry halign=left eval(strip(put(n(NUMVAR),12.0)));
				entry halign=left "Mean";
				entry halign=left eval(strip(put(mean(NUMVAR),12.2)));
				entry halign=left "Std Dev";
				entry halign=left eval(strip(put(stddev(NUMVAR),12.2)));
			endlayout;
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.heart template=expression;
dynamic numvar="MRW";
run;



ods trace on;
ods graphics on;
proc freq data=sashelp.cars order=freq;
tables Type / plots=freqplot(type=dotplot);
weight Weight;
title "Vehicle Weight";
run;
ods graphics off;
ods trace off;
