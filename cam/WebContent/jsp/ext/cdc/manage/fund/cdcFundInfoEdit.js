function init(){
	var fundDataSet=L5.DatasetMgr.lookup("fundDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	if(method=="insert"){
		document.getElementById("backInsert").style.display = "block";
		fundDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"C"});
		reportWorkDataSet.setParameter("organCode", organCode);
		reportWorkDataSet.load();
	}else{
		document.getElementById("backInsert").style.display = "none";
		$("reportDate").disabled=true;
		fundDataSet.setParameter("FUND_ID@=",fundId);
		fundDataSet.load();
		reportWorkDataSet.load();
	}
}
function forInsert(){
	var fundDataSet=L5.DatasetMgr.lookup("fundDataSet");
	fundDataSet.removeAll();
	fundDataSet.setParameter("ORGAN_CODE@=", organCode);
	fundDataSet.setParameter("sort","CREATE_TIME");	
	fundDataSet.setParameter("dir","desc");
	fundDataSet.load();
	fundDataSet.on("load",function(){
		if (fundDataSet.getCount()>0){
		
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				fundDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"C"});
			});
		}
	});
	
}
function forcheck(item){
	var offOtherMon=item.value;
	if (offOtherMon > ""){ 
	   var reg=/^\d+(\.\d{0,2})?$/; 
	   if ( (offOtherMon.match(reg)== null)){ 
	     L5.Msg.alert("提示","请输入正确的'"+item.name+"'！",function(){
		    item.focus();
		    }); 
		    item.value="";
		    return ; 
	   }else{
	   		getOffMon();
	   }
	}
}
function forzxcheck(item){
var offOtherMon=item.value;
	if (offOtherMon > ""){ 
	   var reg=/^\d+(\.\d{0,2})?$/; 
	   if ( (offOtherMon.match(reg)== null)) { 
	    L5.Msg.alert("提示","请输入正确的'"+item.name+"'！",function(){
		    item.focus();
		    }); 
		    item.value="";
		    return ; 
	   }else{
	    getSepMon();
	  }
	}
}
function forytcheck(item){
var offOtherMon=item.value;
if (offOtherMon > "") 
{ 
   var reg=/^\d+(\.\d{2})?$/; 
   if ( (offOtherMon.match(reg)== null)) 
    { 
   L5.Msg.alert("提示","请输入正确的'"+item.name+"'！",function(){
	    item.focus();
	    }); 
	    item.value="";
	    return ; 
    }
}
}
function save(){
	if(document.getElementById("offFinanceMon").value==""){
		L5.Msg.alert("提示","办公经费来源财政拨款不能为空！");
		return;
	}
	if(document.getElementById("offSelfMon").value==""){
		L5.Msg.alert("提示","办公经费来源自筹不能为空！");
		return;
	}
	if(document.getElementById("offEnbowMon").value==""){
		L5.Msg.alert("提示","办公经费来源社会捐助不能为空！");
		return;
	}
	if(document.getElementById("offOtherMon").value==""){
		L5.Msg.alert("提示","办公经费来源其他不能为空！");
		return;
	}
	if(document.getElementById("sepFinanceMon").value==""){
		L5.Msg.alert("提示","专项经费来源财政拨款不能为空！");
		return;
	}
	if(document.getElementById("sepSelfMon").value==""){
		L5.Msg.alert("提示","专项经费来源自筹不能为空！");
		return;
	}
	if(document.getElementById("sepEnbowMon").value==""){
		L5.Msg.alert("提示","专项经费来源社会捐助不能为空！");
		return;
	}
	if(document.getElementById("sepOtherMon").value==""){
		L5.Msg.alert("提示","专项经费来源其他不能为空！");
		return;
	}
	if(document.getElementById("useBuildMon").value==""){
		L5.Msg.alert("提示","专项经费用途基础设施建设不能为空！");
		return;
	}
	if(document.getElementById("useActionMon").value==""){
		L5.Msg.alert("提示","专项经费用途各项活动不能为空！");
		return;
	}
	if(document.getElementById("useServiceMon").value==""){
		L5.Msg.alert("提示","专项经费用途购买服务不能为空！");
		return;
	}
	if(document.getElementById("useOtherMon").value==""){
		L5.Msg.alert("提示","专项经费用途其他不能为空！");
		return;
	}
	var fundDataSet=L5.DatasetMgr.lookup("fundDataSet");
	var record=fundDataSet.getCurrent();
	if(record.get("reportDate")==""){
		L5.Msg.alert("提示","填报日期不能为空！");
		return;
	}
	var isValidate = fundDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcFundInfoCmd");
	command.setParameter("record",record);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			var url="jsp/ext/cdc/manage/fund/cdcFundInfoList.jsp";
			L5.forward(url,'',null);
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function returnBack(){
	L5.MessageBox.confirm("提示", "是否保存数据？",function(sta){
		if(sta=="yes"){
			save();
		}else{
			var url="jsp/ext/cdc/manage/fund/cdcFundInfoList.jsp";
			L5.forward(url,'',null);
		}
	});
}
function reRender(val){
	if(val==''){
	return "0 万元";
	}
	return val+" 万元";
}

function getOffMon(){
	var sum1  = document.getElementById("offFinanceMon").value;
	var sum2 = document.getElementById("offSelfMon").value;
	var sum3 = document.getElementById("offEnbowMon").value;
	var sum4 = document.getElementById("offOtherMon").value;
	var sum5 = document.getElementById("feeAlongMon").value;
	var fundDataSet=L5.DatasetMgr.lookup("fundDataSet");
	var record=fundDataSet.getCurrent();
	record.set("offMon",(Number(sum1)+Number(sum2)+Number(sum3)+Number(sum4)+Number(sum5)));
}

function getSepMon(){
	var sum1  = document.getElementById("sepFinanceMon").value;
	var sum2 = document.getElementById("sepSelfMon").value;
	var sum3 = document.getElementById("sepOtherMon").value;
	var sum4 = document.getElementById("sepEnbowMon").value;
	var fundDataSet=L5.DatasetMgr.lookup("fundDataSet");
	var record=fundDataSet.getCurrent();
	record.set("sepMon",(Number(sum1)+Number(sum2)+Number(sum3)+Number(sum4)));
}