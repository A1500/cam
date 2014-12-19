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
	
	ds.setParameter("MRM_LEVEL_EVALUTION_INFO.DEPT_NAME@like",getParam("deptName"));		
	ds.setParameter("MRM_LEVEL_EVALUTION_INFO.EVALU_LEVEL@=",getParam("evaluLevel"));		
	ds.load();
}

function insert() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/marry/dept/level/mrmlevelevalutioninfo_edit.jsp';
	var text = '增加等级评定信息表';
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
	data.put("dataBean",selected[0].get('evaluId'));
	var url='jsp/cams/marry/dept/level/mrmlevelevalutioninfo_edit.jsp';
	var text = '修改等级评定信息表';
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
				delIds[i]=selected[i].get("evaluId");
			}
			var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmLevelEvalutionInfoCommand");
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




/**
* 登记机关jsp调用
*/
function getDeptName(){
var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/marry/dept/mrmRadioTree.jsp?organCode=370100000000&organName=山东省","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
if(revalue!=""&&revalue!=undefined){
var list = revalue.split(";");
 document.getElementById("deptName").value=list[1]
}
}