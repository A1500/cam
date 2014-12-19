
  
function init() {
	var ds = L5.DatasetMgr.lookup("ds");
	ds.setParameter("ORGAN_ID@=",organId);
	ds.on("load",dsOnLoad);
	ds.load();
}
function dsOnLoad(ds){
	if(ds.getCount()==0){
		//人力资源和社会保障
		var record01 = ds.newRecord();
		record01.set("organId",organId);
		record01.set("extOrganType","01");
		//房管
		var record02 = ds.newRecord();;
		record02.set("organId",organId);
		record02.set("extOrganType","02");
		//工商
		var record03 = ds.newRecord();
		record03.set("organId",organId);
		record03.set("extOrganType","03");
		//公安（车管）
		var record04 = ds.newRecord();
		record04.set("organId",organId);
		record04.set("extOrganType","04");
		//国税
		var record05 = ds.newRecord();
		record05.set("organId",organId);
		record05.set("extOrganType","05");
		//地税
		var record06 = ds.newRecord();
		record06.set("organId",organId);
		record06.set("extOrganType","06");
		//公积金
		var record07 = ds.newRecord();
		record07.set("organId",organId);
		record07.set("extOrganType","07");
		//人民银行
		var record08 = ds.newRecord();
		record08.set("organId",organId);
		record08.set("extOrganType","08");
		//证监
		var record09 = ds.newRecord();
		record09.set("organId",organId);
		record09.set("extOrganType","09");
		//保监
		var record10 = ds.newRecord();
		record10.set("organId",organId);
		record10.set("extOrganType","10");
	}
}


function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){		
	ds.load();
}

function insert() {
	var Grid = L5.getCmp('editGridPanel');
	Grid.stopEditing();
	ds.newRecord();	

}
var onOrganSelect = function(e){
	extOrganDs.removeAll();
	extOrganDs.baseParams["ORGAN_TYPE@"]=ds.getCurrent().get("extOrganType");
	extOrganDs.baseParams["AREA_CODE@in@String"]=filterAreaCode;
	extOrganDs.load();
	var multi = L5.getCmp("helpWin");
	multi.show(e.target);
	multi.afterExecute = function() {
		if (!multi.getReturn().json) {
			ds.getCurrent().set("extOrganId","");
			ds.getCurrent().set("extOrganName","");
		}
		setSelectValue(multi.getReturn());
	};
	
};
function setSelectValue(record){
	ds.getCurrent().set("extOrganId",record.get("organId"));
	ds.getCurrent().set("extOrganName",record.get("organName"));
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
	
	var command = new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyOrganConfigCmd");
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


