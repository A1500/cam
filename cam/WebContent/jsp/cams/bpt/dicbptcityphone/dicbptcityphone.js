var ds;  
function init() {
	ds = L5.DatasetMgr.lookup("ds");	
	ds.setParameter("ORGAN_CODE@=",getorganCode);
	ds.load();
	//L5.QuickTips.init();
};


function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){		
	ds.setParameter("DIC_BPT_CITY_PHONE.ORGAN_CODE@=",getorganCode);		
	ds.setParameter("DIC_BPT_CITY_PHONE.ORGAN_NAME@=",getParam("organName"));		
	//ds.setParameter("DIC_BPT_CITY_PHONE.SERVICE_TYPE@=",getParam("serviceType"));		
	ds.setParameter("DIC_BPT_CITY_PHONE.PHONE@=",getParam("phone"));		
	ds.load();
}

function insert() {
	var Grid = L5.getCmp('editGridPanel');
	Grid.stopEditing();
	ds.newRecord();	
	ds.getCurrent().set("organName",getorganName);
	ds.getCurrent().set("organCode",getorganCode);
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
				delIds[i]=selected[i].get("id");
			}
			var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.DicBptCityPhoneCommand");
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
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.DicBptCityPhoneCommand");
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
function getOrganName(){
	
	onclforHelp()

}
/**
 * 所属机构窗口
 */
 function editDicDetails(value,cellmeta,record,rowindex,colindex,dataset){
 		var struId='1';
 		if(record.get("organName")==""){
 			record.set("organName",getorganName);
 			record.set("organCode",getorganCode);
 		}
	return record.get("organName");
}


function forHelp(){  
		var record = ds.getCurrent();
		var struId='1';
		var revalue=window.showModalDialog("../../../../jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=11,12,13&organType=0&isExact=1&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		record.set("organName",list[1]);
		record.set("organCode",list[0]);  
		}
}
/**
 * 查询所属机构窗口
 */
function winForHelp(){
		var struId='1';
		var revalue=window.showModalDialog("../../../../jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=11,12,13&organType=0&isExact=1&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		//document.getElementById("domicileCode").value = list[0];
		document.getElementById("organName").value = list[1];
		}
}