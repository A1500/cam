var ifQuery = false;
var time = new Date();
var times = time.format("Y");
var query_startTime = times+"-01-01";
var query_endTime = times+"-12-31";
var flag ;
var path ;
var changeContent;
function init() {
        /*L5.getCmp("baseGridPanel").show();
	    //L5.getCmp("disbilityGridPanel").hide();
	    L5.getCmp("depentGridPanel").hide();
	    L5.getCmp("demobilizedGridPanel").hide();
	    L5.getCmp("demobilizeInelldGridPanel").hide();
	    L5.getCmp("warGridPanel").hide();
	    L5.getCmp("testedGridPanel").hide();
	    L5.getCmp("countretiredsoldierGridPanel").hide();*/
        L5.QuickTips.init();
        //sipTime('');
};

/**
 * 时间查询条件赋值以及初始化
 * @param {} id
 */
function sipTime(id) {
	/*document.getElementById(id+"cxsj_qs").value=query_startTime;
	document.getElementById(id+"cxsj_zs").value=query_endTime;
	document.getElementById(id+"cxsj_z").value=query_endTime;*/
}


function showTime(id) {
	var type = document.getElementById(id+"timeType").value;
	if(type == "0") {
		document.getElementById(id+"cxsj_qs").value="";
		document.getElementById(id+"cxsj_zs").value="";
		document.getElementById(id+"cxsj_z").value="";
	} else if (type == '1') {
		document.getElementById(id+"times").style.display = "";
		document.getElementById(id+"time").style.display = "none";
		document.getElementById(id+"cxsj_qs").value=query_startTime;
		document.getElementById(id+"cxsj_zs").value=query_endTime;
	} else {
		document.getElementById(id+"times").style.display = "none";
		document.getElementById(id+"time").style.display = "";
		document.getElementById(id+"cxsj_z").value=query_endTime;
	}
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
	var objectType = getParam("objectType");
	var objectState = getParam("objectState");
	var serviceType = getParam("serviceType");// 获取节点ID
	
	
	dsBptObject.setParameter("domicileCode", domicileCode);
	dsBptObject.setParameter("name", name);
	dsBptObject.setParameter("idCard", idCard);
	dsBptObject.setParameter("objectState", objectState);
	dsBptObject.setParameter("serviceType", getParam("serviceType"));
	dsBptObject.setParameter("organCode", organCode);
	dsBptObject.setParameter("objectType", objectType);
		dsBptObject.load();
		noReclick(dsBptObject,"queryButton");
		
	
	// excelLoad();
}

function reset(){
	document.getElementById("domicileCode").value = "";
	document.getElementById("domicileName").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("nation").value = "";
	document.getElementById("marriageCode").value = "";
	document.getElementById("careerCode").value = "";
	document.getElementById("politicalCode").value = "";
	document.getElementById("domicileType").value = "";
	document.getElementById("personalStatsTag").value = "";
	document.getElementById("bptNo").value = "";
}


function detail(){
	var basicInfoGrid;
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
	}
	var url='../basicInfoView/basicInfoDetail.jsp?peopleId='+peopleId+'&familyId='+familyId+'&username='+username+'&idCard='+idCard+'&objectState='+objectState+'&objectType='+objectType;
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

		// 获取优抚对象类别的值，然后判断是哪个查询页面,写入所属机构的值
		var type = getParam("bptObjectType");
		if (type == '1') {
			document.getElementById("disabilityDomicileCode").value = list[0];
			document.getElementById("disabilityDomicileName").value = list[4];
		} else if (type == '2') {
			document.getElementById("dependantDomicileCode").value = list[0];
			document.getElementById("dependantDomicileName").value = list[4];
		} else if (type == '41') {
			document.getElementById("demobilizeDomicileCode").value = list[0];
			document.getElementById("demobilizeDomicileName").value = list[4];
		} else if (type == '42') {
			document.getElementById("illnessDomicileCode").value = list[0];
			document.getElementById("illnessDomicileName").value = list[4];
		} else if (type == '5') {
			document.getElementById("warDomicileCode").value = list[0];
			document.getElementById("warDomicileName").value = list[4];
		} else if (type == '6') {
			document.getElementById("testDomicileCode").value = list[0];
			document.getElementById("testDomicileName").value = list[4];
		} else if (type == '8') {
			document.getElementById("soldierDomicileCode").value = list[0];
			document.getElementById("soldierDomicileName").value = list[4];
		} else {
			document.getElementById("domicileCode").value = list[0];
			document.getElementById("domicileName").value = list[4];
		}

	}
}

function forHelpOT() {
	
	 
	var revalue = window.showModalDialog("../dicobjecttype/dicobjecttype.jsp");
	 
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		var listTypeId = list[0].split(",");

		/*
		 * 获取第一个数的第一位和最后一个数的第一位， 相等则是有相同的一个上级节点，反之则不是同一个上级节点
		 */
		var tistart = 0;// 第一个数的第一位
		var tiend = 0;// 最后一个数的第一位
		if (listTypeId.length != 0) {
			tistart = listTypeId[0].substring(0, 1);// 获取第一个数的第一位
			tiend = listTypeId[listTypeId.length - 1].substring(0, 1);// 获取最后一个数的第一位
		}
		if (listTypeId.length != 0 && tistart == tiend) {
			document.getElementById("bptObjectType").value = tistart;
			if (tistart == 1) {// 伤残
				document.getElementById("disabilityObjectTypeName").value = list[1];
				document.getElementById("disabilityObjectType").value = list[0];

				L5.getCmp("form").hide();
				L5.getCmp("disabilityform").show();
				L5.getCmp("dependantform").hide();
				L5.getCmp("demobilizeform").hide();
				L5.getCmp("demobilizedIllnessform").hide();
				L5.getCmp("warform").hide();
				L5.getCmp("testform").hide();
				L5.getCmp("countretiredsoldierform").hide();
				sipTime('disability');

				L5.getCmp("baseGridPanel").hide();
				L5.getCmp("disbilityGridPanel").show();
				L5.getCmp("depentGridPanel").hide();
				L5.getCmp("demobilizedGridPanel").hide();
				L5.getCmp("demobilizeInelldGridPanel").hide();
				L5.getCmp("warGridPanel").hide();
				L5.getCmp("testedGridPanel").hide();
				L5.getCmp("countretiredsoldierGridPanel").hide();
				
			} else if (tistart == 2) {// 三属
				document.getElementById("dependantObjectTypeName").value = list[1];
				document.getElementById("dependantObjectType").value = list[0];

				L5.getCmp("form").hide();
				L5.getCmp("disabilityform").hide();
				L5.getCmp("dependantform").show();
				L5.getCmp("demobilizeform").hide();
				L5.getCmp("demobilizedIllnessform").hide();
				L5.getCmp("warform").hide();
				L5.getCmp("testform").hide();
				L5.getCmp("countretiredsoldierform").hide();
				sipTime('dependant');

				L5.getCmp("baseGridPanel").hide();
				L5.getCmp("disbilityGridPanel").hide();
				L5.getCmp("depentGridPanel").show();
				L5.getCmp("demobilizedGridPanel").hide();
				L5.getCmp("demobilizeInelldGridPanel").hide();
				L5.getCmp("warGridPanel").hide();
				L5.getCmp("testedGridPanel").hide();
				L5.getCmp("countretiredsoldierGridPanel").hide();
			} else if (list[0] == 41) {// 在乡
				document.getElementById("bilizedObjectTypeName").value = list[1];
				document.getElementById("bilizedObjectType").value = list[0];
				document.getElementById("bptObjectType").value = list[0];

				L5.getCmp("form").hide();
				L5.getCmp("disabilityform").hide();
				L5.getCmp("dependantform").hide();
				L5.getCmp("demobilizeform").show();
				L5.getCmp("demobilizedIllnessform").hide();
				L5.getCmp("warform").hide();
				L5.getCmp("testform").hide();
				L5.getCmp("countretiredsoldierform").hide();
				sipTime('demobilize');

				L5.getCmp("baseGridPanel").hide();
				L5.getCmp("disbilityGridPanel").hide();
				L5.getCmp("depentGridPanel").hide();
				L5.getCmp("demobilizedGridPanel").show();
				L5.getCmp("demobilizeInelldGridPanel").hide();
				L5.getCmp("warGridPanel").hide();
				L5.getCmp("testedGridPanel").hide();
				L5.getCmp("countretiredsoldierGridPanel").hide();
			} else if (list[0] == 42) {// 带病回乡
				document.getElementById("illnessObjectTypeName").value = list[1];
				document.getElementById("illnessObjectType").value = list[0];
				document.getElementById("bptObjectType").value = list[0];

				L5.getCmp("form").hide();
				L5.getCmp("disabilityform").hide();
				L5.getCmp("dependantform").hide();
				L5.getCmp("demobilizeform").hide();
				L5.getCmp("demobilizedIllnessform").show();
				L5.getCmp("warform").hide();
				L5.getCmp("testform").hide();
				L5.getCmp("countretiredsoldierform").hide();
				sipTime('demobilizedIllness');

				L5.getCmp("baseGridPanel").hide();
				L5.getCmp("disbilityGridPanel").hide();
				L5.getCmp("depentGridPanel").hide();
				L5.getCmp("demobilizedGridPanel").hide();
				L5.getCmp("demobilizeInelldGridPanel").show();
				L5.getCmp("warGridPanel").hide();
				L5.getCmp("testedGridPanel").hide();
				L5.getCmp("countretiredsoldierGridPanel").hide();
			} else if (tistart == 5) {// 参战
				document.getElementById("warObjectTypeName").value = list[1];
				document.getElementById("warObjectType").value = list[0];

				L5.getCmp("form").hide();
				L5.getCmp("disabilityform").hide();
				L5.getCmp("dependantform").hide();
				L5.getCmp("demobilizeform").hide();
				L5.getCmp("demobilizedIllnessform").hide();
				L5.getCmp("warform").show();
				L5.getCmp("testform").hide();
				L5.getCmp("countretiredsoldierform").hide();
				sipTime('war');

				L5.getCmp("baseGridPanel").hide();
				L5.getCmp("disbilityGridPanel").hide();
				L5.getCmp("depentGridPanel").hide();
				L5.getCmp("demobilizedGridPanel").hide();
				L5.getCmp("demobilizeInelldGridPanel").hide();
				L5.getCmp("warGridPanel").show();
				L5.getCmp("testedGridPanel").hide();
				L5.getCmp("countretiredsoldierGridPanel").hide();
			} else if (tistart == 6) {// 参试
				document.getElementById("testObjectTypeName").value = list[1];
				document.getElementById("testObjectType").value = list[0];

				L5.getCmp("form").hide();
				L5.getCmp("disabilityform").hide();
				L5.getCmp("dependantform").hide();
				L5.getCmp("demobilizeform").hide();
				L5.getCmp("demobilizedIllnessform").hide();
				L5.getCmp("warform").hide();
				L5.getCmp("testform").show();
				L5.getCmp("countretiredsoldierform").hide();
				sipTime('test');

				L5.getCmp("baseGridPanel").hide();
				L5.getCmp("disbilityGridPanel").hide();
				L5.getCmp("depentGridPanel").hide();
				L5.getCmp("demobilizedGridPanel").hide();
				L5.getCmp("demobilizeInelldGridPanel").hide();
				L5.getCmp("warGridPanel").hide();
				L5.getCmp("testedGridPanel").show();
				L5.getCmp("countretiredsoldierGridPanel").hide();
			} else if (tistart == 8) {// 60周岁以上农村籍退役军人
				document.getElementById("soldierObjectTypeName").value = list[1];
				document.getElementById("soldierObjectType").value = list[0];

				L5.getCmp("form").hide();
				L5.getCmp("disabilityform").hide();
				L5.getCmp("dependantform").hide();
				L5.getCmp("demobilizeform").hide();
				L5.getCmp("demobilizedIllnessform").hide();
				L5.getCmp("warform").hide();
				L5.getCmp("testform").hide();
				L5.getCmp("countretiredsoldierform").show();

				L5.getCmp("baseGridPanel").hide();
				L5.getCmp("disbilityGridPanel").hide();
				L5.getCmp("depentGridPanel").hide();
				L5.getCmp("demobilizedGridPanel").hide();
				L5.getCmp("demobilizeInelldGridPanel").hide();
				L5.getCmp("warGridPanel").hide();
				L5.getCmp("testedGridPanel").hide();
				L5.getCmp("countretiredsoldierGridPanel").show();
			} else {
				document.getElementById("objectType").value = list[0];
				document.getElementById("objectTypeName").value = list[1];
				document.getElementById("bptObjectType").value = list[0];

				L5.getCmp("form").show();
				L5.getCmp("disabilityform").hide();
				L5.getCmp("dependantform").hide();
				L5.getCmp("demobilizeform").hide();
				L5.getCmp("demobilizedIllnessform").hide();
				L5.getCmp("warform").hide();
				L5.getCmp("testform").hide();
				L5.getCmp("countretiredsoldierform").hide();
				sipTime('');

				L5.getCmp("baseGridPanel").show();
				L5.getCmp("disbilityGridPanel").hide();
				L5.getCmp("depentGridPanel").hide();
				L5.getCmp("demobilizedGridPanel").hide();
				L5.getCmp("demobilizeInelldGridPanel").hide();
				L5.getCmp("warGridPanel").hide();
				L5.getCmp("testedGridPanel").hide();
				L5.getCmp("countretiredsoldierGridPanel").hide();
			}
		} else {
			document.getElementById("objectType").value = list[0];
			document.getElementById("objectTypeName").value = list[1];
			document.getElementById("bptObjectType").value = list[0];

			L5.getCmp("form").show();
			L5.getCmp("disabilityform").hide();
			L5.getCmp("dependantform").hide();
			L5.getCmp("demobilizeform").hide();
			L5.getCmp("demobilizedIllnessform").hide();
			L5.getCmp("warform").hide();
			L5.getCmp("testform").hide();
			L5.getCmp("countretiredsoldierform").hide();
			sipTime('');

			L5.getCmp("baseGridPanel").show();
			L5.getCmp("disbilityGridPanel").hide();
			L5.getCmp("depentGridPanel").hide();
			L5.getCmp("demobilizedGridPanel").hide();
			L5.getCmp("demobilizeInelldGridPanel").hide();
			L5.getCmp("warGridPanel").hide();
			L5.getCmp("testedGridPanel").hide();
			L5.getCmp("countretiredsoldierGridPanel").hide();
		}

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
			command.execute("delete");
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