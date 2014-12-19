function init() {
	ds.setParameter("sort","IN_USE");
	ds.setParameter("SAM_LOW_STANDARDS.ASSITANCE_TYPE@in","01,02,03");
	ds.setParameter("SAM_LOW_STANDARDS.IN_USE@=","1");
	ds.load();
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	ds.setParameter("SAM_LOW_STANDARDS.ASSITANCE_TYPE@in","01,02,03");
	ds.setParameter("SAM_LOW_STANDARDS.ASSITANCE_TYPE@=",getParam("assitanceTypeQuery"));		
	ds.setParameter("SAM_LOW_STANDARDS.VALID_BEGIN_DATE@>=",getParam("validYear"));	
	ds.setParameter("SAM_LOW_STANDARDS.IN_USE@=",getParam("inUseQuery"));	
	ds.setParameter("sort","IN_USE");
	ds.load();
}

function insert() {
	var dataset=L5.DatasetMgr.lookup('editDs');
	dataset.removeAll();
	var newRecord = dataset.newRecord();
	newRecord.set("domicileCode",organCode);
	newRecord.set("apanageName",organName);
	newRecord.set("validBeginDate",nowTime);
	newRecord.set("validEndDate",'3000-12');
	newRecord.set("inUse",'1');
	var win=L5.getCmp("addWin");
	win.show();
	$('assitanceType').disabled=false;

}

function update(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	if(selected[0].get("inUse")=='0'){
		L5.Msg.alert('提示',"该标准已停用，不能修改!");
		return false;
	}else{
		var standardsId=selected[0].get("standardsId");
		var win=L5.getCmp("addWin");
		win.show();
		var dataset=L5.DatasetMgr.lookup('editDs');
		dataset.setParameter("STANDARDS_ID@=",standardsId);
		dataset.load();
		$('assitanceType').disabled=true;
		$('supportWay').disabled=true;
	}
}

function unUse(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	if(selected[0].get("inUse")=='0'){
		L5.Msg.alert('提示',"该标准已经停用!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要停用该标准吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamLowStandardsCmd");
			command.setParameter("id",selected[0].get("standardsId"));
			command.execute("unUse");
			if (!command.error) {
				L5.Msg.alert('提示',"更新成功!",function(){
					var ds=L5.DatasetMgr.lookup("ds");
					ds.setParameter("SAM_LOW_STANDARDS.ASSITANCE_TYPE@in","01,02,03");
					ds.reload();
				});
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}
	});
}
function save(){
	var dataset=L5.DatasetMgr.lookup('editDs');
	var valid = dataset.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',valid);
		valid=true;
		return false;
	}
	var records = dataset.getCurrent();
	if(!isFloat(records.get("lowStandards"))){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+'低保标准不是数字!');
		return false;
	}
	records.set("domicileCode",getParam("domicileCode"));
	records.set("validYear",records.get('validBeginDate').substring(0,4));
	var command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamLowStandardsCmd");
	command.setParameter("records",records);
	command.execute("save");	
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!",function(){
			var win=L5.getCmp("addWin");win.hide();
			var ds=L5.DatasetMgr.lookup("ds");
			ds.setParameter("SAM_LOW_STANDARDS.ASSITANCE_TYPE@in","01,02,03");
			ds.load();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function closeWin(){
	var win=L5.getCmp("addWin");
	win.hide();
}
//弹出救助对象属地选择通用帮助
function forSearchHelp(domId,idField){	  
       var revalue=window.showModalDialog("../../../../../jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=1&organType=11,12,13&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
       if(revalue!=""&&revalue!=undefined){    	   
          var list = revalue.split(";");
          document.getElementById(idField).value = list[0];
          document.getElementById(domId).value = list[1];
           return list[0];
       }
      
}
//弹出救助对象属地选择通用帮助
function forEditHelp(domId){	  
       var revalue=window.showModalDialog("../../../../../jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=1&organType=11,12,13&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
       if(revalue!=""&&revalue!=undefined){    	   
          var list = revalue.split(";");
          document.getElementById("domicileCode").value = list[0];
          document.getElementById(domId).value = list[1];
          if(editFlg){
	          var dataset=L5.DatasetMgr.lookup('editDs');
	          dataset.set("apanage",list[0]);
	          dataset.set("apanageName",list[1]);
          }
           return list[0];
       }      
}

function lowStandardsChange(obj){
	obj.value=formatNum(obj.value);
}
//使用状态
function getInUse(value,cellmeta,record,rowindex,colindex,dataset){
	var inUse=record.get('inUse');
	if(inUse=="1"){
		return '<label style="color:green">'+'启用'+'</label>';
	}else if(inUse=="0"){
		return '<label style="color:red">'+'停用'+'</label>';
	}else{
		return "";
	} 
}
//保障标准增加单位
function formatTime(value,cellmeta,record,rowindex,colindex,dataset){
	var assitanceType=record.get('assitanceType');
	if(assitanceType == "01"){
		return formatNum(record.get('lowStandards'))+' 元/月';
	}else{
		return formatNum(record.get('lowStandards'))+' 元/年';
	}
}
function loadSupportWay(){
	var assitanceType=_$('assitanceType');
	if(assitanceType=='03'){//农村五保
		$('supportWay').disabled=false;
	}else{
		document.getElementById("supportWay").value='';
		$('supportWay').disabled=true;
	}
}
//检查低保标准
function checkLowStandards(){
	var assitanceType=_$('assitanceType');
	if(assitanceType==''){
		return;
	}
	if(assitanceType=='03' && _$('supportWay')==''){//农村五保
		return;
	}
	//新增时 校验分类施保类别代码
	var queryDs = L5.DatasetMgr.lookup("queryDs");
	queryDs.setParameter("DOMICILE_CODE@=",organCode);	
	queryDs.setParameter("ASSITANCE_TYPE@=",_$('assitanceType'));	
	queryDs.setParameter("SUPPORT_WAY@=",_$('supportWay'));	
	queryDs.setParameter("IN_USE@=",'1');	
	queryDs.on('load',function(ds){
		if(ds.getCount()>0){
			L5.Msg.alert("提示","低保标准已存在，请在原标准基础上修改!");
			var record=editDs.getCurrent();
			record.set("standardsId",ds.get("standardsId"));
			record.set("lowStandards",ds.get("lowStandards"));
			record.set("validBeginDate",nowTime);
			$('assitanceType').disabled=true;
			$('supportWay').disabled=true;
			
			return false;
		}
	});
	queryDs.load();	
}

function formateValidEndDate(value,cellmeta,record,rowindex,colindex,dataset){
	var inUse=record.get('inUse');
	var validEndDate=record.get('validEndDate');
	if(inUse=="1"){
		return "";
	}else{
		return validEndDate;
	} 
}