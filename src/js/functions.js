

var graphicContext = null;

var windowObjectReference;
var strWindowFeatures = "resizable,,scrollbars,width=500,height=600";
var strWindowFeatures2 = "toolbar=0,scrollbars=0,location=1,statusbar=0,menubar=0,resizable=0,width=300,height=450";
var strWindowFeatures3 = "menubar=0,location=0,resizable=yes,scrollbars=yes,status=0,width=500,height=700";

function setGraphicContext (context) {
	if(context != null && context.indexOf(".xsd") == -1)
		window.parent.frames[1].graphicContext = context+".xsd";
	else
		window.parent.frames[1].graphicContext = context;
}

function getGraphicContext () {
	return graphicContext;
}


/* ------------------------------------------------------------------------------------------------
-	Function showHideBlock
-
- Show or hide a block
------------------------------------------------------------------------------------------------ */
function showHideBlock(blockId) {
	if(window.document.getElementById(blockId).style.display == "none") {
		window.document.getElementById(blockId).style.display = "block";
	}
	else {
		window.document.getElementById(blockId).style.display = "none";
	}
}

/* ------------------------------------------------------------------------------------------------
-	Function showHideBlock2
-
- Show or hide a block
------------------------------------------------------------------------------------------------ */
function showHideBlock2(blockId) {
	var imgId = 'img_'+blockId;
	var windUrl = window.parent.frames[2].location.pathname;
	
	if(window.document.getElementById(blockId).style.display == "none") {
		window.document.getElementById(blockId).style.display = "block";
		window.document.getElementById(imgId).src = origin + "/img/bluearrow_down.png";
		//window.open(origin + window.location.protocol+window.location.pathname+"#"+blockId, "content");
		// window.open(origin + "file://"+windUrl+"#"+blockId, "content");
	}
	else {
		window.document.getElementById(blockId).style.display = "none";
		window[imgId].src = "../img/bluearrow_left.png";
	}
}

/* ------------------------------------------------------------------------------------------------
-	Function showHideBlock3
-
- Show or hide a block
------------------------------------------------------------------------------------------------ */
function showHideBlock3(blockId, schemaContext) {
	var imgId = 'img_'+blockId;
	var windUrl = window.parent.frames[2].location.pathname;
	
	if(window.document.getElementById(blockId).style.display == "none") {
		window.document.getElementById(blockId).style.display = "block";
		window.document.getElementById(imgId).src = origin + "/img/bluearrow_down.png";
		// window.open(window.location.protocol+window.location.pathname+"#"+blockId, "content");
		// window.open(origin + "file://"+windUrl+"#"+blockId, "content");
	}
	else {
		window.document.getElementById(blockId).style.display = "none";
		window[imgId].src = origin + "/img/bluearrow_left.png";
	}
	
	setGraphicContext(schemaContext);
}


/* ------------------------------------------------------------------------------------------------
-	Function moveTo
-
- 
------------------------------------------------------------------------------------------------ */
function moveTo(blockId) {
	// var windUrl = window.parent.frames[2].location.pathname;
  // console.log(window.location.protocol + "/"+window.location.pathname+"#"+blockId);
	// window.open(window.location.protocol + "/"+window.location.pathname+"#"+blockId, "content");
	// window.open("file://"+windUrl+"#"+blockId, "content");
}

/* ------------------------------------------------------------------------------------------------
-	Function launchDD
-
- Open data dictionary
------------------------------------------------------------------------------------------------ */
function launchDD(type) {
	if(type == "schema") {
		window.open(origin + "/toc/tocSchema.xml", "toc");
		window.open(origin + "/toc/tocSchemaOpen.xml", "content");
	}
	if(type == "elem") {
		window.open(origin + "/toc/tocElem.xml", "toc");
		window.open(origin + "/toc/tocElemOpen.xml", "content");
	}
	if(type == "att") {
		window.open(origin + "/toc/tocAtt.xml", "toc");
		window.open(origin + "/toc/tocAttOpen.xml", "content");
	}
}

/* ------------------------------------------------------------------------------------------------
-	Function returnToList
-
- 
------------------------------------------------------------------------------------------------ */
function returnToList(type) {
	if(type == "elem") {
		window.open(origin + "/toc/tocElemOpen.xml", "content");
	}
	else {
		window.open(origin + "/toc/tocAttOpen.xml", "content");
	}
}

/* ------------------------------------------------------------------------------------------------
-	Function openDD
-
- Open data dictionary
------------------------------------------------------------------------------------------------ */
function openDD(targetId) {
	//window.open("./dd.xml#"+targetId, "content");
	//window.parent["content"][targetId].style.display = "block";	
	
	window.open(origin + "/" + targetId+".xml", "content");
}

/* ------------------------------------------------------------------------------------------------
-	Function load
-
- Loading of data dictionary
------------------------------------------------------------------------------------------------ */
function load() {
	waitF.close();	
}


/* ------------------------------------------------------------------------------------------------
-	Function home
-
- Loading of home frame
------------------------------------------------------------------------------------------------ */
function home() {
	window.open(origin + "/toc.xml", "toc");
	window.open(origin + "/frontpage.xml", "content");
}

/* ------------------------------------------------------------------------------------------------
-	Function about
-
- Loading of about frame
------------------------------------------------------------------------------------------------ */
function about() {
	showModalDialog("./About.html", "", "status:no");	
}

/* ------------------------------------------------------------------------------------------------
-	Function disclaimer
-
- Loading of disclaimer frame
------------------------------------------------------------------------------------------------ */
function disclaimer_org() {
	showModalDialog("./Disclaimer.html", "", "status:no");	
}

/* ------------------------------------------------------------------------------------------------
-
-
- Loading of contact frame
------------------------------------------------------------------------------------------------ */
function contact() {
	showModalDialog("./Contact.html", "", "status:no");	
}

/* ------------------------------------------------------------------------------------------------
-
-
- generic function as firefox does not support showModalDialog any more
------------------------------------------------------------------------------------------------ */
function popup(URL) {
w = window.open(URL, "", strWindowFeatures);
}
