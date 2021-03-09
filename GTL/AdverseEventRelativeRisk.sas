%let mypath=/folders/myfolders/sas_graph/GTL;
%let macroLoc=/folders/myfolders/sas_graph/GTL;

data ae;
   input AE $1-30 A B Low Mean High;
   label a="Drug A";
   label b="Drug B";
   label c="Drug C";
   c = 2*a+b;
   datalines;
ARTHRALGIA                    1   3    1    7     48
NAUSEA                        4   18   2    4     8  
ANOREXIA                      2   3    0.9  3.8   16
HEMATURIA                     2   4    0.8  3.2   15
INSOMNIA                      3   5.5  1.1  3.0   7
VOMITING                      3.5 6    1.2  2.5   6
DYSPEPSIA                     4   10   1.1  2.4   4.5
WEIGHT DECREASE               1.5 3    0.5  2.0   4.2
RESPIRATORY DISORDER          3   4    0.4  1.4   4
HEADACHE                      7   10   0.8  1.1   2
GASTROESOPHAGEAL REFLUX       3   4    0.5  1.05  3.8
BACK PAIN                     5   6    0.8  1.04  2
CHRONIC OBSTRUCTIVE AIRWAY    22  38   0.6  0.7   0.8
DYSPNEA                       7   2.5  0.13 0.3   0.7
ARTHRALGIA2                   1   3    1    5     48
NAUSEA2                       4   18   2    7     8  
ANOREXIA2                     2   3    0.9  4     16
HEMATURIA2                    2   4    0.8  5     15
INSOMNIA2                     3   5.5  1.1  6     7
VOMITING2                     3.5 6    1.2  8     16
DYSPEPSIA2                    4   10   1.1  4     4.5
WEIGHT DECREASE2              1.5 3    0.5  4     4.2
RESPIRATORY DISORDER2         3   4    0.4  3     4
HEADACHE2                     7   10   0.8  4     6
GASTROESOPHAGEAL REFLUX2      3   4    0.5  4     7
BACK PAIN2                    5   6    0.8  1.5   2
CHRONIC OBSTRUCTIVE AIRWAY2   22  38   0.6  1   2
;
run;

data ae2;
   set ae(obs=6);
run;

data ae3;
   set ae(obs=10);
run;

options sasautos=("&macroLoc", sasautos);

ods listing close;
ods html image_dpi=100 file='adverseevents.html' path="&mypath";
ods graphics / reset noborder width=600px height=400px;

%AdverseEventRelativeRiskMacro(data=ae3, events=ae, drug1=a, drug2=b, 
              title=%str(Most Frequent On-Therapy Adverse Events),
              title2=Sorted by Relative Risk, Width=6.4in, 
              CL=95, risk=mean, UCL=high, LCL=low, Grid=Yes);

%AdverseEventRelativeRiskMacro(data=ae, events=ae, drug1=a, drug2=b, 
              title=%str(Most Frequent On-Therapy Adverse Events),
              title2=Sorted by Relative Risk, 
              CL=95, risk=mean, UCL=high, LCL=low, bands=no, grid=yes);

%AdverseEventRelativeRiskMacro(data=ae3, events=ae, drug1=a, drug2=b, drug3=c,
              title=%str(Most Frequent On-Therapy Adverse Events),
              title2=Sorted by Relative Risk,
              footnote=%str(Footnote # 1), 
              footnote2=%str(Footnote # 2),
              risk=mean, UCL=high, LCL=low);

%AdverseEventRelativeRiskMacro(data=ae3, events=ae, drug1=a, drug2=b, drug3=c, 
              title=%str(Most Frequent On-Therapy Adverse Events));

options nomprint nomlogic;
ods html close;
ods listing;
