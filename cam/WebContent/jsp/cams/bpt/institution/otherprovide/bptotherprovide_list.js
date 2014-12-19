function init() {
	var ds=L5.DatasetMgr.lookup("ds");
	ds.setParameter("REG_ORGAN_CODE@like@String",getSubStrOrganCode());
	ds.load()
	L5.QuickTips.init();
};
function getSubStrOrganCode(){
	var returnValue;
	if (!organCode.substring(0, 2)=="00" && organCode.substring(2, 4)=="00") {// 省局
			returnValue = organCode.substring(0, 2);
		}else if(!organCode.substring(2, 4)=="00"&&organCode.substring(4, 6)=="00"){//市局
			returnValue = organCode.substring(0, 4);
		}else{//区县
			returnValue = organCode.substring(0, 6);
		}
	return returnValue+"%";
}
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	ds.setParameter("BPT_OTHERPROVIDE.YEARS@=",getParam("years"));		
	ds.setParameter("BPT_OTHERPROVIDE.DOMICILENAME@=",getParam("domicilename"));	
	ds.setParameter("REG_ORGAN_CODE@like@String",getSubStrOrganCode());	
	ds.load();
	noReclick(ds,"queryButton");  
}

function insert() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/bpt/institution/otherprovide/bptotherprovide_edit.jsp';
	var text = '增加其他供养情况';
	L5.forward(url,text,data);

}

function update(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var regOrganCode=selected[0].get('regOrganCode');
	if(regOrganCode!=organCode){
		L5.Msg.alert("提示","录入单位不是当前登录单位，不能进行修改!");
		return;		
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("dataBean",selected[0].get('id'));
	var url='jsp/cams/bpt/institution/otherprovide/bptotherprovide_edit.jsp';
	var text = '修改其他供养情况';
	L5.forward(url,text,data);
}
function detail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("dataBean",selected[0].get('id'));
	var url='jsp/cams/bpt/institution/otherprovide/bptotherprovide_detail.jsp';
	var text = '其他供养情况详细';
	L5.forward(url,text,data);
}

function del(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	var regOrganCode=selected[0].get('regOrganCode');
	if(regOrganCode!=organCode){
		L5.Msg.alert("提示","录入单位不是当前登录单位，不能进行删除!");
		return;		
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("id");
			}
			var command=new L5.Command("com.inspur.cams.bpt.bptinstitution.cmd.BptOtherprovideCommand");
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
* 选择属地行政区划窗口
*/
function func_ForDomicileSelect1(){
		var escapeorganName = escape(encodeURIComponent('山东省'));
		var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicCityCounty.jsp?organCode=370000000000&organName="+escapeorganName,"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
			var list = revalue.split(";");
			var code = list[0].substring(4, 12);
			if(code!="00999000"){
				document.getElementById("domicileCode").value=list[0].substring(0, 6);
			}else {
				document.getElementById("domicileCode").value=list[0].substring(0, 4);
			}
			document.getElementById("domicileName").value=list[4];
		}
}

