
/***************************根据姓名设置姓名拼音码开始****************************************/
/**
 *	名	 称：getCrjCnStrSpell
 *	功	 能：转化中文姓(名)到拼音姓(名)
 *	参数说明：
 *		namebase  中文输入域
 *		phoneticCode  英文输入域
 *		sType	 转化类型，x为姓 m为名
 *  例	 子：getCrjCnStrSpell("namebase","phoneticCode","m");
 *  修    改： licb   20110904
**/
function getCrjCnStrSpell(namebase,spFName,sType){
	var cnStr = document.getElementById("namebase").value;
	if((cnStr != "")){
	    var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleDisabilityNameCommand");
	    
        command.setParameter("cnStr",cnStr);
	    command.setParameter("sType", sType);
	    command.execute("getCnStr");
	    var sp=command.getReturn('jsonString');//获取姓名拼音码
	    var spObj = eval('('+sp+')'); 
		if(spObj){
			var str;
			/**
			if(spObj.spell.length>1){
			
				str = "<div id=_"+spFName+"_ style='display: inline; width: 138px'><div>";
				str += "<input style='width: 118px' onclick=spshowdown("+spFName+"Div,'"+spFName+"'); onchange=\"checkEN('"+spFName+"','idCard','拼音域')\" value="+spObj.spell[0]+" name="+spFName+">";
				str += "<input hideFocus style='border-right: #8db1d3 1px solid; border-TOP: #8db1d3 1px solid; font-SIZE: 9px; background: azure; " +
						"border-left: azure 1px solid; width: 19px; border-bottom: #8db1d3 1px solid; font-family: webdings; height: 19px' "+
						"onclick=spshowdown("+spFName+"Div,'"+spFName+"') tabIndex=-1 type=button value=6 name=b_sex UNSELECTABLE='on'></div>";
				str += "<div id="+spFName+"Div style='border-right: dimgray 1px solid; border-TOP: dimgray 1px solid; display: none; z-index: 500; " +
						"background: white; filter: progid:DXImageTransform.Microsoft.Shadow(color=#666666, Direction=135, Strength=3); " +
						"border-left: dimgray 1px solid; width: 100%; border-bottom: dimgray 1px solid; position: absolute; height: 10px'>";
				str += "<table onmouseover=\"spdomouseoverd();\" onclick=\"spdoclick("+spFName+"Div, '"+spFName+"');\" onmouseout=\"spdomouseout();\" cellSpacing=1 " +
						"cellPadding=0 width='100%' border=0>";
				for(var i=0;i<spObj.spell.length;i++){
					str += "<tr><td style='border-right: #ffffff 1px solid; border-top: #ffffff 1px solid; border-left: #ffffff 1px solid; border-bottom: #ffffff 1px solid' noWrap val='"+spObj.spell[i]+"'>"+spObj.spell[i]+"</td></tr>";
				}
				str += "</table></div></div>";
				alert(str);
				if(sType == "x") {
					//alert("您输入的中文姓存在多音字\n   请注意选择拼音姓！");
				} else if(sType == "m") {
					//alert("您输入的中文名存在多音字\n   请注意选择拼音名！");
				} else {
					//alert("请注意:存在多音字！");
				}
			}else if(spObj.spell.length==1){
				str = '<input type="text" name="'+spFName+'" value="'+spObj.spell[0]+'" onblur="checkEN(\''+spFName+'\',\'idCard\',\'拼音域\')" maxlength="30" size="18">';
			}*/
			
			if(spObj.spell.length>=1){
				str = '<input type="hidden" name="'+spFName+'" value="'+spObj.spell[0]+'" onblur="checkEN(\''+spFName+'\',\'idCard\',\'拼音域\')" maxlength="30" size="18">';
			}else{
				//alert("可能您输入的汉字中有生僻字或者特殊字符，系统没有完成拼音转化，请手工输入！");
				str = '<input type="hidden" name="'+spFName+'" value="" onblur="checkEN(\''+spFName+'\',\'idCard\',\'拼音域\')" maxlength="30" size="18">';
			}
			var spDivObjId = "_"+spFName+"_";
			if(document.getElementById(spDivObjId) == undefined){
				document.getElementsByName(spFName)[0].outerHTML = str;
			}else{
				document.getElementById(spDivObjId).outerHTML = str;
			}
			document.body.attachEvent("onclick", new Function("sphiddenshowdown('"+spFName+"Div','_"+spFName+"_')"));
		}
	}
} 

// 拼音，打开或关闭下拉框
function spshowdown(objId,textName){
    document.getElementById(textName).select();
	objId.style.display = (objId.style.display=="block")?"none":"block";
}
// 拼音，点击body收回下拉
function sphiddenshowdown(objId,topObjId){
	if(document.getElementById(objId) != undefined){
		if(!document.getElementById(topObjId).contains(event.srcElement)){
			document.getElementById(objId).style.display = 'none';
		}
	}
}
// 拼音，鼠标移动到选项
function spdomouseoverd(){
	window.event.cancelBubble = true;
	var ob = event.srcElement;
	if(ob.tagName=="TD"){
		ob.style.border="1 solid #FF9933";
	}
}
// 拼音，鼠标移开选项
function spdomouseout(){
	window.event.cancelBubble = true;
	var ob = event.srcElement;
	if(ob.tagName=="TD"){
		ob.style.border="1 solid #ffffff";
	}
}
// 拼音，鼠标点击一条选项
function spdoclick(objId,textObjName){
	var ob = event.srcElement;
	if(ob.tagName=="TD"){
		objId.style.display = "none";
		document.getElementById(textObjName).value=ob.val;
	    //document.getElementById("phoneticCode").fireEvent('onchange');//TODO
	}
}

function checkEN(code,idCard,field) {
	
}
/***************************根据姓名设置姓名拼音码结束****************************************/
 