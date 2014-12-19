var ifAdjustAll=false;//是否调整所有
function init() {
	document.getElementById("lrdwmc").value=organName;
	var asisstanceClassDataset = L5.DatasetMgr.lookup("asisstanceClassDataset");
    asisstanceClassDataset.setParameter("filterSql", "ASSISTANCE_TYPE='"+assistanceType+"' AND IN_USE='1' AND SUBSTR(AREA_CODE,1,6)= '" + organArea.substring(0, 6) + "'");
    asisstanceClassDataset.load();
	
	samLowStandardsDataset.load();
};

function query() {
	treamentLisDs.setParameter("assistanceType",assistanceType);
    treamentLisDs.setParameter("domicileCode",_$('lrdwId'));
    treamentLisDs.setParameter("familyName",_$("familyName"));
    treamentLisDs.setParameter("familyCardNo",_$("familyCardNo"));
    treamentLisDs.setParameter("assistanceMoneyStart",_$("assistanceMoneyStart"));
    treamentLisDs.setParameter("assistanceMoneyEnd",_$("assistanceMoneyEnd"));
    treamentLisDs.setParameter("assistancePeopleNumStart",_$("assistancePeopleNumStart"));
    treamentLisDs.setParameter("assistancePeopleNumEnd",_$("assistancePeopleNumEnd"));
    treamentLisDs.load();
    noReclick(treamentLisDs,"queryBtn");
}

/**
 * 选择属地行政区划窗口
 */
function func_ForDomicileSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("lrdwId").value = list[0];
		document.getElementById("lrdwmc").value = list[1];
	}
}
function adjustSelected() {
	ifAdjustAll=false;
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length==0){
		L5.Msg.alert('提示',"请选择需要调整的记录!");
		return false;
	}
	var win = L5.getCmp("adjustWin");
	win.show();
	$('adjuestLog').innerHTML = "您本次操作共选中  "+selected.length+"  户家庭";
	$('adjustTarget').value='01';
	$('adjustMoney').value='';
}
function adjustAll() {
	var count = 0 ;
	if(treamentLisDs.getTotalCount() == 0 ){
		treamentDs.setParameter("assistanceType",assistanceType);
		treamentDs.setParameter("domicileCode",organArea);
		treamentDs.load();
		treamentDs.on('load',function(){
			if(treamentDs.getTotalCount() == 0 ){
				L5.Msg.alert('提示',"没有救助对象，不能进行调整！");
				return false;
			}else{
				count=treamentDs.getTotalCount();
				ifAdjustAll=true;
				var win = L5.getCmp("adjustWin");
				win.show();
				$('adjuestLog').innerHTML = "您将调整所有救助对象，共  "+count+"  户家庭";
				$('adjustTarget').value='01';
				$('adjustMoney').value='';
			}
		});
	}else{
		count=treamentLisDs.getTotalCount();
		ifAdjustAll=true;
		var win = L5.getCmp("adjustWin");
		win.show();
		$('adjuestLog').innerHTML = "您将调整所有救助对象，共  "+count+"  户家庭";
		$('adjustTarget').value='01';
		$('adjustMoney').value='';
	}
}
function closeWin(){
	var win = L5.getCmp("adjustWin");
	win.setVisible(false);
}
//等待显示
function waitMsg() {
	L5.Msg.wait("正在调整保障金","正在调整保障金，请等待...");
	setTimeout( confirmWin, 50);
}
//窗口确定
function confirmWin(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	var adjustType='01';
	var adjustTarget=_$('adjustTarget');
	var adjustMoney=_$('adjustMoney');
	if(adjustMoney==''){
		L5.Msg.alert('提示',"请输入增加值！");
		return;
	}
	//金额
	if(adjustMoney.match(/(^[-]{0,1}[0-9]{1,14}(\.[0-9]{1,2}){0,1}$)/) == null){
		L5.Msg.alert("提示","校验未通过："+"增加值格式不正确!");
		return;
	}
	if(!ifAdjustAll){
		var treatmentIdValue='';
		var assistanceMoneyAddValue='';
		for(var i=0;i<selected.length;i++){
			var treatmentId=selected[i].get('TREATMENT_ID');
			var assistancePeopleNum=selected[i].get('ASSISTANCE_PEOPLE_NUM');
			treatmentIdValue+=treatmentId;
			treatmentIdValue+=',';
			assistanceMoneyAddValue+= parseInt(assistancePeopleNum)*parseFloat(adjustMoney) ;
			assistanceMoneyAddValue+=',';
		}
		treatmentIdValue=treatmentIdValue.substring(0,treatmentIdValue.length-1);
		assistanceMoneyAddValue=assistanceMoneyAddValue.substring(0,assistanceMoneyAddValue.length-1);
		
		var command = new L5.Command("com.inspur.cams.drel.sam.cmd.SamFamilyTreatmentCmd");
		command.setParameter("treatmentIdValue",treatmentIdValue);
		command.setParameter("adjustType",adjustType);
		command.setParameter("adjustTarget",adjustTarget);
		command.setParameter("adjustMoney",adjustMoney);
		command.setParameter("assistanceMoneyAddValue",assistanceMoneyAddValue);
		command.execute("updateAssistanceMoney");
		if (!command.error) {
			L5.Msg.alert("提示",'保存成功！',function(){
				var win = L5.getCmp("adjustWin");
				win.setVisible(false);
				query();
			});
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}else{	
		var command = new L5.Command("com.inspur.cams.drel.sam.cmd.SamFamilyTreatmentCmd");
		command.setParameter("adjustType",adjustType);
		command.setParameter("adjustTarget",adjustTarget);
		command.setParameter("adjustMoney",adjustMoney);
		
		command.setParameter("assistanceType",assistanceType);
	    command.setParameter("domicileCode",_$('lrdwId'));
	    command.setParameter("familyName",_$("familyName"));
	    command.setParameter("familyCardNo",_$("familyCardNo"));
	    command.setParameter("assistanceMoneyStart",_$("assistanceMoneyStart"));
	    command.setParameter("assistanceMoneyEnd",_$("assistanceMoneyEnd"));
	    command.setParameter("assistancePeopleNumStart",_$("assistancePeopleNumStart"));
	    command.setParameter("assistancePeopleNumEnd",_$("assistancePeopleNumEnd"));
		command.execute("updateAllAssistanceMoney");
		if (!command.error) {
			L5.Msg.alert("提示",'保存成功！',function(){
				var win = L5.getCmp("adjustWin");
				win.setVisible(false);
				query();
			});
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}
}
//获取调整记录
function getAdjustRecord(value,cellmeta,record,rowindex,colindex,dataset){
	var adjustDate=record.get('ADJUST_DATE');
	var treatmentId=record.get('TREATMENT_ID');
	if(adjustDate!=''){
		return '<a href="javascript:showAdjustRecord(\''+treatmentId+'\')">'+adjustDate+'</a>';
	}else{
		return '';
	}
}
//弹出调整记录
function showAdjustRecord(treatmentId){
	var win = L5.getCmp("adjustRecordWin");
	win.show();
	samTreatmentAdjustDataset.setParameter("TREATMENT_ID",treatmentId);
	samTreatmentAdjustDataset.load();
}
//关闭调整记录
function closeaAjustRecordWin(){
	var win = L5.getCmp("adjustRecordWin");
	win.setVisible(false);
}
//获取调整日期
function getAdjustTime(value,cellmeta,record,rowindex,colindex,dataset){
	var adjustTime=record.get('adjustTime');
	if(adjustTime!=''){
		return adjustTime.substring(0,10);
	}else{
		return '';
	}
}
//获取调整类型
function getAdjustType(value,cellmeta,record,rowindex,colindex,dataset){
	var adjustType=record.get('adjustType');
	if(adjustType=='01'){
		return '户月保障金';
	}else if(adjustType=='02'){
		return '分类施保金';
	}else{
		return '';
	}
}
//获取调整目标
function getAdjustTarget(value,cellmeta,record,rowindex,colindex,dataset){
	var adjustTarget=record.get('adjustTarget');
	if(adjustTarget=='01'){
		return '家庭';
	}else if(adjustTarget=='02'){
		return '保障人口';
	}else{
		return '';
	}
}