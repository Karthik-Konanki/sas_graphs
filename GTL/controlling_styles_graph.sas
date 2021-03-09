/* Open an HTML destination using the modified style */
ods html style=SerifStatistical;
/* Print the first 5 observations in SASHELP.CLASS */
proc print data=sashelp.class(obs=5);
run;
/* Create a histogram from variable Age */
proc template;
	define statgraph histogram;
		begingraph;
		entrytitle "Histogram of Age";
		entryfootnote "SASHELP.CLASS";
			layout overlay /
						xaxisopts=(label="Age");
						histogram age / name="Histogram"
						scale=density binwidth=1 datalabeltype=count;
				densityplot age / name="Density" normal()
					curvelabel="Normal";
				discretelegend "Histogram" "Density";
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.class template=histogram;
run;


ods path show;

libname common "u:\ODS_templates";
ods path common.dept(update)
sasuser.templat(update)
sashelp.tmplmst(read);


/*Controlling the Appearance of Non-grouped Data*/

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


proc template;
	define statgraph series;
		begingraph;
		entrytitle "Overlay of Multiple SERIESPLOTs";
			layout overlay / yaxisopts=(label="IBM Stock Price");
				seriesplot x=date y=high / curvelabel="High" lineattrs=GraphData1;
				seriesplot x=date y=low / curvelabel="Low" lineattrs=GraphData2;
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
			layout overlay / yaxisopts=(label="IBM Stock Price");
				seriesplot x=date y=high / curvelabel="High"
								lineattrs=GraphData1(pattern=shortdash);
				seriesplot x=date y=low / curvelabel="Low"
								lineattrs=GraphData2(pattern=shortdash);
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.stocks template=series;
	where date between "1jan2002"d and "31dec2005"d
	and stock="IBM";
run;


/*Controlling the Appearance of Grouped Data*/

/*Plots That Support Grouped Data*/
/*
AXISTABLE		HEATMAPPARM			PIECHART
BANDPLOT 		HIGHLOWPLOT 		POLYGONPLOT
BARCHART 		LINECHART 			REGRESSIONPLOT
BARCHARTPARM 	LINEPARM 			SCATTERPLOT
BOXPLOT 		LOESSPLOT 			SCATTERPLOTMATRIX
BOXPLOTPARM 	MODELBAND 			SERIESPLOT
BUBBLEPLOT 		MOSAICPLOTPARM 		STEPPLOT
ELLIPSEPARM 	NEEDLEPLOT 			VECTORPLOT
FRINGEPLOT 		PBSPLINEPLOT 		WATERFALLCHART
Starting with SAS 9.4M2, the DENSITYPLOT, ELLIPSE, and HISTOGRAM
*/

/*Using the Default Appearance for Grouped Data*/

proc template;
	define statgraph groupedseries;
		begingraph;
		entrytitle "Tech Stocks 2002-2004";
		entryfootnote halign=left "Source: SASHELP.STOCKS";
			layout overlay;
				seriesplot x=date y=close / group=stock name="series"
										lineattrs=(thickness=2);
				discretelegend "series";
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.stocks template=groupedseries;
	where date between "1jan02"d and "31dec04"d;
run;

/*Using Custom Styles to Control the Appearance of Grouped Data*/

proc template;
	define style Styles.stocks;
		parent=styles.listing;
		style GraphData1 from GraphData1 /
				ContrastColor=blue
				Color=blue
				MarkerSymbol="CircleFilled"
				Linestyle=1;
		style GraphData2 from GraphData2 /
				ContrastColor=brown
				Color=brown
				MarkerSymbol="TriangleFilled"
				Linestyle=1;
		style GraphData3 from GraphData3 /
				ContrastColor=orange
				Color=orange
				MarkerSymbol="SquareFilled"
				Linestyle=1;
	end;
run;

/* Specify a path for the ODS output */
filename odsout "D:\SAS\SAS Graphs\SAS";
	ods _all_ close;
	ods graphics / reset imagename="stocks";
	ods html file="stocks.html" path=odsout style=stocks;
proc sgrender data=sashelp.stocks
	template=groupedseries;
	where date between "1jan02"d and "31dec04"d;
run;
ods html close;
ods html; /* Not required in SAS Studio */



/*Overriding the Fill Colors*/

proc template;
	define statgraph groupedbar;
		dynamic year;
		begingraph / datacolors=(verylightred verylightgreen lightblue);
		entrytitle "Stock Index Performance - " year;
			layout overlay / xaxisopts=(label="Month");
				barchart category=date response=close / group=stock name="barchart";
				discretelegend "barchart";
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.stocks template=groupedbar;
	where date between "1jan02"d and "31dec02"d;
	format date MONNAME3.;
	dynamic year="2002";
run;

/*Overriding the Line Patterns and Line Colors*/

proc template;
	define statgraph groupedseries2;
		dynamic year;
		begingraph / attrpriority=none
					datacontrastcolors=(lightred orange mediumblue)
					datalinepatterns=(2 9 41);
		entrytitle "Stock Performance - " year;
			layout overlay / xaxisopts=(type=discrete label="Month");
				seriesplot x=date y=close / group=stock name="series";
				discretelegend "series";
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.stocks template=groupedseries2;
	where date between "1jan02"d and "31dec02"d;
	format date MONNAME3.;
	dynamic year="2002";
run;

