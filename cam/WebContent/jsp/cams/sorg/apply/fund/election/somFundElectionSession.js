
function queryElectionDealed(){
	var sorgName = document.getElementById('sorgName').value;
	var sorgCode = document.getElementById('sorgCode').value;
	somElectionDataSet.setParameter("applyType","209");
	somElectionDataSet.setParameter("sorgType","J");
	somElectionDataSet.setParameter("domicileCode",organArea);
	somElectionDataSet.setParameter("sorgName",sorgName);
	somElectionDataSet.setParameter("sorgCode",sorgCode);
	somElectionDataSet.load();
}
//明细
function changeDuty(value,cellmeta,record,rowindex,colindex,dataset){
	var sorgId = record.get('SORG_ID');
	var cnName = record.get('SORG_NAME');
	var sorgCode = record.get('SORG_CODE');
	var meetingName = record.get('MEETING_NAME');
	var meetingId = record.get('MEETING_ID');
	var taskCode = record.get('TASK_CODE');
	if(record.get('DUTY') != '' && nowTime  > record.get("FINISHDATE")){
		return '<font color="blue"><a style="cursor:hand" title ="点击查看" onclick="openDutyWinDetail(\''+sorgId+'\',\''+cnName+'\',\''+sorgCode+'\',\''+meetingName+'\',\''+meetingId+'\')">已经办理但超期</a></font>';
	}else if(record.get('DUTY') != '' && nowTime <= record.get("FINISHDATE")){
		return '<font color="green"><a style="cursor:hand" title ="点击查看"  onclick="openDutyWinDetail(\''+sorgId+'\',\''+cnName+'\',\''+sorgCode+'\',\''+meetingName+'\',\''+meetingId+'\')">已办理</a></font>';
	}else if(record.get('DUTY') == '' && nowTime < record.get("FINISHDATE")){
		return '<font color="green"><a style="cursor:hand"  title ="点击办理" onclick="openDutyWinNew(\''+sorgId+'\',\''+cnName+'\',\''+sorgCode+'\',\''+meetingName+'\',\''+taskCode+'\',\''+meetingId+'\')">未办理未超期</a></font>';
	}else if(record.get('DUTY') == '' && nowTime > record.get("FINISHDATE")){
		return '<font color="red"><a style="cursor:hand"  title ="点击办理" onclick="openDutyWinNew(\''+sorgId+'\',\''+cnName+'\',\''+sorgCode+'\',\''+meetingName+'\',\''+taskCode+'\',\''+meetingId+'\')">未办理但已经超期</a></font>';
	}
}
//弹出负责人换届录入窗口
function openDutyWinNew(sorgId,cnName,sorgCode,meetingName,taskCode,meetingId){
	var url=L5.webPath+"/jsp/cams/sorg/apply/fund/election/record/peopleManage/fundManagePeopleRecordEdit.jsp?sorgId="+sorgId+"&method=insert"
	+"&cnName="+encodeURIComponent(encodeURIComponent(cnName))+"&sorgCode="+sorgCode+"&sessionName="+encodeURIComponent(encodeURIComponent(meetingName))+"&meetingId="+meetingId+"&electionTaskCode="+taskCode;
	window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+900+"px;dialogHeight:"+700+"px;resizable:1");
}
//弹出负责人换届明细窗口
function openDutyWinDetail(sorgId,cnName,sorgCode,meetingName,meetingId){
	var url=L5.webPath+"/jsp/cams/sorg/apply/fund/election/record/peopleManage/fundManagePeopleReportDetail.jsp?sorgId="+sorgId+"&method=detail"
	+"&cnName="+encodeURIComponent(encodeURIComponent(cnName))+"&sorgCode="+sorgCode+"&sessionName="+encodeURIComponent(encodeURIComponent(meetingName))+"&meetingId="+meetingId;
	window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+900+"px;dialogHeight:"+700+"px;resizable:1");
}
function changeRule(value,cellmeta,record,rowindex,colindex,dataset){
	var sorgId = record.get('SORG_ID');
	var cnName = record.get('SORG_NAME');
	var sorgCode = record.get('SORG_CODE');
	var meetingName = record.get('MEETING_NAME');
	var meetingId = record.get('MEETING_ID');
	var borgName = record.get('BORG_NAME');
	
	if(record.get('RULE') != '' && nowTime  > record.get("FINISHDATE")){
		return '<font color="blue"><a style="cursor:hand" title ="点击查看" onclick="openRuleWinDetail(\''+sorgId+'\',\''+cnName+'\',\''+sorgCode+'\',\''+meetingName+'\',\''+meetingId+'\')">已经办理但超期</a></font>';
	}else if(record.get('RULE') != '' && nowTime <= record.get("FINISHDATE")){
		return '<font color="green"><a style="cursor:hand" title ="点击查看"  onclick="openRuleWinDetail(\''+sorgId+'\',\''+cnName+'\',\''+sorgCode+'\',\''+meetingName+'\',\''+meetingId+'\')">已办理</a></font>';
	}else if(record.get('RULE') == '' && nowTime < record.get("FINISHDATE")){
		return '<font color="green"><a style="cursor:hand"  title ="点击办理" onclick="openRuleWinNew(\''+sorgId+'\',\''+cnName+'\',\''+sorgCode+'\',\''+meetingName+'\',\''+meetingId+'\',\''+borgName+'\')">未办理未超期</a></font>';
	}else if(record.get('RULE') == '' && nowTime > record.get("FINISHDATE")){
		return '<font color="red"><a style="cursor:hand"  title ="点击办理" onclick="openRuleWinNew(\''+sorgId+'\',\''+cnName+'\',\''+sorgCode+'\',\''+meetingName+'\',\''+meetingId+'\',\''+borgName+'\')">未办理但已经超期</a></font>';
	}
}
//弹出负责人换届录入窗口
function openRuleWinNew(sorgId,cnName,sorgCode,meetingName,meetingId,borgName){
	var url=L5.webPath+"/jsp/cams/sorg/apply/fund/election/record/rule/fundRuleRecordEdit.jsp?sorgId="+sorgId+"&method=insert"
	+"&cnName="+encodeURIComponent(encodeURIComponent(cnName))+"&sorgCode="+sorgCode+"&sessionName="+encodeURIComponent(encodeURIComponent(meetingName))+"&meetingId="+meetingId
	+"&borgName="+borgName;
	window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+900+"px;dialogHeight:"+700+"px;resizable:1");
}
//弹出负责人换届明细窗口
function openRuleWinDetail(sorgId,cnName,sorgCode,meetingName,meetingId){
	var url=L5.webPath+"/jsp/cams/sorg/apply/fund/election/record/rule/fundRuleRecordDetail.jsp?sorgId="+sorgId+"&method=detail"
	+"&cnName="+encodeURIComponent(encodeURIComponent(cnName))+"&sorgCode="+sorgCode+"&sessionName="+encodeURIComponent(encodeURIComponent(meetingName))+"&meetingId="+meetingId;
	window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+900+"px;dialogHeight:"+700+"px;resizable:1");
}
function changeFee(value,cellmeta,record,rowindex,colindex,dataset){
	if(record.get('FEE') != '' && nowTime  > record.get("FINISHDATE")){
		return '<font color="blue">已经办理但超期</font>';
	}else if(record.get('FEE') != '' && nowTime <= record.get("FINISHDATE")){
		return '<font color="green">已办理</font>';
	}else if(record.get('FEE') == '' && nowTime < record.get("FINISHDATE")){
		return '<font color="red">未办理未超期</font>';
	}else if(record.get('FEE') == '' && nowTime > record.get("FINISHDATE")){
		return '<font color="red">未办理但已经超期</font>';
	}
}