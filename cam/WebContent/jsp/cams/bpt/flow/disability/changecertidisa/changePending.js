function init() {
	var DisabilityPeopleDataSet = L5.DatasetMgr
			.lookup("DisabilityPeopleDataSet");
	DisabilityPeopleDataSet.setParameter("organCode", organCode);
	DisabilityPeopleDataSet.setParameter("serviceType", '18');
	DisabilityPeopleDataSet.load();
	L5.QuickTips.init();
}
function del(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
			command.setParameter("records", selected);
			command.setParameter("disType", "change");
			command.execute("deleteAboutDisability");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	DisabilityPeopleDataSet.remove(selected[i]);
				}
				DisabilityPeopleDataSet.commitChanges();
			}else{
				L5.Msg.alert('提示',"删除时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}
function insert() {
//	var url = "jsp/cams/bpt/flow/disability/changecertidisa/changeCertiDisaInsert.jsp";
//	var text = '添加证件变更人员信息';
//	L5.forward(url, text);
	var width = screen.width-100;
    var height = screen.height-140;
	var url = 'changeCertiDisaInsert.jsp';
	var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	if(returnValue!=""&returnValue!=undefined){
 		var list = returnValue.split(";");
 		var peopleId = list[0];
 		var familyId = list[1];
 		var applyId = list[2];
 		var url2="changeCertiDisaUpdate.jsp?familyId="+familyId+"&peopleId="+peopleId+"&applyId="+applyId;
		var win = window.showModalDialog (url2,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		init();
		if (win==null) {
			return;
		}
 	}
}

function update() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录修改!");
		return false;
	}
	var peopleId = selected[0].get('PEOPLE_ID');
	var familyId = selected[0].get('FAMILY_ID');
	var applyId = selected[0].get('APPLY_ID');
//	var data = new L5.Map();
//	data.put("peopleId", peopleId);
//	data.put("familyId", familyId);
//	data.put("applyId",applyId);
//	var url = 'jsp/cams/bpt/flow/disability/changecertidisa/changeCertiDisaUpdate.jsp';
//	var text = '修改人员证件变更信息修改';
//	L5.forward(url, text, data);
	var width = screen.width-100;
    var height = screen.height-140;
	var url = 'changeCertiDisaUpdate.jsp?familyId=' + familyId + '&peopleId='+ peopleId + '&applyId=' + applyId;
	var win = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	init();
	if (win=="createSend") {
		createAndSend();
	}else{
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
	
	var width = screen.width-100;
    var height = screen.height-140;
	var url = 'changeCertiDisaDetail.jsp?familyId=' + familyId + '&peopleId='
			+ peopleId + '&applyId=' + applyId;
	var win = window.showModalDialog(url, window,
			"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
	if (win == null) {
		return;
	}
}

// 发起单个流程
function createAndSend() {
	operation("pass");
}

function operation(value) {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert("提示", "请选择一个人员进行提交！");
		return false;
	}
	var DisabilityPeopleRecord = selected[0];
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
	command.setParameter("record", DisabilityPeopleRecord);
	command.setParameter("condition",value);
	command.execute("createAndSend");
	if(!command.error){
		   alert("流程发起并发送成功!");
		   //跳转到已办任务页面
		 	var url="";
		   if(value == "pass") {
		  	 url = "jsp/cams/bpt/flow/queryyiban_bpt.jsp";
		   } else if(value == "end") {
		   	 url = "jsp/cams/bpt/flow/queryend_bpt.jsp";
		   }
		   L5.forward(url,"已办任务页面");
	     }else{
	      alert(command.error);
	     }
}

function end() {
	operation("end");
}

// 批量发起流程
function batchSend() {

}