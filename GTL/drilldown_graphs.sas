/*DRILL DOWN GRAPHS*/

ods graphics / imagemap=off;

/* Specify the ODS output path */

filename outp "D:\SAS\SAS Graphs\SAS";

/* 1. Add a URL column for the drill-down links to the
SASHELP.PRDSALE data set. */

data sales;
	length url $30;
	set sashelp.prdsale;
	format actual dollar12.0;
	select (product);
	when ("SOFA") url="sofa.html";
	when ("BED") url="bed.html";
	when ("TABLE") url="table.html";
	when ("CHAIR") url="chair.html";
	when ("DESK") url="desk.html";
	otherwise url=" ";
	end;
run;

/* 2. Create a template for the supporting graphs. */

proc template;
	define statgraph drilldown;
		begingraph;
		dynamic product;
		entrytitle product " Sales Data";
			layout overlay /
							yaxisopts=(griddisplay=on gridattrs=(color=lightgray pattern=dot));
				barchart category=country response=actual /
											name="productsales"
											group=year
											groupdisplay=cluster
											barwidth=0.75
											dataskin=sheen;
				discretelegend "productsales" / title="Year:";
			endlayout;
		endgraph;
	end;
run;
/* 3. Generate a supporting graph for each product. Because there are
several products, create a macro that generates a graph
for a specific product. */
%macro genchart(product=);
	/* Specify the image output filename. */
	ods graphics / imagename="&product";
	/* Generate the graph using ODS HTML. */
	ods _all_ close;
	ods html path=outp file="&product..html";
	proc sgrender data=sales template=drilldown;
		where product = "&product";
		dynamic product="&product"; /* Pass product to the template. */
	run;
	ods html close;
%mend genchart;
/* Use the macro to generate the supporting graphs. */
%genchart(product=SOFA);
%genchart(product=DESK);
%genchart(product=CHAIR);
%genchart(product=TABLE);
%genchart(product=BED);
/* 4. Create a template for the drill-down graph. */
proc template;
	define statgraph basechart;
	begingraph;
		entrytitle "Total Sales By Product";
		entryfootnote textattrs=(size=7pt) "Click a pie slice for
											product-specific sales data.";
			layout region;
				piechart category=product response=actual /
									datalabelcontent=(category response)
									datalabellocation=inside
									url=url
									tip=(category)
									dataskin=gloss;
			endlayout;
		endgraph;
	end;
run;
/* 5. Enable image mapping in the HTML output and specify
a base image name. */
ods graphics / reset imagemap=on imagename="prodsales"
				antialiasmax=2000 tipmax=2000;
/* 6. Generate the drill-down graph using ODS HTML. */
ods html path=outp file="sales.html";
proc sgrender data=sales template=basechart;
run;
ods html close;
/* 7. Disable image mapping and open an output destination. */
ods graphics / reset imagemap=off;
ods html; /* Not required in SAS Studio */
