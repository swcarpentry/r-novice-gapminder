# export figures manually
library(DiagrammeR)
##################################### 14-tidyr-fig1.png #####################################
grViz('digraph html {

      table1 [shape=none, margin=0, label=<
      <TABLE BORDER="0" CELLBORDER="0" CELLSPACING="1" CELLPADDING="6">
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">ID</TD>
      <TD BGCOLOR="#FF7400" CELLPADDING="0">a1</TD>
      <TD BGCOLOR="#009999" CELLPADDING="0">a2</TD>
      <TD BGCOLOR="#00CC00" CELLPADDING="0">a3</TD>
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
      
      table2 [shape=none, margin=0,label=<
      <TABLE BORDER="0" CELLBORDER="0" CELLSPACING="1" CELLPADDING="6">
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">ID</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">ID2</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">A</TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000">1</TD>
      <TD BGCOLOR="#FF7400">a1</TD>
      <TD BGCOLOR="#FF7400"></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000">2</TD>
      <TD BGCOLOR="#FF7400">a1</TD>
      <TD BGCOLOR="#FF7400"></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000">3</TD>
      <TD BGCOLOR="#FF7400">a1</TD>
      <TD BGCOLOR="#FF7400"></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000">1</TD>
      <TD BGCOLOR="#009999">a2</TD>
      <TD BGCOLOR="#009999"></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000">2</TD>
      <TD BGCOLOR="#009999">a2</TD>
      <TD BGCOLOR="#009999"></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000">3</TD>
      <TD BGCOLOR="#009999">a2</TD>
      <TD BGCOLOR="#009999"></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000">1</TD>
      <TD BGCOLOR="#00CC00">a3</TD>
      <TD BGCOLOR="#00CC00"></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000">2</TD>
      <TD BGCOLOR="#00CC00">a3</TD>
      <TD BGCOLOR="#00CC00"></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#FF0000">3</TD>
      <TD BGCOLOR="#00CC00">a3</TD>
      <TD BGCOLOR="#00CC00"></TD>
      </TR>
      </TABLE>>];
      
      subgraph {
      rank = same; table1; table2;
      }
      
      
      labelloc="t";
      fontname="Courier";
      label="wide      vs      long";
      }
      ')
  
##################################### 14-tidyr-fig2.png #####################################
grViz('digraph html {
    table1 [shape=none, margin=0, label=<
      <TABLE BORDER="0" CELLBORDER="0" CELLSPACING="1" CELLPADDING="6">
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">continent</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">country</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">gdpPercap_1952</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">gdpPercap_1957</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">gdpPercap_...</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">lifeExp_1952</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">lifeExp_1957</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">lifeExp_...</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">pop_1952</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">pop_1957</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">pop_...</TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">Algeria</TD>
      <TD BGCOLOR="#F9E559" ></TD>
      <TD BGCOLOR="#F9E559" ></TD>
      <TD BGCOLOR="#F9E559" ></TD>
      <TD BGCOLOR="#EF7126" ></TD>
      <TD BGCOLOR="#EF7126" ></TD>
      <TD BGCOLOR="#EF7126" ></TD>
      <TD BGCOLOR="#8EDC9D" ></TD>
      <TD BGCOLOR="#8EDC9D" ></TD>
      <TD BGCOLOR="#8EDC9D" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">Angola</TD>
      <TD BGCOLOR="#F9E559" ></TD>
      <TD BGCOLOR="#F9E559" ></TD>
      <TD BGCOLOR="#F9E559" ></TD>
      <TD BGCOLOR="#EF7126" ></TD>
      <TD BGCOLOR="#EF7126" ></TD>
      <TD BGCOLOR="#EF7126" ></TD>
      <TD BGCOLOR="#8EDC9D" ></TD>
      <TD BGCOLOR="#8EDC9D" ></TD>
      <TD BGCOLOR="#8EDC9D" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">...</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">...</TD>
      <TD BGCOLOR="#F9E559" ></TD>
      <TD BGCOLOR="#F9E559" ></TD>
      <TD BGCOLOR="#F9E559" ></TD>
      <TD BGCOLOR="#EF7126" ></TD>
      <TD BGCOLOR="#EF7126" ></TD>
      <TD BGCOLOR="#EF7126" ></TD>
      <TD BGCOLOR="#8EDC9D" ></TD>
      <TD BGCOLOR="#8EDC9D" ></TD>
      <TD BGCOLOR="#8EDC9D" ></TD>
      </TR>
      </TABLE>>];
      
      labelloc="t";
      fontname="Courier";
      label="wide format";
      }
      ')

##################################### 14-tidyr-fig3.png #####################################
grViz('digraph html {

      table1 [shape=none, margin=0, label=<
      <TABLE BORDER="0" CELLBORDER="0" CELLSPACING="1" CELLPADDING="6">
      <TR>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">continent</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">country</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">obstype_year</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">obs_value</TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">Algeria</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">gdpPercap_1952</TD>
      <TD BGCOLOR="#F9E559" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">Algeria</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">gdpPercap_1957</TD>
      <TD BGCOLOR="#F9E559" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">Algeria</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">gdpPercap_...</TD>
      <TD BGCOLOR="#F9E559" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">Algeria</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">lifeExp_1952</TD>
      <TD BGCOLOR="#EF7126" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">Algeria</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">lifeExp_1957</TD>
      <TD BGCOLOR="#EF7126" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">Algeria</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">lifeExp_...</TD>
      <TD BGCOLOR="#EF7126" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">Algeria</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">pop_1952</TD>
      <TD BGCOLOR="#8EDC9D" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">Algeria</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">pop_1957</TD>
      <TD BGCOLOR="#8EDC9D" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">Algeria</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">pop_...</TD>
      <TD BGCOLOR="#8EDC9D" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">Angola</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">gdpPercap_1952</TD>
      <TD BGCOLOR="#F9E559" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">Angola</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">gdpPercap_1957</TD>
      <TD BGCOLOR="#F9E559" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">Angola</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">gdpPercap_...</TD>
      <TD BGCOLOR="#F9E559" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">Angola</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">lifeExp_1952</TD>
      <TD BGCOLOR="#EF7126" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">Angola</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">lifeExp_1957</TD>
      <TD BGCOLOR="#EF7126" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">Angola</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">lifeExp_...</TD>
      <TD BGCOLOR="#EF7126" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">Angola</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">pop_1952</TD>
      <TD BGCOLOR="#8EDC9D" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">Angola</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">pop_1957</TD>
      <TD BGCOLOR="#8EDC9D" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">Angola</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">pop_...</TD>
      <TD BGCOLOR="#8EDC9D" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">...</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">gdpPercap_1952</TD>
      <TD BGCOLOR="#F9E559" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">...</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">gdpPercap_1957</TD>
      <TD BGCOLOR="#F9E559" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">...</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">gdpPercap_...</TD>
      <TD BGCOLOR="#F9E559" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">...</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">lifeExp_1952</TD>
      <TD BGCOLOR="#EF7126" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">...</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">lifeExp_1957</TD>
      <TD BGCOLOR="#EF7126" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">...</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">lifeExp_...</TD>
      <TD BGCOLOR="#EF7126" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">...</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">pop_1952</TD>
      <TD BGCOLOR="#8EDC9D" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">...</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">pop_1957</TD>
      <TD BGCOLOR="#8EDC9D" ></TD>
      </TR>
      
      <TR>
      <TD BGCOLOR="#218C8D" CELLPADDING="0">Africa</TD>
      <TD BGCOLOR="#6CCECB" CELLPADDING="0">...</TD>
      <TD BGCOLOR="#FF0000" CELLPADDING="0">pop_...</TD>
      <TD BGCOLOR="#8EDC9D" ></TD>
      </TR>
      
      </TABLE>>];
      
      labelloc="t";
      fontname="Courier";
      label="long format";
      }
      ')
