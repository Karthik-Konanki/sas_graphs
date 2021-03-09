/*MANAGING YOUR GRAPH’S APPEARANCE*/

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
/*ods _all_ close;*/
ods graphics / reset imagename="stocks";
ods html file="stocks.html" path=odsout style=stocks;
proc sgrender data=sashelp.stocks template=groupedseries;
	where date between "1jan02"d and "31dec04"d;
run;
/*ods html close;*/
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

/*Overriding the Marker Symbols and Marker Colors*/

proc template;
	define statgraph groupedscatter;
		dynamic year;
		begingraph / attrpriority=none
						datasymbols=(circlefilled squarefilled trianglefilled)
						datacontrastcolors=(lightred orange mediumblue);
		entrytitle "Stock Performance - " year;
			layout overlay / xaxisopts=(type=discrete label="Month");
				scatterplot x=date y=close / group=stock name="scatterplot";
				discretelegend "scatterplot";
			endlayout;
		endgraph;
	end;
run;
proc sgrender data=sashelp.stocks template=groupedscatter;
	where date between "1jan02"d and "31dec02"d;
	format date MONNAME3.;
	dynamic year="2002";
run;

/*Changing the Grouped Data Display*/

/* Create a variable for the desired year. */
%let year=2002;
/* Specify a path for the ODS output */
filename outp "D:\SAS\SAS Graphs\SAS";
/* Create a data set of the first six months of the year. */
data stocks;
	set sashelp.stocks;
	where year(date) eq &year and month(date) le 6;
	month=month(date);
run;
/* Format the numeric months into 3-character month names. */
proc format;
	value month3char
	1="Jan" 2="Feb" 3="Mar" 4="Apr" 5="May" 6="Jun";
run;
/* Create the template. */
proc template;
	define statgraph stocksgraph;
		begingraph;
		dynamic year;
		entrytitle "Stock Volume By Month for First Six Months of " year;
			layout overlay /
							yaxisopts=(griddisplay=on display=(line ticks tickvalues))
							xaxisopts=(display=(line ticks tickvalues));
				barchart category=month response=volume /
									name="total"
									dataskin=pressed
									group=stock
									groupdisplay=cluster;
				discretelegend "total";
			endlayout;
		endgraph;
	end;
run;
/* Generate the bar chart using the bar template. */
ods graphics on / reset outputfmt=static imagename="stocks_&year";;
/*ods _all_ close;*/
ods html file="stocks_&year..html" path=outp style=stocks;
proc sgrender data=stocks template=stocksgraph;
	dynamic year=&year;
	format month month3char.;
run;
/*ods html close;*/
ods html; /* Not required in SAS Studio */



proc template;
	define statgraph survey;
		begingraph;
		entrytitle "Customer Survey Results";
			layout overlay / xaxisopts=(label="Store Location")
						yaxisopts=(label="Satisfaction Rating");
				barchart category=location response=rating / name="barchart"
							stat=mean group=purchase_method groupdisplay=cluster
							barwidth=0.9 dataskin=sheen includemissinggroup=true;
				discretelegend "barchart" / title="Purchase Method";
			endlayout;
		endgraph;
	end;
run;

/* Create a format for the missing order-type values */
proc format;
	value $ordertypefmt " "="Not Specified";
run;

/* Generate the chart */
proc sgrender data=surveydata template=survey;
	format purchase_method $ordertypefmt.;
run;
ods graphics off;


/*Changing the Grouped Data Order*/

/* Specify a path for the ODS output */
filename odsout "D:\SAS\SAS Graphs\SAS";
/*ods _all_ close;*/
ods graphics / reset imagename="stocks";
ods html file="stocks.html" path=odsout style=stocks;
proc sgrender data= sashelp.stocks template=groupedseries;
	where date between "1jan02"d and "31dec04"d;
run;
/*ods html close;*/
ods html; /* Not required in SAS Studio */
/* Specify a path for the ODS output */
filename odsout "D:\SAS\SAS Graphs\SAS";
proc sort data=sashelp.stocks out=stocks;
	by descending stock;
run;
/*ods _all_ close;*/
ods graphics / reset imagename="stocks";
ods html filename="stocks.html" path=odsout style=stocks;
proc sgrender data= stocks template=groupedseries;
	where date between
	"1jan02"d and "31dec04"d;
run;
/*ods html close;*/
ods html; /* Not required in SAS Studio */



/*Making the Appearance of Grouped Data Independent of Data Order*/

data stockname;
	



/* Define the graph template. */
proc template;
	define statgraph groupindex;
		begingraph;
		/* Create an attribute map for this graph. */
		discreteattrmap name="stockname" / ignorecase=true;
			value "IBM" /
					markerattrs=GraphData1(color=blue symbol=circlefilled)
					lineattrs=GraphData1(color=blue pattern=solid);
			value "Intel" /
					markerattrs=GraphData2(color=orange symbol=squarefilled)
					lineattrs=GraphData2(color=orange pattern=solid);
			value "Microsoft" /
					markerattrs=GraphData3(color=darkred symbol=trianglefilled)
					lineattrs=GraphData3(color=darkred pattern=solid);
		enddiscreteattrmap;
		/* Create the attribute map variable. */
		discreteattrvar attrvar=stockmarkers var=stock
						attrmap="stockname";
		/* Define the graph. */
		entrytitle "Tech Stocks 2002-2004";
		entryfootnote halign=left "Source: SASHELP.STOCKS";
			layout overlay;
				seriesplot x=date y=close / group=stockmarkers
										name="series" lineattrs=(thickness=2) display=(markers);
				discretelegend "series";
			endlayout;
		endgraph;
	end;
run;
/* Render the graph. */
proc sgrender data= sashelp.stocks template=groupindex;
	where date between "1jan02"d and "31dec04"D;
run;

/*Using the INDEX= Option to Achieve Data-Independent Appearance for Grouped Plots*/

/* Specify a path for the ODS output */
filename odsout "D:\SAS\SAS Graphs\SAS";
/* Add the IDX column to the data set */
data stocks;
	set sashelp.stocks;
	if (stock="IBM") then idx=1;
	else if (stock="Microsoft") then idx=2;
	else if (stock="Intel") then idx=3;
run;
/* Create the template for the graph */
proc template;
	define statgraph groupindex;
		begingraph;
		/* Define the graph. */
		entrytitle "Tech Stocks 2002-2004";
		entryfootnote halign=left "Source: SASHELP.STOCKS";
			layout overlay;
				seriesplot x=date y=close / index=idx group=stock
											name="series" lineattrs=(thickness=2) display=(markers);
				discretelegend "series";
			endlayout;
		endgraph;
	end;
run;
/* Render the graph using the custom style. */

/*ods _all_ close;*/
ods graphics / reset imagename="stocks";
ods html file="stocks.html" path=odsout style=stocks;
proc sgrender data= stocks template=groupindex;
	where date between "1jan02"d and "31dec04"D;
run;
/*ods html close;*/
ods html; /* Not required in SAS Studio */




/*Defining Your Discrete Attribute Map in Your Template*/

/* Create a stock data set for the year 2002 */
proc sort data=sashelp.stocks out=stocks;
	by stock date;
	where date between '01JAN02'd and '30DEC02'd;
run;
/* Create a template for IBM, Microsoft, and Intel stocks */
proc template;
	define statgraph stockchart;
		begingraph;
		entrytitle "Trends for IBM, Intel, and Microsoft";
		discreteattrmap name="stockname" / ignorecase=true;
			value "IBM" /
						markerattrs=GraphData1(color=red symbol=circlefilled)
						lineattrs=GraphData1(color=red pattern=solid);
			value "Intel" /
						markerattrs=GraphData2(color=green symbol=trianglefilled)
						lineattrs=GraphData2(color=green pattern=shortdash);
			value "Microsoft" /
						markerattrs=GraphData3(color=blue symbol=squarefilled)
						lineattrs=GraphData3(color=blue pattern=dot);
		enddiscreteattrmap;
		discreteattrvar attrvar=stockmarkers var=stock
		attrmap="stockname";
			layout overlay;
				seriesplot x=date y=close /
									group=stockmarkers
									display=(markers)
									name="trends";
				discretelegend "trends" / title="Stock Trends";
			endlayout;
		endgraph;
	end;
run;
/* Plot the stock trends */
proc sgrender data=stocks template=stockchart;
run;
quit;


/*Defining Your Discrete Attribute Map in a SAS Data Set*/

/* Create the attribute map data set */
data attrmap;
length ID VALUE MARKERCOLOR MARKERSYMBOL LINECOLOR LINEPATTERN $15;
input ID$ VALUE$ MARKERCOLOR$ MARKERSYMBOL$ LINECOLOR$ LINEPATTERN$;
datalines;
stockname IBM red circlefilled red solid
stockname Intel green trianglefilled green shortdash
stockname Microsoft blue squarefilled blue dot
;
run;

/* Create a stock data set for the year 2002 */
proc sort data=sashelp.stocks out=stocks;
	by stock date;
	where date between '01JAN02'd and '30DEC02'd;
run;
/* Create a template for IBM, Microsoft, and Intel stocks */
proc template;
	define statgraph stockchart;
		begingraph;
		entrytitle "Trends for IBM, Intel, and Microsoft";
		discreteattrvar attrvar=stockmarkers var=stock
							attrmap="stockname";
			layout overlay;
				seriesplot x=date y=close /
										group=stockmarkers
										display=(markers)
										name="trends";
				discretelegend "trends" / title="Stock Trends";
			endlayout;
		endgraph;
	end;
run;
/* Plot the stock trends */
proc sgrender data=stocks dattrmap=attrmap template=stockchart;
	run;
quit;


/* Create a template for IBM, Microsoft, and Intel stocks */
proc template;
	define statgraph stockchart;
		begingraph;
		entrytitle "Trends for IBM, Intel, and Microsoft";
			layout overlay;
				seriesplot x=date y=close /
									group=stock
									display=(markers)
									name="trends";
				discretelegend "trends" / title="Stock Trends";
			endlayout;
		endgraph;
	end;
run;
/* Plot the stock trends */
proc sgrender data=stocks dattrmap=attrmap template=stockchart;
	dattrvar stock="stockname";
run;
quit;

proc sgrender data=stocks dattrmap=attrmap(where=(value in ("Microsoft", "Intel"))) 
	template=stockchart; 
	dattrvar stock="stockname";
run;
quit;


/*Using a Range Attribute Map*/

proc template;
	define statgraph attrrange;
		begingraph;
		/* Create the range attribute map. */
			rangeattrmap name="scale";
				range 0-70 /
							rangealtcolor=black; /* 0 to 70 inclusive */
				range 70<-107 /
							rangealtcolor=blue; /* 70 exclusive to 107 inclusive */
				range 107<-125 /
							rangealtcolor=green; /* 107 exclusive to 125 inclusive */
				range 125<-200 /
							rangealtcolor=red; /* 125 exclusive to 200 inclusive */
			endrangeattrmap;
			/* Create the range attribute map variable. */
			rangeattrvar attrvar=weightrange var=weight attrmap="scale";
		/* Create the graph. */
		entrytitle "Weight Class";
			layout overlay /
							xaxisopts=(griddisplay=on gridattrs=(color=lightgray pattern=dot))
							yaxisopts=(griddisplay=on gridattrs=(color=lightgray pattern=dot));
				scatterplot x=weight y=height / markercolorgradient=weightrange
							markerattrs=(symbol=circlefilled size=10) name='wgtclass';
				/* Add a continuous legend. */
				continuouslegend 'wgtclass';
			endlayout;
		endgraph;
	end;
run;
/* Render the graph. */
ods graphics / width=4in height=3in;
proc sgrender data=sashelp.class template=attrrange;
run;


/*Using Transparency*/

/* Define the template for the graph */
proc template;
	define statgraph fit;
		begingraph;
		entrytitle "Regression Fit Plot";
			layout overlay;
				modelband "cli" / display=(outline)
									outlineattrs=GraphPrediction
									datatransparency=.5;
				modelband "clm" / display=(fill)
									fillattrs=GraphConfidence
									datatransparency=.5;
				scatterplot x=height y=weight /
									primary=true;
				regressionplot x=height y=weight /
									alpha=.05 clm="clm" cli="cli";
			endlayout;
		endgraph;
	end;
run;
/* Render the graph */
proc sgrender data=predict template=fit;
run;



proc template;
	define statgraph barchart;
		begingraph / opaque=false;
		entrytitle "Average Mileage by Vehicle Type";
			layout overlay / walldisplay=(outline);
				barchart category=type response=mpg_highway / name="barchart"
										fillattrs=(color=DarkSeaGreen)
										stat=mean orient=horizontal dataskin=matte;
		endlayout;
	endgraph;
end;
proc sgrender data=sashelp.cars template=barchart;
run;




/*Using Anti-Aliasing*/
proc template;
	define statgraph fitline;
		begingraph;
		entrytitle "Spline Fit";
			layout overlay;
				scatterplot x=height y=weight / primary=true datalabel=name;
				pbsplineplot x=height y=weight;
			endlayout;
		endgraph;
	end;
run;
ods graphics / antialias=off;
proc sgrender data=sashelp.class template=fitline;
run;

ods graphics / antialias=on;
proc sgrender data=sashelp.class template=fitline;
run;

/*Using Subpixel Rendering*/

/* Sort the SASHELP.STOCKS data by date. */
proc sort data=sashelp.stocks out=stocks;
by date;
run;
/* Create the template for the graph. */
proc template;
	define statgraph subpixelon;
		begingraph / subpixel=on;
		entrytitle "Stock Index Performance: 2001";
			layout overlay /
								xaxisopts=(label="Month" griddisplay=on
								gridattrs=(pattern=dot color=lightgray))
								yaxisopts=(label="Average Close" type=linear
								linearopts=(viewmin=10) griddisplay=on
								gridattrs=(pattern=dot color=lightgray));
				seriesplot x=eval(put(date, monname3.)) y=close /
										name="stocks"
										group=stock
										smoothconnect=true;
				discretelegend "stocks";
			endlayout;
	endgraph;
end;
/* Render the graph for the year 2001. */
proc sgrender data=stocks template=subpixelon;
	where year(date) = 2001;
run;


proc registry list startat="ods";
run;
