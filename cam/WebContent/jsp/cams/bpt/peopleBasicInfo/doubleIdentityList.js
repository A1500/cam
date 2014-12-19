var ifQuery = false;
var time = new Date();
var times = time.format("Y");
var query_startTime = times+"-01-01";
var query_endTime = times+"-12-31";
var flag ;
var path ;
var changeContent;
function init() {
        L5.QuickTips.init();
        dsBptObject1.on("load",function(ds){
    		fields1="B32,B2,B5,B1,B33,B34,B35,B39,B36,B40,B37,B38";
    		L5.dataset2excel(ds,"/jsp/cams/bpt/peopleBasicInfo/excel/bptPeople_excel.jsp?fields="+fields1);
    	});
};


function excel_imp(){
	var dsBptObject1=L5.DatasetMgr.lookup("dsBptObject1");
	var domicileCode = getParam("domicileCode");
	var name = getParam("name");
	var idCard = getParam("idCard");
	dsBptObject1.setParameter("organCode", domicileCode!=null?domicileCode:organCode);
	dsBptObject1.setParameter("name", name);
	dsBptObject1.setParameter("idCard", idCard);
	dsBptObject1.load();
	noReclick(dsBptObject1,"excelButton");
}





function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}

function query() {
	var domicileCode = getParam("domicileCode");
	var name = getParam("name");
	var idCard = getParam("idCard");
	
	
	dsBptObject.setParameter("organCode", domicileCode!=null?domicileCode:organCode);
	dsBptObject.setParameter("name", name);
	dsBptObject.setParameter("idCard", idCard);
	dsBptObject.load();
	noReclick(dsBptObject,"queryButton");
		
	
	// excelLoad();
}
function typeRender(value,o,a){
	var str = ""; 
	var func = '';
	
	var peopleId = a.data.PEOPLE_ID;
	var familyId = a.data.FAMILY_ID;
	var username = a.data.NAME;
	var idCard = a.data.ID_CARD;
	
	
	
	if(o.id=='disability_flag'){
		func = 'javascript:detail("11","'+peopleId+'","'+familyId+'","'+username+'","'+idCard+'")';
	}else if(o.id=='dependant_flag'){
		func = 'javascript:detail("21","'+peopleId+'","'+familyId+'","'+username+'","'+idCard+'")';
	}else if(o.id=='demobilized_flag'){
		if(a.data.DEMOBILIZED_TYEP_CODE	=='41'){
			func = 'javascript:detail("41","'+peopleId+'","'+familyId+'","'+username+'","'+idCard+'")';
		}else if(a.data.DEMOBILIZED_TYEP_CODE	=='42'){
			func = 'javascript:detail("42","'+peopleId+'","'+familyId+'","'+username+'","'+idCard+'")';
		}
	}else if(o.id=='war_flag'){
		if(a.data.WAR_TYPE_CODE=='51'){
			func = 'javascript:detail("51","'+peopleId+'","'+familyId+'","'+username+'","'+idCard+'")';
		}else if(a.data.WAR_TYPE_CODE=='61'){
			func = 'javascript:detail("61","'+peopleId+'","'+familyId+'","'+username+'","'+idCard+'")';
		}
	}else if(o.id=='retired_flag'){
		func = 'javascript:detail("81","'+peopleId+'","'+familyId+'","'+username+'","'+idCard+'")';
	}else if(o.id=='martyr_offspring_flag'){
		func = 'javascript:detail("B1","'+peopleId+'","'+familyId+'","'+username+'","'+idCard+'")';
	}
	var ObjectStateDataset=L5.DatasetMgr.lookup("ObjectStateDataset");
	if(value != ''){
		var str = "<a href='"+func+"'>" +ObjectStateDataset.data.map[value].data.text + "</a>"; 
		return str;
	}else {
		return str;
	}
		
}
function reset(){
	document.getElementById("domicileCode").value = "";
	document.getElementById("domicileName").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("nation").value = "";
}


function detail(objectType,peopleId,familyId,username,idCard){
	/*var basicInfoGrid;
	var objectType="";
	   basicInfoGrid=L5.getCmp('baseGridPanel');
	var selected=basicInfoGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	var peopleId = selected[0].get('PEOPLE_ID');
	var familyId = selected[0].get('FAMILY_ID');
	var username = selected[0].get('NAME');
	var idCard = selected[0].get('ID_CARD');
	var objectState = selected[0].get('OBJECT_STATE');
	if(objectType == ''){
		objectType = selected[0].get('OBJECT_TYPE');
	}*/
	var url='../basicInfoView/basicInfoDetail.jsp?peopleId='+peopleId+'&familyId='+familyId+'&username='+username+'&idCard='+idCard+'&objectType='+objectType;
	var width = screen.width-60;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if (win==null) {
		return;
	}
}

function forHelp() {
	if(!ifQuery) {
		if (organCode != null && organCode != "") {
			var command = new L5.Command("com.inspur.cams.comm.diccity.cmd.DicCityCommand");
			command.setParameter("ID", organCode);
			command.execute("findOrganName");
			var fullName = command.getReturn("organName");
			if (fullName != null && fullName != "") {
				organName = fullName;
			}
			ifQuery = true;
		}
	}
	var revalue = window.showModalDialog(L5.webPath
					+ "/jsp/cams/comm/diccity/dicCity.jsp?organCode="
					+ organCode + "&radioMaxlevel=0&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	// var
	// revalue=window.showModalDialog(L5.webPath+"/jsp/cams/bpt/comm/getselect_code.jsp?rootId="+struId+"&showOrganType=1&organType=1&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");

		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[4];

	}
}



//伤残等级
function forDisability(){
	var revalue=window.showModalDialog("../dicdisabilitylevel/dicdisabilitylevel.jsp");
	if(revalue!=""&&revalue!=undefined){
          var list = revalue.split(";");      
          
          if(list[0] == 0){
//         	document.getElementById("disabilityLevelCode").value=list[0];
            document.getElementById("disabilityLevelCodeName").value="所有伤残等级";
          }else{
          	document.getElementById("disabilityLevelCode").value=list[0];
            document.getElementById("disabilityLevelCodeName").value=list[1];
          }
          
	}
}
function delPeople(){
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?', function(state) {
		if (state == "yes") {
			var basicInfoGrid;
			 basicInfoGrid=L5.getCmp('baseGridPanel');
			var selected=basicInfoGrid.getSelectionModel().getSelections();
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptDelPeopleCommand");
			command.setParameter("record", selected);
			command.execute("deletePeople");
			if (!command.error) {
				L5.Msg.alert('提示','删除成功！');
				query();
			}else{
				L5.Msg.alert('提示',"删除时出现错误！"+command.error);
			}
		} else {
				return false;
		}
	});

}