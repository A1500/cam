function init() {
	var ds = L5.DatasetMgr.lookup("ds");
	ds.setParameter("CITYID@=",orgCode);
	ds.load();	
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
		
	ds.setParameter("NAME@like",getParam("q_name"));			
	ds.setParameter("EFFECTIVE@=",getParam("effective"));
	ds.setParameter("CITYID@=",orgCode);//避免查询到其他地市的培训专业
	ds.load();
}

function insert() {
	var record = ds.getCurrent();
	if(record==null){
		ds.newRecord({"cityid":orgCode,"effective":"1"});
		record = ds.getCurrent();
	}else{
		if(record.get("name")==''){
			L5.Msg.alert('提示',"专业名称不能为空,不能保存! ");
		}else{
			ds.newRecord({"cityid":orgCode,"effective":"1"});	
			var Grid = L5.getCmp('editGridPanel');
			Grid.stopEditing();
		}
	}
}

function del() {
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
				delIds[i]=selected[i].get("code");
			}
			var command=new L5.Command("com.inspur.cams.prs.prsTrainDic.cmd.DicPrsTrainFieldCommand");
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
function save() {
	var records = ds.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	var command = new L5.Command("com.inspur.cams.prs.prsTrainDic.cmd.DicPrsTrainFieldCommand");
	command.setParameter("records", records);
	command.execute("save");
	if (!command.error) {
		ds.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function reset() {
	ds.rejectChanges();
}



