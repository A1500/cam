function init(){
	var fReportDataSet=L5.DatasetMgr.lookup("fReportDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	if(method=="insert"){
		document.getElementById("backInsert").style.display = "block";
		fReportDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"N"});
		reportWorkDataSet.setParameter("organCode", organCode);
		reportWorkDataSet.load();
	}else{
		document.getElementById("backInsert").style.display = "none";
		$("reportDate").disabled=true;
		fReportDataSet.setParameter("RECORD_ID@=",recordId);
		fReportDataSet.on("load",function(){
			var record=fReportDataSet.getCurrent();
			if(record.get("offKindSelf")=="1"){
				document.getElementById("offKind").value = "1"
			}else if(record.get("offKindLease")=="1"){
				document.getElementById("offKind").value = "2"
			}else if(record.get("offKindLend")=="1"){
				document.getElementById("offKind").value = "3"
			}else if(record.get("offKindOther")=="1"){
				document.getElementById("offKind").value = "4"
			}
			if(record.get("offBuildNew")=="1"){
				document.getElementById("offBuild").value = "1"
			}else if(record.get("offBuildChange")=="1"){
				document.getElementById("offBuild").value = "2"
			}else if(record.get("offKindLend")=="1"){
				document.getElementById("offBuildOther").value = "3"
			}
			
		});
		fReportDataSet.load();
		reportWorkDataSet.load();
	}
}
function forInsert(){
	var fReportDataSet=L5.DatasetMgr.lookup("fReportDataSet");
	fReportDataSet.removeAll();
	fReportDataSet.setParameter("ORGAN_CODE@=", organCode);
	fReportDataSet.setParameter("sort","CREATE_TIME");	
	fReportDataSet.setParameter("dir","desc");
	fReportDataSet.load();
	fReportDataSet.on("load",function(){
		if (fReportDataSet.getCount()>0){
		var record=fReportDataSet.getCurrent();
			if(record.get("offKindSelf")=="1"){
				document.getElementById("offKind").value = "1"
			}else if(record.get("offKindLease")=="1"){
				document.getElementById("offKind").value = "2"
			}else if(record.get("offKindLend")=="1"){
				document.getElementById("offKind").value = "3"
			}else if(record.get("offKindOther")=="1"){
				document.getElementById("offKind").value = "4"
			}
			if(record.get("offBuildNew")=="1"){
				document.getElementById("offBuild").value = "1"
			}else if(record.get("offBuildChange")=="1"){
				document.getElementById("offBuild").value = "2"
			}else if(record.get("offKindLend")=="1"){
				document.getElementById("offBuildOther").value = "3"
			}
			
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				fReportDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"N"});
			});
		}
	});
	
}
function save(){
	if(document.getElementById("offNum").value==""){
		L5.Msg.alert("提示","办公服务用房数量不能为空！");
		return;
	}
	if(document.getElementById("offArea").value==""){
		L5.Msg.alert("提示","办公服务用房建筑面积不能为空！");
		return;
	}
	if(document.getElementById("offYear").value==""){
		L5.Msg.alert("提示","投入使用年份不能为空！");
		return;
	}
	if(document.getElementById("serviceNum").value==""){
		L5.Msg.alert("提示","社区服务大厅个数不能为空！");
		return;
	}
	if(document.getElementById("serviceArea").value==""){
		L5.Msg.alert("提示","社区服务大厅面积不能为空！");
		return;
	}
	if(document.getElementById("serviceYear").value==""){
		L5.Msg.alert("提示","社区服务大厅投入使用年份不能为空！");
		return;
	}
	if(document.getElementById("policeNum").value==""){
		L5.Msg.alert("提示","社区警务室个数不能为空！");
		return;
	}
	if(document.getElementById("policeArea").value==""){
		L5.Msg.alert("提示","社区警务室面积不能为空！");
		return;
	}
	if(document.getElementById("policeYear").value==""){
		L5.Msg.alert("提示","社区警务室投入使用年份不能为空！");
		return;
	}
	if(document.getElementById("clinicNum").value==""){
		L5.Msg.alert("提示","社区卫生室个数不能为空！");
		return;
	}
	if(document.getElementById("clinicArea").value==""){
		L5.Msg.alert("提示","社区卫生室面积不能为空！");
		return;
	}
	if(document.getElementById("clinicYear").value==""){
		L5.Msg.alert("提示","社区卫生室投入使用年份不能为空！");
		return;
	}
	if(document.getElementById("libNum").value==""){
		L5.Msg.alert("提示","社区图书室个数不能为空！");
		return;
	}
	if(document.getElementById("libArea").value==""){
		L5.Msg.alert("提示","社区图书室面积不能为空！");
		return;
	}
	if(document.getElementById("libYear").value==""){
		L5.Msg.alert("提示","社区图书室投入使用年份不能为空！");
		return;
	}
	if(document.getElementById("actionNum").value==""){
		L5.Msg.alert("提示","社区文娱活动室个数不能为空！");
		return;
	}
	if(document.getElementById("actionArea").value==""){
		L5.Msg.alert("提示","社区文娱活动室面积不能为空！");
		return;
	}
	if(document.getElementById("actionYear").value==""){
		L5.Msg.alert("提示","社区文娱活动室投入使用年份不能为空！");
		return;
	}
	if(document.getElementById("handNum").value==""){
		L5.Msg.alert("提示","残疾人活动室个数不能为空！");
		return;
	}
	if(document.getElementById("handArea").value==""){
		L5.Msg.alert("提示","残疾人活动室面积不能为空！");
		return;
	}
	if(document.getElementById("handYear").value==""){
		L5.Msg.alert("提示","残疾人活动室投入使用年份不能为空！");
		return;
	}
	if(document.getElementById("offFinanceMon").value==""){
		L5.Msg.alert("提示","办公服务用房投入资金财政拨款不能为空！");
		return;
	}
	if(document.getElementById("offSelfMon").value==""){
		L5.Msg.alert("提示","办公服务用房投入资金自筹不能为空！");
		return;
	}
	if(document.getElementById("offEndowMon").value==""){
		L5.Msg.alert("提示","办公服务用房投入社会捐助不能为空！");
		return;
	}
	if(document.getElementById("offOtherMon").value==""){
		L5.Msg.alert("提示","办公服务用房投入资金其他不能为空！");
		return;
	}
	if(document.getElementById("outNum").value==""){
		L5.Msg.alert("提示","室外活动室数量不能为空！");
		return;
	}
	if(document.getElementById("outArea").value==""){
		L5.Msg.alert("提示","室外活动室面积不能为空！");
		return;
	}
	if(document.getElementById("outYear").value==""){
		L5.Msg.alert("提示","室外活动室投入使用年份不能为空！");
		return;
	}
	if(document.getElementById("outFinanceMon").value==""){
		L5.Msg.alert("提示","室外活动室投入资金财政拨款不能为空！");
		return;
	}
	if(document.getElementById("outSelfMon").value==""){
		L5.Msg.alert("提示","室外活动室投入资金自筹不能为空！");
		return;
	}
	if(document.getElementById("outEnbowMon").value==""){
		L5.Msg.alert("提示","室外活动室投入资金社会捐助不能为空！");
		return;
	}
	if(document.getElementById("outOtherMon").value==""){
		L5.Msg.alert("提示","室外活动室投入资金其他不能为空！");
		return;
	}
	
	var fReportDataSet=L5.DatasetMgr.lookup("fReportDataSet");
	var record=fReportDataSet.getCurrent();
	if(record.get("reportDate")==""){
		L5.Msg.alert("提示","填报日期不能为空！");
		return;
	}
	var isValidate = fReportDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcFacilitiesReportCmd");
	command.setParameter("record",record);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			var url="jsp/ext/cdc/manage/facilities/vcdcFacilitiesReportList.jsp";
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
			var url="jsp/ext/cdc/manage/facilities/vcdcFacilitiesReportList.jsp";
			L5.forward(url,'',null);
		}
	});
}

function getOffMon(){
	var sum1  = document.getElementById("offFinanceMon").value;
	var sum2 = document.getElementById("offSelfMon").value;
	var sum3 = document.getElementById("offEndowMon").value;
	var sum4 = document.getElementById("offOtherMon").value;
	var fReportDataSet=L5.DatasetMgr.lookup("fReportDataSet");
	var record=fReportDataSet.getCurrent();
	record.set("offMon",(Number(sum1)+Number(sum2)+Number(sum3)+Number(sum4)));
}

function getOutMon(){
	var sum1  = document.getElementById("outFinanceMon").value;
	var sum2 = document.getElementById("outSelfMon").value;
	var sum3 = document.getElementById("outOtherMon").value;
	var sum4 = document.getElementById("outEnbowMon").value;
	var fReportDataSet=L5.DatasetMgr.lookup("fReportDataSet");
	var record=fReportDataSet.getCurrent();
	record.set("outMon",Number(sum1)+Number(sum2)+Number(sum3)+Number(sum4));
}
function reRender(val){
	if(val==""){
		return"0  万元";
	}else{
		return val+" 万元";
	}
}
//如是小数，保留到两位
function fordecimalcheck(item){
	var offOtherMon=item.value;
	if (offOtherMon > ""){ 
	   var reg=/^\d+(\.\d{0,2})?$/; 
	   
	   if ((offOtherMon.match(reg)== null)){ 
	    L5.Msg.alert("提示","请输入正确的'"+item.name+"'！",function(){
	    item.focus();
	    }); 
	    item.value="";
	    return ; 
	 	}else{
			getOffMon();
			getOutMon();
		}
	}
}
//判断是否是整数
function forcheck(item){
	var offOtherMon=item.value;
	if (offOtherMon > ""){ 
	 //  var reg=/^\d+(\.\d{2})?$/; 
	   var reg=/[^\d]/g;
	   if ((offOtherMon.match(reg)!= null)){ 
	    L5.Msg.alert("提示","请输入正确的'"+item.name+"'！",function(){
	    item.focus();
	    }); 
	    item.value="";
	    return ;  
	 	}
	}
}

//如是小数，保留到两位
function fordeccheck(item){
	var offOtherMon=item.value;
	if (offOtherMon > ""){ 
	   var reg=/^\d+(\.\d{0,2})?$/; 
	  
	   if ((offOtherMon.match(reg)== null)){ 
	    L5.Msg.alert("提示","请输入正确的'"+item.name+"'！",function(){
	    item.focus();
	    }); 
	    item.value="";
	    return ;  
	 	}
	}
}

function fordecoutimalcheck(item){
	var offOtherMon=item.value;
	if (offOtherMon > ""){ 
	   var reg=/^\d+(\.\d{0,2})?$/; 
	  
	   if ((offOtherMon.match(reg)== null)){ 
	    L5.Msg.alert("提示","请输入正确的'"+item.name+"'！",function(){
	    item.focus();
	    }); 
	    item.value="";
	    return ; 
	 	}else{
			getOutMon();
		}
	}
}