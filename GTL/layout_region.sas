/*LAYOUT REGION STATEMENT*/

/*Example 1: Pie Chart*/

/* Define the template for the chart */
proc template;
	define statgraph region;
		begingraph;
		entrytitle "Sales By State";
			layout region;
				piechart category=state response=actual /
								dataskin=pressed datalabellocation=outside;
			endlayout;
		endgraph;
	end;
run;
quit;
/* Set the antialias maximum to 15000 */
ods graphics on / reset antialiasmax=15000;
/* Render the chart */
proc sgrender data=sashelp.prdsal2 template=region;
where country eq "U.S.A.";
format actual dollar12.0;
run;
quit;

/*Example 2: Bar Chart and Pie Chart*/


/* Get sales data in millions from SASHELP.PRDSAL2 */
data sales;
	set sashelp.prdsal2;
	actualmils=(actual / 1000000);
run;
/* Define the template for the graph */
proc template;
	define statgraph region;
		begingraph;
		entrytitle "Sales By State";
			layout gridded / columns=1 rows=2;
			layout lattice / columns=2 rows=1;
				cell;
/* Generate a bar chart of sales in millions. */
					cellheader;
						entry "Sales in Millions";
					endcellheader;
			layout overlay / width=250px
							xaxisopts=(display=none)
							yaxisopts=(griddisplay=on display=(ticks tickvalues));
				barchart category=state response=actualmils /
											group=state
											orient=vertical
											dataskin=pressed barwidth=0.8;
			endlayout;
				endcell;
				cell;
/* Generate a pie chart of percent of total sales. */
					cellheader;
						entry "Percent of Total Sales";
					endcellheader;
			layout region / pad=10;
					piechart category=state response=actualmils /
												name="salespct"
												dataskin=pressed
												datalabelcontent=(percent)
												datalabellocation=inside labelfitpolicy=drop;
			endlayout;
				endcell;
			endlayout;
				discretelegend "salespct" / title="State" across=4;
			endlayout;
		endgraph;
	end;
run;
quit;
/* Set the antialias maximum to 15000 */
ods graphics on / reset antialiasmax=15000;
/* Render the graph */
proc sgrender data=sales template=region;
	where country eq "U.S.A.";
	format actualmils dollar5.1;
run;
quit;


/*Example 3: Mosaic Plot*/

/* Summarize the SASHELP.HEART data for BP_STATUS and SMOKING_STATUS */
proc summary data=sashelp.heart nway;
class bp_status smoking_status;
var cholesterol;
output out=heart mean=avgCholesterol N=count / noinherit;
run;
/* Define the template for the plot */
proc template;
	define statgraph mosaicplot;
		begingraph;
		entrytitle "Smoking Status, Blood Pressure, and Cholesterol";
			layout region;
				mosaicPlotParm category=(bp_status smoking_status) count=count /
										name="mosaic" colorresponse=avgCholesterol;
				continuouslegend "mosaic" / title="Average Cholesterol"
				pad=(left=5);
			endlayout;
		endgraph;
	end;
run;
/* Render the plot */
proc sgrender data=heart template=mosaicplot;
run;
