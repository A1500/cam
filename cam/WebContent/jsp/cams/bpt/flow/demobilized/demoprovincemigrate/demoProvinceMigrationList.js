var width = screen.width-100;
var height = screen.height-140;
function init() {
	var DisabilityEmigratDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	BaseinfoPeopleDataSet.setParameter("organCode", organCode);
	BaseinfoPeopleDataSet.load();
	L5.QuickTips.init();
}

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	var domicileCode = getParam("domicileCode");
	var name = getParam("name");
	var idCard = getParam("idCard");
	var belongDate = getParam("belongDate");
	var isKoreanwar = getParam("isKoreanwar");
	var objectState = getParam("objectState");
	var domicileType = getParam("domicileType");
	var note = getParam("note");
	
	BaseinfoPeopleDataSet.setParameter("domicileCode",domicileCode);
	BaseinfoPeopleDataSet.setParameter("name",name);
	BaseinfoPeopleDataSet.setParameter("idCard",idCard);	
	BaseinfoPeopleDataSet.setParameter("belongDate",belongDate);	
	BaseinfoPeopleDataSet.setParameter("isKoreanwar",isKoreanwar);	
	BaseinfoPeopleDataSet.setParameter("objectState",objectState);	
	BaseinfoPeopleDataSet.setParameter("domicileType",domicileType);
	BaseinfoPeopleDataSet.setParameter("organCode",organCode);	
	BaseinfoPeopleDataSet.setParameter("note",note);	
	BaseinfoPeopleDataSet.load();
}

function reset(){
	document.getElementById("domicileCode").value = "";
	document.getElementById("domicileName").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("belongDate").value = "";
	document.getElementById("isKoreanwar").value = "";
	document.getElementById("objectState").value = "";
	document.getElementById("domicileType").value = "";
	document.getElementById("note").value = "";
}
function insert() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='demoProvinceMigrationInsert.jsp';
	var win = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");


}

function update(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}

	var familyId = selected[0].get('FAMILY_ID');
	var peopleId = selected[0].get('PEOPLE_ID');
	var applyId = selected[0].get('APPLY_ID');
	
	 
	var url = 'demoProvinceMigrationUpdate.jsp?familyId=' + familyId + '&peopleId='
			+ peopleId + '&applyId=' + applyId;
	var win = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
	if (win == null) {
		return;
	}
}
function detail() {

	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录查看!");
		return false;
	}

	var familyId = selected[0].get('FAMILY_ID');
	var peopleId = selected[0].get('PEOPLE_ID');
	var applyId = selected[0].get('APPLY_ID');
	
	var url = 'demoProvinceMigrationDetail.jsp?familyId=' + familyId + '&peopleId='
			+ peopleId + '&applyId=' + applyId;
	var win = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
					
	if (win == null) {
		return;
	}
}
function del(){
	/*var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("peopleId");
			}
			var command=new L5.Command("bpt.com.inspur.cams.bpt.disability.cmd.BptBaseinfoPeopleCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	BaseinfoPeopleDataSet.remove(selected[i]);
				}
				BaseinfoPeopleDataSet.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});*/
}
// 发起单个流程
function createAndSend() {

	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert("提示", "请选择一个人员进行提交！");
		return false;
	}
	var DisabilityEmigrateRecord = selected[0];
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateCommand");
	command.setParameter("record", DisabilityEmigrateRecord);
	command.execute("createAndSend");
	if (!command.error) {
		alert("流程发起并发送成功!");
		// 跳转到已办任务页面
		var url = "jsp/workflow/tasklist/queryyiban.jsp";
		L5.forward(url, "已办任务页面");
	} else {
		alert(command.error);
	}
}
function forHelp(){
       var revalue=window.showModalDialog("../../../../jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=11,12,13&organType=0&isExact=1&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
       if(revalue!=""&&revalue!=undefined){
          var list = revalue.split(";");
          document.getElementById("domicileCode").value = list[0];
          document.getElementById("domicileName").value = list[1];
       }
}