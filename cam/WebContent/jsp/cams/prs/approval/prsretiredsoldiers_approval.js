function init() {
	var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
	//未审核退役士兵信息
	retiredSoldierDataset.baseParams["FLAG@="]=0;
	retiredSoldierDataset.baseParams["ALLOT_FLAG@="]="1";
	retiredSoldierDataset.load();
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
	retiredSoldierDataset.setParameter("NAME@like",getParam("name"));
	retiredSoldierDataset.setParameter("IDCARD_NO@like",getParam("idCard"));
	retiredSoldierDataset.setParameter("HUKOU_TYPE@=",getParam("domicileType"));
	retiredSoldierDataset.setParameter("VETERANS_CERTIFICATE_NO@like",getParam("veteransCertificateNo"));
	retiredSoldierDataset.setParameter("SERVED_ARMY@like",getParam("servedArmy"));
	retiredSoldierDataset.setParameter("ENLIST_TYPE@=",getParam("enlistType"));
	retiredSoldierDataset.setParameter("SERVICED_TIME@=",getParam("servicedTime"));
	retiredSoldierDataset.setParameter("CONTENT@like",getParam("note"));
	retiredSoldierDataset.setParameter("WHERE_PLACEMEN@=",getParam("domicileCode"));
	retiredSoldierDataset.load();
}

//更新某条退役士兵信息（基本信息和部队信息）
function update(){

	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("idField",selected[0].get('soldiersId'));
	var url='jsp/cams/prs/approval/prsretiredsoldiers_edit.jsp';
	var text = '修改退役士兵信息';
	L5.forward(url,text,data);
}

//删除未审核退役士兵基本信息
function del(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("soldiersId");
			}
			var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
			var command=new L5.Command("com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	retiredSoldierDataset.remove(selected[i]);
				}
				retiredSoldierDataset.commitChanges();

			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}
//审核为通过退役士兵基本信息
function approval(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要审核的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要审核选中的记录吗?',function(state){
		if(state=="yes"){
			var  ids=[];
			for(var i=0;i<selected.length;i++){
				ids[i]=selected[i].get("soldiersId");
			}
			var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
			var command=new L5.Command("com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersCommand");
			command.setParameter("ids", ids);
			command.execute("approvalSoldiers");
			if (!command.error) {
				var url='jsp/cams/prs/approval/prsretiredsoldiers_approval.jsp';
				var text = '未审核退役士兵信息';
				L5.forward(url,text);
			}
		}else{
			return false;
		}
	});
}
//查看某条未审核退役士兵信息
function detail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("idField",selected[0].get('soldiersId'));
	var url='jsp/cams/prs/approval/prsretiredsoldiers_detail.jsp';
	var text = '查看退役士兵信息';
	L5.forward(url,text,data);
}

//上报未审核退役士兵信息
function sendup(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要退档的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要退档选中的记录吗?',function(state){
		if(state=="yes"){
			var  ids=[];
			for(var i=0;i<selected.length;i++){
				ids[i]=selected[i].get("soldiersId");
			}
			var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
			var command=new L5.Command("com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersCommand");
			command.setParameter("ids", ids);
			command.setParameter("soldiers",selected);
			command.execute("sendUpSoldiers");
			if (!command.error) {
				var url='jsp/cams/prs/approval/prsretiredsoldiers_approval.jsp';
				var text = '未审核退役士兵信息';
				L5.forward(url,text);
			}
		}else{
			return false;
		}
	});

}

function forHelp() {
	// var struId='<%=struId%>';
	var revalue = window
			.showModalDialog(
					"../../../bsp/organization/getselect_code.jsp?rootId="
							+ struId
							+ "&showOrganType=11,12,13&organType=0&isExact=1&isCheckBox=0&isTree=1",
					"",
					"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");

	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
	}
}
function func_ForDomicileSelect() {
	var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&level=2&organCode=370000000000&organName=山东省","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
	}
}