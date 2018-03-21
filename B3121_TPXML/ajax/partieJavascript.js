//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function recupererPremierEnfantDeTypeNode(n) {
    var x = n.firstChild;
    while (x.nodeType != 1) { // Test if x is an element node (and not a text node or other)
        x = x.nextSibling;
    }
    return x;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//change le contenu de l'élement avec l'id "nom" avec la chaine de caractéres en paramètre	  
function setNom(nom) {
    var elementHtmlARemplir = window.document.getElementById("id_nom_a_remplacer");
    elementHtmlARemplir.innerHTML = nom;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//charge le fichier XML se trouvant à l'URL relative donné dans le paramètreet le retourne
function chargerHttpXML(xmlDocumentUrl) {

    var httpAjax;

    httpAjax = window.XMLHttpRequest ?
        new XMLHttpRequest() :
        new ActiveXObject('Microsoft.XMLHTTP');

    if (httpAjax.overrideMimeType) {
        httpAjax.overrideMimeType('text/xml');
    }

    //chargement du fichier XML à l'aide de XMLHttpRequest synchrone (le 3° paramètre est défini à false)
    httpAjax.open('GET', xmlDocumentUrl, false);
    httpAjax.send();

    return httpAjax.responseXML;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
// Charge le fichier JSON se trouvant à l'URL donnée en paramètre et le retourne
function chargerHttpJSON(jsonDocumentUrl) {

    var httpAjax;

    httpAjax = window.XMLHttpRequest ?
        new XMLHttpRequest() :
        new ActiveXObject('Microsoft.XMLHTTP');

    if (httpAjax.overrideMimeType) {
        httpAjax.overrideMimeType('text/xml');
    }

    // chargement du fichier JSON à l'aide de XMLHttpRequest synchrone (le 3° paramètre est défini à false)
    httpAjax.open('GET', jsonDocumentUrl, false);
    httpAjax.send();

    var responseData = eval("(" + httpAjax.responseText + ")");

    return responseData;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function Bouton2_ajaxBibliographie(xmlDocumentUrl, xslDocumentUrl, newElementName) {

    var xsltProcessor = new XSLTProcessor();

    // Chargement du fichier XSL à l'aide de XMLHttpRequest synchrone 
    var xslDocument = chargerHttpXML(xslDocumentUrl);

    // Importation du .xsl
    xsltProcessor.importStylesheet(xslDocument);

    // Chargement du fichier XML à l'aide de XMLHttpRequest synchrone 
    var xmlDocument = chargerHttpXML(xmlDocumentUrl);

    // Création du document XML transformé par le XSL
    var newXmlDocument = xsltProcessor.transformToDocument(xmlDocument);

    // Recherche du parent (dont l'id est "here") de l'élément à remplacer dans le document HTML courant
    var elementHtmlParent = window.document.getElementById("id_element_a_remplacer");
    // Premier élément fils du parent
    var elementHtmlARemplacer = recupererPremierEnfantDeTypeNode(elementHtmlParent);
    // Premier élément "elementName" du nouveau document (par exemple, "ul", "table"...)
    var elementAInserer = newXmlDocument.getElementsByTagName(newElementName)[0];

    // Remplacement de l'élément
    elementHtmlParent.replaceChild(elementAInserer, elementHtmlARemplacer);

}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function Bouton3_ajaxEmployees(xmlDocumentUrl) {


    var xmlDocument = chargerHttpXML(xmlDocumentUrl);

    //extraction des noms à partir du document XML (avec une feuille de style ou en javascript)
    var lesNoms = xmlDocument.getElementsByTagName("LastName");

    // Parcours de la liste des noms avec une boucle for et 
    // construction d'une chaine de charactères contenant les noms séparés par des espaces 
    // Pour avoir la longueur d'une liste : attribut 'length'
    // Accès au texte d'un noeud "LastName" : NOM_NOEUD.firstChild.nodeValue
    var chaineDesNoms = "";
    for (i = 0; i < lesNoms.length; i++) {
        if (i > 0) {
            chaineDesNoms = chaineDesNoms + ", ";
        }
        chaineDesNoms = chaineDesNoms + lesNoms[i].firstChild.nodeValue + " ";
    }


    // Appel (ou recopie) de la fonction setNom(...) ou bien autre façon de modifier le texte de l'élément "span"
    setNom(chaineDesNoms);

}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function Bouton4_ajaxEmployeesTableau(xmlDocumentUrl, xslDocumentUrl) {
    //commenter la ligne suivante qui affiche la boîte de dialogue!
    alert("Fonction à compléter...");
}

function setBg(couleur) {
    window.document.getElementById("myBody").style.backgroundColor=couleur;
}

function setTextButtonColor(couleur) {
	window.document.getElementById("ButtonQu1").style.color=couleur;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function afficherInfoPays(xmlDocumentUrl, xslDocumentUrl, newElementName) {

	var nomDuPays = window.document.getElementById("textQu3").value;
	
    var xsltProcessor = new XSLTProcessor();

    // Chargement du fichier XSL à l'aide de XMLHttpRequest synchrone 
    var xslDocument = chargerHttpXML(xslDocumentUrl);

    // Importation du .xsl
    xsltProcessor.importStylesheet(xslDocument);
	
	// Passage du paramètre au fichier .xsl
	xsltProcessor.setParameter(null, "NomPays", nomDuPays);
	
    // Chargement du fichier XML à l'aide de XMLHttpRequest synchrone 
    var xmlDocument = chargerHttpXML(xmlDocumentUrl);

    // Création du document XML transformé par le XSL
    var newXmlDocument = xsltProcessor.transformToDocument(xmlDocument);

    // Recherche du parent (dont l'id est "informationPays") de l'élément à remplacer dans le document HTML courant
    var elementHtmlParent = window.document.getElementById("informationPays");
    // Premier élément fils du parent
    var elementHtmlARemplacer = recupererPremierEnfantDeTypeNode(elementHtmlParent);
    // Premier élément "newElementName" du nouveau document (ici 'newElementName')
    var elementAInserer = newXmlDocument.getElementsByTagName(newElementName)[0];

    // Remplacement de l'élément
    elementHtmlParent.replaceChild(elementAInserer, elementHtmlARemplacer);

}

function setImg(sourceImage) {
	
	
	var monImage = chargerHttpXML(sourceImage);
	// Recherche du parent (dont l'id est "imageSvg") de l'élément à remplacer dans le document HTML courant
    var elementHtmlParent = window.document.getElementById("imageSvg");
    // Premier élément fils du parent
    var elementHtmlARemplacer = recupererPremierEnfantDeTypeNode(elementHtmlParent);
    // Premier élément "svg" du nouveau document (ici 'svg')
    var elementAInserer = monImage.getElementsByTagName("svg")[0];

    // Remplacement de l'élément
    elementHtmlParent.replaceChild(elementAInserer, elementHtmlARemplacer);
	
}

function imgClickable(){
	var imgSvg = window.document.getElementById("imageSvg");
	
    var lesFormes = imgSvg.getElementsByTagName("g")[0]; // Rend forcement un tableau (tagName)

    for (i = 0; i < lesFormes.children.length; i++) {
		lesFormes.children[i].addEventListener("click",afficherTitle,false);
    }
}

function afficherTitle() {
    // this represente sur quoi l'event a ete rattache
    setTitleForme(this.getAttribute("title"));
}

function setTitleForme(laForme) {
    var elementHtmlARemplir = window.document.getElementById("forme");
    elementHtmlARemplir.innerHTML = laForme;
}

function imgMouse() {
	var imgSvg = window.document.getElementById("imageSvg");
	
    var lesPays = imgSvg.getElementsByTagName("g")[0]; // Rend forcement un tableau (tagName)
   
    for (i = 0; i < lesPays.children.length; i++) {
		lesPays.children[i].addEventListener("mouseover",modifierPays,false);
		lesPays.children[i].addEventListener("mouseleave",remettrePays,false);
		
    }
}

function remettrePays() {
	this.style.fill = "#CCCCCC";

    // Recherche du parent (dont l'id est "payscapitale") de l'élément à remplacer dans le document HTML courant
    var elementHtmlParent = window.document.getElementById("payscapitale");
    // Premier élément fils du parent
    var elementHtmlARemplacer = recupererPremierEnfantDeTypeNode(elementHtmlParent);
    var elementAInserer = "<table border='3' width='600px' align='center'><tr >"
				+"<td style='text-align:center'>Pays</td>"
				+"<td style='text-align:center'>Capitale</td>"
				+"<td style='text-align:center'><img id='emplacementDrapeau' src='' alt=''/>Drapeau</td>"
			+"</tr>"
		+"</table>";

    // Remplacement de l'élément
    elementHtmlParent.replaceChild(elementAInserer, elementHtmlARemplacer);
	
}

function modifierPays() {
	
	var nomTitle = this.getAttribute("title");
	
	var xsltProcessor = new XSLTProcessor();

    // Chargement du fichier XSL à l'aide de XMLHttpRequest synchrone 
    var xslDocument = chargerHttpXML("infos_pays.xsl");

    // Importation du .xsl
    xsltProcessor.importStylesheet(xslDocument);
	
	// Passage du paramètre au fichier .xsl
	xsltProcessor.setParameter(null, "NomPays", nomTitle);
	
    // Chargement du fichier XML à l'aide de XMLHttpRequest synchrone 
    var xmlDocument = chargerHttpXML("countriesTP_ajax_infosPays.xml");

    // Création du document XML transformé par le XSL
    var newXmlDocument = xsltProcessor.transformToDocument(xmlDocument);

    // Recherche du parent (dont l'id est "payscapitale") de l'élément à remplacer dans le document HTML courant
    var elementHtmlParent = window.document.getElementById("payscapitale");
    // Premier élément fils du parent
    var elementHtmlARemplacer = recupererPremierEnfantDeTypeNode(elementHtmlParent);
    // Premier élément "span" du nouveau document (ici span)
    var elementAInserer = newXmlDocument.getElementsByTagName("span")[0];

    // Remplacement de l'élément
    elementHtmlParent.replaceChild(elementAInserer, elementHtmlARemplacer);
	
	this.style.fill="red";
}


