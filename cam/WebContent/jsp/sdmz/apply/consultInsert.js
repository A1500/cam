/**
 * @title:
 * @description:初始化
 * @author:
 * @since:2011-06-08
 * @param
*/

function init(){
	var consultDataset=L5.DatasetMgr.lookup("consultDataset");
	var cityDateSet=L5.DatasetMgr.lookup("cityDateSet");
	cityDateSet.setParameter("filterSql", "leve='1' and id= '" + organArea + "00000000'");
	cityDateSet.load();	
	cityDateSet.on('load',function(){
		document.getElementById("city").value=organArea+ "00000000";
		document.getElementById("city").setAttribute("disabled","true");
	});
	areaDataset.setParameter("filterSql"," leve='2' and substr(id,0,4)= '" + organArea + "'");
	areaDataset.on("load", function onareaDatasetLoad(){
	//根据当前登录单位的区划不同调用不同的处理方法；
		if(sign==2)//区用户
	    {	
	    	var area = document.getElementById("area");
	    	area.disabled="disabled";
	    	
	    	for(var i= 0; i < areaDataset.getTotalCount(); i++) {
	    		var rec = areaDataset.getAt(i);
	    		if(rec.get("value") == organValue) {
	    			area.selectedIndex = i+1;
	    			break;
	    		}
	    	}	
	    }
	    else if(sign==3)//街道用户
	    {	
	    	var area = document.getElementById("area");
	    	area.disabled="disabled";
	    	
	    	for(var i= 0; i < areaDataset.getTotalCount(); i++) {
	    		var rec = areaDataset.getAt(i);
	    		if(rec.get("value") == parentOrganValue) {
	    			area.selectedIndex = i+1;
	    			break;
	    		}
	    	}	
	    }
	    else if(sign==4)//村委会用户
	    {	
	   	   
	    	var area = document.getElementById("area");
	    	area.disabled="disabled";
	    	
	    	for(var i= 0; i < areaDataset.getTotalCount(); i++) {
	    		var rec = areaDataset.getAt(i);
	    		
	    		if(rec.get("value") == organValue) {
	    		
	    			area.selectedIndex = i+1;
	    			break;
	    		}
	    	}
	    	
	    }
	});
    L5.DatasetMgr.lookup("areaDataset").load();
    if(sign==1){
    }else if(sign==2)
    {	//区用户登录的时候加载街道
     	streetDataset.setParameter("filterSql"," leve='3' and substr(id,1,6)= '"+organValue.substr(0,6)+"'");
    	L5.DatasetMgr.lookup("streetDataset").load();
    	
    }
    else if(sign==3)
    {	//街道用户登录的时候加载街道
    
    streetDataset.setParameter("filterSql"," leve='3' and substr(id,1,6)= '"+organValue.substr(0,6)+"'");
    L5.DatasetMgr.lookup("streetDataset").load();
    	
    }
     else if(sign==4)
    {	//村委会用户登录时候加载街道
  
    
    streetDataset.setParameter("filterSql"," leve='3' and substr(id,1,6)= '"+organValue.substr(0,6)+"'");
    L5.DatasetMgr.lookup("streetDataset").load();
    	
    }
	
	consultDataset.load();
}

//得到街道
function getStreet() {
	if(sign==1){
		var dzZhenquery = document.getElementById("area").value;
		
		streetDataset.setParameter("filterSql"," leve='3' and substr(id,1,6)= '"+dzZhenquery.substr(0,6)+"'");
	    L5.DatasetMgr.lookup("streetDataset").load();
    }
 }
 
 //验证文本域的长度
function checkTextarea(num,name){
	elementTxt=document.getElementById(name);
	if(elementTxt.value.length>num){
	alert("输入的字符过多")
	elementTxt.focus();
	elementTxt.value="";
	return false;
	}
}
//验证家庭人口
function CheckJtrk()
 {
 var regExp=/^[0-9]{1,2}$/;
 var elementTxt=document.getElementById("applyPeopleNum");
 	if(regExp .test (elementTxt.value ))
 	{
 	return true ;
 	}
	else
 	{
	  alert ('家庭人口不合法');
	  elementTxt.focus();
	  elementTxt.value="";
	  return false ;
 	} 
 }
//固定电话校验
function __isFixedTelephone(s){
	return /^(\d{2,4}-)?((\(\d{3,5}\))|(\d{3,5}-))?\d{3,8}(-\d+)?$/g.test(s);
}
 //手机校验
function __isMobileTelephone(s) {
	return /^1(3\d|(58|59|56|52|53|50|89|88|87|86|85|83|82|55|51|57|45|47))\d{8}$/g.test(s);
}
//固定电话
function checkDhhm(){
  var dhhm = document.getElementById("applyTel");
    if(trim(dhhm.value)!=""&&!__isFixedTelephone(trim(dhhm.value))&&!__isMobileTelephone(trim(dhhm.value)))
  {
     alert("请输入正确的电话号码！");
  	 dhhm.value="";
     dhhm.focus();
     return false;
  }
  return true;
}
function trim(str){ 
   var start = -1,    
   end = str.length;
   while (str.charCodeAt(--end) < 33);    
   while (str.charCodeAt(++start) < 33);    
   return str.slice(start, end + 1);    
	} 

//手机
 function checkSjhm(){
  var sjhm = document.getElementById("sjhm");
    if(trim(sjhm.value)!=""&&!__isMobileTelephone(trim(sjhm.value)))
  {
     alert("请输入正确的手机号码！");
  	 sjhm.value="";
     sjhm.focus();
     return false;
  }
  return true;
}
 
//点击确定按钮的时候调用的函数
function Evt_butsave_onclick(){
	
	var consultDataset = L5.DatasetMgr.lookup("consultDataset");
	var consultRecord=consultDataset.getCurrent();
	var value0=consultRecord.get("handleResult");
	var value1=consultRecord.get("agreeState");
	var value2=consultRecord.get("street");
	var value3=consultRecord.get("applyPeople");
	var value4=consultRecord.get("applyIdcard");
	var value5=consultRecord.get("applyWay");
	var value6=consultRecord.get("applyTel");
	var value7=consultRecord.get("applyReasons");
	var value8=consultRecord.get("handleOpinion");
	var value9=consultRecord.get("handleResult");
	var area=document.getElementById("area").value;
	
	
	if(value0=="0"){
		if(value1==""){
		L5.Msg.alert("提示","请选择是否同意！");
		return;
		}
	}
	if(value3==""){
		L5.Msg.alert("提示","请填写咨询人！");
		return;
		}
	if(value4==""){
		L5.Msg.alert("提示","请填写身份证号！");
		return;
		}
	if(value5==""){
		L5.Msg.alert("提示","请填写咨询方式！");
		return;
		}
	if(value6==""){
		L5.Msg.alert("提示","请填写联系电话！");
		return;
		}
	if(value7==""){
		L5.Msg.alert("提示","请填写咨询内容！");
		return;
		}
	if(value8==""){
		L5.Msg.alert("提示","请填写本单位意见！");
		return;
		}
	if(value9==""){
		L5.Msg.alert("提示","请选择受理结果！");
		return;
		}
	
	var command = new L5.Command("com.inspur.sdmz.apply.cmd.SamApplySaveCmd");
	command.setParameter("consultRecord", consultRecord.toBean("com.inspur.sdmz.apply.data.SamApply"));
	command.setParameter("area",area);
	command.execute("consultSave");
	if (!command.error) {
			var url='jsp/sdmz/apply/consultHandleList.jsp';
   		var text = '困难户信息查询';
   		L5.Msg.alert("提示","保存成功！",function(){L5.forward(url,text);});
	}else{
		L5.Msg.alert("错误",command.error);
	}
}

//点击取消按钮时调用的函数
function Evt_butreturn_onclick(){
	var url='jsp/sdmz/apply/consultHandleList.jsp';
    var text = '困难户信息查询';
    L5.forward(url,text);
}
//根据需要控制组件的是否可编辑
function disable4(){
document.getElementById("agreeState").disabled="disabled";
document.getElementById("area").disabled="disabled";
document.getElementById("street").disabled="disabled";
}
function disable2(){
if(sign==1){
document.getElementById("area").disabled="";
}
document.getElementById("agreeState").disabled="disabled";
document.getElementById("street").disabled="";
}
function disable1(){
document.getElementById("agreeState").disabled="";
document.getElementById("area").disabled="disabled";
document.getElementById("street").disabled="disabled";	
}
