function init() {
	query();
}
function query(){
	ds.setParameter("COM_EXT_USER.USER_ID",document.getElementById('userId').value);
	ds.setParameter("COM_EXT_USER.USER_NAME@=",document.getElementById('userName').value);
	ds.load();		
	
}
function insert() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/dataexchange/extUser/dataexchangeUserInsert.jsp';
	var text = '增加数据共享用户';
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
	var url='jsp/cams/dataexchange/extUser/dataexchangeUserInsert.jsp';
	var text = '修改数据共享用户';
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
			var command=new L5.Command("com.inspur.cams.sorg.online.extuser.cmd.SomExtUserCmd");
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



