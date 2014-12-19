/**
*动态行增加一行
* 参数: tableObj
*/
var actionClicked = false;  //是否点过本地操作
//文本框变色
function  appendit()   
{   
  var   nodes   =   document.getElementsByTagName("INPUT");   
  for   (var   i=0;   i<nodes.length;   i++)   
  {   
    var   ctype   =   nodes[i].getAttribute("type");   
    if   (ctype   ==   'text')    
    {   
      nodes[i].onfocus   =   function   ()   {   this.style.backgroundColor='#e6e7e6';   }   
      nodes[i].onblur   =   function   ()   {   this.style.backgroundColor='#ffffff';   }   
     }   
  }   
  nodes   =   document.getElementsByTagName("TEXTAREA");   
  for   (var   i=0;   i<nodes.length;   i++)   
  {    
      nodes[i].onfocus   =   function   ()   {   this.style.backgroundColor='#e6e7e6';   }   
      nodes[i].onblur   =   function   ()   {   this.style.backgroundColor='#ffffff';   }    
  }   
}   
function addrow(tableObjname,rowno){
	var tableObj = document.all.item(tableObjname);
	if(tableObj==null||tableObj.tagName!="TABLE"){
		return;
	}
	var tr=tableObj.rows[1];
	if(tr!=null){
		for(j=1;j<=rowno;j++){
		try{
		  var ntr=tableObj.insertRow();
		  ntr.ondblclick = tr.ondblclick;
	   		for(var i=0;i<tr.cells.length;i++){
		     var otd=ntr.insertCell();
		     //处理日期控件
		     var temhtml;
		     if(tr.cells[i].innerHTML.indexOf("datetime")>0){
		        temhtml = tr.cells[i].innerHTML.replace(/rowIndex/g,ntr.rowIndex);
		        otd.innerHTML=temhtml.replace("l_must","v_must");
		     }else{
		        otd.innerHTML = tr.cells[i].innerHTML.replace("l_must","v_must");
		     }
		  //   otd.children[0].value="";
		 //    otd.children[0].checked=false;
		     otd.width=tr.cells[i].width;
		   //  otd.index=tr.cells[i].index;
		     otd.style.display=tr.cells[i].style.display;
	         otd.align=tr.cells[i].align;
		  	}
		}catch(ex){
		      alert("增加一行失败！"+ex.description);
		      return;
		   }
		}
	  }	
}

/**
*动态行删除一行
* 参数: tableObj
*/
function delrow(tableObj)
{ 
 if(tableObj==null||tableObj.tagName!="TABLE") return;

   for(var i=2;i<tableObj.rows.length;i++){
     var otd = tableObj.rows[i].cells[0];
     if (otd.outerHTML.indexOf("CHECKED")> 0  ) {
	try{
	 tableObj.deleteRow(i);
	 i=i-1;
	}  catch(ex)
	   {
	      alert(" 删除一行失败！"+ex.description);
	      return;
          }
       }   	   
    }
	
}
/**
* 重复节增加一行
* 参数: tableObj
*/
function addrow2(tableObjname)
{  var tableObj = document.all.item(tableObjname);
 if(tableObj==null||tableObj.tagName!="TABLE") return;
  var tr=tableObj.rows[0];
  if(tr!=null)
  { 
	try
	{
	 // tableObj.rows[1].style.display="block";
	 var ntr=tableObj.insertRow();
	  ntr.onmouseover  = tr.onmouseover ;
	  ntr.onmouseout  = tr.onmouseout ;
      for(var i=0;i<tr.cells.length;i++)
	  {
	     var otd=ntr.insertCell();
	     //处理日期控件

	     var temhtml; 
	     temhtml = tr.cells[i].innerHTML.replace(/PicRowIndex/g,ntr.rowIndex);
	     if(tr.cells[i].innerHTML.indexOf("datetime")>0){
	        temhtml = temhtml.replace(/rowIndex/g,ntr.rowIndex+1);
	        otd.innerHTML=temhtml.replace("l_must","v_must");
	        
	
	     }else
	       otd.innerHTML = temhtml.replace("l_must","v_must");
	       
	    // otd.width=tr.cells[i].width;
	    // otd.index=tr.cells[i].index;
	     otd.style.display=tr.cells[i].style.display;
	     otd.style.borderStyle=tr.cells[i].style.borderStyle;
	     otd.style.borderWidth=tr.cells[i].style.borderWidth;
	  } 
	}  catch(ex)
	   {
	      alert("增加一行失败！"+ex.description);
	      return;
	   }
	}
}
//currRowIndex 选定行
var currRowIndex = 0;
var currDivTable ;
//选定指定行
function SelectRow(objTD)
{
var objTR =objTD.parentElement;
currRowIndex = objTR.rowIndex;
currDivTable =  objTR.parentElement;
}


/**
*动态行删除一行
* 参数: tableObj
*/
function delrow2(tableObj)
{ 
 if(tableObj==null||tableObj.tagName!="TABLE") return;
 
     if(tableObj.rows.length!=2 )	{
	try{

	 tableObj.deleteRow(currRowIndex);
	 currRowIndex = 0;
	}  catch(ex)
	   {
	      alert(" 删除失败！"+ex.description);
	      return;
          }
       }   	   
}	

function changestyle(Field,ifhidden,ifitalic,fontweight,Color,bkcolor){
  if(ifhidden==1){ 
    var oldhidden= Field.getAttribute("oldhidden")
    if(oldhidden==null){	
      oldhidden = Field.style.hidden
      Field.setAttribute("oldhidden",oldhidden)	
     
    }
    Field.style.display='none'
  }
  if(ifitalic==1){
   var olditalic =Field.getAttribute("olditalic")
    if(olditalic==null){ 
      olditalic = Field.style.fontStyle;
      Field.setAttribute("olditalic",olditalic)	
    }
      Field.style.fontStyle='italic'
   
  }
  if(fontweight==1){ 
    var oldfontweight= Field.getAttribute("oldfontweight")
    if(oldfontweight ==null){ 
      oldfontweight = Field.style.fontWeight;
      Field.setAttribute("oldfontweight",oldfontweight)	
      
     }
    Field.style.fontWeight='bolder'
  }
  if(Color!=""){ 
    var oldColor= Field.getAttribute("oldColor")
    if(oldColor ==null){ 
     oldColor = Field.style.color;
     Field.setAttribute("oldColor",oldColor)	
     
    }
    Field.style.color=Color
  }
  if(bkcolor!=""){ 
    var oldbkcolor= Field.getAttribute("oldbkcolor")
    if(oldbkcolor==null){ 
      oldbkcolor = Field.style.backgroundColor;
      Field.setAttribute("oldbkcolor",oldbkcolor)	
     
     }
      Field.style.backgroundColor=bkcolor
   }
}
function restorestyle(Field){
     var oldhidden =  Field.getAttribute("oldhidden")	
     
     if(oldhidden!=null) { Field.style.display=oldhidden;}
     		
     var olditalic =  Field.getAttribute("olditalic")	
     if(olditalic!=null) {Field.style.fontStyle=olditalic;}
     	
     var oldfontweight =  Field.getAttribute("oldfontweight")	
     if(oldfontweight!=null) Field.style.fontWeight=oldfontweight;
     
     var oldColor =  Field.getAttribute("oldColor")	
     if(oldColor!=null) Field.style.color=oldColor;
     
     var oldbkColor =  Field.getAttribute("oldbkcolor")	
     if(oldbkColor!=null) Field.style.backgroundColor=oldbkColor;		
}



function hideallpage(pagesdiv){
	
	for(v=0;v<document.all.item(pagesdiv).children.length;v++){
		document.all.item(pagesdiv).children[v].style.display="none";
	}
}
function showpage(pagesdiv,pagedivid){
        hideallpage(pagesdiv);
	    document.all.item(pagedivid).style.display="";	
	    
//	    var pageheight = document.body.scrollHeight;
//	    if(parent.document.getElementById("iframe1")!=null)
//	    {
//			parent.document.getElementById("iframe1").style.height=pageheight;
//	    }
//	    else
//	    {
//			document.getElementsByTagName("Div")[0].style.height="90%";
//	    }
	
}
function getFirstPage(pagesdiv){
   var page= document.all.item(pagesdiv);
   for(var i=0;i<page.children.length;i++){
     var tdName = "td_"+ page.children[i].id;
      if(document.all.item(tdName)!=null)
       if(document.all.item(tdName).style.display!="none")
         return  page.children[i].id;
   }
   return  page.children[0].id ;
}

function initpages(){
	var page=document.getElementsByTagName("div");
	for(i=0;i<page.length;i++){
	  if(page[i].id.indexOf("pages")==0)
	    showpage(page[i].id,getFirstPage(page[i].id));	
	}
	var tabs=document.getElementsByTagName("table");
	for(i=0;i<tabs.length;i++){ 
	  if(tabs[i].id.indexOf("tab_")==0)
	    inittabpage(tabs[i].id);	  	
	}
/*	var url = document.URL.split('?');
	if(url[1].indexOf("AjaxFormContainer") > 0)
	{
	   document.Form1.insertAdjacentHTML("afterBegin","<div class='jqmWindow' style='width:200px;' id='dialog'><p><font color='red'><strong>保存成功！</strong></p></div>");
       $('#dialog').jqm();
    }   */
	
}
function initdynas(){
	var url = document.URL.split('?');
	var queryString;
	var isnew="";
	if(url.length>1){
		queryString = url[1].split('&'); 
			for(var i=0;i<queryString.length;i++)
			{
				var queryStr;
				queryStr = queryString[i].split('=');
				if(queryStr[0]=="dataId"||queryStr[0]=="dataId"){
					isnew = queryStr[1];
					break;
				}
			}
		}
     var dynas=document.getElementsByTagName("FIELDSET");
	for(i=0;i<dynas.length;i++){ 
	   var oType = dynas[i].getAttribute("elementType");
	   var rowno = dynas[i].getAttribute("rowno");
	   if (oType=="dyna"){
	     document.all.item("table_"+dynas[i].name).rows[1].style.display="none";
	     if(isnew=="") addrow("table_"+dynas[i].name,rowno);	
	   }  
	   if (oType=="regroup") {
	     document.all.item("table_"+dynas[i].name).rows[0].style.display="none";
	     if(isnew=="") addrow2("table_"+dynas[i].name);	   
        }
	}	
	
}
function doTabpageClick(tabpage)
{
var tabtab=document.all(tabpage);
for(var i=0;i<tabtab.rows[0].cells.length;i++)
{
var ootd=tabtab.rows[0].cells[i];
ootd.className="taboffcss";

}
var otd=event.srcElement;
otd.className="taboncss";
}

function inittabpage(tabpage){
  var tabtab=document.all(tabpage);
  var  flag = 0; 
  if(tabtab.rows[0].getElementsByTagName('button').length==1){
  	tabtab.style.display="none"
  	return;
  }
  for(var i=0;i<tabtab.rows[0].cells.length;i++){
	  var ootd=tabtab.rows[0].cells[i];
	  if ( flag==0 && ootd.style.display!="none"){
	    ootd.className="taboncss";
	    flag = 1;
	  }  
	  else
	    ootd.className="taboffcss";
  }
}

function openpromptwin(obj,dicname){
	
	    var DataToSend = "treetype=all&checktype=radio";
		DataToSend += "&orgroot=0&typeid="+dicname;
		var rtnValue = DynamicDicTree(DataToSend);	
	    if (rtnValue!=""&&rtnValue!=null) 	
			{var ss = rtnValue.split("|");
             document.all.item("zidian_" + obj.id).value = ss[0];
             obj.value = ss[1];}	
        
}
function selectOrg(obj,type){
 		   var DataToSend = "treetype=org&checktype="+type;
			//DataToSend += "&haschecked=" + obj.value + "&hascheckedtext=" + obj.getAttribute("v_name");
			if(!document.all("TreeXmlData"))
			  Form1.insertAdjacentHTML("afterBegin","<input type=hidden id='TreeXmlData' name='TreeXmlData'>");
			var rtnValue = OpenTree2("../../components/generaltree/","OrgTreeView","checktype=radio");
			
			if(rtnValue == undefined) 
			{
				return "|";
			}
			else
			  return rtnValue;
			
//			var ss = rtnValue.split("|");
//			obj.value =	ss[1];
//			if(type=="radio")
//			  obj.value =	ss[1];
//            else if(type=="checkbox"){
//              
//               if(obj.value !=null && obj.value!="")
//                 obj.value = obj.value+","+ss[1];  
//               else 
//                 obj.value = ss[1];       
//    
//             }
     
}
function selectPerson(obj,type){
            var DataToSend = "treetype=user&checktype="+type;
			var rtnValue = DynamicTree(DataToSend);
			
			if(rtnValue == undefined)
			{
				return false;
			}
			
			var ss = rtnValue.split("|");
			if(type=="radio")
			  obj.value =ss[1];
            else if(type=="checkbox") { 
               if(obj.value !=null && obj.value!="")
                 obj.value = obj.value+","+ss[1];  
               else 
                 obj.value = ss[1];
             }    
} 
//显示重复节菜单
var divmenu = document.createElement("<div class=contextmenu>");
function showMenu(regroupname) 
{ document.body.appendChild(divmenu);

  divmenu.style.position='absolute';
  divmenu.style.width='40px';
  divmenu.style.height='50px'; 
  divmenu.innerHTML = "<A href=\"javascript:addrow2('table_" + regroupname + "')\">增加</A><BR><A href=\"javascript:delrow2(table_" + regroupname + ")\">删除</A>";
  divmenu.style.left=event.clientX;
  divmenu.style.top=event.clientY; 
  divmenu.style.visibility='visible';
  event.returnValue=false;
  event.calcelBubble=true;

} 
document.onmouseup=function ()
{  
    if( divmenu != null) {
    
     divmenu.style.visibility="hidden"; 
     }
} 

//沉默提交
function PostMum(DataToSend,Url)
{
	var xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.Open("POST",Url,false);
	xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlhttp.send(DataToSend);
	return xmlhttp.responseText;
}

function PostToXmlHttp(DataToSend,Url)
{
	var xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.Open("POST",Url,false);
	xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlhttp.setRequestHeader("charset","utf-8");
	xmlhttp.send(DataToSend);
	//alert(DataToSend);
	return xmlhttp.responseXml.xml;
}
function EchoAuto()
{

}

function enableChkValues(obj){
     for(var i=0;i<obj.childNodes.length;i++){
         if(obj.childNodes(i).type =="checkbox"){
            if(obj.childNodes(i).checked==false){ 
               obj.childNodes(i).value = ""; 
               obj.childNodes(i).checked = true;
             }
          }   
        enableChkValues(obj.childNodes(i));
     }
}

function printdoc(){
	 var url = document.URL;
	 var questr = document.URL.split('?');
   	 showModalDialog("../../FormPrint/SelectPublicModal.aspx?"+questr[1]+"&primaryKeys=sourcerefenceid$"+document.all("docId").value,"","dialogHeight:400px;dialogWidth:600px;help:no;status:no");
		 
}
function printdocYB(){
	    var url = document.URL;
	    var questr = document.URL.split('?');      
	     window.open("../../FormPrint/PrintModalSel.aspx?"+questr[1]+"&docid="+document.all("docId").value,"","height=400,width=600,left=150,top=150,help=no,status=no,resizable=no");
	     
}

function SelectPic(picfield,rowIndex){

  if(document.all(picfield).length>=0)
  {  
     if(document.all(picfield)(parseInt(rowIndex)).getAttribute("CanWrite")==0)
     {
       return;
     }
     var filename = showModalDialog(EcgapForm.webPath+"/skins/ecgapform/resource/selectpic.htm","","dialogHeight:200px;dialogWidth:250px;help:no;status:no");
     if (filename!=null && filename!=""){

       dataObj = document.all("base64obj");
       dataObj.filename = filename;
       dataObj.encode();
       document.all(picfield)(parseInt(rowIndex)).value = dataObj.encodeString;
       document.all("pic_"+picfield)(parseInt(rowIndex)).src=filename;
     }else{
           
     }
     return;
  }
  if(document.all(picfield).getAttribute("CanWrite")==0){
    return;
  }
  var filename = showModalDialog(EcgapForm.webPath+"/skins/ecgapform/resource/selectpic.htm","","dialogHeight:200px;dialogWidth:250px;help:no;status:no");
  if (filename!=null && filename!=""){
   //document.all("pic_"+picfield).src=filename;
   dataObj = document.all("base64obj");
   dataObj.filename = filename;
   dataObj.encode();
   document.all(picfield).value = dataObj.encodeString;
   document.all("pic_"+picfield).src=filename;
  }else{
  }
}


function replaceSubstring(inputString, fromString, toString) {
	var temp = inputString;
	if (fromString == "") {
		return inputString;
	}
	if (toString.indexOf(fromString) == -1) { 
		while (temp.indexOf(fromString) != -1) {
		var toTheLeft = temp.substring(0, temp.indexOf(fromString));
		var toTheRight = temp.substring(temp.indexOf(fromString)+fromString.length, temp.length);
		temp = toTheLeft + toString + toTheRight;
		}
	} else { 
		var midStrings = new Array("~", "`", "_", "^", "#");
		var midStringLen = 1;
		var midString = "";
		while (midString == "") {
			for (var i=0; i < midStrings.length; i++) {
				var tempMidString = "";
				for (var j=0; j < midStringLen; j++) { tempMidString += midStrings; }
				if (fromString.indexOf(tempMidString) == -1) {
				midString = tempMidString;
				i = midStrings.length + 1;
				}
			}
		} 
		while (temp.indexOf(fromString) != -1) {
		var toTheLeft = temp.substring(0, temp.indexOf(fromString));
		var toTheRight = temp.substring(temp.indexOf(fromString)+fromString.length, temp.length);
		temp = toTheLeft + midString + toTheRight;
		}
		while (temp.indexOf(midString) != -1) {
		var toTheLeft = temp.substring(0, temp.indexOf(midString));
		var toTheRight = temp.substring(temp.indexOf(midString)+midString.length, temp.length);
		temp = toTheLeft + toString + toTheRight;
		}
	} 
	return temp; 
} 


function disableChilds(obj){
     for(var i=0;i<obj.childNodes.length;i++){
       if(obj.childNodes(i).tagName =="INPUT"||obj.childNodes(i).tagName =="TEXTAREA"||obj.childNodes(i).tagName =="SELECT"){

          obj.childNodes(i).disabled= true;
          obj.childNodes(i).setAttribute("CanWrite",'0');
          
        }  
       disableChilds(obj.childNodes(i));
     }
  
  }
  function enableChilds(obj){
     for(var i=0;i<obj.childNodes.length;i++){
       if(obj.childNodes(i).tagName =="INPUT"||obj.childNodes(i).tagName =="TEXTAREA"||obj.childNodes(i).tagName =="SELECT"){

          obj.childNodes(i).disabled= false;
          if(obj.childNodes(i).name!="rtnName"){
          obj.childNodes(i).value = obj.childNodes(i).value.replace(",","，");
          }
        }  
       enableChilds(obj.childNodes(i));
     }
     actionClicked = true;
  
  }
  
  
    
  //导出数据
  function exportData(){
     var xmlDoc = new ActiveXObject("Msxml2.DOMDocument.3.0");
     var root =  xmlDoc.createElement("FormValues");
     xmlDoc.documentElement = root;
     var record = root;
     for(i = 0;i<document.all.length;i++){
       var temhtmlele = document.all(i);
       if(temhtmlele.getAttribute("elementType")!=null){ 
        //假如是动态行或重复节
         var fieldEle ;
         var parentele ;
         if(temhtmlele.getAttribute("elementType") =="dyna"||temhtmlele.getAttribute("elementType") =="regroup" ){
            fieldEle = xmlDoc.createElement("Multirow");
            fieldEle.setAttribute("name", temhtmlele.id);
            record.appendChild(fieldEle);
         }
         if( temhtmlele.getAttribute("elementType")==("txt")||temhtmlele.getAttribute("elementType")==("chk")
            ||temhtmlele.getAttribute("elementType")==("rad")||temhtmlele.getAttribute("elementType")==("area")
            ||temhtmlele.getAttribute("elementType")==("com")||temhtmlele.getAttribute("elementType")==("date"))
         {
           
           if(u_getparent(temhtmlele) !="" && u_getparent(temhtmlele) !=null) {
             
              parentele = getdynaNode(record, u_getparent(temhtmlele));
              fieldEle = getChildNode(parentele, temhtmlele.name);
           
              if( fieldEle !=null)
                fieldEle.text = fieldEle.text + "," + temhtmlele.value;
             
               else{
      
                 fieldEle = xmlDoc.createElement("Field");
                 fieldEle.setAttribute("name", temhtmlele.name);
                 fieldEle.text = temhtmlele.value;
                 parentele.appendChild(fieldEle);
               }
          }else{
            
              fieldEle = xmlDoc.createElement("Field");
              fieldEle.setAttribute("name", document.all(i).name);
              fieldEle.text = document.all(i).value;
              record.appendChild(fieldEle);
          
          }
        }
      }
     }
     
     //  alert(xmlDoc.xml);
     var fso,filehandle;
     fso = new ActiveXObject("Scripting.FileSystemObject");
     var filename = showModalDialog("../pages/selectpic.htm","","dialogHeight:200px;dialogWidth:300px;help:no;status:no");
     filehandle = fso.CreateTextFile(filename,true);
     filehandle.Write(xmlDoc.xml);
     filehandle.Close();

  }
  function u_getparent(curEle)
  {
     if(curEle.parentElement.tagName =="BODY") {
       return "";
     }
     if(curEle.parentElement.getAttribute("elementType") != null ){

       if(curEle.parentElement.getAttribute("elementType") == "dyna"|| curEle.parentElement.getAttribute("elementType") == "regroup" )
       {   
          return curEle.parentElement.id;
       }
    }else{
        return u_getparent(curEle.parentElement);
    }  
  }
  function getChildNode(parent,name)
  {
    if(parent.hasChildNodes()){
       for(var i = 0 ;i<parent.childNodes.length;i++)
         if(parent.childNodes(i).attributes(0).nodeValue == name)
           return parent.childNodes(i);
    }  
  }
  function getdynaNode(parent,name)
  {  
     for(var i = 0 ;i<parent.getElementsByTagName("Multirow").length;i++){
       if(parent.getElementsByTagName("Multirow").item(i).attributes(0).nodeValue == name)
         return parent.getElementsByTagName("Multirow").item(i);
   
     }
 
  }
  //导入数据
  function importData()
  {
      var dom = new ActiveXObject("Msxml2.DOMDocument.3.0");
//     var fso,filehandle;
//     fso = new ActiveXObject("Scripting.FileSystemObject");
//     var filename = showModalDialog("../pages/selectpic.htm","","dialogHeight:200px;dialogWidth:300px;help:no;status:no");
//     filehandle = fso.OpenTextFile(filename);
//     var filecontent = filehandle.ReadAll();
//     filehandle.Close();
      dom.loadXML(formValueXml);
      var rootAllXml = dom.documentElement;
      var temfield,temfieldvalue,temfieldname;
      
      for(var i = 0 ;i<rootAllXml.getElementsByTagName("Field").length;i++){
        temfield = rootAllXml.getElementsByTagName("Field").item(i);
        temfieldvalue = temfield.text;
        temfieldname = temfield.getAttribute("name"); 
        document.all.item(temfieldname).value= temfieldvalue ;
      }
   
     
      for(var i = 0 ;i< rootAllXml.getElementsByTagName("Multirow").length;i++){
    
         var temparent = rootAllXml.getElementsByTagName("Multirow").item(i);
         //行数
         var count = temparent.childNodes(0).text.split("$").length;
         //删除动态行的所有行
         var tableObj = document.all.item("table_" + temparent.attributes(0).nodeValue);
         var dynaObj = document.all.item(temparent.attributes(0).nodeValue);
         
         if(dynaObj.getAttribute("elementType")=="regroup"){
           for(var h=tableObj.rows.length-1;h>=1;h--)
	          tableObj.deleteRow(h);
	       for(var j = 1;j<count;j++)
             addrow2("table_" + temparent.attributes(0).nodeValue);         
	      } 
	     if(dynaObj.getAttribute("elementType")=="dyna"){
           for(var h=tableObj.rows.length-1;h>=2;h--)
	          tableObj.deleteRow(h);
	       for(var j = 1;j<count;j++)
             addrow("table_" + temparent.attributes(0).nodeValue,1);
       
	      } 
	              
         //列循环
     
         for(var  k = 0;k<temparent.childNodes.length;k++){
           temfield = temparent.childNodes(k);
           var temstring = temfield.text.split("$");
           temfieldname = temfield.getAttribute("name");
       
         //行循环
          for(var j = 1;j<count;j++){
            document.all.item(temfieldname)(j).value=temstring[j];
          }
      
        }
       }
 
  }
function showdynadetail(trObj,dynaName) 
{ 
   var rowno = trObj.rowIndex ;
   if(document.getElementById("detail_"+dynaName).value!="")
    window.open("../pages/DynaRowDetail.html?dynaname="+dynaName+"&rowno="+rowno,"","height=600,width=700,left=150,top=150,help=no,status=no,resizable=no");

}

function getUrlvalue(value)
{
		var url = document.URL.split('?');
		var queryString;
		var name;
		if(url.length>1){
			queryString = url[1].split('&'); 
			for(var i=0;i<queryString.length;i++)
			{
				if(queryString[i].toUpperCase().indexOf(value.toUpperCase()) == 0){
					name = queryString[i].substring(queryString[i].indexOf("=")+1);
					return name;
				}
			}
		}
		return "";
}
/***********************************************
工作流操作脚本区开始

created by zhangxiaolei 2008/06/12
***********************************************/


 function PostToXmlHttp(DataToSend,Url)
  {
	var xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.Open("POST",Url,false);
	xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlhttp.send(DataToSend);
	return xmlhttp.responseXml.xml;
  }
    
    
//审核意见
function OpenAudit(ActionName){
	var url = document.URL.split('?');
	var srsub = document.all;
	if(url.length>1){
	
		var ok = window.showModalDialog("../../Integrated/Public/Opinion.aspx?"+url[1]+"&sourcerefenceId="+document.all("docId").value,srsub,"dialogHeight:500px;dialogWidth:660px;help:no;status:no;dialogLeft:170px;dialogTop:90px")//"width=500,height=400,top=140,left=280")
		return ok;
	}
}

//附件
function OpenAtt(businessType,businessState,entityName)
{
    var url = document.URL.split('?');
    var vs = window.showModalDialog("../../Integrated/Resources/Tab_Fujian.aspx?EntityType=CustomForm&"+url[1]+"&BusinessType="+businessType+"&BuinessState="+businessState+"&EntityName="+entityName,window,"dialogwidth:800px; scroll:no ; dialogheight:600px;status=no");
	
}
/**  
* 把表单转换成json数据格式  
*/
function formToJsonObject(form) {
	var jsonObject = new L5.Map();
	for (i = 0, max = form.elements.length; i < max; i++) {
		e = form.elements[i];
		em = new Array();
		if (e.type == 'select-multiple') {
			for (j = 0; j < e.options.length; j++) {
				op = e.options[j];
				if (op.selected) {
					em[em.length] = op.value;
				}
			}
		}
		switch (e.type) {
			case 'radio' :
				if (!e.checked) {
					break;
				}
			case 'hidden' :
			case 'password' :
			case 'select-one' :
			case 'select-multiple' :
			case 'textarea' :
			case 'text' :
			case 'checkbox' :
				eName = e.name;
				if (e.type == 'select-multiple') {
					eValue = em.join(",");
				} else if(e.type == 'checkbox'&&!e.checked){
					eValue="";
				} else{
					eValue = e.value.replace(new RegExp('(["\\\\])', 'g'),'\\$1');
				}
				//处理动态行;动态行容器中不会出现多值,所以分割符不会混乱,如果增加了增加了动态行容器中支持多值的情形,需要修改本方法
				valueStr=jsonObject.get(eName);
				if(typeof valueStr=='undefined'){
					valueStr=eValue;
				}else{
					valueStr+=",";
					valueStr+=eValue;
				}
				jsonObject.put(eName,valueStr)
				break;
			case 'button' :
			case 'file' :
			case 'image' :
			case 'reset' :
			case 'submit' :
			default :
		}
	}
	return jsonObject;
}

function formunload(){}

