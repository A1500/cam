function init() {
	ds.setParameter("FILL_PEOPLE_AREA@like",areaCode);
	ds.setParameter("SORG_TYPE","S");
	ds.setParameter("STATUS","1");
     var d = new Date(),
        nowYear = +d.getFullYear();
      document.getElementById("batchYear").value=nowYear-1
	ds.load();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	//if(value=="") value=undefined;
	return value;
}
function query(){
	ds.setParameter("FILL_PEOPLE_AREA@like",areaCode);
	ds.setParameter("SORG_TYPE","S");
	ds.setParameter("STATUS","1");
	ds.setParameter("CN_NAME@like",getParam("cnName"));
	ds.setParameter("SORG_CODE",getParam("sorgCode"));
	ds.setParameter("BATCH_YEAR@=",getParam("batchYear"));
	ds.load();
}

function correctPass(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录进行接收!");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.sorg.check.manage.SomCheckManageCommand");
	command.setParameter("taskCode", selected[0].get('taskCode'));
	command.setParameter("status", "3");
	command.execute("updateStatus");
	if (!command.error) {
		L5.Msg.alert("提示","校对通过成功！",function(){
			init();
		});
	}else{
		L5.Msg.alert('提示',"校对通过时出现错误！"+command.error);
	}
}

function correctNotPass(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录进行接收!");
		return false;
	}
	var win = L5.getCmp("correctNotPassReasonWin");
	win.show();
}
function correctNotPassReason(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	var command = new L5.Command("com.inspur.cams.sorg.check.manage.SomCheckManageCommand");
	command.setParameter("taskCode", selected[0].get('taskCode'));
	command.setParameter("status", "4");
	command.setParameter("correctNotReason",document.getElementById("correctNotReason").value);
	command.execute("updateStatus");
	if (!command.error) {
		L5.Msg.alert("提示","校对不通过成功！",function(){
			var win = L5.getCmp("correctNotPassReasonWin");
			win.hide();
			init();
		});
	}else{
		L5.Msg.alert('提示',"校对不通过时出现错误！"+command.error);
	}
}
function closeCorrectNotPassReasonWin(){
	var win = L5.getCmp("correctNotPassReasonWin");
	win.hide();
}
function detail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","DETAIL");
	data.put("flag","correct");
	data.put("taskCode",selected[0].get('taskCode'));
	var url='jsp/cams/sorg/check/group/manage/somgroupcheckcorrectDetail.jsp';
	var text = '年检明细';
	L5.forward(url,text,data);
}




