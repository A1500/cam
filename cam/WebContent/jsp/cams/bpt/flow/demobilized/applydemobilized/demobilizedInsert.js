function init() {

	if (method == null || method == "") {
		L5.Msg.alert('提示', "未知的页面命令!");
		back();
	} else if (method == "INSERT") {
		BaseinfoPeopleDataSet.newRecord({peopleId : document.forms[0].peopleId.value,familyId : document.forms[0].familyId.value});
		var BaseinfoFamilyDataSet = L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
		BaseinfoFamilyDataSet.newRecord({familyId : document.forms[0].familyId.value});
		var PeopleDemobilizedDataset = L5.DatasetMgr.lookup("PeopleDemobilizedDataset");
		PeopleDemobilizedDataset.newRecord({peopleId : document.forms[0].peopleId.value});
		PeopleDemobilizedDataset.set("supportPattern",1);//，默认为：分散供养
		PeopleDemobilizedDataset.set("demobilizedStateCode",1);
		var typeInfo =L5.getCmp("typeInfo");
		typeInfo.on("activate",func_BankName);
		return;
	} else if (method == "UPDATE") {
		document.getElementById("peopleId").readOnly = true;
		BaseinfoPeopleDataSet.baseParams["PEOPLE_ID@="] = idField;
		BaseinfoPeopleDataSet.on("load", getValue);
		BaseinfoPeopleDataSet.load();
    }
	L5.QuickTips.init();
}
function func_BankName(){
  PeopleDemobilizedDataset.set("accountName",BaseinfoPeopleDataSet.get("name"));
}
function Evt_butPrev_click(e) {
	var dataset = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	if (dataset.movePrev()) {

		BptPeopleDisabilityDataSet.baseParams["PEOPLE_ID@="] = document.forms[0].peopleId.value;
		BptPeopleDisabilityDataSet.load();
		if (e)
			e.stopEvent();
		return true;
	}
	return false;
}

function Evt_butNext_click(e) {
	var dataset = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	if (dataset.moveNext()) {

		BptPeopleDisabilityDataSet.baseParams["PEOPLE_ID@="] = document.forms[0].peopleId.value;
		BptPeopleDisabilityDataSet.load();
		if (e)
			e.stopEvent();
		return true;
	}
	return false;

}

function removeBptPeopleDisability() {
	var editGrid = L5.getCmp('BptPeopleDisabilityEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert('提示', "请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?', function(state) {
		if (state == "yes") {
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleDisabilityCommand");
			for (var i = 0; i < selected.length; i++) {
				var delId = selected[i].get("peopleId");
				command.setParameter("delId", delId);
				command.execute("delete");
				BptPeopleDisabilityDataSet.remove(selected[i]);
			}

		} else {
			return false;
		}
	});
}

function insertClick(e) {
	document.getElementById("peopleId").readOnly = false;
	var dataset = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	// 如果某必填数据为"",不再继续增加
	if (dataset.getCount() > 0 && document.forms[0].peopleId.value.trim() == "") {
		return;
	}
	dataset.newRecord();
	dataset.moveTo(dataset.getCount() - 1);

	BptPeopleDisabilityDataSet.baseParams["PEOPLE_ID@="] = "-";
	BptPeopleDisabilityDataSet.load();

}
function deleteClick(e) {
	L5.MessageBox.confirm('确定', '你确定要删除吗？', function(sta) {
		if (sta == "yes") {
			var BaseinfoPeopleDataSet = L5.DatasetMgr
					.lookup("BaseinfoPeopleDataSet");
			var BaseinfoPeopleRecord = BaseinfoPeopleDataSet.getCurrent();
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleCommand");
			var delIds = [];
			delIds[0] = BaseinfoPeopleRecord.get("peopleId");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				BaseinfoPeopleDataSet.remove(BaseinfoPeopleRecord);
				if (!Evt_butNext_click()) {
					Evt_butPrev_click();
				}
				L5.Msg.alert('提示', '删除成功！');
				var url = 'jsp/bpt/disability/baseinfopeople_list.jsp';
				var text = "用户表";
				L5.forward(url, text);
			} else {
				L5.Msg.alert('提示', "保存时出现错误！" + command.error);
			}
		} else
			return;
	});

}
function saveClick() {
    var img=document.getElementById("photoTemp").value;

    
    var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleDemobilizedCommand");
	// 人员信息验证
	var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	var BaseinfoPeopleRecord = BaseinfoPeopleDataSet.getCurrent();
	
	BaseinfoPeopleRecord.set('photoTemp',img);

	
	// 在乡复员军人信息验证
	var PeopleDemobilizedDataset = L5.DatasetMgr.lookup("PeopleDemobilizedDataset");
	var PeopleDemobilizedRecord = PeopleDemobilizedDataset.getCurrent();
	//新增人员信息
	if(BaseinfoPeopleRecord.get("peopleId")==""&&BaseinfoPeopleRecord.get("familyId")==""){
	   BaseinfoPeopleRecord.set("peopleId",peopleId);
	   BaseinfoPeopleRecord.set("familyId",familyId);
	   PeopleDemobilizedRecord.set("peopleId",peopleId);
	}else{//修改人员信息
	   PeopleDemobilizedRecord.set("peopleId",BaseinfoPeopleRecord.get("peopleId"));
	   //command.setParameter("flag","");
	}
	
	var idCard = document.getElementById("idCard");
	   if(!checkIDCard(idCard)){
		    L5.Msg.alert("提示", "身份证格式不正确!");
		    return false;
	   }
	
	var isValidate = BaseinfoPeopleDataSet.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", isValidate);
		return false;
	}
	
	 //校验属地行政规划
	var domicileCode = BaseinfoPeopleRecord.get("domicileCode");
	if(domicileCode==''){
		 L5.Msg.alert('提示','属地行政规划不能为空！');
		 return false;
	}
	//校验住址行政规划
	var apanageCode = BaseinfoPeopleRecord.get("apanageCode");
	if(apanageCode==''){
		 L5.Msg.alert('提示','地址行政规划不能为空！');
		 return false;
	}
	//校验户籍类别
	var domicileType = BaseinfoPeopleRecord.get("domicileType");
	if(domicileType==''){
		 L5.Msg.alert('提示','户籍类别不能为空！');
		 return false;
	}
	var conscriptDate = PeopleDemobilizedRecord.get("conscriptDate");
	if(conscriptDate!=''&&!validateDateFormat(conscriptDate)){
		L5.Msg.alert("提示", "入伍时间格式不正确!");
		return false;
	}
	
	var decruitmentDate = PeopleDemobilizedRecord.get("decruitmentDate");
	if(decruitmentDate!=''&&!validateDateFormat(decruitmentDate)){
		L5.Msg.alert("提示", "复员时间格式不正确!");
		return false;
	}
	
	//if(phoneticCode == null || phoneticCode == "" ) {
	//	L5.Msg.alert("提示","姓名拼音码不能为空!");
	//	return false;
	//}
	getCrjCnStrSpell('namebase','phoneticCode','m');
		var phoneticCode=document.getElementById("phoneticCode").value;
			BaseinfoPeopleRecord.set('phoneticCode',phoneticCode);
		
	if(!checkIDCard(idCard)){
	    L5.Msg.alert("提示", "身份证格式不正确!");
		return false;
	}
	
	if(document.getElementById("safeguardType").value==""){
	    L5.Msg.alert("提示", "请选择医疗保障方式!");
		return false;
	}
	if(L5.getDom("conscriptDate")==null||L5.getDom("conscriptDate")=="")
	{
		 L5.Msg.alert('提示','请录入类别信息后再保存！');
		 return false;
	}
	
	var isValidate = PeopleDemobilizedDataset.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", isValidate);
		return false;
	}
	
	var idCard = BaseinfoPeopleDataSet.get("idCard");
	if(!writeAble(idCard,"41",true)){
		L5.Msg.alert('提示', '该人员已经是在乡复员军人！');
		return false;
	}
	PeopleDemobilizedRecord.set("demobilizedStateCode",1);
	command.setParameter("flag",document.forms[0].flag.value);
	command.setParameter("BaseinfoPeopleRecord", BaseinfoPeopleRecord);
	command.setParameter("PeopleDemobilizedRecord", PeopleDemobilizedRecord);
	command.setParameter("ifApplyAdd","applyAdd");
	command.execute("insert");
	var peopleId1=command.getReturn("peopleId");

	if (!command.error) {
		/*var data = new L5.Map();
		data.put("peopleId",BaseinfoPeopleRecord.get("peopleId"));
		data.put("familyId",BaseinfoPeopleRecord.get("familyId"));
		peopleId=BaseinfoPeopleRecord.get("peopleId");
		familyId=BaseinfoPeopleRecord.get("familyId");
		var peopleId1=command.getReturn("peopleId");
		var familyId1=command.getReturn("familyId");
		var applyId1=command.getReturn("applyId");
		var url='demobilizedUpdateManage.jsp?peopleId='+peopleId1+'&familyId='+familyId1+'&applyId='+applyId1;
		var width = screen.width-100;
	    var height = screen.height-140;
		var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		*/
		var peopleId1=command.getReturn("peopleId");
		var familyId1=command.getReturn("familyId");
		var applyId1=command.getReturn("applyId");
		window.returnValue = peopleId1+";"+familyId1+";"+applyId1;
		window.close();
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}

function returnClick() {
	var url = 'jsp/cams/bpt/demobilized/demobilizedList.jsp';
	var text = '基础信息_人员信息';
	L5.forward(url, text);
}

function submit() {
	var records = BptPeopleDisabilityDataSet.getAllChangedRecords();
	if (records.length < 1) {
		L5.Msg.alert('提示', '没有需要保存的数据！');
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.disability.cmd.BptPeopleDisabilityCommand");
	command.setParameter("bptpeopledisabilityRecords", records);
	command.execute("save");
	if (!command.error) {
		BptPeopleDisabilityDataSet.commitChanges();
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}
function undo() {
	BptPeopleDisabilityDataSet.rejectChanges();
}

function func_BelongDate(){
  var conscriptDate = PeopleDemobilizedDataset.get("conscriptDate");
  if(conscriptDate !=''){
     if(conscriptDate>='1937-07-07'&&conscriptDate<='1945-09-02'){
         PeopleDemobilizedDataset.set("belongDate",1);
     }else if(conscriptDate>='1945-09-03'&&conscriptDate<='1949-09-30'){
         PeopleDemobilizedDataset.set("belongDate",2);
     }else{
         PeopleDemobilizedDataset.set("belongDate",3);
     }
  }
}
function check_conscriptDate(){
	 var conscriptDate = document.getElementById("conscriptDate").value;
	 if(conscriptDate>='1954-10-31'){
	 	L5.Msg.alert('提示', '入伍时间必须为1954年10月31日前！');
	 	document.getElementById("conscriptDate").value="";
	 }
}
function func_Type(){
  if(document.getElementById("domicileType").value=='1'){
     document.getElementById("work").style.display='none';
     document.getElementById("workAddress").style.display='none';
     document.getElementById("employmentCode").disabled=true;
  }else{
     document.getElementById("work").style.display='';
     document.getElementById("workAddress").style.display='';
     document.getElementById("employmentCode").disabled=false;
  }
}

function closewindow(){

	window.close();

}

function KoreaWar(k){

	if(k.value==3){
		document.getElementById("k1").style.display='';
		document.getElementById("k2").style.display='';
		document.getElementById("k3").style.display='none';
		document.getElementById("k4").style.display='none';
	}else{
		document.getElementById("k1").style.display='none';
		document.getElementById("k2").style.display='none';
		document.getElementById("k3").style.display='';
		document.getElementById("k4").style.display='';
		document.getElementById("isKoeanwar").value="";
	}
}
function idcardlookup(){
	L5.getCmp("imgshow").show();
	//window.open (L5.webPath+'/jsp/cams/bpt/comm/idCardDetail.jsp?src=data:image/jpeg;base64,'+ pPrintPhotoBuffer,'身份证件',
	//'height=500,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no, status=no');
}
function idcardclose(){
	var win = L5.getCmp("imgshow");
	win.hide();
}