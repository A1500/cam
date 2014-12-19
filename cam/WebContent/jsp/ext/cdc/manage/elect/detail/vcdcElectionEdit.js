var ifQuery = false;
var DOMObjects = new Object();//菜单元素
var IMGObjects = new Object();//菜单图片元素
function init(){
  if (window.DOMObjects && window.IMGObjects)
    DOMInitialize('tr');
	document.getElementById("domicileName").value = organName;
	document.getElementById("domicileCode").value = organCode;
	if(organLevel=="JD"){
		document.getElementById("domicileName").disabled = true;
	}
}

function DOMInitialize(type) {
  if (document.getElementById){
    DOMObjects = document.getElementsByTagName(type);
    IMGObjects = document.getElementsByTagName('img');}
  else if (document.all) DOMObjects = document.all.tags(type);
  else if (document.layers) DOMObjects = document.layers;
  else DOMObjects = null;
}

function selectedNode(id){
	var reportDate = document.getElementById("reportDate").value;
	if(reportDate==""){
		alert("请选择填报日期情况！");
		return;
	}
	var organC ;
	if(organLevel=="11"){
		organC =organCode.substring(0,2); 
	}else if(organLevel=="12" ){
		organC =organCode.substring(0,4); 
	}else if(organLevel=="13"){
		organC =organCode.substring(0,6); 
	}else if(organLevel=="JD"){
		organC =organCode.substring(0,9)
	}else{
		organC =organCode;
	}
	var sumOrganCode = document.getElementById("domicileCode").value;
	var leve = document.getElementById("leve").value;
	if(leve =="3"){
		if(sumOrganCode.substring(6)=="999000"){
			organC =sumOrganCode.substring(0,4); 
		}else{
			organC =sumOrganCode.substring(0,9);
		}
	}else if(leve =="4" ) {
		organC =sumOrganCode;
	}
	var frame = document.getElementById("nodeFrame");
	var url;
	if(id=='1'){//选举准备情况
		url = "vcdcElectionPrepareDetail.jsp?reportDate="+reportDate+"&organC="+organC;
	}else if(id=='2'){//候选人的产生
		url = "vcdcElectionNominateDetail.jsp?reportDate="+reportDate+"&organC="+organC;
	}else if(id=='3'){//正式选举
		url = "vcdcElectionVoteDetail.jsp?reportDate="+reportDate+"&organC="+organC;
	}else if(id=='4'){//选举结果
		url = "vcdcElectionResultDetail.jsp?reportDate="+reportDate+"&organC="+organC;
	}else if(id=='5'){//村务监督委员会情况
		url = "vcdcElectionSupDetail.jsp?reportDate="+reportDate+"&organC="+organC;
	}else if(id=='6'){//村党组织成员情况
		url = "vcdcElectionPartyDetail.jsp?reportDate="+reportDate+"&organC="+organC;
	}
	for(var i = 1 ; i<= 6;i++){
		var t = document.getElementById("node"+i);
		if(id == i){
			t.color = "#0000FF";
			t.style.fontWeight="bold";
		}else{
			t.color = "#000000";
			t.style.fontWeight="normal";
		}
	}
	frame.setAttribute("src", url);
}
function undo(){
	var url = "jsp/ext/cdc/manage/elect/city/cdcElectionList.jsp";
	var data=new L5.Map();
	L5.forward(url,'',data);
}
/**
 * 选择属地行政区划窗口
 */
function func_ForDomicileSelect() {

	queryOrganName();
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileName").value = list[4];
		document.getElementById("leve").value = list[2];
		document.getElementById("domicileCode").value = list[0];
	}
}


/*
*从数据库dic_city中查询organName
*/
function queryOrganName() {
	if(!ifQuery) {
		if(organCode != null && organCode != "") {
			var command = new L5.Command("com.inspur.cams.comm.diccity.cmd.DicCityCommand");
			command.setParameter("ID",organCode);
			command.execute("findOrganName");
			var fullName = command.getReturn("organName");
			if(fullName != null && fullName != "") {
				organName = fullName;
			}
			ifQuery = true;
		}
	}	
}
function undo(){
	var url = "jsp/ext/cdc/manage/elect/country/cdcElectionList.jsp";
	var data=new L5.Map();
	L5.forward(url,'',data);
}