
graphicLevel = 2;
activeView = "master";
element = null;
schema = null;
graphicContext = null;

function init(inElement) {

	// di hihlangkan agar tidak menggangu graphic view
	// graphicContext = window.parent.frames[1].getGraphicContext();
	// displayGraphicContext();

	element = inElement;
	document.getElementById("graphicLevel").innerHTML = graphicLevel;
	displayXSDGraphic(inElement, graphicContext);
}

function levelSet(level, inElement) {
	if (level < 1) {
		level = 1;
	}
	if (level > 6) {
		level = 6;
	}
	graphicLevel = level;
	document.getElementById("graphicLevel").innerHTML = graphicLevel;
}


function displayGraphicContext() {
	if (graphicContext != null)
		document.getElementById("graphicContext").innerHTML = "Context of: " + graphicContext;
	else
		document.getElementById("graphicContext").innerHTML = "";
}

function changeLevel(changeValue) {
	levelSet(graphicLevel + changeValue);

	if (activeView == "master")
		displayXSDGraphic(element, null);
	if (activeView == "flat")
		displayXSDGraphicFlat(element, schema);
}

function loadXMLDoc(fname) {
	var xmlDoc;
	if (document.implementation && document.implementation.createDocument) {
		xmlDoc = document.implementation.createDocument("", "", null);
	}
	else {
		alert('Your browser cannot handle this script');
	}
	try {
		;
		xmlDoc.async = false;
		xmlDoc.load(fname);
		return (xmlDoc);
	}
	catch (e) {
		try //Google Chrome
		{
			var xmlhttp = new top.XMLHttpRequest();
			xmlhttp.open("GET", fname, false);
			xmlhttp.send(null);
			xmlDoc = xmlhttp.responseXML.documentElement;
			return (xmlDoc);
		}
		catch (e) {
			error = e.message;
		}
	}
}

function displayXSDGraphic(startElement, context) {
	activeView = "master";

	if (context == null) {
		graphicContext = null;
		displayGraphicContext();
		wx = window;
		if (window.parent.frames[1] && window.parent.frames[1].name) {
			window.parent.frames[1].setGraphicContext(null)
		};
	}
	if (graphicContext != null)
		displayXSDGraphicFlat(startElement, graphicContext);
	else {
		if (document.implementation && document.implementation.createDocument && typeof XSLTProcessor != 'undefined') {
			xml = loadXMLDoc("../xml_schema_viewer/xsd_graphic.xml");
			// let url = new URL(xml.owner	Document.baseURI);
			// let origin = url.origin;
			let origin = window.location.origin;
			let inner = `<start-element>${startElement}</start-element><max-level>${graphicLevel}</max-level><origin>${origin}</origin>`;
			top.xml = xml;
			xml.innerHTML = inner;

			let grapContainer = document.getElementById('XSDGraphic');
			let text = `<?xml version="1.0" encoding="UTF-8"?><?xml-stylesheet type="text/xsl" href="http://localhost:1020/xml_schema_viewer/xsd_graphic.xsl"?>` + xml.outerHTML;
			let blob = new Blob([text], { type: "text/xml" });
			let bloburl = URL.createObjectURL(blob);
			let iframe = document.createElement('iframe');
			iframe.name = 'xsdgraph';
			iframe.style.border = 'none';
			grapContainer.appendChild(iframe)
			iframe.src = bloburl;

			console.log(iframe.contentDocument, iframe.contentDocument.firstElementChild)

			iframe.contentDocument.addEventListener('load', () => {
				console.log('aa');
				iframe.style.width = '100%';
				iframe.style.height = iframe.contentDocument.body.scrollHeight + 'px';
			})	
			iframe.style.width = '100%';
			iframe.style.height = iframe.contentDocument.body.scrollHeight + 'px';

			return;
		}

		// script if use PHP
		// var xhr = new window.XMLHttpRequest;
		// xhr.open("GET",`/displayXSDGraphic.php?startElement=${startElement}&graphicLevel=${graphicLevel}`,false);
		// xhr.send(null);

		// window.doc = xhr.responseXML;
		// var node = xhr.responseXML.documentElement.cloneNode(true);
		// var imported = document.importNode(node,true);

		// document.getElementById("XSDGraphic").innerHTML = "";
		// var node = doc.documentElement.cloneNode(true);
		// var imported = document.importNode(node, true);
		// imported = imported.outerHTML.replace(/xmlns:\w+="\S+"/gm,'')
		// document.getElementById("XSDGraphic").innerHTML = imported;
		return;
	}
}

function displayXSDGraphicFlat(startElement, schemaFile) {
	activeView = "flat";

	graphicContext = schemaFile;
	displayGraphicContext();
	window.parent.frames[1].setGraphicContext(schemaFile);

	schema = schemaFile;

	// Code for chrome, firefox etc.
	if (document.implementation && document.implementation.createDocument && typeof XSLTProcessor != 'undefined') {
		xml = loadXMLDoc("../xml_schema_viewer/xsd_graphic_flat.xml");
		// xml=loadXMLDoc("./Files/xml_schema_viewer/xsd_graphic_flat.xml");
		xsl = loadXMLDoc("../xml_schema_viewer/xsd_graphic_flat.xsl");
		// xsl=loadXMLDoc("./Files/xml_schema_viewer/xsd_graphic_flat.xsl");
		xsltProcessor = new XSLTProcessor();
		xsltProcessor.importStylesheet(xsl);
		xsltProcessor.setParameter(null, "startElement", startElement);
		xsltProcessor.setParameter(null, "maxLevel", graphicLevel);
		xsltProcessor.setParameter(null, "flatSchema", schemaFile);


		resultDocument = xsltProcessor.transformToFragment(xml, document);
		document.getElementById("XSDGraphic").innerHTML = ""
		document.getElementById("XSDGraphic").appendChild(resultDocument);
	}
	else {
		try {	 // IE
			var xml = new ActiveXObject("Microsoft.XMLDOM");
			var xsl = new ActiveXObject("MSXML2.FreeThreadedDOMDocument");
			xml.load("../xml_schema_viewer/xsd_graphic_flat.xml");
			// xml.load("./Files/xml_schema_viewer/xsd_graphic_flat.xml");
			xsl.load("../xml_schema_viewer/xsd_graphic_flat.xsl");
			// xsl.load("./Files/xml_schema_viewer/xsd_graphic_flat.xsl");
			var processor = new ActiveXObject("Msxml2.XSLTemplate");
			processor.stylesheet = xsl;
			var objXSLTProc = processor.createProcessor();
			objXSLTProc.input = xml;
			objXSLTProc.addParameter("startElement", startElement);
			objXSLTProc.addParameter("maxLevel", graphicLevel);
			objXSLTProc.addParameter("flatSchema", schemaFile);
			objXSLTProc.transform();
			document.getElementById("XSDGraphic").innerHTML = objXSLTProc.output;
		}
		catch (e) {
			if (typeof console != "undefined") {
				console.log('transformxml: no browser support');
			}
			return null;
		}
	}
}


