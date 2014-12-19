function init(){
	var xiaXiaCun=L5.DatasetMgr.lookup("xiaXiaCun");
	var electionInfoDataSet=L5.DatasetMgr.lookup("electionInfoDataSet");
 	electionInfoDataSet.on("load",function(){
 		if(method=="insert"){
 		}else{
 			var reocrd = electionInfoDataSet.getCurrent();
 			var i = 0;
 			for(i = 0;i<reportOrgan.options.length;i++){
 				 if (reportOrgan.options[i].text == reocrd.get("organName")) {        
		            reportOrgan.options[i].selected = true;
		            $("reportOrgan").disabled=true;        
		            break;        
		        }        
 			}
 			
 		}
 	});
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	xiaXiaCun.setParameter("organCode", organCode);
	xiaXiaCun.load();
	var reportOrgan = document.getElementById("reportOrgan");
	xiaXiaCun.on("load",function(){
		var reportOrgan = document.getElementById("reportOrgan");
		reportOrgan.options.length = 0;
		var varItem = new Option("请选择... ",""); 
		reportOrgan.options.add(varItem); 
		xiaXiaCun.each(function(record,index){
			reportOrgan.options.add(new Option(record.get("userName"),record.get("userId")));
		});
		if(method=="insert"){
			electionInfoDataSet.newRecord({"parentCode":parentCode,"reportType":"N","communityCode":organCode});
		}else{
			$("reportDate").disabled=true;
			electionInfoDataSet.setParameter("RECORD_ID@=",recordId);
			electionInfoDataSet.load();
			reportWorkDataSet.load();
		}
	});
}
function save(){
	var reportOrgan = document.getElementById("reportOrgan").value;
	if(reportOrgan==""){
		L5.Msg.alert("提示","填报单位不能为空！");
		return;
	}
	var reportTime = document.getElementById("reportDate").value;
	if(reportTime==""){
		L5.Msg.alert("提示","填报日期不能为空！");
		return;
	}
	var yearly = document.getElementById("yearly").value;
	var season = document.getElementById("season").value;
	var ifComplete = document.getElementById("ifComplete").value;
	var completeResult = document.getElementById("completeResult").value;
	var ifElection = document.getElementById("ifElection").value;
	if(ifElection==""){
		L5.Msg.alert("提示","是否参加换届选举不能为空！");
		return;
	}
	if(ifElection == '1'){
		if(yearly==""){
			L5.Msg.alert("提示","选举年份不能为空！");
		return;
		}
		if(season==""){
			L5.Msg.alert("提示","选举届次不能为空！");
		return;
		}
		if(ifComplete==""){
			L5.Msg.alert("提示","是否完成选举不能为空！");
		return;
		}
		if(ifComplete == '1'){
		
			if(completeResult==""){
			L5.Msg.alert("提示","完成情况不能为空！");
			return;
			}
		
		}
	}
	var electionInfoDataSet=L5.DatasetMgr.lookup("electionInfoDataSet");
	var record=electionInfoDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcElectionInfoCmd");
	command.setParameter("record",record);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){ 
		L5.Msg.alert("提示","保存成功！",function(){
			var data=new L5.Map();
			var url="jsp/ext/cdc/manage/elect/country/cdcElectionList.jsp";
			if(method=="insert"){
				recordId = command.getReturn("recordId");
				if(recordId=="" ||recordId =="null"||recordId ==null){
					url="jsp/ext/cdc/manage/elect/country/cdcElectionList.jsp";
				}else{
					url="jsp/ext/cdc/manage/elect/country/cdcElectionEdit.jsp";
				}
			}else{
				url="jsp/ext/cdc/manage/elect/country/cdcElectionEdit.jsp";
			}
			data.put("reportTime",reportTime);
			data.put("recordId",recordId);
			if(method=="insert"){
				var reportOrgan = document.getElementById("reportOrgan");
				data.put("organ_Code",reportOrgan.value);
			}else{
				data.put("organ_Code",organ_Code);
			}
			data.put("method","update");
			L5.forward(url,'',data);
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}

function returnBack(){
	history.go(-1);
}
function completeChanges(){
	var complete =  document.getElementById("ifComplete").value;
	if(complete=='0'){
		var electionInfoDataSet=L5.DatasetMgr.lookup("electionInfoDataSet");
		electionInfoDataSet.set("completeResult","");
		document.getElementById("completeResult").disabled = true;
	}else{
		document.getElementById("completeResult").disabled = false;
	}
}


function electionChanges(){
	var ifElection = document.getElementById("ifElection").value;
	if(ifElection == '0'){
		document.getElementById("yearly").disabled =true;
		//document.getElementById("season").disabled =true;
		document.getElementById("completeResult").disabled =true;
		document.getElementById("ifComplete").disabled =true;
		var electionInfoDataSet=L5.DatasetMgr.lookup("electionInfoDataSet");
		electionInfoDataSet.set("yearly","");
		//electionInfoDataSet.set("season","");
		electionInfoDataSet.set("completeResult","");
		electionInfoDataSet.set("ifComplete","");
	}else{
		document.getElementById("yearly").disabled =false;
		document.getElementById("season").disabled =false;
		document.getElementById("completeResult").disabled =false;
		document.getElementById("ifComplete").disabled =false;
	}
}

function setSeason(){
	var reportDataSet = L5.DatasetMgr.lookup("reportDataSet");
	reportDataSet.setParameter("WORK_ID@=", document.getElementById("reportDate").value);
	reportDataSet.load();
	reportDataSet.on("load",function(){
		var electionInfoDataSet=L5.DatasetMgr.lookup("electionInfoDataSet");
		var record=electionInfoDataSet.getCurrent();
		record.set("season",reportDataSet.get("countryElectionSeason"));
	});
}

function reportOrganChanges(){
	var electionInfoDataSet=L5.DatasetMgr.lookup("electionInfoDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	var reportOrgan = document.getElementById("reportOrgan");
	var index = reportOrgan.selectedIndex; // 选中索引
	var text = reportOrgan.options[index].text; // 选中文本
	var value = reportOrgan.options[index].value; // 选中值
	electionInfoDataSet.set("organCode",value);
	electionInfoDataSet.set("organName",text);
	if(method=="insert"){
		reportWorkDataSet.setParameter("organCode",value);
		reportWorkDataSet.load();
	}
}