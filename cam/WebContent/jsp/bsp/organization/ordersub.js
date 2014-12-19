function init(){
 	var command=new L5.Command("org.loushang.bsp.organization.cmd.StruCommand");
  	command.setParameter("struId",struId);
  	command.execute("getAllChildForOrder");

	if (!command.error) {

    	var text =command.getReturn("text");
     	var value =command.getReturn("value");

     	var textOptions=text.split(",");
     	var valueOptions=value.split(",");
     	var len;
     	if(textOptions.length==valueOptions.length){
     		len=textOptions.length;
     	}else{
     		len=textOptions.length>valueOptions.length?valueOptions.length:textOptions.length;
     	}
     	var subStruSelect=document.getElementById('subStruSelId');
     	for(var i=0;i<len;i++){
     		var varItem = new Option(textOptions[i],valueOptions[i]);
        	subStruSelect.options.add(varItem);

     	}
     	var sellen=subStruSelect.options.length;
		if(sellen>20){
			subStruSelect.size=sellen;
		}

		}else{
			alert(command.error);
		}

}


function confirmValue(){
var parentId=struId;
  var subStruSelect=document.getElementById('subStruSelId');
  var selLength=subStruSelect.options.length;
  var list="";
  for(var i=0;i<selLength;i++){
   list=list+subStruSelect.options[i].value+","  ;
  }
  list=list.substr(0,list.length-1);

   var command=new L5.Command("org.loushang.bsp.organization.cmd.StruCommand");
  command.setParameter("parentId",parentId);
   command.setParameter("newOrderList",list);
  command.execute("changeStruOrder");
  if (!command.error) {
	alert("操作成功!");
	window.returnValue="OK";
	window.close();
	}else{
		alert(command.error);
		return false;
	}

}

 //向上
function  turnToSelUp(){
var subStruSelect=document.getElementById('subStruSelId');
var selIndex=GetIndex(subStruSelect);

if(selIndex==0 || selIndex==-1){
return false;
}
 var  SelOpt = subStruSelect.options[selIndex];
 var  UpOpt=subStruSelect.options[selIndex-1];
subStruSelect.remove(selIndex);
 try {
     subStruSelect.add(SelOpt, UpOpt); // standards compliant; doesn't work in IE
    }
    catch(ex) {
     subStruSelect.add( SelOpt,selIndex-1); // IE only
    }

}

//向下
function turnToSelDown(){
var subStruSelect=document.getElementById('subStruSelId');
var selIndex=GetIndex(subStruSelect);
var selLength=subStruSelect.options.length;
if(selIndex==selLength-1 || selIndex==-1){
return false;
}
 var  SelOpt = subStruSelect.options[selIndex];
 var  DownOpt=subStruSelect.options[selIndex+1];
subStruSelect.remove(selIndex+1);
 try {
     subStruSelect.add(DownOpt, SelOpt); // standards compliant; doesn't work in IE
    }
    catch(ex) {
     subStruSelect.add(DownOpt,selIndex); // IE only
    }
}

//顶端
function  turnToSelTop(){
var subStruSelect=document.getElementById('subStruSelId');
var selIndex=GetIndex(subStruSelect);
if(selIndex==0  || selIndex==-1){
return false;
}
 var  SelOpt = subStruSelect.options[selIndex];
 var  FirstOpt=subStruSelect.options[0];
subStruSelect.remove(selIndex);
 try {
     subStruSelect.add(SelOpt, FirstOpt); // standards compliant; doesn't work in IE
    }
    catch(ex) {
     subStruSelect.add( SelOpt, 0); // IE only
    }

}

//底端
function  turnToSelBottom(){
var subStruSelect=document.getElementById('subStruSelId');
var selIndex=GetIndex(subStruSelect);
var selLength=subStruSelect.options.length;
if(selIndex==selLength-1  || selIndex==-1){
return false;
}
 var  SelOpt = subStruSelect.options[selIndex];
subStruSelect.remove(selIndex);
 try {
     subStruSelect.add(SelOpt,null); // standards compliant; doesn't work in IE
    }
    catch(ex) {
     subStruSelect.add( SelOpt); // IE only
    }


}

//获得选中的索引
function GetIndex(obj){
 return obj.selectedIndex;
}

function closew(){
	//return false;
	//window.returnValue="";
	window.close();

}