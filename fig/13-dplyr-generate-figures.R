# export figures manually
library(DiagrammeR)
##################################### 13-dplyr-fig2.png #####################################
grViz('digraph html {
      table1 [shape=none, margin=0,label=<
      <TABLE BORDER="0" CELLBORDER="0" CELLSPACING="1" CELLPADDING="6">
      <TR>
      <TD PORT="f0" BGCOLOR="#FF0000" CELLPADDING="0">a</TD>
      <TD BGCOLOR="#FF7400" CELLPADDING="0">b</TD>
      <TD PORT="f1" BGCOLOR="#009999" CELLPADDING="0">c</TD>
      <TD BGCOLOR="#00CC00" CELLPADDING="0">d</TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000"></TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD BGCOLOR="#00CC00"></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000"></TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD BGCOLOR="#00CC00"></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000"></TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD BGCOLOR="#00CC00"></TD>
      </TR>
      </TABLE>>];
      
      table2 [shape=none, margin=0, label=<
      <TABLE BORDER="0" CELLBORDER="0" CELLSPACING="1" CELLPADDING="6">
      <TR>
      <TD PORT="f0" BGCOLOR="#FF0000" CELLPADDING="0">a</TD>
      <TD PORT="f1" BGCOLOR="#009999" CELLPADDING="0">c</TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000"></TD>
      <TD BGCOLOR="#009999"></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000"></TD>
      <TD BGCOLOR="#009999"></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000"></TD>
      <TD BGCOLOR="#009999"></TD>
      </TR>
      </TABLE>>];
      
      table1:f1 -> table2:f1 
      table1:f0 -> table2:f0
      
      subgraph {
      rank = same; table1; table2;
      }
      
      labelloc="t";
      fontname="Courier";
      label="select(data.frame,a,c)";
      }
      ')
  
##################################### 13-dplyr-fig2.png #####################################
grViz('digraph html {
      table1 [shape=none, margin=0,label=<
      <TABLE BORDER="0" CELLBORDER="0" CELLSPACING="1" CELLPADDING="6">
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">a</TD>
      <TD BGCOLOR="#FF7400" CELLPADDING="0">b</TD>
      <TD BGCOLOR="#009999" CELLPADDING="0">c</TD>
      <TD BGCOLOR="#00CC00" CELLPADDING="0">d</TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">1</TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD PORT="f0" BGCOLOR="#00CC00"></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">1</TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD BGCOLOR="#00CC00"></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">2</TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD PORT="f1" BGCOLOR="#00CC00"></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">2</TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD BGCOLOR="#00CC00"></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">3</TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD PORT="f2" BGCOLOR="#00CC00"></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">3</TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD BGCOLOR="#00CC00"></TD>
      </TR>
      </TABLE>>];
      table2 [shape=none, margin=0,label=<
      <TABLE BORDER="0" CELLBORDER="0" CELLSPACING="1" CELLPADDING="6">
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">a</TD>
      <TD BGCOLOR="#FF7400" CELLPADDING="0">b</TD>
      <TD BGCOLOR="#009999" CELLPADDING="0">c</TD>
      <TD BGCOLOR="#00CC00" CELLPADDING="0">d</TD>
      </TR>
      
      <TR>
      <TD PORT="f0" BGCOLOR="#FF0000" CELLPADDING="0">1</TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD BGCOLOR="#00CC00"></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">1</TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD BGCOLOR="#00CC00"></TD>
      </TR>
      
      </TABLE>>];
      table3 [shape=none, margin=0,label=<
      <TABLE BORDER="0" CELLBORDER="0" CELLSPACING="1" CELLPADDING="6">
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">a</TD>
      <TD BGCOLOR="#FF7400" CELLPADDING="0">b</TD>
      <TD BGCOLOR="#009999" CELLPADDING="0">c</TD>
      <TD BGCOLOR="#00CC00" CELLPADDING="0">d</TD>
      </TR>
      
      <TR>
      <TD PORT="f1" BGCOLOR="#FF0000" CELLPADDING="0">2</TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD BGCOLOR="#00CC00"></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">2</TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD BGCOLOR="#00CC00"></TD>
      </TR>
      </TABLE>>];
      table4 [shape=none, margin=0,label=<
      <TABLE BORDER="0" CELLBORDER="0" CELLSPACING="1" CELLPADDING="6">
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">a</TD>
      <TD BGCOLOR="#FF7400" CELLPADDING="0">b</TD>
      <TD BGCOLOR="#009999" CELLPADDING="0">c</TD>
      <TD BGCOLOR="#00CC00" CELLPADDING="0">d</TD>
      </TR>
      
      <TR>
      <TD PORT="f2" BGCOLOR="#FF0000" CELLPADDING="0">3</TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD BGCOLOR="#00CC00"></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">3</TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD BGCOLOR="#00CC00"></TD>
      </TR>
      </TABLE>>];
      
      
      
      table1:f0 -> table2:f0 
      table1:f1 -> table3:f1
      table1:f2 -> table4:f2
      
      subgraph {
      rank = same; table1; table2; table3 ;table4;
      }
      subgraph {
      table2
      table3
      table4
      }
      
      labelloc="t";
      fontname="Courier";
      label="gapminder %>% group_by(a)";
      }
      ')

##################################### 13-dplyr-fig3.png #####################################
grViz('digraph html {
      table1 [shape=none, margin=0,label=<
      <TABLE BORDER="0" CELLBORDER="0" CELLSPACING="1" CELLPADDING="6">
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">a</TD>
      <TD BGCOLOR="#FF7400" CELLPADDING="0">b</TD>
      <TD BGCOLOR="#009999" CELLPADDING="0">c</TD>
      <TD BGCOLOR="#00CC00" CELLPADDING="0">d</TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">1</TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD PORT="f0" BGCOLOR="#00CC00"></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">1</TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD BGCOLOR="#00CC00"></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">2</TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD PORT="f1" BGCOLOR="#00CC00"></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">2</TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD BGCOLOR="#00CC00"></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">3</TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD PORT="f2" BGCOLOR="#00CC00"></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">3</TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD BGCOLOR="#00CC00"></TD>
      </TR>
      </TABLE>>];
      
      table2 [shape=none, margin=0,label=<
      <TABLE BORDER="0" CELLBORDER="0" CELLSPACING="1" CELLPADDING="6">
      <TR>
      <TD PORT="f0" BGCOLOR="#FF0000" CELLPADDING="0">a</TD>
      <TD BGCOLOR="#FF7400" CELLPADDING="0">b</TD>
      <TD BGCOLOR="#009999" CELLPADDING="0">c</TD>
      <TD BGCOLOR="#00CC00" CELLPADDING="0">d</TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">1</TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD BGCOLOR="#00CC00"></TD>
      </TR>
      
      <TR>
      <TD PORT="f3" BGCOLOR="#FF0000" CELLPADDING="0">1</TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD BGCOLOR="#00CC00"></TD>
      </TR>
      
      </TABLE>>];
      
      table3 [shape=none, margin=0,label=<
      <TABLE BORDER="0" CELLBORDER="0" CELLSPACING="1" CELLPADDING="6">
      <TR>
      <TD PORT="f1" BGCOLOR="#FF0000" CELLPADDING="0">a</TD>
      <TD BGCOLOR="#FF7400" CELLPADDING="0">b</TD>
      <TD BGCOLOR="#009999" CELLPADDING="0">c</TD>
      <TD BGCOLOR="#00CC00" CELLPADDING="0">d</TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">2</TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD BGCOLOR="#00CC00"></TD>
      </TR>
      
      <TR>
      <TD PORT="f3" BGCOLOR="#FF0000" CELLPADDING="0">2</TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD BGCOLOR="#00CC00"></TD>
      </TR>
      </TABLE>>];
      
      table4 [shape=none, margin=0,label=<
      <TABLE BORDER="0" CELLBORDER="0" CELLSPACING="1" CELLPADDING="6">
      <TR>
      <TD PORT="f2" BGCOLOR="#FF0000" CELLPADDING="0">a</TD>
      <TD BGCOLOR="#FF7400" CELLPADDING="0">b</TD>
      <TD BGCOLOR="#009999" CELLPADDING="0">c</TD>
      <TD BGCOLOR="#00CC00" CELLPADDING="0">d</TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">3</TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD BGCOLOR="#00CC00"></TD>
      </TR>
      
      <TR>
      <TD PORT="f3" BGCOLOR="#FF0000" CELLPADDING="0">3</TD>
      <TD BGCOLOR="#FF7400"></TD>
      <TD BGCOLOR="#009999"></TD>
      <TD BGCOLOR="#00CC00"></TD>
      </TR>
      </TABLE>>];
      
      table5 [shape=none, margin=0,label=<
      <TABLE BORDER="0" CELLBORDER="0" CELLSPACING="1" CELLPADDING="6">
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">a</TD>
      <TD BGCOLOR="#FF7400" CELLPADDING="0">mean_b</TD>
      </TR>
      
      <TR>
      <TD PORT="f0" BGCOLOR="#FF0000" CELLPADDING="0">1</TD>
      <TD BGCOLOR="#FF7400"></TD>
      </TR>
      
      <TR>
      <TD PORT="f1" BGCOLOR="#FF0000" CELLPADDING="0">2</TD>
      <TD BGCOLOR="#FF7400"></TD>
      </TR>
      
      <TR>
      <TD PORT="f2" BGCOLOR="#FF0000" CELLPADDING="0">3</TD>
      <TD BGCOLOR="#FF7400"></TD>
      </TR>
      
      </TABLE>>];
      
      
      table1:f0 -> table2:f0 
      table1:f1 -> table3:f1
      table1:f2 -> table4:f2
      table2:f3 -> table5:f0 
      table3:f3 -> table5:f1
      table4:f3 -> table5:f2
      subgraph {
      rank = same; table1; table2; table3 ; table4;
      }
      subgraph {
      table2
      table3
      table4
      }
      
      labelloc="t";
      fontname="Courier";
      label="gapminder %>%\\l\tgroup_by(a) %>%\\l\tsummarize(mean_b=mean(b))\\l";
      }
      ')
