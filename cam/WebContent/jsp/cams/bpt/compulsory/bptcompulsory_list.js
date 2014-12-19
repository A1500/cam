function init() {
//	L5.DatasetMgr.lookup("ds").load();
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){	
	ds.setParameter("domicileCode",getParam("domicileCode"));
	ds.setParameter("name",getParam("name"));		
	ds.setParameter("sex",getParam("sex"));		
	ds.setParameter("idCard",getParam("idCard"));		
	ds.setParameter("nation",getParam("nation"));
	ds.setParameter("organCode",organCode);
	ds.load();
}

function insert() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/bpt/compulsory/bptcompulsory_edit.jsp';
	var text = '增加义务兵信息';
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
	data.put("dataBean",selected[0].get('ID'));
	var url='jsp/cams/bpt/compulsory/bptcompulsory_edit.jsp';
	var text = '修改BPT_COMPULSORY';
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
				delIds[i]=selected[i].get("ID");
			}
			var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCompulsoryCommand");
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
 * 事件处理：点击详细按钮,转向详细页面
 */
function Evt_butdetail_click() {
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("dataBean",selected[0].get('ID'));
	var url='jsp/cams/bpt/compulsory/bptcompulsory_detail.jsp';
	var text = '义务兵家庭信息';
	L5.forward(url,text,data);
}

/**
 * 事件处理：点击取消按钮
 */
function Evt_butundo_click() {
	var custDataset=L5.DatasetMgr.lookup("custDataset");
	//dataset取消所有修改：
	custDataset.rejectChanges();
}

/**
 * 重置
 */
function reset(){
	document.getElementById("name").value = "";
	document.getElementById("sex").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("nation").value = "";
	document.getElementById("domicileCode").value = "";
}

/*
 * 通用帮助--行政区划
 */
function forHelp(){
//	var struId = document.getElementById("struId").value;
	var revalue=window.showModalDialog("../../../bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=1&organType=1&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];

	}
}

