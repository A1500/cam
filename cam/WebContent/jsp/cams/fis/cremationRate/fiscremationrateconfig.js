	var currentCode="";
 	function init() {
	L5.DatasetMgr.lookup("ds");	
	ds.setParameter("sort","ID");
	L5.QuickTips.init();
};


function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){	
	var ds = L5.DatasetMgr.lookup("ds");
	if(organCode.substring(2) == "0000000000")	{
		ds.setParameter("FIS_CREMATION_RATE_CONFIG.LEVE@=","0");
		ds.setParameter("FIS_CREMATION_RATE_CONFIG.SUM_YEAR@=",getParam("sumYear"));
		ds.setParameter("sort","ID");			
		ds.load();
		}
	else if(organCode.substring(4) == "00000000"){
		ds.setParameter("FIS_CREMATION_RATE_CONFIG.LEVE@=","1");
		ds.setParameter("FIS_CREMATION_RATE_CONFIG.SUM_YEAR@=",getParam("sumYear"));
		ds.setParameter("sort","ID");			
		ds.load();
	}
	else if(organCode.substring(6) == "000000"){
		ds.setParameter("FIS_CREMATION_RATE_CONFIG.LEVE@=","2");
		ds.setParameter("FIS_CREMATION_RATE_CONFIG.SUM_YEAR@=",getParam("sumYear"));
		ds.setParameter("sort","ID");			
		ds.load();
	}
	else if(organCode.substring(8) == "0000"){
		ds.setParameter("FIS_CREMATION_RATE_CONFIG.LEVE@=","3");
		ds.setParameter("FIS_CREMATION_RATE_CONFIG.SUM_YEAR@=",getParam("sumYear"));
		ds.setParameter("sort","ID");			
		ds.load();
	}
	else
	return ;
}

function insert() {
	var Grid = L5.getCmp('editGridPanel');
	Grid.stopEditing();
	ds.newRecord();	

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
				delIds[i]=selected[i].get("recordId");
			}
			var command=new L5.Command("com.inspur.cams.fis.cremationRate.cmd.FisCremationRateConfigCommand");
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
	var isValidate = ds.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.fis.cremationRate.cmd.FisCremationRateConfigCommand");
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
function detailRender(value, cellmeta, record, rowindex, colindex, dataset) {
	return '<a href="javascript:forDown(\'' + record.get('id')+'\',\''+ record.get('name')+'\',\''+ record.get('sumYear') + '\')">'
			+ value + '</a>';
}
// 下钻
function forDown(id,name,sumYear) {
	//var organCode = obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML; // 行政区划
	var ds = L5.DatasetMgr.lookup("ds");
	if(id.substring(2) == "0000000000")	{
		ds.setParameter("FIS_CREMATION_RATE_CONFIG.ID@LIKE",id.substring(0,2));
		ds.setParameter("FIS_CREMATION_RATE_CONFIG.LEVE@=","1");
		ds.setParameter("FIS_CREMATION_RATE_CONFIG.SUM_YEAR@=",sumYear);
		ds.setParameter("sort","ID");			
		ds.load();
		currentCode="0";
		}
	else if(id.substring(4) == "00000000"){
		ds.setParameter("FIS_CREMATION_RATE_CONFIG.ID@LIKE",id.substring(0,4));	
		ds.setParameter("FIS_CREMATION_RATE_CONFIG.LEVE@=","2");
		ds.setParameter("FIS_CREMATION_RATE_CONFIG.SUM_YEAR@=",sumYear);
		ds.setParameter("sort","ID");			
		ds.load();
		currentCode="1";
	}
	else if(id.substring(6) == "000000"){
		ds.setParameter("FIS_CREMATION_RATE_CONFIG.ID@LIKE",id.substring(0,6));
		ds.setParameter("FIS_CREMATION_RATE_CONFIG.LEVE@=","3");
		ds.setParameter("FIS_CREMATION_RATE_CONFIG.SUM_YEAR@=",sumYear);
		ds.setParameter("sort","ID");			
		ds.load();
		currentCode="2";
	}
	
	else
	return ;
}
// 手工返回
function back() {
	if(currentCode == "2")	{
		ds.setParameter("FIS_CREMATION_RATE_CONFIG.LEVE@=","2");
		ds.setParameter("sort","ID");		
		ds.load();
		currentCode="1";
		}
	else if(currentCode == "1"){
		ds.setParameter("FIS_CREMATION_RATE_CONFIG.LEVE@=","1");
		ds.setParameter("sort","ID");			
		ds.load();
		currentCode="0";
	}
	else if(currentCode == "0"){
		ds.setParameter("FIS_CREMATION_RATE_CONFIG.LEVE@=","0");
		ds.setParameter("sort","ID");		
		ds.load();
		currentCode="";
	}
	
	else
	return ;
}