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
	
	ds.setParameter("COM_EXT_USER.USER_ID@=",getParam("userId"));		
	ds.setParameter("COM_EXT_USER.USER_NAME@=",getParam("userName"));		
	ds.setParameter("COM_EXT_USER.ORGAN_TYPE@=",getParam("organType"));		
	ds.load();
}
function changeStatus(){

	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要解除冻结的社会组织!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要解除冻结选中的社会组织吗?',function(state){
		if(state=="yes"){
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i];
			}
			var command=new L5.Command("com.inspur.cams.comm.extuser.cmd.ComExtUserCmd");
			command.setParameter("comExtUser",delIds);
			command.execute("batchUpdate");
			if (!command.error) {
				L5.Msg.alert("提示","解除冻结成功!",function(){
					query();
				});
			}else{
				L5.Msg.alert('提示',"操作时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}
//明细
function detailHref(value,cellmeta,record,rowindex,colindex,dataset){
	if(record.get("organType")=="ST"){
		return "社会团体";
	}
	if(record.get("organType")=="MF"){
		return "民办非企业";
	}
	if(record.get("organType")=="JJ"){
		return "基金会";
	}
}

