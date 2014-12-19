var sorgId="";
var applyType="203";
function init() {
	if(method=="INSERT"){
		somOrganDataSet.newRecord({"cnName":userId,"sorgCode":sorgCode,"sorgId":sorgId,"sorgStatus":'22',
			"sorgType":"J","ifBranch":'0',"morgName":userId,"morgArea":morgArea});
		somApplyDataSet.newRecord({"curActivity":"受理","taskCode":taskCode,
		"sorgId":sorgId,"applyType":applyType,"dataSource":"ONLINE","sorgType":"J",
		"acceptArea":morgArea,"createOrgan":morgArea,"createPerson":userId,"ifFinish":"0"});

		somElectronicDataSet_load();
	}else{
		somOrganDataSet.setParameter("SORG_ID",sorgId);
		somOrganDataSet.load();
		somOrganDataSet.on('load',function (){
			if(typeof businessOrganSelectDic !="undefined"){
				var borgName = somOrganDataSet.get('borgName');
				var records = businessOrganSelectDic.query("value",borgName);
				if(records.length>0){
					var borgCode = records.items[0].get("text");
					document.getElementById("borgName").value = borgName;
					document.getElementById("borgNameDispaly").value = borgCode;
				}
			}
		});
		somApplyDataSet.setParameter("TASK_CODE", taskCode);
		somApplyDataSet.load();
		//加载社会组织清算组织人员信息
		somLiqpeopleDataSet.setParameter("SORG_ID@=",sorgId);
		somLiqpeopleDataSet.load();
		//加载电子档案
		somElectronicDataSet_load();
	}
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	win.on("hide",function(el){
		somElectronicDataSet_load();
	});
	L5.QuickTips.init();
}
//根据登记证号加载社会组织信息
function loadSorg(){
	if(method=="INSERT"){
		if(""!=_$("sorgCode")){
			somOrganDataSet.setParameter("SORG_CODE",_$("sorgCode"));
			somOrganDataSet.setParameter("SORG_TYPE","J");
			somOrganDataSet.setParameter("IF_BRANCH","0");
			somOrganDataSet.load();
			somOrganDataSet.on("load",function(){
				if(somOrganDataSet.getCount()<1){
					somOrganDataSet.removeAll();
					somOrganDataSet.newRecord();
					L5.Msg.alert("提示","登记证号不存在!");
					return;
				}else{
					sorgId=somOrganDataSet.get('sorgId');
					somLiqpeopleDataSet.setParameter("SORG_ID@=",sorgId);
					somLiqpeopleDataSet.load();
					//加载电子档案
					somElectronicDataSet_load();
				}
			});
		}
	}
}
//保存
function save(){
	var somOrganRd = somOrganDataSet.getCurrent();
	var somLiqpeopleRds = somLiqpeopleDataSet.getAllChangedRecords();
	var somApplyRd = somApplyDataSet.getCurrent();
	var somOrganDataSetIsValidate = somOrganDataSet.isValidate();
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	//校验社会组织信息
	if(somOrganDataSetIsValidate!=true){
		L5.Msg.alert("提示",somOrganDataSetIsValidate);
		L5.getCmp("tabSomOrgan").setActiveTab("0");
		return;
	}
	//校验社会组织清算人员信息
	if(somLiqpeopleDataSet.getCount() < 1){
		L5.Msg.alert("提示","还未增加清算组织人员");
		L5.getCmp("tabSomOrgan").setActiveTab("1");
		return;
	}
	//校验业务意见
//	if(somApplyDataSetIsValidate!=true){
		//L5.Msg.alert("提示",somApplyDataSetIsValidate);
		//L5.getCmp("tabSomOrgan").setActiveTab("3");
		//return;
//	}
	if(document.getElementById("borgName").value == ''){
		L5.Msg.alert("提示","校验未通过！业务主管单位不能为空");
		L5.getCmp("tabSomOrgan").setActiveTab("0");
		return;
	}
	var command = new L5.Command("com.inspur.cams.sorg.online.apply.fund.cmd.SomFundOnlineCmd");
	//提交保存
	somOrganRd.set('borgName',document.getElementById("borgName").value);
	command.setParameter("somOrganRd",somOrganRd);
	command.setParameter("somLiqpeopleRds",somLiqpeopleRds);
	command.setParameter("somApplyRd",somApplyRd);
	command.execute("saveCancel");
	if(!command.error){
		somLiqpeopleDataSet.commitChanges();
		L5.Msg.alert("提示","保存成功！",function(){
			//goBack();
			method="UPDATE";
			somOrganDataSet.setParameter("SORG_ID",sorgId);
			somOrganDataSet.load();
			somApplyDataSet.setParameter("TASK_CODE", taskCode);
			somApplyDataSet.load();
			//加载社会组织清算组织人员信息
			somLiqpeopleDataSet.setParameter("SORG_ID@=",sorgId);
			somLiqpeopleDataSet.load();
			//加载电子档案
			somElectronicDataSet_load();
		});
	}else{
		L5.Msg.alert("错误","保存时出现错误！"+command.error);
	}
}
//返回
function goBack(){
	window.history.go(-1);
}

var liqpeopleRecord=null;
//增加清算组织人员
function addLiqpeople(){
	liqpeopleRecord=null;
	var grid = L5.getCmp("gridLiqpeople");
	grid.stopEditing();
	var winLiqpeopleDataSet=L5.DatasetMgr.lookup("winLiqpeopleDataSet");
	winLiqpeopleDataSet.removeAll();
	winLiqpeopleDataSet.newRecord({"ifChief":"1"});
	var win = L5.getCmp("winLiqpeople");
	win.show();
}
//修改清算组织人员
function editLiqpeople(){
	var grid = L5.getCmp("gridLiqpeople");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	liqpeopleRecord=record;
	var winLiqpeopleDataSet=L5.DatasetMgr.lookup("winLiqpeopleDataSet");
	winLiqpeopleDataSet.removeAll();
	var newRecord = winLiqpeopleDataSet.newRecord();
	var win = L5.getCmp("winLiqpeople");
	win.show();
	newRecord.set("name",record.get("name"));
	newRecord.set("workName",record.get("workName"));
	newRecord.set("workDuties",record.get("workDuties"));
	newRecord.set("liqDuties",record.get("liqDuties"));
	newRecord.set("ifChief",record.get("ifChief"));
}
//删除清算组织人员
function delLiqpeople(){
	var grid = L5.getCmp("gridLiqpeople");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选中一行后删除!");
		return;
	}
	L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
		if(sta=="yes"){
			var somLiqpeopleRd = somLiqpeopleDataSet.getCurrent();
			somLiqpeopleDataSet.remove(somLiqpeopleRd);
		}
	});
}
//确定添加清算组织成员
function saveWinLiqpeople(){
	//清算人员信息校验
	var winLiqpeopleDataSet=L5.DatasetMgr.lookup("winLiqpeopleDataSet");
	var winLiqpeopleDataSetIsValidate = winLiqpeopleDataSet.isValidate();
	if(winLiqpeopleDataSetIsValidate!=true){
		L5.Msg.alert("提示",winLiqpeopleDataSetIsValidate);
		return;
	}
	var currentRecord = winLiqpeopleDataSet.getCurrent();
	if(liqpeopleRecord == null){
		somLiqpeopleDataSet.insert(somLiqpeopleDataSet.getCount(),currentRecord);
	}else{
		liqpeopleRecord.set("name",currentRecord.get("name"));
		liqpeopleRecord.set("workName",currentRecord.get("workName"));
		liqpeopleRecord.set("workDuties",currentRecord.get("workDuties"));
		liqpeopleRecord.set("liqDuties",currentRecord.get("liqDuties"));
		liqpeopleRecord.set("ifChief",currentRecord.get("ifChief"));
	}
	var win = L5.getCmp("winLiqpeople");
	win.setVisible(false);
}
//取消清算组织人员
function undoLiqpeople(){
	somLiqpeopleDataSet.rejectChanges();
}
//关闭添加清算组织成员
function closeWinLiqpeople(){
	var win = L5.getCmp("winLiqpeople");
	win.setVisible(false);
}

//查看清算组织人员信息
function detailSomLiqpeople(){
	var grid = L5.getCmp("gridSomLiqpeople");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	var winSomLiqpeopleDataSet = L5.DatasetMgr.lookup("winSomLiqpeopleDataSet");
	winSomLiqpeopleDataSet.removeAll();
	var newRecord = winSomLiqpeopleDataSet.newRecord();
	var win = L5.getCmp("winSomLiqpeople");
	win.show();
	newRecord.set("name",record.get("name"));
	newRecord.set("workName",record.get("workName"));
	newRecord.set("workDuties",record.get("workDuties"));
	newRecord.set("liqDuties",record.get("liqDuties"));
	newRecord.set("ifChief",record.get("ifChief"));
}
//关闭清算组织人员信息窗口
function winCloseSomLiqpeople(){
	var win = L5.getCmp("winSomLiqpeople");
	win.setVisible(false);
}

//点击增加上传附件按钮
function clickUploadFile(){
	uploadFile();
}