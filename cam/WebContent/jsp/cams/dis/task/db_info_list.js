var editGrid;
function init() {
	amountds.on('load', function(){
		if(amountds.getCount()>0) {
			document.getElementById("FOOD_AMOUNT").innerText = (amountds.get("FOOD_AMOUNT"));
			document.getElementById("FOOD_AVERAGE").innerText = formatNum(amountds.get("FOOD_AVERAGE"));
			
			document.getElementById("CLOTHES_AMOUNT").innerText = (amountds.get("CLOTHES_AMOUNT"));
			document.getElementById("CLOTHES_AVERAGE").innerText = formatNum(amountds.get("CLOTHES_AVERAGE"));
			
			document.getElementById("REBUILED_HOUSE_AMOUNT").innerText = (amountds.get("REBUILED_HOUSE_AMOUNT"));
			document.getElementById("REBUILED_HOUSE_AVERAGE").innerText = formatNum(amountds.get("REBUILED_HOUSE_AVERAGE"));
			
			document.getElementById("REPAIRED_HOUSE_AMOUNT").innerText = (amountds.get("REPAIRED_HOUSE_AMOUNT"));
			document.getElementById("REPAIRED_HOUSE_AVERAGE").innerText = formatNum(amountds.get("REPAIRED_HOUSE_AVERAGE"));
			
			document.getElementById("MONRY_AMOUNT").innerText = formatNum(amountds.get("MONRY_AMOUNT"));
			document.getElementById("MONRY_AVERAGE").innerText = formatNum(amountds.get("MONRY_AVERAGE"));
		}
	});
	L5.QuickTips.init();
	initPanel();
	query();
};
//权限控制控制审批select  
function initSelect(){

	var selectTag = document.getElementById("changeState");
	var o=[['3','同意'],['4','不同意'],['5','补齐补正'],['31','全部同意'],['41','全部不同意'],['1','提交'],['4','不同意']];
	var num=0;
	var len=o.length;
	if(organType == 13){
		len=5;
	}else if(organType == 14){
		num=5;
	}
	for( var i=num;i<len;i++){
		var theOption=document.createElement("option");
		theOption.innerHTML=o[i][1];
		theOption.value=o[i][0];
		selectTag.appendChild(theOption);
	}
	document.getElementById("auditPeopleName").value=currentUserName;
	document.getElementById("auditDate").value=day;
	

}
//根据类型显示panel
function initPanel(){
	var yjGridPanel=L5.getCmp('yjGridPanel');
	var swGridPanel=L5.getCmp('swGridPanel');
	var cjGridPanel=L5.getCmp('cjGridPanel');
	var gdGridPanel=L5.getCmp('gdGridPanel');
	var dcGridPanel=L5.getCmp('dcGridPanel');
	if(reliefType=="DC"){
		editGrid=dcGridPanel;
		yjGridPanel.setVisible(false);
		swGridPanel.setVisible(false);
		cjGridPanel.setVisible(false);
		gdGridPanel.setVisible(false);
		dcGridPanel.setVisible(true);
		
		document.getElementById("jtTr").style.display='';
		document.getElementById("lsTr").style.display='';
		document.getElementById("ybTr").style.display='';
		document.getElementById("cjTr").style.display='none';
		document.getElementById("xsTr").style.display='none';
		document.getElementById("zjTr").style.display='';
	}else if(reliefType=="YJ"){
		editGrid=yjGridPanel;
		yjGridPanel.setVisible(true);
		swGridPanel.setVisible(false);
		cjGridPanel.setVisible(false);
		gdGridPanel.setVisible(false);
		dcGridPanel.setVisible(false);
		
		document.getElementById("jtTr").style.display='';
		document.getElementById("lsTr").style.display='';
		document.getElementById("ybTr").style.display='';
		document.getElementById("cjTr").style.display='none';
		document.getElementById("xsTr").style.display='none';
		document.getElementById("zjTr").style.display='';
	}else if(reliefType=="CJ"){
		editGrid=cjGridPanel;
		yjGridPanel.setVisible(false);
		swGridPanel.setVisible(false);
		cjGridPanel.setVisible(true);
		gdGridPanel.setVisible(false);
		dcGridPanel.setVisible(false);
		
		document.getElementById("jtTr").style.display='';
		document.getElementById("lsTr").style.display='none';
		document.getElementById("ybTr").style.display='none';
		document.getElementById("cjTr").style.display='';
		document.getElementById("xsTr").style.display='';
		document.getElementById("zjTr").style.display='';
	}else if(reliefType=="GD"){
		editGrid=gdGridPanel;
		yjGridPanel.setVisible(false);
		swGridPanel.setVisible(false);
		cjGridPanel.setVisible(false);
		gdGridPanel.setVisible(true);
		dcGridPanel.setVisible(false);
		
		document.getElementById("jtTr").style.display='';
		document.getElementById("lsTr").style.display='';
		document.getElementById("ybTr").style.display='';
		document.getElementById("cjTr").style.display='none';
		document.getElementById("xsTr").style.display='none';
		document.getElementById("zjTr").style.display='';
	}else if(reliefType=="SW"){
		editGrid=swGridPanel;
		yjGridPanel.setVisible(false);
		swGridPanel.setVisible(true);
		cjGridPanel.setVisible(false);
		gdGridPanel.setVisible(false);
		dcGridPanel.setVisible(false);
		
		document.getElementById("jtTr").style.display='none';
		document.getElementById("lsTr").style.display='none';
		document.getElementById("ybTr").style.display='none';
		document.getElementById("cjTr").style.display='none';
		document.getElementById("xsTr").style.display='none';
		document.getElementById("zjTr").style.display='';
	}
	editButton();
}

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	amountds.setParameter("BATCH_DETAIL_ID@=",batchDetailId);	
	amountds.setParameter("RELIEF_TYPE@=",reliefType);
	amountds.setParameter("WORKFLOW_STATUS@!=",'4');
	amountds.load();
	
	
	ds.setParameter("I.BATCH_DETAIL_ID@=",batchDetailId);		
	ds.setParameter("I.RELIEF_TYPE@=",reliefType);	
	if(organType == 13){//县级
		ds.setParameter("I.WORKFLOW_STATUS@=","1");
		ds.load();
	}else if(organType == 14&&batchState=='3'){//街道
		ds.setParameter("I.WORKFLOW_STATUS@=","3");
		ds.load();
	}else if(organType == 14&&batchState=='4'){//街道
		ds.setParameter("I.WORKFLOW_STATUS@=","5");
		ds.load();
	}	
	
}

function getTimes(item) {
	LoushangDate(item.previousSibling);
}
function detail(){
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	var url="";
	if(reliefType=="DC"){
		url="../assistance/lifeAssistanceWinterSpring/approveLifeAssistanceWinterSpringDetail.jsp?cx_infoId="+selected[0].get("INFO_ID")+"&cx_recordId="+selected[0].get("RECORD_ID");
	}else if(reliefType=="YJ"){
		url="../assistance/yj_info/approve_yj_info_detail.jsp?infoId="+selected[0].get("INFO_ID");
	}else if(reliefType=="CJ"){
		url="../assistance/disasterReconstructionSubsidy/approveDisasterReconstructionSubsidyDetail.jsp?cx_infoId="+selected[0].get("INFO_ID")+"&cx_recordId="+selected[0].get("RECORD_ID");
	}else if(reliefType=="GD"){
		url="../assistance/gd_info/approve_gd_info_detail.jsp?infoId="+selected[0].get("INFO_ID");
	}else if(reliefType=="SW"){
		url="../assistance/disasterDeathSolatium/approveDisasterDeathSolatiumDetail.jsp?cx_infoId="+selected[0].get("INFO_ID")+"&cx_recordId="+selected[0].get("RECORD_ID");
	}
	var width = 900;
	var height = 580;
    var reValue = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}

function send(){
	
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1&&getParam("changeState")!="31"&&getParam("changeState")!="41"){
		L5.Msg.alert('提示',"请选择记录进行提交!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要提交选中的记录吗?',function(state){
		if(state=="yes"){
			closeWin();
			var command=new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefTaskCommand");
			command.setParameter("records", selected);
			command.setParameter("changeState", getParam("changeState"));
			command.setParameter("auditPeopleName", getParam("auditPeopleName"));
			command.setParameter("auditDate", getParam("auditDate"));
			command.setParameter("batchDetailId", batchDetailId);
			command.execute("send");
			if (!command.error) {
				query();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}
var f=true;
function deal(){
	
	var s = L5.getCmp('sendinfo');
	s.show();
	if(f){
		initSelect();
		f=false;
	}
	
}
function closeWin(){
	var s = L5.getCmp('sendinfo');
	s.hide();
}
function edit(){
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var url="";
	if(reliefType=="DC"){
		url="../assistance/lifeAssistanceWinterSpring/lifeAssistanceWinterSpringEdit.jsp?cx_infoId="+selected[0].get("INFO_ID")+"&cx_recordId="+selected[0].get("RECORD_ID")+"&method=update";
	}else if(reliefType=="YJ"){
		url="../assistance/yj_info/yj_info_edit.jsp?infoId="+selected[0].get("INFO_ID")+"&method=UPDATE";
	}else if(reliefType=="CJ"){
		url="../assistance/disasterReconstructionSubsidy/disasterReconstructionSubsidyEdit.jsp?cx_infoId="+selected[0].get("INFO_ID")+"&cx_recordId="+selected[0].get("RECORD_ID")+"&method=update";
	}else if(reliefType=="GD"){
		url="../assistance/gd_info/gd_info_edit.jsp?infoId="+selected[0].get("INFO_ID")+"&method=UPDATE";
	}else if(reliefType=="SW"){
		url="../assistance/disasterDeathSolatium/disasterDeathSolatiumEdit.jsp?cx_infoId="+selected[0].get("INFO_ID")+"&cx_recordId="+selected[0].get("RECORD_ID")+"&method=update";
	}
	var width = 900;
	var height = 580;
    var reValue = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	query();
}
function editButton(){
	if(organType == 14&&batchState=='4'){//控制修改按钮是否显示
		var but= L5.getCmp("xg"+reliefType);
		but.show();
	}
	if(organType == 14&&batchState=='3'){//显示发放按钮是否显示 隐藏办理按钮
		var ffbut= L5.getCmp("ff"+reliefType);
		ffbut.show();
		var blbut= L5.getCmp("bl"+reliefType);
		blbut.hide();
	}
}
function grant (){
	var url = "grant_edit.jsp?batchDetailId="+batchDetailId+"&reliefType="+reliefType;
	var width = 700;
	var height = 300;
    var reValue = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	if(reValue && reValue=="T") {
		window.close();
	}
//	var s = L5.getCmp('grantinfo');
//	s.show();
//	document.getElementById("grantPeopleName").value=currentUserName;
//	document.getElementById("grantTime").value=day;
}
function suregrant(){
	/*var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1&&getParam("grantselect")!="1"){
		L5.Msg.alert('提示',"请选择记录进行发放!");
		return false;
	}*/
	L5.MessageBox.confirm('确定', '确定要发放物资吗?',function(state){
		if(state=="yes"){
			grantclose();
			var command=new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefTaskCommand");
//			command.setParameter("state", getParam("grantselect"));
			command.setParameter("grantPeopleName", getParam("grantPeopleName"));
			command.setParameter("grantTime", getParam("grantTime"));
			command.setParameter("batchDetailId", batchDetailId);
			command.execute("grant");
			if (!command.error) {
				query();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}
function grantclose(){
	var s = L5.getCmp('grantinfo');
	s.hide();
}