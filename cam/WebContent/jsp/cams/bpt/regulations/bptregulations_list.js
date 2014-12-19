function init() {
	var ds=L5.DatasetMgr.lookup("ds");
	ds.load();
	
	ds.on("load", function changeToolbar() {
	
		if(getorganCode=='370000000000'){
			L5.get("add").show();
			L5.get("edit").show();
			L5.get("remove").show();
		} else {
			L5.get("add").hide();
			L5.get("edit").hide();
			L5.get("remove").hide();
		}
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
	var ds=L5.DatasetMgr.lookup("ds");
	ds.setParameter("FILE_NUM@like",getParam("p_fileNum"));
	ds.setParameter("FILE_LEVEL@=",getParam("p_fileLevel"));
	ds.setParameter("REGULATIONS_TITLE@like",getParam("p_filetitle"));
	ds.setParameter("RELEASE_DATE@=",getParam("p_releaseDate"));
	ds.setParameter("FLAG@=",getParam("p_filestate"));
	ds.load();
	noReclick(ds,"queryButton");
}


function insert() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url = "/jsp/cams/bpt/regulations/bptregulations_edit.jsp";
	var text ="文件明细编辑";
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
	data.put("id",selected[0].get('regulationsId'));
	var url = "/jsp/cams/bpt/regulations/bptregulations_edit.jsp";
	var text ="文件明细编辑";
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
			var  ids=[];
			for(var i=0;i<selected.length;i++){
				ids[i] = selected[i].get("regulationsId");
			}
			var command = new L5.Command("com.inspur.cams.bpt.regulations.cmd.BptRegulationsAjaxCommand");
			command.setParameter("ids", ids);
			command.execute("deleteRegulations");
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

function detail(){
	
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var data = new L5.Map();
	data.put("id",selected[0].get("regulationsId"));
	var url ='/jsp/cams/bpt/regulations/bptregulations_detail.jsp';
	var text = "文件明细";
	L5.forward(url,text,data);
}
