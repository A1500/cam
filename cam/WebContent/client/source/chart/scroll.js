//mapApp.js start
//this mapApp object helps to convert clientX/clientY coordinates to the coordinates of the group where the element is within
//normally one can just use .getScreenCTM(), but ASV3 does not implement it, 95% of the code in this function is for ASV3!!!
//credits: Kevin Lindsey for his example at http://www.kevlindev.com/gui/utilities/viewbox/ViewBox.js
function mapApp(adjustVBonWindowResize,resizeCallbackFunction) {
	this.adjustVBonWindowResize = adjustVBonWindowResize;
	this.resizeCallbackFunction = resizeCallbackFunction;
	this.initialized = false;
	if (!document.documentElement.getScreenCTM) {
		//add zoom and pan event event to document element
		//this part is only required for viewers not supporting document.documentElement.getScreenCTM() (e.g. ASV3)
		document.documentElement.addEventListener("SVGScroll",this,false);
		document.documentElement.addEventListener("SVGZoom",this,false);
	}
	//add SVGResize event, note that because FF does not yet support the SVGResize event, there is a workaround
 	try {
  		//browsers with native SVG support
  		window.addEventListener("resize",this,false);
 	}
	catch(er) {
		//SVG UAs, like Batik and ASV/Iex
		document.documentElement.addEventListener("SVGResize",this,false);
	}
	//determine the browser main version
	this.navigator = "Batik";
	if (window.navigator) {
		if (window.navigator.appName.match(/Adobe/gi)) {
			this.navigator = "Adobe";
		}
		if (window.navigator.appName.match(/Netscape/gi)) {
			this.navigator = "Mozilla";
		}
		if (window.navigator.userAgent) {
			if (window.navigator.userAgent.match(/Opera/gi)) {
				this.navigator = "Opera";
			}
			if (window.navigator.userAgent.match(/AppleWebKit/gi) || window.navigator.userAgent.match(/Safari/gi) ) {
				this.navigator = "Safari";
			}
		}
	}
	//we need to call this once to initialize this.innerWidth/this.innerHeight
	this.resetFactors();
	//per default, tooltips are disabled
	this.tooltipsEnabled = false;
	//create new arrays to hold GUI references
	this.Windows = new Array();
	this.checkBoxes = new Array();
	this.radioButtonGroups = new Array();
	this.tabgroups = new Array();
	this.textboxes = new Array();
	this.buttons = new Array();	
	this.selectionLists = new Array();	
	this.comboboxes = new Array();	
	this.sliders = new Array();
	this.scrollbars = new Array();
	this.colourPickers = new Array();
	this.htmlAreas = new Array();
	this.tables = new Array();
}

mapApp.prototype.handleEvent = function(evt) {
	if (evt.type == "SVGResize" || evt.type == "resize" || evt.type == "SVGScroll" || evt.type == "SVGZoom") {
		this.resetFactors();
	}
	if ((evt.type == "mouseover" || evt.type == "mouseout" || evt.type == "mousemove") && this.tooltipsEnabled) {
		this.displayTooltip(evt);
	}
}

mapApp.prototype.resetFactors = function() {
	//set inner width and height
	if (window.innerWidth) {
		this.innerWidth = window.innerWidth;
		this.innerHeight = window.innerHeight;
	}
	else {
		var viewPort = document.documentElement.viewport;
		this.innerWidth = viewPort.width;
		this.innerHeight = viewPort.height;
	}
	if (this.adjustVBonWindowResize) {
		this.adjustViewBox();
	}
	//this code is for ASV3
	if (!document.documentElement.getScreenCTM) {
		var svgroot = document.documentElement;
		this.viewBox = new ViewBox(svgroot);
		var trans = svgroot.currentTranslate;
		var scale = svgroot.currentScale;
		this.m = this.viewBox.getTM();
		//undo effects of zoom and pan
		this.m = this.m.scale( 1/scale );
		this.m = this.m.translate(-trans.x, -trans.y);
	}
	if (this.resizeCallbackFunction && this.initialized) {
		if (typeof(this.resizeCallbackFunction) == "function") {
			this.resizeCallbackFunction();
		}
	}
	this.initialized = true;
}

//set viewBox of document.documentElement to innerWidth and innerHeight
mapApp.prototype.adjustViewBox = function() {
	document.documentElement.setAttributeNS(null,"viewBox","0 0 "+this.innerWidth+" "+this.innerHeight);
}

mapApp.prototype.calcCoord = function(evt,ctmNode) {
	var svgPoint = document.documentElement.createSVGPoint();
	svgPoint.x = evt.clientX;
	svgPoint.y = evt.clientY;
	if (!document.documentElement.getScreenCTM) {
		//undo the effect of transformations
		if (ctmNode) {
			var matrix = getTransformToRootElement(ctmNode);
		}
		else {
			var matrix = getTransformToRootElement(evt.target);			
		}
  		svgPoint = svgPoint.matrixTransform(matrix.inverse().multiply(this.m));
	}
	else {
		//case getScreenCTM is available
		if (ctmNode) {
			var matrix = ctmNode.getScreenCTM();
		}
		else {
			var matrix = evt.target.getScreenCTM();		
		}
  	svgPoint = svgPoint.matrixTransform(matrix.inverse());
	}
  //undo the effect of viewBox and zoomin/scroll
	return svgPoint;
}

mapApp.prototype.calcInvCoord = function(svgPoint) {
	if (!document.documentElement.getScreenCTM) {
		var matrix = getTransformToRootElement(document.documentElement);
	}
	else {
		var matrix = document.documentElement.getScreenCTM();
	}
	svgPoint = svgPoint.matrixTransform(matrix);
	return svgPoint;
}

//initialize tootlips
mapApp.prototype.initTooltips = function(groupId,tooltipTextAttribs,tooltipRectAttribs,xOffset,yOffset,padding) {
	var nrArguments = 6;
	if (arguments.length == nrArguments) {
		this.toolTipGroup = document.getElementById(groupId);
		this.tooltipTextAttribs = tooltipTextAttribs;
		if (!this.tooltipTextAttribs["font-size"]) {
			this.tooltipTextAttribs["font-size"] = 12;
		}	
		this.tooltipRectAttribs = tooltipRectAttribs;
		this.xOffset = xOffset;
		this.yOffset = yOffset;
		this.padding = padding;
		if (!this.toolTipGroup) {
			alert("Error: could not find tooltip group with id '"+groupId+"'. Please specify a correct tooltip parent group id!");
		}
		else {
			//set tooltip group to invisible
			this.toolTipGroup.setAttributeNS(null,"visibility","hidden");
			this.toolTipGroup.setAttributeNS(null,"pointer-events","none");
			this.tooltipsEnabled = true;
			//create tooltip text element
			this.tooltipText = document.createElementNS(svgNS,"text");
			for (var attrib in this.tooltipTextAttribs) {
				value = this.tooltipTextAttribs[attrib];
				if (attrib == "font-size") {
					value += "px";
				}
				this.tooltipText.setAttributeNS(null,attrib,value);
			}
			//create textnode
			var textNode = document.createTextNode("Tooltip");
			this.tooltipText.appendChild(textNode);
			this.toolTipGroup.appendChild(this.tooltipText);
			var bbox = this.tooltipText.getBBox();
			this.tooltipRect = document.createElementNS(svgNS,"rect");
			this.tooltipRect.setAttributeNS(null,"x",bbox.x-this.padding);
			this.tooltipRect.setAttributeNS(null,"y",bbox.y-this.padding);
			this.tooltipRect.setAttributeNS(null,"width",bbox.width+this.padding*2);
			this.tooltipRect.setAttributeNS(null,"height",bbox.height+this.padding*2);
			for (var attrib in this.tooltipRectAttribs) {
				this.tooltipRect.setAttributeNS(null,attrib,this.tooltipRectAttribs[attrib]);
			}
			this.toolTipGroup.insertBefore(this.tooltipRect,this.tooltipText);
		}
	}
	else {
			alert("Error in method 'initTooltips': wrong nr of arguments! You have to pass over "+nrArguments+" parameters.");			
	}
}

mapApp.prototype.addTooltip = function(tooltipNode,tooltipTextvalue,followmouse,checkForUpdates,targetOrCurrentTarget,childAttrib) {
	var nrArguments = 6;
	if (arguments.length == nrArguments) {
		//get reference
		if (typeof(tooltipNode) == "string") {
			tooltipNode = document.getElementById(tooltipNode);
		}
		//check if tooltip attribute present or create one
		if (!tooltipNode.hasAttributeNS(attribNS,"tooltip")) {
			if (tooltipTextvalue) {
				tooltipNode.setAttributeNS(attribNS,"tooltip",tooltipTextvalue);
			}
			else {
				tooltipNode.setAttributeNS(attribNS,"tooltip","Tooltip");			
			}
		}
		//see if we need updates
		if (checkForUpdates) {
			tooltipNode.setAttributeNS(attribNS,"tooltipUpdates","true");		
		}
		//see if we have to use evt.target
		if (targetOrCurrentTarget == "target") {
			tooltipNode.setAttributeNS(attribNS,"tooltipParent","true");
		}
		//add childAttrib
		if (childAttrib) {
			tooltipNode.setAttributeNS(attribNS,"tooltipAttrib",childAttrib);
		}
		//add event listeners
		tooltipNode.addEventListener("mouseover",this,false);
		tooltipNode.addEventListener("mouseout",this,false);
		if (followmouse) {
			tooltipNode.addEventListener("mousemove",this,false);
		}
	}
	else {
		alert("Error in method 'addTooltip()': wrong nr of arguments! You have to pass over "+nrArguments+" parameters.");			
	}
}

mapApp.prototype.displayTooltip = function(evt) {
	var curEl = evt.currentTarget;
	var coords = this.calcCoord(evt,this.toolTipGroup.parentNode);
	if (evt.type == "mouseover") {
		this.toolTipGroup.setAttributeNS(null,"visibility","visible");
		this.toolTipGroup.setAttributeNS(null,"transform","translate("+(coords.x+this.xOffset)+","+(coords.y+this.yOffset)+")");
		this.updateTooltip(evt);
	}
	if (evt.type == "mouseout") {
		this.toolTipGroup.setAttributeNS(null,"visibility","hidden");
	}
	if (evt.type == "mousemove") {
		this.toolTipGroup.setAttributeNS(null,"transform","translate("+(coords.x+this.xOffset)+","+(coords.y+this.yOffset)+")");		
		if (curEl.hasAttributeNS(attribNS,"tooltipUpdates")) {
			this.updateTooltip(evt);
		}
	}
}

mapApp.prototype.updateTooltip = function(evt) {
	var el = evt.currentTarget;
	if (el.hasAttributeNS(attribNS,"tooltipParent")) {
		var attribName = "tooltip";
		if (el.hasAttributeNS(attribNS,"tooltipAttrib")) {
			attribName = el.getAttributeNS(attribNS,"tooltipAttrib");
		}
		el = evt.target;
		var myText = el.getAttributeNS(attribNS,attribName);
	}
	else {
		var myText = el.getAttributeNS(attribNS,"tooltip");
	}
	if (myText) {
		var textArray = myText.split("\\n");
		while(this.tooltipText.hasChildNodes()) {
			this.tooltipText.removeChild(this.tooltipText.lastChild);
		}
		for (var i=0;i<textArray.length;i++) {
			var tspanEl = document.createElementNS(svgNS,"tspan");
			tspanEl.setAttributeNS(null,"x",0);
			var dy = this.tooltipTextAttribs["font-size"];
			if (i == 0) {
				var dy = 0;
			}
			tspanEl.setAttributeNS(null,"dy",dy);
			var textNode = document.createTextNode(textArray[i]);
			tspanEl.appendChild(textNode);
			this.tooltipText.appendChild(tspanEl);
		}
		// set text and rect attributes
		var bbox = this.tooltipText.getBBox();
		this.tooltipRect.setAttributeNS(null,"x",bbox.x-this.padding);
		this.tooltipRect.setAttributeNS(null,"y",bbox.y-this.padding);
		this.tooltipRect.setAttributeNS(null,"width",bbox.width+this.padding*2);
		this.tooltipRect.setAttributeNS(null,"height",bbox.height+this.padding*2);	
	}
	else {
		this.toolTipGroup.setAttributeNS(null,"visibility","hidden");	
	}
}

mapApp.prototype.enableTooltips = function() {
	this.tooltipsEnabled = true;
}

mapApp.prototype.disableTooltips = function() {
	this.tooltipsEnabled = false;
	this.toolTipGroup.setAttributeNS(null,"visibility","hidden");
}

/*************************************************************************/

/*****
*
*   ViewBox.js
*
*   copyright 2002, Kevin Lindsey
*
*****/

ViewBox.VERSION = "1.0";


/*****
*
*   constructor
*
*****/
function ViewBox(svgNode) {
    if ( arguments.length > 0 ) {
        this.init(svgNode);
    }
}


/*****
*
*   init
*
*****/
ViewBox.prototype.init = function(svgNode) {
    var viewBox = svgNode.getAttributeNS(null, "viewBox");
    var preserveAspectRatio = svgNode.getAttributeNS(null, "preserveAspectRatio");
    
    if ( viewBox != "" ) {
        var params = viewBox.split(/\s*,\s*|\s+/);

        this.x      = parseFloat( params[0] );
        this.y      = parseFloat( params[1] );
        this.width  = parseFloat( params[2] );
        this.height = parseFloat( params[3] );
    } else {
        this.x      = 0;
        this.y      = 0;
        this.width  = innerWidth;
        this.height = innerHeight;
    }
    
    this.setPAR(preserveAspectRatio);
    var dummy = this.getTM(); //to initialize this.windowWidth/this.windowHeight
};


/*****
*
*   getTM
*
*****/
ViewBox.prototype.getTM = function() {
    var svgRoot      = document.documentElement;
    var matrix       = document.documentElement.createSVGMatrix();
		//case width/height contains percent
    this.windowWidth = svgRoot.getAttributeNS(null,"width");
    if (this.windowWidth.match(/%/) || this.windowWidth == null) {
    	if (this.windowWidth == null) {
    		if (window.innerWidth) {
    			this.windowWidth = window.innerWidth;
    		}
    		else {
    			this.windowWidth = svgRoot.viewport.width;
    		}
    	}
    	else {
    		var factor = parseFloat(this.windowWidth.replace(/%/,""))/100;
    		if (window.innerWidth) {
    			this.windowWidth = window.innerWidth * factor;
    		}
    		else {
    			this.windowWidth = svgRoot.viewport.width * factor;
    		}
    	}
    }
    else {
    	this.windowWidth = parseFloat(this.windowWidth);
    }
    this.windowHeight = svgRoot.getAttributeNS(null,"height");
    if (this.windowHeight.match(/%/) || this.windowHeight == null) {
    	if (this.windowHeight == null) {
    		if (window.innerHeight) {
    			this.windowHeight = window.innerHeight;
    		}
    		else {
    			this.windowHeight = svgRoot.viewport.height;
    		}
    	}
    	else {
    		var factor = parseFloat(this.windowHeight.replace(/%/,""))/100;
    		if (window.innerHeight) {
    			this.windowHeight = window.innerHeight * factor;
    		}
    		else {
    			this.windowHeight = svgRoot.viewport.height * factor;
    		}
    	}
    }
    else {
    	this.windowHeight = parseFloat(this.windowHeight);
    }
    var x_ratio = this.width  / this.windowWidth;
    var y_ratio = this.height / this.windowHeight;

    matrix = matrix.translate(this.x, this.y);
    if ( this.alignX == "none" ) {
        matrix = matrix.scaleNonUniform( x_ratio, y_ratio );
    } else {
        if ( x_ratio < y_ratio && this.meetOrSlice == "meet" ||
             x_ratio > y_ratio && this.meetOrSlice == "slice"   )
        {
            var x_trans = 0;
            var x_diff  = this.windowWidth*y_ratio - this.width;

            if ( this.alignX == "Mid" )
                x_trans = -x_diff/2;
            else if ( this.alignX == "Max" )
                x_trans = -x_diff;
            
            matrix = matrix.translate(x_trans, 0);
            matrix = matrix.scale( y_ratio );
        }
        else if ( x_ratio > y_ratio && this.meetOrSlice == "meet" ||
                  x_ratio < y_ratio && this.meetOrSlice == "slice"   )
        {
            var y_trans = 0;
            var y_diff  = this.windowHeight*x_ratio - this.height;

            if ( this.alignY == "Mid" )
                y_trans = -y_diff/2;
            else if ( this.alignY == "Max" )
                y_trans = -y_diff;
            
            matrix = matrix.translate(0, y_trans);
            matrix = matrix.scale( x_ratio );
        }
        else
        {
            // x_ratio == y_ratio so, there is no need to translate
            // We can scale by either value
            matrix = matrix.scale( x_ratio );
        }
    }

    return matrix;
}


/*****
*
*   get/set methods
*
*****/

/*****
*
*   setPAR
*
*****/
ViewBox.prototype.setPAR = function(PAR) {
    // NOTE: This function needs to use default values when encountering
    // unrecognized values
    if ( PAR ) {
        var params = PAR.split(/\s+/);
        var align  = params[0];

        if ( align == "none" ) {
            this.alignX = "none";
            this.alignY = "none";
        } else {
            this.alignX = align.substring(1,4);
            this.alignY = align.substring(5,9);
        }

        if ( params.length == 2 ) {
            this.meetOrSlice = params[1];
        } else {
            this.meetOrSlice = "meet";
        }
    } else {
        this.align  = "xMidYMid";
        this.alignX = "Mid";
        this.alignY = "Mid";
        this.meetOrSlice = "meet";
    }
};

//mapApp.js end


//helper_functions.js start
/**
 * @fileoverview
 * 
 * ECMAScript <a href="http://www.carto.net/papers/svg/resources/helper_functions.html">helper functions</a>, main purpose is to serve in SVG mapping or other SVG based web applications
 *
 * This ECMA script library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library (http://www.carto.net/papers/svg/resources/lesser_gpl.txt); if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 * Please report bugs and send improvements to neumann@karto.baug.ethz.ch
 * If you use these scripts, please link to the original (http://www.carto.net/papers/svg/resources/helper_functions.html)
 * somewhere in the source-code-comment or the "about" of your project and give credits, thanks!
 * 
 * See <a href="js_docs_out/overview-summary-helper_functions.js.html">documentation</a>. 
 * 
 * @author Andreas Neumann a.neumann@carto.net
 * @copyright LGPL 2.1 <a href="http://www.gnu.org/copyleft/lesser.txt">Gnu LGPL 2.1</a>
 * @credits Bruce Rindahl, numerous people on svgdevelopers@yahoogroups.com
 */

//global variables necessary to create elements in these namespaces, do not delete them!!!!

/**
 * This variable is a shortcut to the full URL of the SVG namespace
 * @final
 * @type String
 */
var svgNS = "http://www.w3.org/2000/svg";

/**
 * This variable is a shortcut to the full URL of the XLink namespace
 * @final
 * @type String
 */
var xlinkNS = "http://www.w3.org/1999/xlink";

/**
 * This variable is a shortcut to the full URL of the attrib namespace
 * @final
 * @type String
 */
var cartoNS = "http://www.carto.net/attrib";

/**
 * This variable is a alias to the full URL of the attrib namespace
 * @final
 * @type String
 */
var attribNS = "http://www.carto.net/attrib";

/**
 * This variable is a alias to the full URL of the Batik extension namespace
 * @final
 * @type String
 */
var batikNS = "http://xml.apache.org/batik/ext";

/**
 * Returns the polar direction from a given vector
 * @param {Number} xdiff	the x-part of the vector
 * @param {Number} ydiff	the y-part of the vector
 * @return direction		the direction in radians
 * @type Number
 * @version 1.0 (2007-04-30)
 * @see #toPolarDist
 * @see #toRectX
 * @see #toRectY
 */
function toPolarDir(xdiff,ydiff) {
   var direction = (Math.atan2(ydiff,xdiff));
   return(direction);
}

/**
 * Returns the polar distance from a given vector
 * @param {Number} xdiff	the x-part of the vector
 * @param {Number} ydiff	the y-part of the vector
 * @return distance			the distance
 * @type Number
 * @version 1.0 (2007-04-30)
 * @see #toPolarDir
 * @see #toRectX
 * @see #toRectY
 */
function toPolarDist(xdiff,ydiff) {
   var distance = Math.sqrt(xdiff * xdiff + ydiff * ydiff);
   return(distance);
}

/**
 * Returns the x-part of a vector from a given direction and distance
 * @param {Number} direction	the direction (in radians)
 * @param {Number} distance		the distance
 * @return x					the x-part of the vector
 * @type Number
 * @version 1.0 (2007-04-30)
 * @see #toPolarDist
 * @see #toPolarDir
 * @see #toRectY
 */
function toRectX(direction,distance) {
   var x = distance * Math.cos(direction);
   return(x);
}

/**
 * Returns the y-part of the vector from a given direction and distance
 * @param {Number} direction	the direction (in radians)
 * @param {Number} distance		the distance
 * @return y					the y-part of the vector
 * @type Number
 * @version 1.0 (2007-04-30)
 * @see #toPolarDist
 * @see #toPolarDir
 * @see #toRectX
 */
function toRectY(direction,distance) {
   y = distance * Math.sin(direction);
   return(y);
}

/**
 * Converts degrees to radians
 * @param {Number} deg	the degree value
 * @return rad			the radians value
 * @type Number
 * @version 1.0 (2007-04-30)
 * @see #RadToDeg
 */
function DegToRad(deg) {
     return (deg / 180.0 * Math.PI);
}

/**
 * Converts radians to degrees
 * @param {Number} rad	the radians value
 * @return deg			the degree value
 * @type Number
 * @version 1.0 (2007-04-30)
 * @see #DegToRad
 */
function RadToDeg(rad) {
     return (rad / Math.PI * 180.0);
}

/**
 * Converts decimal degrees to degrees, minutes, seconds
 * @param {Number} dd	the decimal degree value
 * @return degrees		the degree values in the following notation: {deg:degrees,min:minutes,sec:seconds}
 * @type literal
 * @version 1.0 (2007-04-30)
 * @see #dms2dd
 */
function dd2dms(dd) {
        var minutes = (Math.abs(dd) - Math.floor(Math.abs(dd))) * 60;
        var seconds = (minutes - Math.floor(minutes)) * 60;
        var minutes = Math.floor(minutes);
        if (dd >= 0) {
            var degrees = Math.floor(dd);
        }
        else {
            var degrees = Math.ceil(dd);       
        }
        return {deg:degrees,min:minutes,sec:seconds};
}

/**
 * Converts degrees, minutes and seconds to decimal degrees
 * @param {Number} deg	the degree value
 * @param {Number} min	the minute value
 * @param {Number} sec	the second value
 * @return deg			the decimal degree values
 * @type Number
 * @version 1.0 (2007-04-30)
 * @see #dd2dms
 */
function dms2dd(deg,min,sec) {
	if (deg < 0) {
		return deg - (min / 60) - (sec / 3600);
	}
	else {
		return deg + (min / 60) + (sec / 3600);
	}
}

/**
 * log function, missing in the standard Math object
 * @param {Number} x	the value where the log function should be applied to
 * @param {Number} b	the base value for the log function
 * @return logResult	the result of the log function
 * @type Number
 * @version 1.0 (2007-04-30)
 */
function log(x,b) {
	if(b==null) b=Math.E;
	return Math.log(x)/Math.log(b);
}

/**
 * interpolates a value (e.g. elevation) bilinearly based on the position within a cell with 4 corner values
 * @param {Number} za		the value at the upper left corner of the cell
 * @param {Number} zb		the value at the upper right corner of the cell
 * @param {Number} zc		the value at the lower right corner of the cell
 * @param {Number} zd		the value at the lower left corner of the cell
 * @param {Number} xpos		the x position of the point where a new value should be interpolated
 * @param {Number} ypos		the y position of the point where a new value should be interpolated
 * @param {Number} ax		the x position of the lower left corner of the cell
 * @param {Number} ay		the y position of the lower left corner of the cell
 * @param {Number} cellsize	the size of the cell
 * @return interpol_value	the result of the bilinear interpolation function
 * @type Number
 * @version 1.0 (2007-04-30)
 */
function intBilinear(za,zb,zc,zd,xpos,ypos,ax,ay,cellsize) { //bilinear interpolation function
	var e = (xpos - ax) / cellsize;
	var f = (ypos - ay) / cellsize;

	//calculation of weights
	var wa = (1 - e) * (1 - f);
	var wb = e * (1 - f);
	var wc = e * f;
	var wd = f * (1 - e);

	var interpol_value = wa * zc + wb * zd + wc * za + wd * zb;
	return interpol_value;	
}

/**
 * tests if a given point is left or right of a given line
 * @param {Number} pointx		the x position of the given point
 * @param {Number} pointy		the y position of the given point
 * @param {Number} linex1		the x position of line's start point
 * @param {Number} liney1		the y position of line's start point
 * @param {Number} linex2		the x position of line's end point
 * @param {Number} liney2		the y position of line's end point
 * @return leftof				the result of the leftOfTest, 1 means leftOf, 0 means rightOf
 * @type Number (integer, 0|1)
 * @version 1.0 (2007-04-30)
 */
function leftOfTest(pointx,pointy,linex1,liney1,linex2,liney2) {
	var result = (liney1 - pointy) * (linex2 - linex1) - (linex1 - pointx) * (liney2 - liney1);
	if (result < 0) {
		var leftof = 1; //case left of
	}
	else {
		var leftof = 0; //case left of	
	}
	return leftof;
}

/**
 * calculates the distance between a given point and a given line
 * @param {Number} pointx		the x position of the given point
 * @param {Number} pointy		the y position of the given point
 * @param {Number} linex1		the x position of line's start point
 * @param {Number} liney1		the y position of line's start point
 * @param {Number} linex2		the x position of line's end point
 * @param {Number} liney2		the y position of line's end point
 * @return distance				the result of the leftOfTest, 1 means leftOf, 0 means rightOf
 * @type Number
 * @version 1.0 (2007-04-30)
 */
function distFromLine(xpoint,ypoint,linex1,liney1,linex2,liney2) {
	var dx = linex2 - linex1;
	var dy = liney2 - liney1;
	var distance = (dy * (xpoint - linex1) - dx * (ypoint - liney1)) / Math.sqrt(Math.pow(dx,2) + Math.pow(dy,2));
	return distance;
}

/**
 * calculates the angle between two vectors (lines)
 * @param {Number} ax		the x part of vector a
 * @param {Number} ay		the y part of vector a
 * @param {Number} bx		the x part of vector b
 * @param {Number} by		the y part of vector b
 * @return angle			the angle in radians
 * @type Number
 * @version 1.0 (2007-04-30)
 * @credits <a href="http://www.mathe-online.at/mathint/vect2/i.html#Winkel">Mathe Online (Winkel)</a>
 */
function angleBetwTwoLines(ax,ay,bx,by) {
	var angle = Math.acos((ax * bx + ay * by) / (Math.sqrt(Math.pow(ax,2) + Math.pow(ay,2)) * Math.sqrt(Math.pow(bx,2) + Math.pow(by,2))));
	return angle;
}

/**
 * calculates the bisector vector for two given vectors
 * @param {Number} ax		the x part of vector a
 * @param {Number} ay		the y part of vector a
 * @param {Number} bx		the x part of vector b
 * @param {Number} by		the y part of vector b
 * @return c				the resulting vector as an Array, c[0] is the x part of the vector, c[1] is the y part
 * @type Array
 * @version 1.0 (2007-04-30)
 * @credits <a href="http://www.mathe-online.at/mathint/vect1/i.html#Winkelsymmetrale">Mathe Online (Winkelsymmetrale)</a>
 * see #calcBisectorAngle
 *  */
function calcBisectorVector(ax,ay,bx,by) {
	var betraga = Math.sqrt(Math.pow(ax,2) + Math.pow(ay,2));
	var betragb = Math.sqrt(Math.pow(bx,2) + Math.pow(by,2));
	var c = new Array();
	c[0] = ax / betraga + bx / betragb;
	c[1] = ay / betraga + by / betragb;
	return c;
}

/**
 * calculates the bisector angle for two given vectors
 * @param {Number} ax		the x part of vector a
 * @param {Number} ay		the y part of vector a
 * @param {Number} bx		the x part of vector b
 * @param {Number} by		the y part of vector b
 * @return angle			the bisector angle in radians
 * @type Number
 * @version 1.0 (2007-04-30)
 * @credits <a href="http://www.mathe-online.at/mathint/vect1/i.html#Winkelsymmetrale">Mathe Online (Winkelsymmetrale)</a>
 * see #calcBisectorVector
 * */
function calcBisectorAngle(ax,ay,bx,by) {
	var betraga = Math.sqrt(Math.pow(ax,2) + Math.pow(ay,2));
	var betragb = Math.sqrt(Math.pow(bx,2) + Math.pow(by,2));
	var c1 = ax / betraga + bx / betragb;
	var c2 = ay / betraga + by / betragb;
	var angle = toPolarDir(c1,c2);
	return angle;
}

/**
 * calculates the intersection point of two given lines
 * @param {Number} line1x1	the x the start point of line 1
 * @param {Number} line1y1	the y the start point of line 1
 * @param {Number} line1x2	the x the end point of line 1
 * @param {Number} line1y2	the y the end point of line 1
 * @return interSectPoint	the intersection point, interSectPoint.x contains x-part, interSectPoint.y the y-part of the resulting coordinate
 * @type Object
 * @version 1.0 (2007-04-30)
 * @credits <a href="http://astronomy.swin.edu.au/~pbourke/geometry/lineline2d/">P. Bourke</a>
 */
function intersect2lines(line1x1,line1y1,line1x2,line1y2,line2x1,line2y1,line2x2,line2y2) {
	var interSectPoint = new Object();
	var denominator = (line2y2 - line2y1)*(line1x2 - line1x1) - (line2x2 - line2x1)*(line1y2 - line1y1);
	if (denominator == 0) {
		alert("lines are parallel");
	}
	else {
		var ua = ((line2x2 - line2x1)*(line1y1 - line2y1) - (line2y2 - line2y1)*(line1x1 - line2x1)) / denominator;
		var ub = ((line1x2 - line1x1)*(line1y1 - line2y1) - (line1y2 - line1y1)*(line1x1 - line2x1)) / denominator;
	}
	interSectPoint["x"] = line1x1 + ua * (line1x2 - line1x1);
	interSectPoint["y"] = line1y1 + ua * (line1y2 - line1y1);
	return interSectPoint;
}

/**
 * reformats a given number to a string by adding separators at every third digit
 * @param {String|Number} inputNumber	the input number, can be of type number or string
 * @param {String} separator			the separator, e.g. ' or ,
 * @return newString					the intersection point, interSectPoint.x contains x-part, interSectPoint.y the y-part of the resulting coordinate
 * @type String
 * @version 1.0 (2007-04-30)
 */
function formatNumberString(inputNumber,separator) {
	//check if of type string, if number, convert it to string
	if (typeof(inputNumber) == "Number") {
		var myTempString = inputNumber.toString();
	}
	else {
		var myTempString = inputNumber;
	}
	var newString="";
	//if it contains a comma, it will be split
	var splitResults = myTempString.split(".");
	var myCounter = splitResults[0].length;
	if (myCounter > 3) {
		while(myCounter > 0) {
			if (myCounter > 3) {
				newString = separator + splitResults[0].substr(myCounter - 3,3) + newString;
			}
			else {
				newString = splitResults[0].substr(0,myCounter) + newString;
			}
			myCounter -= 3;
		}
	}
	else {
		newString = splitResults[0];
	}
	//concatenate if it contains a comma
	if (splitResults[1]) {
		newString = newString + "." + splitResults[1];
	}
	return newString;
}

/**
 * writes a status text message out to a SVG text element's first child
 * @param {String} statusText	the text message to be displayed
 * @version 1.0 (2007-04-30)
 */
 function statusChange(statusText) {
	document.getElementById("statusText").firstChild.nodeValue = "Statusbar: " + statusText;
}

/**
 * scales an SVG element, requires that the element has an x and y attribute (e.g. circle, ellipse, use element, etc.)
 * @param {dom::Event} evt		the evt object that triggered the scaling
 * @param {Number} factor	the scaling factor
 * @version 1.0 (2007-04-30)
 */
function scaleObject(evt,factor) {
	//reference to the currently selected object
	var element = evt.currentTarget;
	var myX = element.getAttributeNS(null,"x");
	var myY = element.getAttributeNS(null,"y");
	var newtransform = "scale(" + factor + ") translate(" + (myX * 1 / factor - myX) + " " + (myY * 1 / factor - myY) +")";
	element.setAttributeNS(null,'transform', newtransform);
}

/**
 * returns the transformation matrix (ctm) for the given node up to the root element
 * the basic use case is to provide a wrapper function for the missing SVGLocatable.getTransformToElement method (missing in ASV3)
 * @param {svg::SVGTransformable} node		the node reference for the SVGElement the ctm is queried
 * @return CTM								the current transformation matrix from the given node to the root element
 * @type svg::SVGMatrix
 * @version 1.0 (2007-05-01)
 * @credits <a href="http://www.kevlindev.com/tutorials/basics/transformations/toUserSpace/index.htm">Kevin Lindsey (toUserSpace)</a>
 * @see #getTransformToElement
 */
function getTransformToRootElement(node) {
 	try {
		//this part is for fully conformant players (like Opera, Batik, Firefox, Safari ...)
		var CTM = node.getTransformToElement(document.documentElement);
	}
	catch (ex) {
		//this part is for ASV3 or other non-conformant players
		// Initialize our CTM the node's Current Transformation Matrix
		var CTM = node.getCTM();
		// Work our way through the ancestor nodes stopping at the SVG Document
		while ( ( node = node.parentNode ) != document ) {
			// Multiply the new CTM to the one with what we have accumulated so far
			CTM = node.getCTM().multiply(CTM);
		}
	}
	return CTM;
}

/**
 * returns the transformation matrix (ctm) for the given dom::Node up to a different dom::Node
 * the basic use case is to provide a wrapper function for the missing SVGLocatable.getTransformToElement method (missing in ASV3)
 * @param {svg::SVGTransformable} node			the node reference for the element the where the ctm should be calculated from
 * @param {svg::SVGTransformable} targetNode	the target node reference for the element the ctm should be calculated to
 * @return CTM									the current transformation matrix from the given node to the target element
 * @type svg::SVGMatrix
 * @version 1.0 (2007-05-01)
 * @credits <a href="http://www.kevlindev.com/tutorials/basics/transformations/toUserSpace/index.htm">Kevin Lindsey (toUserSpace)</a>
 * @see #getTransformToRootElement
 */
function getTransformToElement(node,targetNode) {
    try {
        //this part is for fully conformant players
        var CTM = node.getTransformToElement(targetNode);
    }
    catch (ex) {
  		//this part is for ASV3 or other non-conformant players
		// Initialize our CTM the node's Current Transformation Matrix
		var CTM = node.getCTM();
		// Work our way through the ancestor nodes stopping at the SVG Document
		while ( ( node = node.parentNode ) != targetNode ) {
			// Multiply the new CTM to the one with what we have accumulated so far
			CTM = node.getCTM().multiply(CTM);
		}
    }
    return CTM;
}

/**
 * converts HSV to RGB values
 * @param {Number} hue		the hue value (between 0 and 360)
 * @param {Number} sat		the saturation value (between 0 and 1)
 * @param {Number} val		the value value (between 0 and 1)
 * @return rgbArr			the rgb values (associative array or object, the keys are: red,green,blue), all values are scaled between 0 and 255
 * @type Object
 * @version 1.0 (2007-05-01)
 * @see #rgb2hsv
 */
function hsv2rgb(hue,sat,val) {
	var rgbArr = new Object();
	if ( sat == 0) {
		rgbArr["red"] = Math.round(val * 255);
		rgbArr["green"] = Math.round(val * 255);
		rgbArr["blue"] = Math.round(val * 255);
	}
	else {
		var h = hue / 60;
		var i = Math.floor(h);
		var f = h - i;
		if (i % 2 == 0) {
			f = 1 - f;
		}
		var m = val * (1 - sat); 
		var n = val * (1 - sat * f);
		switch(i) {
			case 0:
				rgbArr["red"] = val;
				rgbArr["green"] = n;
				rgbArr["blue"] = m;
				break;
			case 1:
				rgbArr["red"] = n;
				rgbArr["green"] = val;
				rgbArr["blue"] = m;
				break;
			case 2:
				rgbArr["red"] = m;
				rgbArr["green"] = val;
				rgbArr["blue"] = n;
				break;
			case 3:
				rgbArr["red"] = m;
				rgbArr["green"] = n;
				rgbArr["blue"] = val;
				break;
			case 4:
				rgbArr["red"] = n;
				rgbArr["green"] = m;
				rgbArr["blue"] = val;
				break;
			case 5:
				rgbArr["red"] = val;
				rgbArr["green"] = m;
				rgbArr["blue"] = n;
				break;
			case 6:
				rgbArr["red"] = val;
				rgbArr["green"] = n;
				rgbArr["blue"] = m;
				break;
		}
		rgbArr["red"] = Math.round(rgbArr["red"] * 255);
		rgbArr["green"] = Math.round(rgbArr["green"] * 255);
		rgbArr["blue"] = Math.round(rgbArr["blue"] * 255);
	}
	return rgbArr;
}

/**
 * converts RGB to HSV values
 * @param {Number} red		the hue value (between 0 and 255)
 * @param {Number} green	the saturation value (between 0 and 255)
 * @param {Number} blue		the value value (between 0 and 255)
 * @return hsvArr			the hsv values (associative array or object, the keys are: hue (0-360),sat (0-1),val (0-1))
 * @type Object
 * @version 1.0 (2007-05-01)
 * @see #hsv2rgb
 */
function rgb2hsv(red,green,blue) {
	var hsvArr = new Object();
	red = red / 255;
	green = green / 255;
	blue = blue / 255;
	myMax = Math.max(red, Math.max(green,blue));
	myMin = Math.min(red, Math.min(green,blue));
	v = myMax;
	if (myMax > 0) {
		s = (myMax - myMin) / myMax;
	}
	else {
		s = 0;
	}
	if (s > 0) {
		myDiff = myMax - myMin;
		rc = (myMax - red) / myDiff;
		gc = (myMax - green) / myDiff;
		bc = (myMax - blue) / myDiff;
		if (red == myMax) {
			h = (bc - gc) / 6;
		}
		if (green == myMax) {
			h = (2 + rc - bc) / 6;
		}
		if (blue == myMax) {
			h = (4 + gc - rc) / 6;
		}
	}
	else {
		h = 0;
	}
	if (h < 0) {
		h += 1;
	}
	hsvArr["hue"] = Math.round(h * 360);
	hsvArr["sat"] = s;
	hsvArr["val"] = v;
	return hsvArr;
}

/**
 * populates an array such that it can be addressed by both a key or an index nr,
 * note that both Arrays need to be of the same length
 * @param {Array} arrayKeys		the array containing the keys
 * @param {Array} arrayValues	the array containing the values
 * @return returnArray			the resulting array containing both associative values and also a regular indexed array
 * @type Array
 * @version 1.0 (2007-05-01)
 */
function arrayPopulate(arrayKeys,arrayValues) {
	var returnArray = new Array();
	if (arrayKeys.length != arrayValues.length) {
		alert("error: arrays do not have the same length!");
	}
	else {
		for (i=0;i<arrayKeys.length;i++) {
			returnArray[arrayKeys[i]] = arrayValues[i];
		}
	}
	return returnArray;
}

/**
 * Wrapper object for network requests, uses getURL or XMLHttpRequest depending on availability
 * The callBackFunction receives a XML or text node representing the rootElement
 * of the fragment received or the return text, depending on the returnFormat. 
 * See also the following <a href="http://www.carto.net/papers/svg/network_requests/">documentation</a>.
 * @class this is a wrapper object to provide network request functionality (get|post)
 * @param {String} url												the URL/IRI of the network resource to be called
 * @param {Function|Object} callBackFunction						the callBack function or object that is called after the data was received, in case of an object, the method 'receiveData' is called; both the function and the object's 'receiveData' method get 2 return parameters: 'node.firstChild'|text (the root element of the XML or text resource), this.additionalParams (if defined) 
 * @param {String} returnFormat										the return format, either 'xml' or 'json' (or text)
 * @param {String} method											the method of the network request, either 'get' or 'post'
 * @param {String|Undefined} postText								the String containing the post text (optional) or Undefined (if not a 'post' request)
 * @param {Object|Array|String|Number|Undefined} additionalParams	additional parameters that will be passed to the callBackFunction or object (optional) or Undefined
 * @return a new getData instance
 * @type getData
 * @constructor
 * @version 1.0 (2007-02-23)
 */
function getData(url,callBackFunction,returnFormat,method,postText,additionalParams) {
	this.url = url;
	this.callBackFunction = callBackFunction;
	this.returnFormat = returnFormat;
	this.method = method;
	this.additionalParams = additionalParams;
	if (method != "get" && method != "post") {
		alert("Error in network request: parameter 'method' must be 'get' or 'post'");
	}
	this.postText = postText;
	this.xmlRequest = null; //@private reference to the XMLHttpRequest object
} 

/**
 * triggers the network request defined in the constructor
 */
getData.prototype.getData = function() {
	//call getURL() if available
	if (window.getURL) {
		if (this.method == "get") {
			getURL(this.url,this);
		}
		if (this.method == "post") {
			postURL(this.url,this.postText,this);
		}
	}
	//or call XMLHttpRequest() if available
	else if (window.XMLHttpRequest) {
		var _this = this;
		this.xmlRequest = new XMLHttpRequest();
		if (this.method == "get") {
			if (this.returnFormat == "xml") {
				this.xmlRequest.overrideMimeType("text/xml");
			}
			this.xmlRequest.open("GET",this.url,true);
		}
		if (this.method == "post") {
			this.xmlRequest.open("POST",this.url,true);
		}
		this.xmlRequest.onreadystatechange = function() {_this.handleEvent()};
		if (this.method == "get") {
			this.xmlRequest.send(null);
		}
		if (this.method == "post") {
			//test if postText exists and is of type string
			var reallyPost = true;
			if (!this.postText) {
				reallyPost = false;
				alert("Error in network post request: missing parameter 'postText'!");
			}
			if (typeof(this.postText) != "string") {
				reallyPost = false;
				alert("Error in network post request: parameter 'postText' has to be of type 'string')");
			}
			if (reallyPost) {
				this.xmlRequest.send(this.postText);
			}
		}
	}
	//write an error message if neither method is available
	else {
		alert("your browser/svg viewer neither supports window.getURL nor window.XMLHttpRequest!");
	}	
}

/**
 * this is the callback method for the getURL() or postURL() case
 * @private
 */
getData.prototype.operationComplete = function(data) {
	//check if data has a success property
	if (data.success) {
		//parse content of the XML format to the variable "node"
		if (this.returnFormat == "xml") {
			//convert the text information to an XML node and get the first child
			var node = parseXML(data.content,document);
			//distinguish between a callback function and an object
			if (typeof(this.callBackFunction) == "function") {
				this.callBackFunction(node.firstChild,this.additionalParams);
			}
			if (typeof(this.callBackFunction) == "object") {
				this.callBackFunction.receiveData(node.firstChild,this.additionalParams);
			}
		}
		if (this.returnFormat == "json") {
			if (typeof(this.callBackFunction) == "function") {
				this.callBackFunction(data.content,this.additionalParams);
			}
			if (typeof(this.callBackFunction) == "object") {
				this.callBackFunction.receiveData(data.content,this.additionalParams);
			}			
		}
	}
	else {
		alert("something went wrong with dynamic loading of geometry!");
	}
}

/**
 * this is the callback method for the XMLHttpRequest case
 * @private
 */
getData.prototype.handleEvent = function() {
	if (this.xmlRequest.readyState == 4) {
		if (this.returnFormat == "xml") {
			//we need to import the XML node first
			var importedNode = document.importNode(this.xmlRequest.responseXML.documentElement,true);
			if (typeof(this.callBackFunction) == "function") {
				this.callBackFunction(importedNode,this.additionalParams);
			}
			if (typeof(this.callBackFunction) == "object") {
				this.callBackFunction.receiveData(importedNode,this.additionalParams);
			}			
		}
		if (this.returnFormat == "json") {
			if (typeof(this.callBackFunction) == "function") {
				this.callBackFunction(this.xmlRequest.responseText,this.additionalParams);
			}
			if (typeof(this.callBackFunction) == "object") {
				this.callBackFunction.receiveData(this.xmlRequest.responseText,this.additionalParams);
			}			
		}		
	}	
}

/**
 * Serializes an XML node and returns a string representation. Wrapper function to hide implementation differences. 
 * This can be used for debugging purposes or to post data to a server or network resource.
 * @param {dom::Node} node		the DOM node reference
 * @return textRepresentation	the String representation of the XML node
 * @type String
 * @version 1.0 (2007-05-01)
 * @see getData
 */
function serializeNode(node) {
  if (typeof XMLSerializer != 'undefined') {
    return new XMLSerializer().serializeToString(node);
  }
  else if (typeof node.xml != 'undefined') {
    return node.xml;
  }
  else if (typeof printNode != 'undefined') {
    return printNode(node);
  }
  else if (typeof Packages != 'undefined') {
    try {
      var stringWriter = new java.io.StringWriter();
      Packages.org.apache.batik.dom.util.DOMUtilities.writeNode(node,stringWriter);
      return stringWriter.toString();
    }
    catch (e) {
       alert("Sorry, your SVG viewer does not support the printNode/serialize function.");
       return '';
    }
  }
  else {
    alert("Sorry, your SVG viewer does not support the printNode/serialize function.");
    return '';
  }
}

/**
 * Starts a SMIL animation element with the given id by triggering the '.beginElement()' method. 
 * This is a convenience (shortcut) function. 
 * @param {String} id		a valid id of a valid SMIL animation element
 * @version 1.0 (2007-05-01)
 */
//starts an animtion with the given id
//this function is useful in combination with window.setTimeout()
function startAnimation(id) {
		document.getElementById(id).beginElement();
}
//helper_functions.js end
 
//timer.js start
//source/credits: "Algorithm": http://www.codingforums.com/showthread.php?s=&threadid=10531
//The constructor should be called with
//the parent object (optional, defaults to window).

function Timer(){
  this.obj = (arguments.length)?arguments[0]:window;
  return this;
}

//The set functions should be called with:
//- The name of the object method (as a string) (required)
//- The millisecond delay (required)
//- Any number of extra arguments, which will all be
// passed to the method when it is evaluated.

Timer.prototype.setInterval = function(func, msec){
  var i = Timer.getNew();
  var t = Timer.buildCall(this.obj, i, arguments);
  Timer.set[i].timer = window.setInterval(t,msec);
  return i;
}
Timer.prototype.setTimeout = function(func, msec){
  var i = Timer.getNew();
  Timer.buildCall(this.obj, i, arguments);
  Timer.set[i].timer = window.setTimeout("Timer.callOnce("+i+");",msec);
  return i;
}

//The clear functions should be called with
//the return value from the equivalent set function.

Timer.prototype.clearInterval = function(i){
  if(!Timer.set[i]) return;
  window.clearInterval(Timer.set[i].timer);
  Timer.set[i] = null;
}
Timer.prototype.clearTimeout = function(i){
  if(!Timer.set[i]) return;
  window.clearTimeout(Timer.set[i].timer);
  Timer.set[i] = null;
}

//Private data

Timer.set = new Array();
Timer.buildCall = function(obj, i, args){
  var t = "";
  Timer.set[i] = new Array();
  if(obj != window){
      Timer.set[i].obj = obj;
      t = "Timer.set["+i+"].obj.";
  }
  t += args[0]+"(";
  if(args.length > 2){
      Timer.set[i][0] = args[2];
      t += "Timer.set["+i+"][0]";
      for(var j=1; (j+2)<args.length; j++){
          Timer.set[i][j] = args[j+2];
          t += ", Timer.set["+i+"]["+j+"]";
  }}
  t += ");";
  Timer.set[i].call = t;
  return t;
}
Timer.callOnce = function(i){
  if(!Timer.set[i]) return;
  eval(Timer.set[i].call);
  Timer.set[i] = null;
}
Timer.getNew = function(){
  var i = 0;
  while(Timer.set[i]) i++;
  return i;
}
//timer.js end

//scrollbar.js start
function scrollbar(id,parentNode,x,y,width,height,startValue,endValue,initialHeightPerc,initialOffset,scrollStep,scrollButtonLocations,scrollbarStyles,scrollerStyles,triangleStyles,highlightStyles,functionToCall) {
	var nrArguments = 17;
	var createScrollbar = true;
	if (arguments.length == nrArguments) {
		//get constructor variables
		this.id = id;
		this.parentNode = parentNode;
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.startValue = startValue;
		this.endValue = endValue;
		this.initialHeightPerc = initialHeightPerc;
		this.initialOffset = initialOffset;
		this.scrollStep = scrollStep; //this value indicates how much the slider will scroll when the arrow buttons are pressed, values are in percentage
		this.scrollButtonLocations = scrollButtonLocations;
		if (this.scrollButtonLocations != "bottom_bottom" && this.scrollButtonLocations != "top_bottom" && this.scrollButtonLocations && "top_top" && this.scrollButtonLocations != "none_none") {
		    createScrollbar = false;
		    alert("Error: parameter 'scrollButtonLocations' can only be of the following values: 'bottom_bottom' || 'top_top' || 'top_bottom' || 'none_none'.");		
		}
		this.scrollbarStyles = scrollbarStyles;
		this.scrollerStyles = scrollerStyles;
		this.triangleStyles = triangleStyles;
		this.highlightStyles = highlightStyles;
		this.functionToCall = functionToCall;
		//additional properties to be used later
		this.horizOrVertical = "vertical"; //specifies wether scrollbar is horizontal or vertical
		this.cellHeight = this.width; //the height or width of the buttons on top or bottom of the scrollbar
		this.scrollStatus = false; //indicates whether scrolling is active
		this.buttonScrollActive = false; //indicates whether the scrollbutton is currently being pressed
		this.scrollbarScrollActive = false; //indicates whether the scrollbar is currently being pressed
	}
	else {
		createScrollbar = false;
		alert("Error ("+id+"): wrong nr of arguments! You have to pass over "+nrArguments+" parameters.");
	}
	if (createScrollbar) {
		//create scrollbar
		var result = this.testParent();
		if (result) {
			//timer stuff
			this.timer = new Timer(this); //a Timer instance for calling the functionToCall
			this.timerMs = 200; //a constant of this object that is used in conjunction with the timer - functionToCall is called after 200 ms
			this.createScrollbar();
		}
		else {
			alert("could not create or reference 'parentNode' of scrollbar with id '"+this.id+"'");
		}			
	}
	else {
		alert("Could not create scrollbar with id '"+id+"' due to errors in the constructor parameters");	
	}
}

//test if parent group exists or create a new group at the end of the file
scrollbar.prototype.testParent = function() {
    //test if of type object
    var nodeValid = false;
    this.parentGroup = document.createElementNS(svgNS,"g");
    if (typeof(this.parentNode) == "object") {
    	if (this.parentNode.nodeName == "svg" || this.parentNode.nodeName == "g" || this.parentNode.nodeName == "svg:svg" || this.parentNode.nodeName == "svg:g") {
    		this.parentNode.appendChild(this.parentGroup);
    		nodeValid = true;
    	}
    }
    else if (typeof(this.parentNode) == "string") { 
    	//first test if button group exists
    	if (!document.getElementById(this.parentNode)) {
        	this.parentGroup.setAttributeNS(null,"id",this.parentNode);
        	document.documentElement.appendChild(this.parentGroup);
        	nodeValid = true;
   		}
   		else {
       		document.getElementById(this.parentNode).appendChild(this.parentGroup);
       		nodeValid = true;
   		}
   	}
   	return nodeValid;
}

//create scrollbar geometry
scrollbar.prototype.createScrollbar = function() {
	//first determine if vertical of horizontal
	if (this.width > this.height) {
		this.horizOrVertical = "horizontal";
		this.cellHeight = this.height;
	}
	this.triangleFourth = Math.round(this.cellHeight / 4); //this is used to construct the triangles for the buttons

	if (this.scrollButtonLocations != "none_none") {
		this.scrollUpperRect = document.createElementNS(svgNS,"rect");
		this.scrollLowerRect = document.createElementNS(svgNS,"rect");
		this.scrollUpperTriangle = document.createElementNS(svgNS,"path");
		this.scrollLowerTriangle = document.createElementNS(svgNS,"path");
	}
 
	if (this.horizOrVertical == "vertical")  {
		this.scrollUpperRectX = this.x;
		this.scrollLowerRectX = this.x;
		switch (this.scrollButtonLocations)  {
			case "top_top":
				this.scrollbarX = this.x;
				this.scrollbarY = this.y + (2 * this.cellHeight);
				this.scrollbarWidth = this.width;
				this.scrollbarHeight = this.height - (2 * this.cellHeight);
 				this.scrollUpperRectY = this.y;
 				this.scrollLowerRectY = this.y + this.cellHeight;
				break;
			case "bottom_bottom":
				this.scrollbarX = this.x;
				this.scrollbarY = this.y;
				this.scrollbarWidth = this.width;
				this.scrollbarHeight = this.height - (2 * this.cellHeight);
 				this.scrollUpperRectY = this.y + this.height - (2 * this.cellHeight);
 				this.scrollLowerRectY = this.y + this.height - this.cellHeight;
				break;
			case "top_bottom":
				this.scrollbarX = this.x;
				this.scrollbarY = this.y + this.cellHeight;
				this.scrollbarWidth = this.width;
				this.scrollbarHeight = this.height - (2 * this.cellHeight);
 				this.scrollUpperRectY = this.y;
 				this.scrollLowerRectY = this.y + this.height - this.cellHeight;
				break;
			default:
				this.scrollbarX = this.x;
				this.scrollbarY = this.y;
				this.scrollbarWidth = this.width;
				this.scrollbarHeight = this.height;
				break;                
		}
		var myUpperTriPath = "M"+(this.scrollUpperRectX + this.cellHeight * 0.5)+" "+(this.scrollUpperRectY + this.triangleFourth)+" L"+(this.scrollUpperRectX + 3 * this.triangleFourth)+" "+(this.scrollUpperRectY + 3 * this.triangleFourth)+" L"+(this.scrollUpperRectX + this.triangleFourth)+" "+(this.scrollUpperRectY + 3 * this.triangleFourth)+" Z";
		var myLowerTriPath = "M"+(this.scrollLowerRectX + this.cellHeight * 0.5)+" "+(this.scrollLowerRectY + 3 * this.triangleFourth)+" L"+(this.scrollLowerRectX + this.triangleFourth)+" "+(this.scrollLowerRectY + this.triangleFourth)+" L"+(this.scrollLowerRectX + this.triangleFourth * 3)+" "+(this.scrollLowerRectY + this.triangleFourth)+" Z";
	}

	if (this.horizOrVertical == "horizontal")  {
		this.scrollUpperRectY = this.y;
		this.scrollLowerRectY = this.y;
		switch (this.scrollButtonLocations)  {
			case "top_top":
				this.scrollbarX = this.x + (2 * this.cellHeight);
				this.scrollbarY = this.y;
				this.scrollbarWidth = this.width - (2 * this.cellHeight);
				this.scrollbarHeight = this.height;
				this.scrollUpperRectX = this.x;
 				this.scrollLowerRectX = this.x + this.cellHeight;
				break;
			case "bottom_bottom":
				this.scrollbarX = this.x;
				this.scrollbarY = this.y;
				this.scrollbarWidth = this.width - (2 * this.cellHeight);
				this.scrollbarHeight = this.height;
 				this.scrollUpperRectX = this.x + this.width - (2 * this.cellHeight);
 				this.scrollLowerRectX = this.x + this.width - this.cellHeight;
				break;
			case "top_bottom":
				this.scrollbarX = this.x + this.cellHeight;
				this.scrollbarY = this.y;
				this.scrollbarWidth = this.width - (2 * this.cellHeight);
				this.scrollbarHeight = this.height;
 				this.scrollUpperRectX = this.x;
 				this.scrollLowerRectX = this.x + this.width - this.cellHeight;
				break;
			default:
				this.scrollbarX = this.x;
				this.scrollbarY = this.y;
				this.scrollbarWidth = this.width;
				this.scrollbarHeight = this.height;
				break;                
		}
		var myUpperTriPath = "M"+(this.scrollUpperRectX + this.triangleFourth)+" "+(this.scrollUpperRectY + this.triangleFourth * 2)+" L"+(this.scrollUpperRectX + 3 * this.triangleFourth)+" "+(this.scrollUpperRectY + this.triangleFourth)+" L"+(this.scrollUpperRectX + 3 * this.triangleFourth)+" "+(this.scrollUpperRectY + 3 * this.triangleFourth)+" Z";
		var myLowerTriPath = "M"+(this.scrollLowerRectX + this.triangleFourth * 3)+" "+(this.scrollLowerRectY + 2 * this.triangleFourth)+" L"+(this.scrollLowerRectX + this.triangleFourth)+" "+(this.scrollLowerRectY + this.triangleFourth * 3)+" L"+(this.scrollLowerRectX + this.triangleFourth)+" "+(this.scrollLowerRectY + this.triangleFourth)+" Z";
	}

	this.scrollbar = document.createElementNS(svgNS,"rect");
	this.scrollbar.setAttributeNS(null,"x",this.scrollbarX);
	this.scrollbar.setAttributeNS(null,"y",this.scrollbarY);
	this.scrollbar.setAttributeNS(null,"width",this.scrollbarWidth);
	this.scrollbar.setAttributeNS(null,"height",this.scrollbarHeight);
	this.scrollbar.setAttributeNS(null,"id","scrollbar_"+this.id);
	for (var attrib in this.scrollbarStyles) {
		this.scrollbar.setAttributeNS(null,attrib,this.scrollbarStyles[attrib]);
	}
	this.scrollbar.addEventListener("mousedown",this,false);
	this.parentGroup.appendChild(this.scrollbar);
	//now create scroller
	this.scroller = document.createElementNS(svgNS,"rect");
	if (this.horizOrVertical == "vertical")  {
		this.scroller.setAttributeNS(null,"x",this.scrollbarX);
		this.scrollerY = this.scrollbarY + (this.scrollbarHeight - this.scrollbarHeight * this.initialHeightPerc)  * this.initialOffset;
		this.scroller.setAttributeNS(null,"y",this.scrollerY);
		this.scroller.setAttributeNS(null,"width",this.scrollbarWidth);
		this.scrollerHeight = this.scrollbarHeight * this.initialHeightPerc;
		this.scroller.setAttributeNS(null,"height",this.scrollerHeight);
	}
	if (this.horizOrVertical == "horizontal")  {
		this.scrollerX = this.scrollbarX + (this.scrollbarWidth - this.scrollbarWidth * this.initialHeightPerc)  * this.initialOffset;
		this.scroller.setAttributeNS(null,"x",this.scrollerX);
		this.scroller.setAttributeNS(null,"y",this.scrollbarY);
		this.scrollerWidth = this.scrollbarWidth * this.initialHeightPerc;
		this.scroller.setAttributeNS(null,"width",this.scrollerWidth);
		this.scroller.setAttributeNS(null,"height",this.scrollbarHeight);
	}
	for (var attrib in this.scrollerStyles) {
		this.scroller.setAttributeNS(null,attrib,this.scrollerStyles[attrib]);
	}
	//need to add events here
	this.scroller.setAttributeNS(null,"id","scroller_"+this.id);
	this.scroller.addEventListener("mousedown",this,false);
	this.parentGroup.appendChild(this.scroller);
	//append rects and triangles
	if (this.scrollButtonLocations != "none_none") {
		//upper rect
		for (var attrib in this.scrollerStyles) {
			this.scrollUpperRect.setAttributeNS(null,attrib,this.scrollerStyles[attrib]);
		}
		this.scrollUpperRect.setAttributeNS(null,"x",this.scrollUpperRectX);
		this.scrollUpperRect.setAttributeNS(null,"y",this.scrollUpperRectY);
		this.scrollUpperRect.setAttributeNS(null,"width",this.cellHeight);
		this.scrollUpperRect.setAttributeNS(null,"height",this.cellHeight);
		this.scrollUpperRect.addEventListener("mousedown", this, false);
		this.scrollUpperRect.setAttributeNS(null,"id","scrollUpperRect_"+this.id);
		this.parentGroup.appendChild(this.scrollUpperRect);
		//lower rect
		for (var attrib in this.scrollerStyles) {
			this.scrollLowerRect.setAttributeNS(null,attrib,this.scrollerStyles[attrib]);
		}
		this.scrollLowerRect.setAttributeNS(null,"x",this.scrollLowerRectX);
		this.scrollLowerRect.setAttributeNS(null,"y",this.scrollLowerRectY);
		this.scrollLowerRect.setAttributeNS(null,"width",this.cellHeight);
		this.scrollLowerRect.setAttributeNS(null,"height",this.cellHeight);
		this.scrollLowerRect.addEventListener("mousedown", this, false);
		this.scrollLowerRect.setAttributeNS(null,"id","scrollLowerRect_"+this.id);
		this.parentGroup.appendChild(this.scrollLowerRect);
		//upper triangle
		this.scrollUpperTriangle.setAttributeNS(null,"d",myUpperTriPath);
		this.scrollUpperTriangle.setAttributeNS(null,"pointer-events","none");
		for (var attrib in this.triangleStyles) {
			this.scrollUpperTriangle.setAttributeNS(null,attrib,this.triangleStyles[attrib]);
		}
		this.parentGroup.appendChild(this.scrollUpperTriangle);
		//lower triangle
		this.scrollLowerTriangle.setAttributeNS(null,"d",myLowerTriPath);
		this.scrollLowerTriangle.setAttributeNS(null,"pointer-events","none");
		for (var attrib in this.triangleStyles) {
			this.scrollLowerTriangle.setAttributeNS(null,attrib,this.triangleStyles[attrib]);
		}
		this.parentGroup.appendChild(this.scrollLowerTriangle);
	}
 }
 
 scrollbar.prototype.handleEvent = function(evt) {
	var el = evt.target;
	var callerId = el.getAttributeNS(null,"id");
	if (evt.type == "mousedown") {
		if (callerId == "scroller_"+this.id) {
			//case the mouse went down on scroller
			this.scroll(evt);
		}
		if (callerId == "scrollLowerRect_"+this.id || callerId == "scrollUpperRect_"+this.id) {
			//this part is for scrolling per button
			this.buttonScrollActive = true;
			this.scrollDir = "down";
			this.currentScrollButton = evt.target;
			this.currentScrollTriangle = this.scrollLowerTriangle;
			if (callerId == "scrollUpperRect_"+this.id) {
				this.scrollDir = "up";
				this.currentScrollTriangle = this.scrollUpperTriangle;
			}
			document.documentElement.addEventListener("mouseup",this,false);
			//change appearance of button
			for (var attrib in this.scrollerStyles) {
				this.currentScrollButton.removeAttributeNS(null,attrib);
			}
			for (var attrib in this.highlightStyles) {
				this.currentScrollButton.setAttributeNS(null,attrib,this.highlightStyles[attrib]);
			}
			//change appearance of triangle
			for (var attrib in this.triangleStyles) {
				this.currentScrollTriangle.removeAttributeNS(null,attrib);
			}
			for (var attrib in this.scrollerStyles) {
				this.currentScrollTriangle.setAttributeNS(null,attrib,this.scrollerStyles[attrib]);
			}
			this.scrollPercent(this.scrollDir,this.scrollStep);
			this.timer.setTimeout("scrollPerButton",400);
		}
		if (callerId == "scrollbar_"+this.id) {
			//this part is for scrolling when mouse is down on scrollbar
			var coords = myMapApp.calcCoord(evt,this.scrollbar);
			this.scrollbarScrollActive = true;
			this.scrollDir = "down";
			if (this.horizOrVertical == "vertical") {
				if (coords.y < this.scrollerY) {
					this.scrollDir = "up";
				}
			}
			if (this.horizOrVertical == "horizontal") {
				if (coords.x < this.scrollerX) {
					this.scrollDir = "up";
				}
			}
			document.documentElement.addEventListener("mouseup",this,false);
			//change styling
			for (var attrib in this.scrollerStyles) {
				this.scroller.removeAttributeNS(null,attrib);
			}
			for (var attrib in this.highlightStyles) {
				this.scroller.setAttributeNS(null,attrib,this.highlightStyles[attrib]);
			}
			this.scrollPercent(this.scrollDir,this.scrollStep*10);
			this.timer.setTimeout("scrollPerScrollbar",400);
		}
	}
	if (evt.type == "mousemove" && this.scrollStatus) {
		//this is for scrolling per scroller
		this.scroll(evt);
	}
	if (evt.type == "mouseup") {
		//this is for finishing the different scroll modi
		if (this.scrollStatus) {
			//finishing scroll per scroller
			this.scroll(evt);
		}
		if (this.buttonScrollActive) {
			//finishing scroll per button
			this.buttonScrollActive = false;
			document.documentElement.removeEventListener("mouseup",this,false);
			//change appearance of button
			for (var attrib in this.highlightStyles) {
				this.currentScrollButton.removeAttributeNS(null,attrib);
			}
			for (var attrib in this.scrollerStyles) {
				this.currentScrollButton.setAttributeNS(null,attrib,this.scrollerStyles[attrib]);
			}
			//change appearance of triangle
			for (var attrib in this.scrollerStyles) {
				this.currentScrollTriangle.removeAttributeNS(null,attrib);
			}
			for (var attrib in this.triangleStyles) {
				this.currentScrollTriangle.setAttributeNS(null,attrib,this.triangleStyles[attrib]);
			}
			this.currentScrollButton = undefined;
			this.currentScrollTriangle = undefined;
		}
		if (this.scrollbarScrollActive) {
			//finishing scroll per scrollbar
			this.scrollbarScrollActive = false;
			document.documentElement.removeEventListener("mouseup",this,false);		
			//change styling
			for (var attrib in this.highlightStyles) {
				this.scroller.removeAttributeNS(null,attrib);
			}
			for (var attrib in this.scrollerStyles) {
				this.scroller.setAttributeNS(null,attrib,this.scrollerStyles[attrib]);
			}
		}
	}
}

scrollbar.prototype.scroll = function(evt) {
	var coords = myMapApp.calcCoord(evt,this.scrollbar);
	if (evt.type == "mousedown") {
		document.documentElement.addEventListener("mousemove",this,false);
		document.documentElement.addEventListener("mouseup",this,false);
		this.scrollStatus = true;
		this.panCoords = coords;
		this.fireFunction("scrollStart");
		//change styling
		for (var attrib in this.scrollerStyles) {
			this.scroller.removeAttributeNS(null,attrib);
		}
		for (var attrib in this.highlightStyles) {
			this.scroller.setAttributeNS(null,attrib,this.highlightStyles[attrib]);
		}
	}
	if (evt.type == "mousemove") {
		var diffX = coords.x - this.panCoords.x;
		var diffY = coords.y - this.panCoords.y;
		var scrollerDiff = false;
		if (this.horizOrVertical == "vertical") {
			var scrollerOrigY = this.scrollerY;
			this.scrollerY += diffY;
			if (this.scrollerY < this.scrollbarY) {
				this.scrollerY = this.scrollbarY;
			}
			if ((this.scrollerY + this.scrollerHeight) > (this.scrollbarY + this.scrollbarHeight)) {
				this.scrollerY = this.scrollbarY + this.scrollbarHeight - this.scrollerHeight;
			}
			this.scroller.setAttributeNS(null,"y",this.scrollerY);
			if (scrollerOrigY != this.scrollerY) {
				scrollerDiff = true;
			}
		}
		if (this.horizOrVertical == "horizontal") {
			var scrollerOrigX = this.scrollerX;
			this.scrollerX += diffX;
			if (this.scrollerX < this.scrollbarX) {
				this.scrollerX = this.scrollbarX;
			}
			if ((this.scrollerX + this.scrollerWidth) > (this.scrollbarX + this.scrollbarWidth)) {
				this.scrollerX = this.scrollbarX + this.scrollbarWidth - this.scrollerWidth;
			}
			this.scroller.setAttributeNS(null,"x",this.scrollerX);
			if (scrollerOrigX != this.scrollerX) {
				scrollerDiff = true;
			}
		}
		if (scrollerDiff) {
			this.fireFunction("scrollChange");
		}
		this.panCoords = coords;
	}
	if (evt.type == "mouseup") {
		this.scrollStatus = false;
		document.documentElement.removeEventListener("mousemove",this,false);
		document.documentElement.removeEventListener("mouseup",this,false);
		//change styling
		for (var attrib in this.highlightStyles) {
			this.scroller.removeAttributeNS(null,attrib);
		}
		for (var attrib in this.scrollerStyles) {
			this.scroller.setAttributeNS(null,attrib,this.scrollerStyles[attrib]);
		}
		this.fireFunction("scrollEnd");
	}
}

scrollbar.prototype.scrollPercent = function(direction,increment) {
	var currentValues = this.getValue();
	if (direction == "up") {
		increment = increment * -1;
	}
	var newPercent = currentValues.perc + increment;
	if (newPercent < 0) {
		newPercent = 0;
	}
	if (newPercent > 1) {
		newPercent = 1;
	}
	this.scrollToPercent(newPercent);
}

scrollbar.prototype.scrollToPercent = function(percValue) {
	if (percValue >= 0 && percValue <= 1) {
		if (this.horizOrVertical == "vertical") {
			var newY = this.scrollbarY + (this.scrollbarHeight - this.scrollerHeight) * percValue;
			this.scrollerY = newY;
			this.scroller.setAttributeNS(null,"y",newY);
		}
		if (this.horizOrVertical == "horizontal") {
			var newX = this.scrollbarX + (this.scrollbarWidth - this.scrollerWidth) * percValue;
			this.scrollerX = newX;
			this.scroller.setAttributeNS(null,"x",newX);
		}
		this.fireFunction("scrolledStep");
	}
	else {
		alert("error in method '.scrollToPercent()' of scrollbar with id '"+this.id+"'. Value out of range. Value needs to be in range 0 <= value <= 1.");
	}
}

scrollbar.prototype.scrollPerButton = function() {
	if (this.buttonScrollActive) {
			this.scrollPercent(this.scrollDir,this.scrollStep);
			this.timer.setTimeout("scrollPerButton",150);
	}
}

scrollbar.prototype.scrollPerScrollbar = function() {
	if (this.scrollbarScrollActive) {
			this.scrollPercent(this.scrollDir,this.scrollStep*5);
			this.timer.setTimeout("scrollPerScrollbar",150);
	}
}

scrollbar.prototype.scrollToValue = function(value) {
	if ((value >= this.startValue && value <= this.endValue) || (value <= this.startValue && value >= this.endValue)) {
		var percValue = value/(this.endValue - this.startValue);
		this.scrollToPercent(percValue);
	}
	else {
		alert("Error in scrollbar with id '"+this.id+"': the provided value '"+value+"' is out of range. The valid range is between '"+this.startValue+"' and '"+this.endValue+"'");
	}
}

scrollbar.prototype.getValue = function() {
	var perc;
	if (this.horizOrVertical == "vertical") {
		perc = (this.scrollerY - this.scrollbarY) / (this.scrollbarHeight - this.scrollerHeight);
	}
	if (this.horizOrVertical == "horizontal") {
		perc = (this.scrollerX - this.scrollbarX) / (this.scrollbarWidth - this.scrollerWidth);
	}
	var abs = this.startValue + (this.endValue - this.startValue) * perc;
	return {"abs":abs,"perc":perc};
}

scrollbar.prototype.fireFunction = function(changeType) {
	var values = this.getValue();
	if (typeof(this.functionToCall) == "function") {
		this.functionToCall(this.id,changeType,values.abs,values.perc);
	}
	if (typeof(this.functionToCall) == "object") {
		this.functionToCall.scrollbarChanged(this.id,changeType,values.abs,values.perc);
	}
	if (typeof(this.functionToCall) == undefined) {
		return;
	}
}

scrollbar.prototype.hide = function() {
	this.parentGroup.setAttributeNS(null,"display","none");
}

scrollbar.prototype.show = function() {
	this.parentGroup.setAttributeNS(null,"display","inherit");
}

scrollbar.prototype.remove = function() {
	this.parentGroup.parentNode.removeChild(this.parentGroup);
}
//scrollbar.js end