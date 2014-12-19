var includeJuniorWealer;
function init() {
	var ds = L5.DatasetMgr.lookup("ds");
	resetSome();
    selectJuniorReset();
	ds.setParameter("morgArea",organArea);
	ds.setParameter("status",'1');
	ds.load();
	L5.QuickTips.init();
	
};
function selectJuniorReset(){
 	var codeWel = document.getElementById("domicileCode").value;
	 	if(codeWel.substring(2)=="0000000000"){
		  document.getElementById("selectJunior").disabled = true;
		}else if(codeWel.substring(4) == "00000000"){
		  document.getElementById("selectJunior").disabled = false;
		}else {
		    document.getElementById("selectJunior").disabled = true;
		}
}
function resetSome(){
	document.getElementById("domicileCode").value=organArea;
	document.getElementById("domicileName").value=organName;
	document.getElementById("statusQuery").value='1';
}
function resetAll(){
	document.getElementById("queryForm").reset();
	includeJuniorWealer='2';
	resetSome();
    selectJuniorReset();
}

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	return value;
}
function func_ForDomicileSelect() {

	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=-2&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
        selectJuniorReset();
	}
}	
function query(){
	var ds = L5.DatasetMgr.lookup("ds");
	var domicileCode=document.getElementById("domicileCode").value;
/*	if(domicileCode && includeJuniorWealer == '1'){
	   ds.setParameter("morgArea",domicileCode.substring(0,4)+"%");
	}else{
	   ds.setParameter("morgArea",organArea);//370100000000
	}*/
	
	var domicileCodeWelfare=document.getElementById("domicileCode").value;
	    if(domicileCodeWelfare.toString().substring(2) == "0000000000"){
	        includeJuniorWealer='2';
	    }else if(domicileCodeWelfare.toString().substring(4) == "00000000"){
						    if(document.getElementById("selectJunior").checked){
						        includeJuniorWealer='1';
						    }else{
						        includeJuniorWealer='0';
						    }
        }else{
            includeJuniorWealer='2';
            }

	if(domicileCode){
		ds.setParameter("morgArea",domicileCode);
	}else{
		ds.setParameter("morgArea",organArea);
	}
	ds.setParameter("includeJuniorWealer",includeJuniorWealer);
	ds.setParameter("serialNum",getParam("serialNumQuery"));
	ds.setParameter("companyName","%"+getParam("companyNameQuery")+"%");
	ds.setParameter("economicNatureCode",getParam("economicNatureCodeQuery"));
	ds.setParameter("legalPeople",getParam("legalPeopleQuery"));
	ds.setParameter("address",getParam("addressQuery"));
	ds.setParameter("status",getParam("statusQuery"));
	ds.setParameter("regFundBegin",getParam("regFundBeginQuery"));
	ds.setParameter("regFundEnd",getParam("regFundEndQuery"));
	ds.setParameter("approveDateBegin",getParam("approveDateBeginQuery"));
	ds.setParameter("approveDateEnd",getParam("approveDateEndQuery"));
	ds.setParameter("workerNumBegin",getParam("workerNumBeginQuery"));
	ds.setParameter("workerNumEnd",getParam("workerNumEndQuery"));
	ds.setParameter("disNumBegin",getParam("disNumBeginQuery"));
	ds.setParameter("disNumEnd",getParam("disNumEndQuery"));
	ds.load();		
}
function detail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","DETAIL");
	data.put("taskCode",selected[0].get('TASK_CODE'));
	var url='jsp/cams/welfare/query/unit/unitInfoDetail.jsp';
	var text = '基本信息查询';
	L5.forward(url,text,data);
}
//导出基本信息查询列表
function exportExcel(){
	var dataset = L5.DatasetMgr.lookup("ds");
	if(dataset.getCount()<1){
		L5.Msg.alert("提示","没有要导出的信息！");
		return;
	}
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	var filename="福利基本信息查询列表";
	var class_path = "com.inspur.cams.welfare.comm.cmd.WealCSVCommand";
	var gridObj = L5.getCmp("editGridPanel");
	L5.grid2excel(dataset, gridObj, filename, class_path);
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}