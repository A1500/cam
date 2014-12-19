//页面初始化方法
function init(){
	L5.DatasetMgr.lookup("BaseinfoPeopleDataSet").newRecord();
	L5.DatasetMgr.lookup("BaseinfoFamilyDataSet").newRecord();
	L5.DatasetMgr.lookup("hosDataset").newRecord();
	L5.DatasetMgr.lookup("ds").newRecord();
	//家庭基本信息加载
	var familyDataset=L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
	familyDataset.setParameter("family_Id",familyId);	
	familyDataset.load();
	familyDataset.on('load',loadMainPeople);
	//个人信息加载
	var baseinfoPeopleDataSet=L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	baseinfoPeopleDataSet.setParameter("people_Id",peopleId);	
	baseinfoPeopleDataSet.load();
	//家庭成员信息加载
	var baseinfoPeopleDataSet1=L5.DatasetMgr.lookup("BaseinfoPeopleDataSet1");
	baseinfoPeopleDataSet1.setParameter("family_Id",familyId);	
	baseinfoPeopleDataSet1.load();
	
	//历史救助信息加载
	var hosDataset=L5.DatasetMgr.lookup("hosDataset");
	hosDataset.setParameter("leaveTime",getCurDate());	
	hosDataset.setParameter("familyId",familyId);	
	hosDataset.load();
}
//根据家庭ID户主姓名加载户主信息
function loadMainPeople(familyDataset){
	var baseinfoPeopleDataSet2=L5.DatasetMgr.lookup("BaseinfoPeopleDataSet2");
	alert(familyId);
	baseinfoPeopleDataSet2.setParameter("family_Id",familyId);	
	alert(familyDataset.getCurrent().get('patriarchName'));
	baseinfoPeopleDataSet2.setParameter("name",familyDataset.getCurrent().get('patriarchName'));
	baseinfoPeopleDataSet2.load();
}
//住院登记
function insert() {
	var ds = L5.DatasetMgr.lookup("ds");
	var SMBDataset = L5.DatasetMgr.lookup("SMBDataset");
	var editGrid=L5.getCmp('peoEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	SMBDataset.setParameter("peopleId",selected[0].get('PEOPLE_ID'));
	SMBDataset.load();
	SMBDataset.on('load',inCheck);
}
//重复住院登记校验
function inCheck(SMBDataset){
	if(SMBDataset.getCount()!=0){
		L5.Msg.alert('提示',"此人已住院!");
		return false;
	}else{
		var editGrid=L5.getCmp('peoEditGridPanel');
		var selected = editGrid.getSelectionModel().getSelections();
		var data = new L5.Map();	
		data.put("method","INSERT");
		data.put("familyId",selected[0].get('FAMILY_ID'));
	    data.put("peopleId",selected[0].get('PEOPLE_ID'));
	    data.put("name",selected[0].get('NAME'));
	    data.put("idCard",selected[0].get('ID_CARD'));
	    data.put("sex",selected[0].get('SEX'));
		data.put("medicalCode",selected[0].get('MEDICAL_CODE'));
        data.put("domicileCode",selected[0].get('DOMICILE_CODE'));
		var url='jsp/cams/drel/mbalance/samMBalanceEdit.jsp';
		var text = '增加一站结算_住院登记';
		L5.forward(url,text,data);
	}
}
//住院登记按钮事件，打开登记信息窗口
function inHosReg(){
	if(win==undefined){
		var win=L5.getCmp("inRegiste");
	}
	win=L5.getCmp("inRegiste");
	win.show();
}
//取消住院登记窗口
function undoReg(){
	if(win==undefined){
		var win=L5.getCmp("inRegiste");
	}
	win=L5.getCmp("inRegiste");
	win.hide();
}
//返回查询页面
function back()
 {	 	var url='jsp/cams/drel/mbalance/samMBalancePeople.jsp';
		var text = '一站结算_住院登记';
		L5.forward(url,text);	 
 }
 //保存住院登记信息
function save(){
	//校验
	var valid = ds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}	
    var records = ds.getCurrent();
    records.set("balanceId",document.getElementById("balanceId").value);
    records.set("familyId",document.getElementById("familyId").value);
    records.set("peopleId",document.getElementById("peopleId").value);
    records.set("hospitalId",document.getElementById("hospitalId").value);
	var command=new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMBalanceCmd"); 
	command.setParameter("records",records);
	command.execute("save");	
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
		var url='jsp/cams/drel/manage/mbalance/samMBalanceList.jsp';
		var text = '一站结算_住院登记';
		L5.forward(url,text);
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}