---
layout: page
title: R for reproducible scientific analysis
subtitle: Data structures
minutes: 15
---

> ## Learning Objectives {.objectives}
>
> - To be aware of the different types of data
> - To be aware of the different basic data structures commonly encountered in R
> - To be able to ask questions from R about the type, class, and structure of an object.
>

### Data Types

To make the best of the R language, you'll need a strong understanding of 
the basic data types and data structures and how to operate on those.
**Very Important** to understand because these are the things you will
manipulate on a day-to-day basis in R. 

Importantly, they are the most common source of frustration among beginners.


> ### Challenge: Object types {.challenge}
> 
> Look at the first 6 rows of the gapminder dataset we loaded before:
> 
> ~~~ {.r}
> head(gapminder)
> ~~~
> 
> ~~~ {.output}
>       country year      pop continent lifeExp gdpPercap
> 1 Afghanistan 1952  8425333      Asia  28.801  779.4453
> 2 Afghanistan 1957  9240934      Asia  30.332  820.8530
> 3 Afghanistan 1962 10267083      Asia  31.997  853.1007
> 4 Afghanistan 1967 11537966      Asia  34.020  836.1971
> 5 Afghanistan 1972 13079460      Asia  36.088  739.9811
> 6 Afghanistan 1977 14880372      Asia  38.438  786.1134
> ~~~
> 
> Write down what type of data you think is in each column
>


R has 5 basic atomic classes (meaning they can't be broken down into anything smaller):

* logical (e.g., `TRUE`, `FALSE`)
* integer (e.g,, 2L, as.integer(3))
* numeric (real or decimal) (e.g, 2, 2.0, pi)
* complex (e.g, 1 + 0i, 1 + 4i)
* character (e.g, "a", "swc")

There a few functions we can use to interrogate data structures in R:

~~~ {.r}
class() # what is the data structure?
typeof() # what is its atomic type?
length() # how long is it? What about two dimensional objects?
attributes() # does it have any metadata?
str() # A full summary of the entire object
~~~

Lets use them to explore the gapminder dataset.

~~~ {.r}
class(gapminder)
~~~

~~~ {.output}
[1] "data.frame"
~~~

The gapminder data is stored in a "data.frame", this is the default data structure when you read
in data, and is useful for storing data with mixed types of columns.

~~~ {.r}
typeof(gapminder)
~~~

~~~ {.output}
[1] "list"
~~~

That's not particularly informative. That's because we're looking at the type of the whole
`data.frame`. Let's look at some of the columns instead. We can access the columns in a 
`data.frame` by using the `$` operator. 

~~~ {.r}
typeof(gapminder$year)
typeof(gapminder$lifeExp)
~~~

~~~ {.output}
[1] "integer"
[1] "double"
~~~

Can anyone guess what we should expect the type of the continent column to be?

~~~ {.r}
typeof(gapminder$continent)
~~~

~~~ {.output}
[1] "integer"
~~~

If you were expecting a the answer to be "character", you would rightly be 
surprised by the answer. Let's take a look at the class of this column:

~~~ {.r}
class(gapminder$continent)
~~~

~~~ {.output}
[1] "factor"
~~~

One of the default behaviours of R is to treat any text columns as "factors"
when reading in data. The reason for this is that text columns often represent
categorical data, which need to be factors to be handled appropriately by
the statistical modelling functions in R. 

However its not obvious behaviour, and something that trips novices up. We can
disable this behaviour and read in the data again.

~~~ {.r}
options(stringsAsFactors=FALSE)
gapminder <- read.table(
  file="data/gapminder-FiveYearData.csv", header=TRUE, row.names=1, 
  sep=","
)
~~~

This is a personal preference of mine. There are a few reasons I like to turn off
this behaviour:

 1. I'm often tripped up by this behaviour.
 2. It's better to explicitly convert the variables into factors when
    running statistical models. This forces you to think about the 
    question you're asking, and makes it easier to specify the ordering
    of the categories (this can be important!).

However there are many in the R community who find it more sensible to
leave this as the default behaviour.

> ## Tip {.callout}
>
> When R starts, the first thing it does is runs any code in the file `.Rprofile`
> in the project directory. Any permanent changes to default behaviour you want 
> to make should be stored in that file.
>

The first thing you should do when reading data in, is check that it matches what
you expect, even if the command ran without warnings or errors. The `str` function,
short for "structure", is really useful for this:

~~~ {.r}
str(gapminder)
~~~

~~~ {.output}
'data.frame': 1704 obs. of  6 variables:
 $ country  : chr  "Afghanistan" "Afghanistan" "Afghanistan" "Afghanistan" ...
 $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
 $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
 $ continent: chr  "Asia" "Asia" "Asia" "Asia" ...
 $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
 $ gdpPercap: num  779 821 853 836 740 ...
~~~

We can see that the object is a `data.frame` with 1,704 observations (rows), 
and 6 variables (columns). Below that, we see the name of each column, followed
by a ":", followed by the type of variable in that column, along with the first
few entries.

We can also retrieve or modify the column or rownames of the data.frame:

~~~ {.r}
colnames(gapminder)
~~~

~~~ {.output}
[1] "country"   "year"      "pop"       "continent" "lifeExp"   "gdpPercap"
~~~

~~~ {.r}
rownames(gapminder)
~~~

~~~ {.output}
   [1] "1"    "2"    "3"    "4"    "5"    "6"    "7"    "8"    "9"    "10"  
  [11] "11"   "12"   "13"   "14"   "15"   "16"   "17"   "18"   "19"   "20"  
  [21] "21"   "22"   "23"   "24"   "25"   "26"   "27"   "28"   "29"   "30"  
  [31] "31"   "32"   "33"   "34"   "35"   "36"   "37"   "38"   "39"   "40"  
  [41] "41"   "42"   "43"   "44"   "45"   "46"   "47"   "48"   "49"   "50"  
  [51] "51"   "52"   "53"   "54"   "55"   "56"   "57"   "58"   "59"   "60"  
  [61] "61"   "62"   "63"   "64"   "65"   "66"   "67"   "68"   "69"   "70"  
  [71] "71"   "72"   "73"   "74"   "75"   "76"   "77"   "78"   "79"   "80"  
  [81] "81"   "82"   "83"   "84"   "85"   "86"   "87"   "88"   "89"   "90"  
  [91] "91"   "92"   "93"   "94"   "95"   "96"   "97"   "98"   "99"   "100" 
 [101] "101"  "102"  "103"  "104"  "105"  "106"  "107"  "108"  "109"  "110" 
 [111] "111"  "112"  "113"  "114"  "115"  "116"  "117"  "118"  "119"  "120" 
 [121] "121"  "122"  "123"  "124"  "125"  "126"  "127"  "128"  "129"  "130" 
 [131] "131"  "132"  "133"  "134"  "135"  "136"  "137"  "138"  "139"  "140" 
 [141] "141"  "142"  "143"  "144"  "145"  "146"  "147"  "148"  "149"  "150" 
 [151] "151"  "152"  "153"  "154"  "155"  "156"  "157"  "158"  "159"  "160" 
 [161] "161"  "162"  "163"  "164"  "165"  "166"  "167"  "168"  "169"  "170" 
 [171] "171"  "172"  "173"  "174"  "175"  "176"  "177"  "178"  "179"  "180" 
 [181] "181"  "182"  "183"  "184"  "185"  "186"  "187"  "188"  "189"  "190" 
 [191] "191"  "192"  "193"  "194"  "195"  "196"  "197"  "198"  "199"  "200" 
 [201] "201"  "202"  "203"  "204"  "205"  "206"  "207"  "208"  "209"  "210" 
 [211] "211"  "212"  "213"  "214"  "215"  "216"  "217"  "218"  "219"  "220" 
 [221] "221"  "222"  "223"  "224"  "225"  "226"  "227"  "228"  "229"  "230" 
 [231] "231"  "232"  "233"  "234"  "235"  "236"  "237"  "238"  "239"  "240" 
 [241] "241"  "242"  "243"  "244"  "245"  "246"  "247"  "248"  "249"  "250" 
 [251] "251"  "252"  "253"  "254"  "255"  "256"  "257"  "258"  "259"  "260" 
 [261] "261"  "262"  "263"  "264"  "265"  "266"  "267"  "268"  "269"  "270" 
 [271] "271"  "272"  "273"  "274"  "275"  "276"  "277"  "278"  "279"  "280" 
 [281] "281"  "282"  "283"  "284"  "285"  "286"  "287"  "288"  "289"  "290" 
 [291] "291"  "292"  "293"  "294"  "295"  "296"  "297"  "298"  "299"  "300" 
 [301] "301"  "302"  "303"  "304"  "305"  "306"  "307"  "308"  "309"  "310" 
 [311] "311"  "312"  "313"  "314"  "315"  "316"  "317"  "318"  "319"  "320" 
 [321] "321"  "322"  "323"  "324"  "325"  "326"  "327"  "328"  "329"  "330" 
 [331] "331"  "332"  "333"  "334"  "335"  "336"  "337"  "338"  "339"  "340" 
 [341] "341"  "342"  "343"  "344"  "345"  "346"  "347"  "348"  "349"  "350" 
 [351] "351"  "352"  "353"  "354"  "355"  "356"  "357"  "358"  "359"  "360" 
 [361] "361"  "362"  "363"  "364"  "365"  "366"  "367"  "368"  "369"  "370" 
 [371] "371"  "372"  "373"  "374"  "375"  "376"  "377"  "378"  "379"  "380" 
 [381] "381"  "382"  "383"  "384"  "385"  "386"  "387"  "388"  "389"  "390" 
 [391] "391"  "392"  "393"  "394"  "395"  "396"  "397"  "398"  "399"  "400" 
 [401] "401"  "402"  "403"  "404"  "405"  "406"  "407"  "408"  "409"  "410" 
 [411] "411"  "412"  "413"  "414"  "415"  "416"  "417"  "418"  "419"  "420" 
 [421] "421"  "422"  "423"  "424"  "425"  "426"  "427"  "428"  "429"  "430" 
 [431] "431"  "432"  "433"  "434"  "435"  "436"  "437"  "438"  "439"  "440" 
 [441] "441"  "442"  "443"  "444"  "445"  "446"  "447"  "448"  "449"  "450" 
 [451] "451"  "452"  "453"  "454"  "455"  "456"  "457"  "458"  "459"  "460" 
 [461] "461"  "462"  "463"  "464"  "465"  "466"  "467"  "468"  "469"  "470" 
 [471] "471"  "472"  "473"  "474"  "475"  "476"  "477"  "478"  "479"  "480" 
 [481] "481"  "482"  "483"  "484"  "485"  "486"  "487"  "488"  "489"  "490" 
 [491] "491"  "492"  "493"  "494"  "495"  "496"  "497"  "498"  "499"  "500" 
 [501] "501"  "502"  "503"  "504"  "505"  "506"  "507"  "508"  "509"  "510" 
 [511] "511"  "512"  "513"  "514"  "515"  "516"  "517"  "518"  "519"  "520" 
 [521] "521"  "522"  "523"  "524"  "525"  "526"  "527"  "528"  "529"  "530" 
 [531] "531"  "532"  "533"  "534"  "535"  "536"  "537"  "538"  "539"  "540" 
 [541] "541"  "542"  "543"  "544"  "545"  "546"  "547"  "548"  "549"  "550" 
 [551] "551"  "552"  "553"  "554"  "555"  "556"  "557"  "558"  "559"  "560" 
 [561] "561"  "562"  "563"  "564"  "565"  "566"  "567"  "568"  "569"  "570" 
 [571] "571"  "572"  "573"  "574"  "575"  "576"  "577"  "578"  "579"  "580" 
 [581] "581"  "582"  "583"  "584"  "585"  "586"  "587"  "588"  "589"  "590" 
 [591] "591"  "592"  "593"  "594"  "595"  "596"  "597"  "598"  "599"  "600" 
 [601] "601"  "602"  "603"  "604"  "605"  "606"  "607"  "608"  "609"  "610" 
 [611] "611"  "612"  "613"  "614"  "615"  "616"  "617"  "618"  "619"  "620" 
 [621] "621"  "622"  "623"  "624"  "625"  "626"  "627"  "628"  "629"  "630" 
 [631] "631"  "632"  "633"  "634"  "635"  "636"  "637"  "638"  "639"  "640" 
 [641] "641"  "642"  "643"  "644"  "645"  "646"  "647"  "648"  "649"  "650" 
 [651] "651"  "652"  "653"  "654"  "655"  "656"  "657"  "658"  "659"  "660" 
 [661] "661"  "662"  "663"  "664"  "665"  "666"  "667"  "668"  "669"  "670" 
 [671] "671"  "672"  "673"  "674"  "675"  "676"  "677"  "678"  "679"  "680" 
 [681] "681"  "682"  "683"  "684"  "685"  "686"  "687"  "688"  "689"  "690" 
 [691] "691"  "692"  "693"  "694"  "695"  "696"  "697"  "698"  "699"  "700" 
 [701] "701"  "702"  "703"  "704"  "705"  "706"  "707"  "708"  "709"  "710" 
 [711] "711"  "712"  "713"  "714"  "715"  "716"  "717"  "718"  "719"  "720" 
 [721] "721"  "722"  "723"  "724"  "725"  "726"  "727"  "728"  "729"  "730" 
 [731] "731"  "732"  "733"  "734"  "735"  "736"  "737"  "738"  "739"  "740" 
 [741] "741"  "742"  "743"  "744"  "745"  "746"  "747"  "748"  "749"  "750" 
 [751] "751"  "752"  "753"  "754"  "755"  "756"  "757"  "758"  "759"  "760" 
 [761] "761"  "762"  "763"  "764"  "765"  "766"  "767"  "768"  "769"  "770" 
 [771] "771"  "772"  "773"  "774"  "775"  "776"  "777"  "778"  "779"  "780" 
 [781] "781"  "782"  "783"  "784"  "785"  "786"  "787"  "788"  "789"  "790" 
 [791] "791"  "792"  "793"  "794"  "795"  "796"  "797"  "798"  "799"  "800" 
 [801] "801"  "802"  "803"  "804"  "805"  "806"  "807"  "808"  "809"  "810" 
 [811] "811"  "812"  "813"  "814"  "815"  "816"  "817"  "818"  "819"  "820" 
 [821] "821"  "822"  "823"  "824"  "825"  "826"  "827"  "828"  "829"  "830" 
 [831] "831"  "832"  "833"  "834"  "835"  "836"  "837"  "838"  "839"  "840" 
 [841] "841"  "842"  "843"  "844"  "845"  "846"  "847"  "848"  "849"  "850" 
 [851] "851"  "852"  "853"  "854"  "855"  "856"  "857"  "858"  "859"  "860" 
 [861] "861"  "862"  "863"  "864"  "865"  "866"  "867"  "868"  "869"  "870" 
 [871] "871"  "872"  "873"  "874"  "875"  "876"  "877"  "878"  "879"  "880" 
 [881] "881"  "882"  "883"  "884"  "885"  "886"  "887"  "888"  "889"  "890" 
 [891] "891"  "892"  "893"  "894"  "895"  "896"  "897"  "898"  "899"  "900" 
 [901] "901"  "902"  "903"  "904"  "905"  "906"  "907"  "908"  "909"  "910" 
 [911] "911"  "912"  "913"  "914"  "915"  "916"  "917"  "918"  "919"  "920" 
 [921] "921"  "922"  "923"  "924"  "925"  "926"  "927"  "928"  "929"  "930" 
 [931] "931"  "932"  "933"  "934"  "935"  "936"  "937"  "938"  "939"  "940" 
 [941] "941"  "942"  "943"  "944"  "945"  "946"  "947"  "948"  "949"  "950" 
 [951] "951"  "952"  "953"  "954"  "955"  "956"  "957"  "958"  "959"  "960" 
 [961] "961"  "962"  "963"  "964"  "965"  "966"  "967"  "968"  "969"  "970" 
 [971] "971"  "972"  "973"  "974"  "975"  "976"  "977"  "978"  "979"  "980" 
 [981] "981"  "982"  "983"  "984"  "985"  "986"  "987"  "988"  "989"  "990" 
 [991] "991"  "992"  "993"  "994"  "995"  "996"  "997"  "998"  "999"  "1000"
[1001] "1001" "1002" "1003" "1004" "1005" "1006" "1007" "1008" "1009" "1010"
[1011] "1011" "1012" "1013" "1014" "1015" "1016" "1017" "1018" "1019" "1020"
[1021] "1021" "1022" "1023" "1024" "1025" "1026" "1027" "1028" "1029" "1030"
[1031] "1031" "1032" "1033" "1034" "1035" "1036" "1037" "1038" "1039" "1040"
[1041] "1041" "1042" "1043" "1044" "1045" "1046" "1047" "1048" "1049" "1050"
[1051] "1051" "1052" "1053" "1054" "1055" "1056" "1057" "1058" "1059" "1060"
[1061] "1061" "1062" "1063" "1064" "1065" "1066" "1067" "1068" "1069" "1070"
[1071] "1071" "1072" "1073" "1074" "1075" "1076" "1077" "1078" "1079" "1080"
[1081] "1081" "1082" "1083" "1084" "1085" "1086" "1087" "1088" "1089" "1090"
[1091] "1091" "1092" "1093" "1094" "1095" "1096" "1097" "1098" "1099" "1100"
[1101] "1101" "1102" "1103" "1104" "1105" "1106" "1107" "1108" "1109" "1110"
[1111] "1111" "1112" "1113" "1114" "1115" "1116" "1117" "1118" "1119" "1120"
[1121] "1121" "1122" "1123" "1124" "1125" "1126" "1127" "1128" "1129" "1130"
[1131] "1131" "1132" "1133" "1134" "1135" "1136" "1137" "1138" "1139" "1140"
[1141] "1141" "1142" "1143" "1144" "1145" "1146" "1147" "1148" "1149" "1150"
[1151] "1151" "1152" "1153" "1154" "1155" "1156" "1157" "1158" "1159" "1160"
[1161] "1161" "1162" "1163" "1164" "1165" "1166" "1167" "1168" "1169" "1170"
[1171] "1171" "1172" "1173" "1174" "1175" "1176" "1177" "1178" "1179" "1180"
[1181] "1181" "1182" "1183" "1184" "1185" "1186" "1187" "1188" "1189" "1190"
[1191] "1191" "1192" "1193" "1194" "1195" "1196" "1197" "1198" "1199" "1200"
[1201] "1201" "1202" "1203" "1204" "1205" "1206" "1207" "1208" "1209" "1210"
[1211] "1211" "1212" "1213" "1214" "1215" "1216" "1217" "1218" "1219" "1220"
[1221] "1221" "1222" "1223" "1224" "1225" "1226" "1227" "1228" "1229" "1230"
[1231] "1231" "1232" "1233" "1234" "1235" "1236" "1237" "1238" "1239" "1240"
[1241] "1241" "1242" "1243" "1244" "1245" "1246" "1247" "1248" "1249" "1250"
[1251] "1251" "1252" "1253" "1254" "1255" "1256" "1257" "1258" "1259" "1260"
[1261] "1261" "1262" "1263" "1264" "1265" "1266" "1267" "1268" "1269" "1270"
[1271] "1271" "1272" "1273" "1274" "1275" "1276" "1277" "1278" "1279" "1280"
[1281] "1281" "1282" "1283" "1284" "1285" "1286" "1287" "1288" "1289" "1290"
[1291] "1291" "1292" "1293" "1294" "1295" "1296" "1297" "1298" "1299" "1300"
[1301] "1301" "1302" "1303" "1304" "1305" "1306" "1307" "1308" "1309" "1310"
[1311] "1311" "1312" "1313" "1314" "1315" "1316" "1317" "1318" "1319" "1320"
[1321] "1321" "1322" "1323" "1324" "1325" "1326" "1327" "1328" "1329" "1330"
[1331] "1331" "1332" "1333" "1334" "1335" "1336" "1337" "1338" "1339" "1340"
[1341] "1341" "1342" "1343" "1344" "1345" "1346" "1347" "1348" "1349" "1350"
[1351] "1351" "1352" "1353" "1354" "1355" "1356" "1357" "1358" "1359" "1360"
[1361] "1361" "1362" "1363" "1364" "1365" "1366" "1367" "1368" "1369" "1370"
[1371] "1371" "1372" "1373" "1374" "1375" "1376" "1377" "1378" "1379" "1380"
[1381] "1381" "1382" "1383" "1384" "1385" "1386" "1387" "1388" "1389" "1390"
[1391] "1391" "1392" "1393" "1394" "1395" "1396" "1397" "1398" "1399" "1400"
[1401] "1401" "1402" "1403" "1404" "1405" "1406" "1407" "1408" "1409" "1410"
[1411] "1411" "1412" "1413" "1414" "1415" "1416" "1417" "1418" "1419" "1420"
[1421] "1421" "1422" "1423" "1424" "1425" "1426" "1427" "1428" "1429" "1430"
[1431] "1431" "1432" "1433" "1434" "1435" "1436" "1437" "1438" "1439" "1440"
[1441] "1441" "1442" "1443" "1444" "1445" "1446" "1447" "1448" "1449" "1450"
[1451] "1451" "1452" "1453" "1454" "1455" "1456" "1457" "1458" "1459" "1460"
[1461] "1461" "1462" "1463" "1464" "1465" "1466" "1467" "1468" "1469" "1470"
[1471] "1471" "1472" "1473" "1474" "1475" "1476" "1477" "1478" "1479" "1480"
[1481] "1481" "1482" "1483" "1484" "1485" "1486" "1487" "1488" "1489" "1490"
[1491] "1491" "1492" "1493" "1494" "1495" "1496" "1497" "1498" "1499" "1500"
[1501] "1501" "1502" "1503" "1504" "1505" "1506" "1507" "1508" "1509" "1510"
[1511] "1511" "1512" "1513" "1514" "1515" "1516" "1517" "1518" "1519" "1520"
[1521] "1521" "1522" "1523" "1524" "1525" "1526" "1527" "1528" "1529" "1530"
[1531] "1531" "1532" "1533" "1534" "1535" "1536" "1537" "1538" "1539" "1540"
[1541] "1541" "1542" "1543" "1544" "1545" "1546" "1547" "1548" "1549" "1550"
[1551] "1551" "1552" "1553" "1554" "1555" "1556" "1557" "1558" "1559" "1560"
[1561] "1561" "1562" "1563" "1564" "1565" "1566" "1567" "1568" "1569" "1570"
[1571] "1571" "1572" "1573" "1574" "1575" "1576" "1577" "1578" "1579" "1580"
[1581] "1581" "1582" "1583" "1584" "1585" "1586" "1587" "1588" "1589" "1590"
[1591] "1591" "1592" "1593" "1594" "1595" "1596" "1597" "1598" "1599" "1600"
[1601] "1601" "1602" "1603" "1604" "1605" "1606" "1607" "1608" "1609" "1610"
[1611] "1611" "1612" "1613" "1614" "1615" "1616" "1617" "1618" "1619" "1620"
[1621] "1621" "1622" "1623" "1624" "1625" "1626" "1627" "1628" "1629" "1630"
[1631] "1631" "1632" "1633" "1634" "1635" "1636" "1637" "1638" "1639" "1640"
[1641] "1641" "1642" "1643" "1644" "1645" "1646" "1647" "1648" "1649" "1650"
[1651] "1651" "1652" "1653" "1654" "1655" "1656" "1657" "1658" "1659" "1660"
[1661] "1661" "1662" "1663" "1664" "1665" "1666" "1667" "1668" "1669" "1670"
[1671] "1671" "1672" "1673" "1674" "1675" "1676" "1677" "1678" "1679" "1680"
[1681] "1681" "1682" "1683" "1684" "1685" "1686" "1687" "1688" "1689" "1690"
[1691] "1691" "1692" "1693" "1694" "1695" "1696" "1697" "1698" "1699" "1700"
[1701] "1701" "1702" "1703" "1704"
~~~

See those numbers in the square brackets on the left? That tells you the 
number of the first entry in that row of output. So in the last line, we
see that the "[1701]" element has "1701" stored in it. The rownames in 
this case are simply the row numbers.

We can also modify this information:

~~~ {.r}
copy <- gapminder # lets create a copy so we don't mess up the original
colnames(copy) <- c("a", "b", "c", "d", "e", "f")
head(copy)
~~~

~~~ {.output}
            a    b        c    d      e        f
1 Afghanistan 1952  8425333 Asia 28.801 779.4453
2 Afghanistan 1957  9240934 Asia 30.332 820.8530
3 Afghanistan 1962 10267083 Asia 31.997 853.1007
4 Afghanistan 1967 11537966 Asia 34.020 836.1971
5 Afghanistan 1972 13079460 Asia 36.088 739.9811
6 Afghanistan 1977 14880372 Asia 38.438 786.1134
~~~

There are a few related ways of retreiving and modifying this information. 
`attributes` will give you both the row and column names, along with the 
class information, while `dimnames` will give you just the rownames and
column names.

In both cases, the output object is stored in a `list`:

~~~ {.r}
str(dimnames(df))
~~~

~~~ {.output}
List of 2
 $ : chr [1:1704] "1" "2" "3" "4" ...
 $ : chr [1:6] "country" "year" "pop" "continent" ...
~~~

### Data Structures

There are five data structures you will commonly encounter in R. These include:

* vector
* factors
* list
* matrix
* data.frame

We've already encountered four of them in this lesson! Let's explore
them in more detail

#### Vectors

A vector is the most common and basic data structure in `R` and is pretty much
the workhorse of R. They are sometimes referred to as atomic vectors, because
importantly, they can only contain one type. They are the building blocks of
every other data structure.

We've seen vectors already when we retrieved the rownames and columnames of 
the gapminder dataset, and when accessing its individual columns!

A vector can contain any of the five types we introduced before:

* logical (e.g., `TRUE`, `FALSE`)
* integer (e.g,, 2L, as.integer(3))
* numeric (real or decimal) (e.g, 2, 2.0, pi)
* complex (e.g, 1 + 0i, 1 + 4i)
* character (e.g, "a", "swc")

> ### Tip: "Character Vectors" {.callout}
>
> You will sometimes hear the term "character vector", especially in
> warning or error messages. This is a somewhat confusing and unfortunate
> name. Remember that the type "character" really means some text
> wrapped in quotation symbols.
>

Create an empty vector with `vector()` or by using the concatenate 
function, `c()`.

~~~ {.r} 
x <- vector()
x
~~~

~~~ {.output}
logical(0) 
~~~

So by default, it creates an empty vector (i.e. a length of 0) of type "logical".

~~~ {.r}
x <- vector(length = 10) # with a predefined length
x
~~~

~~~ {.output}
[1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
~~~

If we count the number of FALSEs there should be 10.

~~~ {.r}
x <- vector("character", length = 10)  # with a predefined length and type
x
~~~

~~~ {.output}
 [1] "" "" "" "" "" "" "" "" "" ""
~~~

Or we can use the concatenate function to combine any values we like into
a vector (so long as they're the same atomic type!).

~~~ {.r}
x <- c(10, 12, 45, 33)
x
~~~

~~~ {.output}
[1] 10 12 45 33
~~~

You can also create vectors as sequence of numbers

~~~ {.r}
series <- 1:10 
series
~~~

~~~ {.output}
 [1]  1  2  3  4  5  6  7  8  9 10
~~~

~~~ {.r}
seq(10) 
~~~

~~~ {.output}
 [1]  1  2  3  4  5  6  7  8  9 10
~~~

~~~ {.r}
seq(1, 10, by = 0.1)
~~~

~~~ {.output}
 [1]  1.0  1.1  1.2  1.3  1.4  1.5  1.6  1.7  1.8  1.9  2.0  2.1  2.2  2.3  2.4
 [16]  2.5  2.6  2.7  2.8  2.9  3.0  3.1  3.2  3.3  3.4  3.5  3.6  3.7  3.8  3.9
 [31]  4.0  4.1  4.2  4.3  4.4  4.5  4.6  4.7  4.8  4.9  5.0  5.1  5.2  5.3  5.4
 [46]  5.5  5.6  5.7  5.8  5.9  6.0  6.1  6.2  6.3  6.4  6.5  6.6  6.7  6.8  6.9
 [61]  7.0  7.1  7.2  7.3  7.4  7.5  7.6  7.7  7.8  7.9  8.0  8.1  8.2  8.3  8.4
 [76]  8.5  8.6  8.7  8.8  8.9  9.0  9.1  9.2  9.3  9.4  9.5  9.6  9.7  9.8  9.9
 [91] 10.0
~~~


> ### Tip {.callout}
>
> When you combine numbers using the concatenate function, `c()` the type
> will automatically become "numeric", that is real/decimal numbers. If you
> specifically want to create a vector of integers (whole numbers only),
> you need to append each number with an L, i.e. `c(10L, 12L, 45L, 33L)`.
>

You can also use the concatenate function to add elements to a vector:

~~~ {.r}
x <- c(x, 57)
x
~~~

~~~ {.output}
[1] 10 12 45 33 57
~~~

> ### Challenge {.challenge}
>
> Vectors can only contain one atomic type. If you try to combine different
> types, R will create a vector that is the least common denominator: the
> type that is easiest to coerce to.
>
> **Guess what the following do without running them first:**
> 
> ~~~ {.r}
> xx <- c(1.7, "a") 
> xx <- c(TRUE, 2) 
> xx <- c("a", TRUE) ```
> ~~~
>

This is called implicit coercion.

The coersion rule goes `logical` -> `integer` -> `numeric` -> `complex` ->
`character`. 

You can also coerce vectors explicitly using the `as.<class_name>`. Example

~~~ {.r}
as.numeric() 
as.character()
~~~~

R will try to do whatever makes the most sense for that value:

~~~ {.r}
as.character(x)
~~~

~~~ {.output}
[1] "0" "1" "2" "3" "4" "5" "6"
~~~

~~~ {.r}
as.complex(x)
~~~

~~~ {.output}
[1] 0+0i 1+0i 2+0i 3+0i 4+0i 5+0i 6+0i
~~~

~~~ {.r}
x <- 0:6 
as.logical(x)
~~~

~~~ {.output}
[1] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
~~~

This is behaviour you will find in many programming languages. 0 is
FALSE, while every other number is treated as TRUE.
Sometimes coercions, especially nonsensical ones won't work.

In some cases, R won't be able to do anything sensible:

~~~ {.r}
x <- c("a", "b", "c") 
as.numeric(x) 
as.logical(x)
~~~ 

~~~ {.output}
[1] NA NA NA
Warning message:
NAs introduced by coercion 
~~~

In both cases, a vector of "NAs" was returned, and in the first case
so was a warning. 

> ### Special Objects {.callout}
>
> "NA" is a special object in R which denotes a missing value. NA can
> occur in any type of vector. There are a few other types of
> special objects: `Inf` denotes infinity (can be positive or negative),
> while `NaN` means Not a number, an undefined value (i.e. `0/0`).
>

Like data.frames, you can ask questions about the structure of vectors:

~~~ {.r}
x <- 0:10
tail(x, n=2) # get the last 'n' elements
~~~

~~~ {.output}
[1] 45 33
~~~

~~~ {.r}
head(x, n=1) # get the first 'n' elements
~~~

~~~ {.output}
[1] 33
~~~

~~~ {.r}
length(x) 
~~~

~~~ {.output}
[1] 4
~~~

~~~ {.r}
str(x)
~~~

~~~ {.output}
 num [1:4] 10 12 45 33
~~~

Like data.frames, vectors can also be named:

~~~ {.r}
names(x) <- c("a", "b", "c", "d")
x
~~~

~~~ {.output}
 a  b  c  d 
 10 12 45 33 
}

> ### Advanced Tip {.callout}
>
> If you're coming from other programming languages you might 
> recognise this as a useful tool akin to dictionaries and hash
> tables. This is true for small vectors, but for true hash table
> functionality, you should use the environment object. See
> `?new.env`.
>

#### Lists

If you want to combine different types of data, you will need to use lists.
Lists act as containers, and can contain any type of data structure, even 
themselves!

Lists can be created using `list` or coerced from other objects using `as.list()`:

~~~ {.r} 
x <- list(1, "a", TRUE, 1+4i)
x
~~~

~~~ {.output}
[[1]]
[1] 1

[[2]]
[1] "a"

[[3]]
[1] TRUE

[[4]]
[1] 1+4i
~~~

Each element of the list is denoted by a `[[` in the output. Inside
each list element is an atomic vector of length one containing 

Lists can contain more complex objects:

~~~ {.r}
xlist <- list(a = "Research Bazaar", b = 1:10, data = head(iris))
xlist
~~~

~~~ {.output}
$a
[1] "Research Bazaar"

$b
 [1]  1  2  3  4  5  6  7  8  9 10

$data
   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
   1          5.1         3.5          1.4         0.2  setosa
   2          4.9         3.0          1.4         0.2  setosa
   3          4.7         3.2          1.3         0.2  setosa
   4          4.6         3.1          1.5         0.2  setosa
   5          5.0         3.6          1.4         0.2  setosa
   6          5.4         3.9          1.7         0.4  setosa
~~~

In this case our list contains a character vector of lenght one,
a numeric vector with 10 entries, and a small data frame from
one of R's many preloaded datasets (see `?data`). We've also given
each list element a name, which is why you see `$a` instead of `[[1]]`.

Lists can also contain themselves:

~~~ {.r}
list(list(list(list())))
~~~

~~~ {.output}
[[1]]
[[1]][[1]]
[[1]][[1]][[1]]
list()
~~~


Lists are extremely useful inside functions. You can "staple" together lots of
different kinds of results into a single object that a function can return. In
fact many R functions which return complex output store their results in a list.

Lets run a basic linear regression on the gapminder dataset:

~~~ {.r}
# What is the relationship between life expectancy and year?
l1 <- lm(lifeExp ~ year, data=gapminder)
~~~

We won't go into too much detail of what I just wrote, but briefly;
the "~" denotes a formula, which means treat the variable on the left of the 
"~" as the left hand side of the equation (or response in this case), and
everything on the right as the right hand side. By telling the linear 
model function to use the gapminder data frame, it knows to look for those
variable names as its columns.

Let's look at the output:

~~~ {.r}
l1
~~~

~~~ {.output}

Call:
lm(formula = lifeExp ~ year, data = df)

Coefficients:
(Intercept)         year  
  -585.6522       0.3259  

~~~

Not much there right? But if we look at the structure...

~~~ {.r}
str(l1)
~~~

~~~ {.output}
List of 12
 $ coefficients : Named num [1:2] -585.652 0.326
  ..- attr(*, "names")= chr [1:2] "(Intercept)" "year"
 $ residuals    : Named num [1:1704] -21.7 -21.8 -21.8 -21.4 -20.9 ...
  ..- attr(*, "names")= chr [1:1704] "1" "2" "3" "4" ...
 $ effects      : Named num [1:1704] -2455.1 232.2 -20.8 -20.5 -20.2 ...
  ..- attr(*, "names")= chr [1:1704] "(Intercept)" "year" "" "" ...
 $ rank         : int 2
 $ fitted.values: Named num [1:1704] 50.5 52.1 53.8 55.4 57 ...
  ..- attr(*, "names")= chr [1:1704] "1" "2" "3" "4" ...
 $ assign       : int [1:2] 0 1
 $ qr           :List of 5
  ..$ qr   : num [1:1704, 1:2] -41.2795 0.0242 0.0242 0.0242 0.0242 ...
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : chr [1:1704] "1" "2" "3" "4" ...
  .. .. ..$ : chr [1:2] "(Intercept)" "year"
  .. ..- attr(*, "assign")= int [1:2] 0 1
  ..$ qraux: num [1:2] 1.02 1.03
  ..$ pivot: int [1:2] 1 2
  ..$ tol  : num 1e-07
  ..$ rank : int 2
  ..- attr(*, "class")= chr "qr"
 $ df.residual  : int 1702
 $ xlevels      : Named list()
 $ call         : language lm(formula = lifeExp ~ year, data = df)
 $ terms        :Classes 'terms', 'formula' length 3 lifeExp ~ year
  .. ..- attr(*, "variables")= language list(lifeExp, year)
  .. ..- attr(*, "factors")= int [1:2, 1] 0 1
  .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. ..$ : chr [1:2] "lifeExp" "year"
  .. .. .. ..$ : chr "year"
  .. ..- attr(*, "term.labels")= chr "year"
  .. ..- attr(*, "order")= int 1
  .. ..- attr(*, "intercept")= int 1
  .. ..- attr(*, "response")= int 1
  .. ..- attr(*, ".Environment")=<environment: R_GlobalEnv> 
  .. ..- attr(*, "predvars")= language list(lifeExp, year)
  .. ..- attr(*, "dataClasses")= Named chr [1:2] "numeric" "numeric"
  .. .. ..- attr(*, "names")= chr [1:2] "lifeExp" "year"
 $ model        :'data.frame':  1704 obs. of  2 variables:
  ..$ lifeExp: num [1:1704] 28.8 30.3 32 34 36.1 ...
  ..$ year   : int [1:1704] 1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
  ..- attr(*, "terms")=Classes 'terms', 'formula' length 3 lifeExp ~ year
  .. .. ..- attr(*, "variables")= language list(lifeExp, year)
  .. .. ..- attr(*, "factors")= int [1:2, 1] 0 1
  .. .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. .. ..$ : chr [1:2] "lifeExp" "year"
  .. .. .. .. ..$ : chr "year"
  .. .. ..- attr(*, "term.labels")= chr "year"
  .. .. ..- attr(*, "order")= int 1
  .. .. ..- attr(*, "intercept")= int 1
  .. .. ..- attr(*, "response")= int 1
  .. .. ..- attr(*, ".Environment")=<environment: R_GlobalEnv> 
  .. .. ..- attr(*, "predvars")= language list(lifeExp, year)
  .. .. ..- attr(*, "dataClasses")= Named chr [1:2] "numeric" "numeric"
  .. .. .. ..- attr(*, "names")= chr [1:2] "lifeExp" "year"
 - attr(*, "class")= chr "lm"
~~~

There's a lot of stuff, stored in nested lists! This is why the structure 
function is really useful, it allows you to see all the data available to
you returned by a function.

For now, we can look at the `summary`:

~~~ {.r}
summary(l1)
~~~

~~~ {.output}
Call:
lm(formula = lifeExp ~ year, data = df)

Residuals:
    Min      1Q  Median      3Q     Max 
-39.949  -9.651   1.697  10.335  22.158 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept) -585.65219   32.31396  -18.12   <2e-16 ***
year           0.32590    0.01632   19.96   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 11.63 on 1702 degrees of freedom
Multiple R-squared:  0.1898,  Adjusted R-squared:  0.1893 
F-statistic: 398.6 on 1 and 1702 DF,  p-value: < 2.2e-16
~~~

As you might expect, life expectancy has slowly been increasing over
time, so we see a significant positive association!

########## TODO

## Matrix

Matrices are a special vector in R. They are not a separate class of object but
simply a vector but now with dimensions added on to it. Matrices have rows and
columns.

``` m <- matrix(nrow = 2, ncol = 2) m dim(m) same as attributes(m) ```

Matrices are constructed columnwise.

``` m <- matrix(1:6, nrow=2, ncol =3) ```

Other ways to construct a matrix

``` m <- 1:10 dim(m) <- c(2,5) ```

This takes a vector and transform into a matrix with 2 rows and 5 columns.


Another way is to bind columns or rows using `cbind()` and `rbind()`.

``` x <- 1:3 y <- 10:12 cbind(x,y) # or rbind(x,y) ```

---


---

## Factors

Factors are special vectors that represent categorical data. Factors can be
ordered or unordered and are important when for modelling functions such as
`aov()`, `lm()` and `glm()` and also in plot methods.

Factors can only contain pre-defined values.

Factors are pretty much integers that have labels on them.  While factors look
(and often behave) like character vectors, they are actually integers under the
hood, and you need to be careful when treating them like strings. Some string
methods will coerce factors to strings, while others will throw an error.

Sometimes factors can be left unordered. Example: male, female

Other times you might want factors to be ordered (or ranked). Example: low,
medium, high.


Underlying it's represented by numbers 1,2,3.


They are better than using simple integer labels because factors are what are
called self describing. male and female is more descriptive than 1s and 2s.
Helpful when there is no additional metadata.

Which is male? 1 or 2? You wouldn't be able to tell with just integer data.
Factors have this information built in.

Factors can be created with `factor()`. Input is a character vector.

``` x <- factor(c("yes", "no", "no", "yes", "yes")) x ```

`table(x)` will return a frequency table.

`unclass(x)` strips out the class information.

In modelling functions, important to know what baseline levels is.  This is the
first factor but by default the ordering is determined by alphabetical order of
words entered. You can change this by specifying the levels.

``` x <- factor(c("yes", "no", "yes"), levels = c("yes", "no")) ``` ## Data
frame

A data frame is a very important data type in R. It's pretty much the de facto
data structure for most tabular data and what we use for statistics.

data frames can have additional attributes such as `rownames()`. This can be
useful for annotating data, like subject_id or sample_id. But most of the time
they are not used.

e.g. `rownames()` useful for annotating data. subject names.  other times they
are not useful.

* Data frames Usually created by read.csv and read.table.

* Can convert to `matrix` with `data.matrix()`

* Coercion will force and not always what you expect.

* Can also create with `data.frame()` function.


With and data frame, you can do `nrow(df)` and `ncol(df)` rownames are usually
1..n.

**Combining data frames**

``` df <- data.frame(id = letters[1:10], x = 1:10, y = rnorm(10))
> df
   id  x          y 1   a  1 -0.3913992 2   b  2 -0.8607609 3   c  3  1.1234612
   4   d  4 -0.8283688 5   e  5 -0.8785586 6   f  6  0.2116839 7   g  7
   -0.3795995 8   h  8 -0.5992272 9   i  9  0.3203085 10  j 10  0.2901185 ```

`cbind(df, data.frame(z = 4))`

When you combine column wise, only row numbers need to match. If you are adding
a vector, it will get repeated.

**Useful functions** `head()` - see first 5 rows `tail()` - see last 5 rows
`dim()` - see dimensions `nrow()` - number of rows `ncol()` - number of columns
`str()` - structure of each column `names()` - will list column names for a
data.frame (or any object really).

A data frame is a special type of list where every element of a list has same
length.

See that it is actually a special list:

    > is.list(iris)
    [1] TRUE
    > class(iris)
    [1] "data.frame"
     >
--

**Naming objects**

Other R objects can also have names not just true for data.frames. Adding names
is helpful since it's useful for readable code and self describing objects.

``` x <- 1:3 names(x) <- c("rich", "daniel", "diego") x ```

Lists can also have names.

``` x <- as.list(1:10) names(x) <- letters[seq(x)] x ```

Finally matrices can have names and these are called `dimnames`

``` m <- matrix(1:4, nrow = 2) dimnames(m) <- list(c("a", "b"), c("c", "d")) #
first element = rownames # second element = colnames ```

---


## Missing values

denoted by `NA` and/or `NaN` for undefined mathematical operations.

``` is.na() is.nan() ```

check for both.

NA values have a class. So you can have both an integer NA and a missing
character NA.

NaN is also NA. But not the other way around.

``` x <- c(1,2, NA, 4, 5) ```

`is.na(x)` returns logical.  shows third

`is.nan(x)` # none are NaN.

``` x <- c(1,2, NA, NaN, 4, 5) ```

`is.na(x)` shows 2 TRUE.  `is.nan(x)` shows 1 TRUE

Missing values are very important in R, but can be very frustrating for new
users.

What do these do?  What should they do?  ``` 1 == NA NA == NA ```

How can we do that sort of comparison?

# Diagnostic functions in R

**Super helpful functions**

* `str()` Compactly display the internal structure of an R object. Perhaps the
  most uesful diagnostic function in R.
* `names()` Names of elements within an object
* `class()` Retrieves the internal class of an object
* `mode()` Get or set the type or storage mode of an object.
* `length()` Retrieve or set the dimension of an object.
* `dim()` Retrieve or set the dimension of an object.
* `R --vanilla` - Allows you to start a clean session of R. A great way to test
  whether your code is reproducible.
* `sessionInfo()` Print version information about R and attached or loaded
  packages.
* `options()` Allow the user to set and examine a variety of global options
  which affect the way in which R computes and displays its results.

`str()` is your best friend

`str` is short for structure. You can use it on any object. Try the following:

```r x <- 1:10 class(x) mode(x) str(x) ```
