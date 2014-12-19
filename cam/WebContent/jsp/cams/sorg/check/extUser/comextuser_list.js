function init() {
	L5.DatasetMgr.lookup("ds").load();
	L5.QuickTips.init();
	L5.DatasetMgr.lookup("ds").on("load",function(){
		ds.each(function(record, index){
			if(record.get("organType")=="ST"){
				record.set("organType","社会团体")
			}
			if(record.get("organType")=="MF"){
				record.set("organType","民办非企业")
			}
			if(record.get("organType")=="JJ"){
				record.set("organType","基金会")
			}
		});
		ds.commitChanges();
	});
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	
	ds.setParameter("COM_EXT_USER.USER_ID@=",getParam("userId"));		
	ds.setParameter("COM_EXT_USER.USER_NAME@=",getParam("userName"));		
	ds.setParameter("COM_EXT_USER.ORGAN_TYPE@=",getParam("organType"));		
	ds.load();
}

function insert() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/sorg/check/extUser/comextuser_edit.jsp';
	var text = '增加COM_EXT_USER';
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
	var userId = encodeURIComponent(encodeURIComponent(selected[0].get('userId')));
	data.put("dataBean",userId);
	var url='jsp/cams/sorg/check/extUser/comextuser_edit.jsp';
	var text = '修改COM_EXT_USER';
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
				delIds[i]=selected[i].get("userId");
			}
			var command=new L5.Command("com.inspur.cams.comm.extuser.cmd.ComExtUserCmd");
			command.setParameter("delIds", delIds);
			command.execute("del");
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



