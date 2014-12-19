function GetFormData( srId)
{
   var formid = document.all("formid").value;
   $.get("./public/GetFormData.aspx",{SrId:srId,FormId:formid},function(data,textStatus){LoadData(data.xml); }); 
   //$.ajax({ type: "GET", url: "./public/GetFormData.aspx", data: "SrId="+srId+"&FormId="+"斯蒂芬", contentType: "text/xml; charset=gb2312",  dataType: "xml",success:function(data,textStatus){alert('a');LoadData(data.xml); }});
   $("#docId").val(srId);
}

//导入数据
  function LoadData(xmlData)
  {   
      var dom = new ActiveXObject("Msxml2.DOMDocument.3.0");
      dom.loadXML(xmlData);
      var rootAllXml = dom.documentElement;
      var temfield,temfieldvalue,temfieldname;
      
      for(var i = 0 ;i<rootAllXml.getElementsByTagName("Field").length;i++){
        temfield = rootAllXml.getElementsByTagName("Field").item(i);
        temfieldvalue = temfield.text;
        temfieldname = temfield.getAttribute("name");
        if(document.all.item(temfieldname)) 
        { if(document.all(i).type!="checkbox")
             document.all.item(temfieldname).value= temfieldvalue ;
          else if(document.all(i).type=="checkbox" && temfieldvalue!=null&& temfieldvalue!="")
             document.all.item(temfieldname).checked = true ; 
        }
      }
   
   
      for(var i = 0 ;i< rootAllXml.getElementsByTagName("Multirow").length;i++){
         var temparent = rootAllXml.getElementsByTagName("Multirow").item(i);
         //行数
         var count = temparent.childNodes(0).text.split(",").length;
         //删除动态行的所有行
         var tableObj = document.all.item("table_" + temparent.attributes(0).nodeValue);
         if(tableObj==null) continue;
         var dynaObj = document.all.item(temparent.attributes(0).nodeValue);
         if(dynaObj==null) continue;
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
           var temstring = temfield.text.split(",");
           temfieldname = temfield.getAttribute("name");
       
         //行循环
          for(var j = 1;j<count;j++){
            document.all.item(temfieldname)(j).value=temstring[j];
          }
      
        }
       }
 
  }
