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
	
	ds.setParameter("SOM_ASSESS.ASSESS_PERSON_NAME@=",getParam("assessPersonName"));		
	ds.load();
}

function insert() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/sorg/assess/assess/somassess/somassess_edit.jsp';
	var text = '增加SOM_ASSESS';
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
	data.put("dataBean",selected[0].get('taskCode'));
	var url='jsp/cams/sorg/assess/assess/somassess_edit.jsp';
	var text = '修改SOM_ASSESS';
	L5.forward(url,text,data);
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
				delIds[i]=selected[i].get("taskCode");
			}
			var command=new L5.Command("com.inspur.cams.sorg.assess.assess.cmd.SomAssessCommand");
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

 function back()
 {	 	var url='jsp/cams/sorg/assess/assess/somassess_list.jsp';
		var text = 'SOM_ASSESS';
		L5.forward(url,text);	 
 }
