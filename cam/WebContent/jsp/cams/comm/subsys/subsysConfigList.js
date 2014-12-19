function init() {
	L5.DatasetMgr.lookup("ds").load();
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	
	ds.setParameter("COM_SUBSYS_CONFIG.SYS_NAME@like",getParam("sysName"));		
	ds.load();
}

function insert() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/comm/subsys/subsysConfigEdit.jsp';
	var text = '增加';
	L5.forward(url,text,data);

}

function update(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("dataBean",selected[0].get('sysId'));
	var url='jsp/cams/comm/subsys/subsysConfigEdit.jsp';
	var text = '修改COM_SUBSYS_CONFIG';
	L5.forward(url,text,data);
}

function apply(){
	var command=new L5.Command("com.inspur.cams.comm.subsys.cmd.ComSubsysConfigCmd");
	command.execute("apply");
	if (!command.error) {
		L5.Msg.alert('提示',"刷新成功！");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
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
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("sysId");
			}
			var command=new L5.Command("com.inspur.cams.comm.subsys.cmd.ComSubsysConfigCmd");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	ds.remove(selected[i]);
				}
				ds.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}



