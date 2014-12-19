function init() {
	L5.DatasetMgr.lookup("ds").load();
	ds.on("load",function(){
		ds.each(function(record, index){
			if(record.get("sorgType")=="S"){
				record.set("sorgType","社会团体");
			}
			if(record.get("sorgType")=="M"){
				record.set("sorgType","民办非企业");
			}
			if(record.get("sorgType")=="J"){
				record.set("sorgType","基金会");
			}
			if(record.get("status")=="0"){
				record.set("status","待使用");
			}
			if(record.get("status")=="1"){
				record.set("status","使用中");
			}
			if(record.get("status")=="2"){
				record.set("status","停止使用");
			}
			ds.commitChanges();
		});
	});
	
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	if(getParam("type")!=undefined||getParam("typeDesc")!=undefined){
		ds.setParameter("SOM_ASSESS_TYPE.TYPE@=",getParam("type"));		
		ds.setParameter("SOM_ASSESS_TYPE.TYPE_DESC@LIKE","%"+getParam("typeDesc")+"%");	
	}else{
		L5.Msg.alert('提示',"请输入查询条件!");
	}
	ds.load();
}

function insert() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/sorg/assess/assesstype/somassesstype_edit.jsp';
	var text = '增加社会组织评估类型';
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
	data.put("dataBean",selected[0].get('id'));
	var url='jsp/cams/sorg/assess/assesstype/somassesstype_edit.jsp';
	var text = '修改社会组织评估类型';
	L5.forward(url,text,data);
}
function assess(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请先选择一条记录!");
		return false;
	}
	if(selected[0].get('status') != "使用中"){
		L5.Msg.alert('提示',"请该配置项状态不是'使用中',不能进行维护!");
		return false;
	}
	var data = new L5.Map();
	data.put("id",selected[0].get('id'));
	data.put("typeDesc",encodeURIComponent(encodeURIComponent(selected[0].get('typeDesc'))));
	data.put("type",selected[0].get('type'));
	var url='jsp/cams/sorg/assess/assessconfig/assessConfig.jsp';
	var text = '修改社会组织评估配置';
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
				delIds[i]=selected[i].get("id");
			}
			var command=new L5.Command("com.inspur.cams.sorg.assess.assesstype.cmd.SomAssessTypeCommand");
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



