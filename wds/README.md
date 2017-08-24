wds_catalog
============


WDS catalog of double stars in different formats

Details about how it was made are in the main code file `wds_catalog.R`

Format of the WDS file can be found here: [wds format](http://ad.usno.navy.mil/wds/Webtextfiles/wdsweb_format.txt)

The catalog was imported in excel making a copy-paste into sublime-text app of the web page [WDS catalog](http://ad.usno.navy.mil/wds/Webtextfiles/wdsweb_summ2.txt)
Save the file (this file was saved here as `/csv/wds_catalog.txt`) and change the header to fit the fixed-space rows (read format in [wds format](http://ad.usno.navy.mil/wds/Webtextfiles/wdsweb_format.txt) ).

Then the import is done choosing the right columns separation following the format and the result is `/excel/wds_catalog.xlsx`. 
Saving that file as csv makes possible to play with it using `R`. See code details in `/Rcode/wds_catalog.R`.   
There there are some scripts to generate `skysafari` observation lists, which is extremely useful to plan and make star gazing nights.

Some scripts here make double stars selections that can be seen with binoculars. Change the code to make your own list !! :-)

Here a post thread about WDS catalog in csv, where there is a link to this repo: [cloudy nights wds csv](https://www.cloudynights.com/topic/444854-wds-catalog-in-csv-format/)

SkySafari Observation Lists
-----------------------------

Some links to understand better the format of those lists:

* http://skysafariastronomy.com/support/manual/observing_lists.shtml
* http://www.southernstars.com/support/faq/skysafari.html

File `/Rcode/wds_catalog.R` will transform the csv file into a `skysafari` observation list.
The trick is that we only need the `WDS NAME` field (the first one) of the data-base and sky-safari will fill the information with it.
Here is an example of an observation list with 2 stars:

```
SkySafariObservingListVersion=3.0
SkyObject=BeginObject
	ObjectID=2,-1,-1
	CatalogNumber=WDS 00315-6257
EndObject=SkyObject
SkyObject=BeginObject
	ObjectID=2,-1,-1
	CatalogNumber=WDS 00567+6043
EndObject=SkyObject
SkyObject=BeginObject
	ObjectID=2,-1,-1
	CatalogNumber=WDS 01496-1041
EndObject=SkyObject
```

So this is what the simple script is doing: passing from `00315-6257` to:

```
SkyObject=BeginObject
	ObjectID=2,-1,-1
	CatalogNumber=WDS 00315-6257
EndObject=SkyObject
```

See `/Rcode/wds_catalog.R` for details.

Not all the WDS stars are imported into skysafari, and some of them do not have the same properties (like separation and magnitude) than the ones in the data-base...

