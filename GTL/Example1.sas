ods _all_ close;
ods graphics / reset width=460px height=440px;
ods html style=Daisy path="/folders/myfolders/sas_graph/GTL" file="mychart.html";

proc sort data=sashelp.cars out=cars;
	by type;
run;

proc template;
	define statgraph mygraphtemplate;
		begingraph;
		entrytitle "Models Produced By Vehicle Type and Origin";
		entryfootnote "Data: SASHELP.CARS";
		layout overlay / xaxisopts=(label="Vehicle Type") 
			yaxisopts=(label="Models Produced" griddisplay=on gridattrs=(color=gray 
			pattern=dot));
		barchart category=type / name="bar" stat=freq barlabel=true group=origin;
		discretelegend "bar" / title="Origin";
		endlayout;
		endgraph;
	end;
run;

proc sgrender data=cars template=mygraphtemplate;
run;

ods html close;
ods html;

