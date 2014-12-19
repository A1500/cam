/**
 * @title:
 * @description:初始化
 * @author:
 * @since:2011-06-08
 * @param
*/
function init() {
	var applyDataset = L5.DatasetMgr.lookup("applyDataset");
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
		if(sign==2)//区用户登录的时候
	    {	
	    	var area = document.getElementById("area");
	    	area.disabled="disabled";
	    	
	    	for(var i= 0; i < areaDataset.getTotalCount(); i++) {
	    		var rec = areaDataset.getAt(i);
	    		if(rec.get("value") == organValue) {//指定区组件内的值为当前登录单位
	    			area.selectedIndex = i+1;
	    			break;
	    		}
	    	}	
	    }
	    else if(sign==3)//街道用户登录的时候
	    {	
	   	  
	    	var area = document.getElementById("area");
	    	area.disabled="disabled";
	    	
	    	for(var i= 0; i < areaDataset.getTotalCount(); i++) {
	    		var rec = areaDataset.getAt(i);
	    		if(rec.get("value") == parentOrganValue) {//指定区组件内的值为当前登录单位的上级区单位
	    			area.selectedIndex = i+1;
	    			break;
	    		}
	    	}	
	    }
	     else if(sign==4)//村委会登录的时候
	    {	
	   	   
	    	var area = document.getElementById("area");
	    	area.disabled="disabled";
	    	
	    	for(var i= 0; i < areaDataset.getTotalCount(); i++) {//指定区组件内的值为当前登录单位的上级区单位
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
    {	
    	//区用户登录加载街道
     	streetDataset.setParameter("filterSql"," leve='3' and substr(id,1,6)= '"+organValue.substr(0,6)+"'");
    	L5.DatasetMgr.lookup("streetDataset").load();
    	
    }
    else if(sign==3)
    {	
   
    //街道用户登录加载街道
    streetDataset.setParameter("filterSql"," leve='3' and substr(id,1,6)= '"+organValue.substr(0,6)+"'");
    L5.DatasetMgr.lookup("streetDataset").load();
    	
    }
     else if(sign==4)
    {	
  
    //村委会用户登录加载街道
    streetDataset.setParameter("filterSql"," leve='3' and substr(id,1,6)= '"+organValue.substr(0,6)+"'");
    L5.DatasetMgr.lookup("streetDataset").load();
    	
    }
	applyDataset.load();
	
}

//得到街道
function getStreet() {
	if(sign==1){
		var dzZhenquery = document.getElementById("area").value;
		
		streetDataset.setParameter("filterSql"," leve='3' and substr(id,1,6)= '"+dzZhenquery.substr(0,6)+"'");
	    L5.DatasetMgr.lookup("streetDataset").load();
    }
 }
//点击确定的时候 触发的函数
function Evt_butsave_onclick(){
	var applyDataset = L5.DatasetMgr.lookup("applyDataset");
	var applyRecord=applyDataset.getCurrent();
	
	var value0=applyRecord.get("handleResult");
	var value1=applyRecord.get("agreeState");
	var value2=applyRecord.get("street");
	var value3=applyRecord.get("handleOpinion");
	var value4=applyRecord.get("handleResult");
	var area=document.getElementById("area").value;
	
	if(value0=="0"){
		if(value1==""){
		L5.Msg.alert("提示","请选择是否同意！");
		return;
		}
	}
	if(value3==""){
		L5.Msg.alert("提示","请填写本单位意见！");
		return;
		}
	if(value4==""){
		L5.Msg.alert("提示","请选择受理结果！");
		return;
		}
	
	var command = new L5.Command("com.inspur.sdmz.apply.cmd.SamApplySaveCmd");
	command.setParameter("area",area);
	command.setParameter("samapplyRecord", applyRecord.toBean("com.inspur.sdmz.apply.data.SamApply"));
	command.execute("samapplyUpdate");
	if (!command.error) {
			var url='jsp/sdmz/apply/assistanceCheckList.jsp';
   		var text = '困难户信息查询';
   		L5.Msg.alert("提示","保存成功！",function(){L5.forward(url,text);});
	}else{
		L5.Msg.alert("错误",command.error);
	}
}
//点击返回按钮时触发函数
function Evt_butreturn_onclick(){
	var url='jsp/sdmz/apply/assistanceCheckList.jsp';
    var text = '困难户信息查询';
    L5.forward(url,text);
}
//组件的是否可编辑触发事件
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