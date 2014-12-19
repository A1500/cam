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
	ds.setParameter("CON_AREA",document.getElementById("conArea").value);
	ds.setParameter("CON_TYPE",document.getElementById("qconType").value);
	ds.setParameter("CON_MOD",document.getElementById("qconMod").value);
	ds.load();
}

function insert() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/comm/extuser/samMConConfigEdit.jsp';
	var text = '增加一站结算_医保系统连接配置';
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
	data.put("dataBean",selected[0].get('conArea'));
	data.put("conType",selected[0].get('conType'));
	var url='jsp/cams/comm/extuser/samMConConfigEdit.jsp';
	var text = '修改一站结算_医保系统连接配置';
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
				delIds[i]=selected[i].get("conArea")+","+selected[i].get("conType");
			}
			var command=new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMedicalConConfigCmd");
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
function forHelp(){
	var revalue = window.showModalDialog(
    		L5.webPath+"/jsp/cams/comm/diccity/dicCityCounty.jsp?organCode="+organCode+"&organName=请选择", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
    if(revalue!=""&&revalue!=undefined){
       var list = revalue.split(";");
       document.getElementById("conArea").value=list[0];
       document.getElementById("conAreaName").value=list[1];
    }
    
	
}



