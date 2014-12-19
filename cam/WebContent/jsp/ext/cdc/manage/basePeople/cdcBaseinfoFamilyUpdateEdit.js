function init(){
	var cdcBaseinfoPeopleDataSet=L5.DatasetMgr.lookup("cdcBaseinfoPeopleDataSet");
	var familyMemberDataSet=L5.DatasetMgr.lookup("familyMemberDataSet");
	if(method=="insert"){
		cdcBaseinfoPeopleDataSet.newRecord({"relationshipType":"1","domicileCode":organCode,"domicileName":organName});
	}else{
		cdcBaseinfoPeopleDataSet.setParameter("PEOPLE_ID@=",databeanId);
		familyMemberDataSet.setParameter("FAMILY_ID@=",databeanId);
		cdcBaseinfoPeopleDataSet.load();
		familyMemberDataSet.load();
	}
}
function returnBack(){
	var data=new L5.Map();
	var url="jsp/ext/cdc/manage/basePeople/cdcBaseinfoFamilyList.jsp";
	L5.forward(url,'',data);
}
function updateFamilyMember(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var url;
	if(records[0].get("relationshipType")=='01'){
		url = 'cdcBaseinfoFamilyHeadEdit.jsp?method=update&databeanId='+records[0].get("peopleId")
	}else{
		url = 'cdcBaseinfoFamilyMemberEdit.jsp?method=update&databeanId='+records[0].get("peopleId")
	}
	var width = screen.width-100;
    var height = screen.height-140;
	var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	if(returnValue!=null){
		var familyMemberDataSet=L5.DatasetMgr.lookup("familyMemberDataSet");
		familyMemberDataSet.reload();
	}
}
function delFamilyMember(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("relationshipType")=="01"){
		L5.Msg.alert("提示","户主信息，不允许删除!");
		return;
	}
	L5.MessageBox.confirm("提示", "是否删除该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcBaseinfoPeopleCmd");
			command.setParameter("peopleId",records[0].get("peopleId"));
			command.execute("delete");
			if (!command.error){
				var familyMemberDataSet=L5.DatasetMgr.lookup("familyMemberDataSet");
				familyMemberDataSet.reload();
			}else{
				L5.Msg.alert("提示","删除出错！");
			}
		}
	});
}
function addFamilyMember(){
	var width = screen.width-100;
    var height = screen.height-140;
	var url = 'cdcBaseinfoFamilyMemberEdit.jsp?method=insert&databeanId='+databeanId;
	var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	if(returnValue!=null){
		var familyMemberDataSet=L5.DatasetMgr.lookup("familyMemberDataSet");
		familyMemberDataSet.reload();
	}
}
