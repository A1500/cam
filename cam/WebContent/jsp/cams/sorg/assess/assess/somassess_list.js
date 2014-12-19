function init() {
	ds.baseParams["ORGAN_AREA_CODE@LIKE"]=organCode;
	L5.DatasetMgr.lookup("ds").load();
	ds.on("load",function(){
		ds.each(function(record, index){
			if(record.get("ifEnd")=="0"){
				record.set("ifEnd","结束")
			}
			if(record.get("ifEnd")=="1"){
				record.set("ifEnd","启用")
			}
			ds.commitChanges();
		});
	});
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	if(getParam("sorgName")!=undefined){
		ds.setParameter("SOM_ASSESS_TASK.SORG_NAME@LIKE","%"+getParam("sorgName")+"%");		
	}
	ds.setParameter("SOM_ASSESS_TASK.SORG_CODE@=",getParam("sorgCode"));		
	ds.setParameter("SOM_ASSESS_TASK.SORG_TYPE@=",getParam("sorgType"));		
	ds.setParameter("SOM_ASSESS_TASK.ASSESS_TYPE@=",getParam("assessType"));		
	ds.load();
}

function assess(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录进行评估!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","INSERT");
	data.put("taskId",selected[0].get('taskId'));
	data.put("assessType",selected[0].get('assessType'));
	data.put("sorgCode",selected[0].get('sorgCode'));
	data.put("sorgType",selected[0].get('sorgType'));
	data.put("sorgName",selected[0].get('sorgName'));
	var url='jsp/cams/sorg/assess/assess/somassess_edit.jsp';
	var text = '增加社会组织评估';
	L5.forward(url,text,data);
}
function assessDetail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录进行评估!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","INSERT");
	data.put("taskId",selected[0].get('taskId'));
	var url='jsp/cams/sorg/assess/assess/somassessdetail_list.jsp';
	var text = '增加社会组织评估明细';
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
				delIds[i]=selected[i].get("taskId");
			}
			var command=new L5.Command("com.inspur.cams.sorg.assess.assesstask.cmd.SomAssessTaskCommand");
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



