var idCard;
var idCardValue;
var idCardValue1;
var stype;
var ifQuery = false;


function backMsgByIdCard(dsId,o){
	var ds=L5.DatasetMgr.lookup(dsId);
	var idCard=o.value;
	if(!idCard){
		return;
	}
	idCard=checkIdCard(idCard);
	if(idCard){
		ds.getCurrent().set("birthday", getBirthByCode(idCard));
		ds.getCurrent().set("sex",getSexByCode(idCard));
	}else {
		ds.getCurrent().set("idCard", "");
		L5.Msg.alert("提示", "身份证号格式不正确！");
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

/*
*由身份证自动生成出生日期
*/
function func_ShowBirthday() 
{ 
   var val=document.forms[0].idCard.value;
   var birthdayValue; 
   if(15==val.length){ //15位身份证号码 
       birthdayValue = val.charAt(6)+val.charAt(7); 
       if(parseInt(birthdayValue)<10){ 
           birthdayValue = '20'+birthdayValue; 
       }else { 
           birthdayValue = '19'+birthdayValue; 
       } 
           birthdayValue=birthdayValue+'-'+val.charAt(8)+val.charAt(9)+'-'+val.charAt(10)+val.charAt(11);
           BaseinfoPeopleDataSet.getCurrent().set("birthday",birthdayValue);
    } 
   if(18==val.length){ //18位身份证号码 
           birthdayValue=val.charAt(6)+val.charAt(7)+val.charAt(8)+val.charAt(9)+'-'+val.charAt(10)+val.charAt(11)+'-'+val.charAt(12)+val.charAt(13);
           BaseinfoPeopleDataSet.getCurrent().set("birthday",birthdayValue);
   } 
}

/*function getTimes(item) {
	LoushangDate(item.previousSibling);
}*/
//验证身份证合法性
function func_QueryIdCard(){ 
	idCard =document.forms[0].idCard;	
	stype =document.forms[0].stype.value;
    idCardValue=idCard.value;   
    if(idCardValue==null||idCardValue=="")
    {
    	return;
    }
	if(!checkIDCard(idCard)){
	    L5.Msg.alert("提示", "身份证格式不正确!");
	    return false;
	}
	idCardValue1 = document.getElementById("idCard").value;
	BaseinfoPeopleDataSet.setParameter("ID_CARD@=",idCardValue1);
	BaseinfoPeopleDataSet.load();
	BaseinfoPeopleDataSet.on('load',func_QueryCheck);
	BaseinfoPeopleDataSet.on('load',checkSpell);
}
function func_QueryIdCardAllMessage(){ 
	idCard =document.forms[0].idCard;	
	stype =document.forms[0].stype.value;
    idCardValue=idCard.value;   
    if(idCardValue==null||idCardValue=="")
    {
    	return;
    }
	if(!checkIDCard(idCard)){
	    L5.Msg.alert("提示", "身份证格式不正确!");
	    return false;
	}
	idCardValue1 = document.getElementById("idCard").value;
	BaseinfoPeopleDataSet.setParameter("ID_CARD@=",idCardValue1);
	BaseinfoPeopleDataSet.load();
	BaseinfoPeopleDataSet.on('load',func_QueryCheck);
	BaseinfoPeopleDataSet.on('load',checkSpell);
	BaseinfoPeopleDataSet.on('load',loadTypeMessage);
}
function loadTypeMessage(){//加载类别信息
	if(BaseinfoPeopleDataSet.getCount()!=0){
		var peopleId= BaseinfoPeopleDataSet.get("peopleId");
	    if(stype=='01'){
	       if(BaseinfoPeopleDataSet.get("disabilityFlag")=='1' && BaseinfoPeopleDataSet.get("disabilityStateCode") == '6'){
	    	   BaseinfoPeopleDataSet.set("disabilityStateCode",2);
	           //此处加载伤残类别信息
				BptPeopleDisabilityDataSet.setParameter("PEOPLE_ID",peopleId);
				BptPeopleDisabilityDataSet.load();
	           return false;
	       }
       	}
	    if(stype=='10'){
		       if(BaseinfoPeopleDataSet.get("dependantFlag")=='1' && BaseinfoPeopleDataSet.get("dependantStateCode") == '6'){
		    	   BaseinfoPeopleDataSet.set("dependantStateCode",2);
		           //此处加载伤残类别信息
		    	   DependantDataset.setParameter("PEOPLE_ID",peopleId);
		    	   DependantDataset.load();
		           return false;
		       }
	       	}
       	if(stype=='12'){
	       if(BaseinfoPeopleDataSet.get("demobilizedFlag")=='1'&& BaseinfoPeopleDataSet.get("demobilizedStateCode") == '6'){
	    	   BaseinfoPeopleDataSet.set("demobilizedStateCode",2);
	           //此处加载在乡类别信息
	           PeopleDemobilizedDataset.setParameter("peopleId",peopleId);
    			PeopleDemobilizedDataset.load();
	           return false;
	       }
       	}
       	if(stype=='13'){
	       if(BaseinfoPeopleDataSet.get("demobilizedFlag")=='1'&& BaseinfoPeopleDataSet.get("demobilizedStateCode") == '6'){
	    	   BaseinfoPeopleDataSet.set("demobilizedStateCode",2);
	           //此处加载带病类别信息
	           DemobilizedIllnessDataset.setParameter("peopleId",peopleId);
				DemobilizedIllnessDataset.load();
	           return false;
	       }
       	}
       	if(stype=='14'){
 	       if(BaseinfoPeopleDataSet.get("warFlag")=='1'&& BaseinfoPeopleDataSet.get("warStateCode") == '6'){
 	    	   BaseinfoPeopleDataSet.set("warStateCode",2);
 	           //此处加载参战参试类别信息
 	    	   if(typeof(dsWar)!="undefined"){
 	    		  dsWar.setParameter("PEOPLE_ID",peopleId);
 	 	    	  dsWar.load();
 	    	   }else if(typeof(dsTested) !="undefined" ){
 	    		  
 	    		  dsTested.setParameter("PEOPLE_ID",peopleId);
 	    		  dsTested.load();
 	    	   }
 	           return false;
 	       }
        }
       	if(stype=='81'){
 	       if(BaseinfoPeopleDataSet.get("retiredFlag")=='1'&& BaseinfoPeopleDataSet.get("retiredStateCode") == '6'){
 	    	   BaseinfoPeopleDataSet.set("retiredStateCode",2);
 	           //此处加载带病类别信息
 	    	  RetiredSoldierDataSet.setParameter("peopleId",peopleId);
 	    	 RetiredSoldierDataSet.load();
 	           return false;
 	       }
        }
       	if(stype=='B1'){
  	       if(BaseinfoPeopleDataSet.get("martyrOffspringFlag")=='1'&& BaseinfoPeopleDataSet.get("martyrOffspringStateCode") == '6'){
  	    	   BaseinfoPeopleDataSet.set("martyrOffspringStateCode",2);
  	           //此处加载带病类别信息
  	    	  MartyrOffspringDataSet.setParameter("peopleId",peopleId);
  	    	 MartyrOffspringDataSet.load();
  	           return false;
  	       }
         }
    }

}
function checkSpell(BaseinfoPeopleDataSet){
	var phoneticCode = BaseinfoPeopleDataSet.get("phoneticCode");
	if (phoneticCode==null||phoneticCode==""){
		getCrjCnStrSpell('namebase','phoneticCode','m');
	}

}
//判断是否是多重身份人员
function isDouID(BaseinfoPeopleDataSet,stype){
	if(BaseinfoPeopleDataSet.get("disabilityFlag")=='1'&&stype!='01'){
		var s =  getBptState(BaseinfoPeopleDataSet.get("disabilityStateCode"));
		L5.Msg.alert("提示", "该人员是多重身份人员!已为伤残人员，状态:"+s);
		return ;
	}
	if(BaseinfoPeopleDataSet.get("dependantFlag")=='1'&&stype=='10'){
		var s = getBptState(BaseinfoPeopleDataSet.get("dependantStateCode"));
		L5.Msg.alert("提示", "该人员是多重身份人员!已为三属人员，状态:"+s);
		return ;
	}
	if(BaseinfoPeopleDataSet.get("demobilizedFlag")=='1'&&!(stype=='13'||stype=='12')){
		var s = getBptState(BaseinfoPeopleDataSet.get("demobilizedStateCode"));
		L5.Msg.alert("提示", "该人员是多重身份人员!已为在乡复员或带病回乡人员，状态:"+s);
		return ;
	}
	if(BaseinfoPeopleDataSet.get("warFlag")=='1'&&stype!='14'){
		var s = getBptState(BaseinfoPeopleDataSet.get("warStateCode"));
		L5.Msg.alert("提示", "该人员是多重身份人员!已为参战或参试人员，状态:"+s);
		return ;
	}
	if(BaseinfoPeopleDataSet.get("martyrOffspringFlag")=='1'&&stype!='B1'){
		var s = getBptState(BaseinfoPeopleDataSet.get("martyrOffspringStateCode"));
		L5.Msg.alert("提示", "该人员是多重身份人员!已为部分烈士（错杀被平反人员）子女，状态:"+s);
		return ;
	}
	if(BaseinfoPeopleDataSet.get("retiredFlag")=='1'&&stype!='81'){
		var s = getBptState(BaseinfoPeopleDataSet.get("retiredStateCode"));
		L5.Msg.alert("提示", "该人员是多重身份人员!已为60岁以上农村籍退役军人，状态:"+s);
		return ;
	}
	
}


function func_QueryCheck(BaseinfoPeopleDataSet){
	if(BaseinfoPeopleDataSet.getCount()!=0){
	    if(stype=='01'){
	    	var s =  getBptState(BaseinfoPeopleDataSet.get("disabilityStateCode"));
	       if(BaseinfoPeopleDataSet.get("disabilityFlag")=='1' && BaseinfoPeopleDataSet.get("disabilityStateCode") != 6){
	           L5.Msg.alert("提示", "该人员已经是伤残人员!状态:"+s);
	           document.forms[0].reset();
	           return false;
	       }
	       if(BaseinfoPeopleDataSet.get("disabilityFlag")=='1' && BaseinfoPeopleDataSet.get("disabilityStateCode") == 6){
	    	   
	           L5.Msg.alert("提示", "该人员曾申请过伤残!状态:"+s);
	           
	       }
       	}
       	if(stype=='10'){
       		var s = getBptState(BaseinfoPeopleDataSet.get("dependantStateCode"));
	         if(BaseinfoPeopleDataSet.get("dependantFlag")=='1'&& BaseinfoPeopleDataSet.get("dependantStateCode") != 6){
	           L5.Msg.alert("提示", "该人员已经是三属人员!");
	           document.forms[0].reset();
	           return false;
	       }
	       if(BaseinfoPeopleDataSet.get("dependantFlag")=='1' && BaseinfoPeopleDataSet.get("dependantStateCode") == 6){
	    	   //BaseinfoPeopleDataSet.set("dependantStateCode",2);
		           L5.Msg.alert("提示", "该人员曾申请过三属!状态:"+s);
		   }
       	}
       	if(stype=='13'||stype=='12'){
       		var s = getBptState(BaseinfoPeopleDataSet.get("demobilizedStateCode"));
	       if(BaseinfoPeopleDataSet.get("demobilizedFlag")=='1'&& BaseinfoPeopleDataSet.get("demobilizedStateCode") != 6){
	           L5.Msg.alert("提示", "该人员已经是在乡复员(带病回乡)军人!");
	           document.forms[0].reset();
	           return false;
	       }
	       if(BaseinfoPeopleDataSet.get("demobilizedFlag")=='1' && BaseinfoPeopleDataSet.get("demobilizedStateCode") == 6){
	    	   
	           L5.Msg.alert("提示", "该人员曾申请过在乡复员(带病回乡)军人!状态:"+s);
	       }
       	}
       
       	if(stype=='14'){
       		var s = getBptState(BaseinfoPeopleDataSet.get("warStateCode"));
	      if(BaseinfoPeopleDataSet.get("warFlag")=='1' && BaseinfoPeopleDataSet.get("warStateCode") != 6){
	           L5.Msg.alert("提示", "该人员已经是参战参试人员!");
	           document.forms[0].reset();
	           return false;
	       }
	      if(BaseinfoPeopleDataSet.get("warFlag")=='1' && BaseinfoPeopleDataSet.get("warStateCode") == 6){
	    	  //BaseinfoPeopleDataSet.set("warStateCode",2);
	           L5.Msg.alert("提示", "该人员曾申请过参战参试!状态:"+s);
	      }
       	}
       	if(stype=='B1'){
       		var s = getBptState(BaseinfoPeopleDataSet.get("martyrOffspringStateCode"));
	      if(BaseinfoPeopleDataSet.get("martyrOffspringFlag")=='1' && BaseinfoPeopleDataSet.get("martyrOffspringStateCode") != '6'){
	           L5.Msg.alert("提示", "该人员已经是部分烈士（错杀被平反人员）子女!");
	           document.forms[0].reset();
	           return false;
	       }
	      if(BaseinfoPeopleDataSet.get("martyrOffspringFlag")=='1' && BaseinfoPeopleDataSet.get("martyrOffspringStateCode") == 6){
	    	 // BaseinfoPeopleDataSet.set("martyrOffspringStateCode",2);
	           L5.Msg.alert("提示", "该人员曾申请过部分烈士（错杀被平反人员）子女!状态:"+s);
	      }
       	}
       	if(stype=='81'){
       		var s = getBptState(BaseinfoPeopleDataSet.get("retiredStateCode"));
  	      if(BaseinfoPeopleDataSet.get("retiredFlag")=='1' && BaseinfoPeopleDataSet.get("retiredStateCode") != '6'){
  	           L5.Msg.alert("提示", "该人员已经是60岁以上农村籍退役军人!");
  	           document.forms[0].reset();
  	           return false;
  	       }
	  	    if(BaseinfoPeopleDataSet.get("retiredFlag")=='1' && BaseinfoPeopleDataSet.get("retiredStateCode") == 6){
	  	    	//BaseinfoPeopleDataSet.set("retiredStateCode",2);
		           L5.Msg.alert("提示", "该人员曾申请过60岁以上农村籍退役军人!状态:"+s);
	  	    }
        }
       	//alert("00000");
       	document.forms[0].flag.value="";	
        commShowPhoto(BaseinfoPeopleDataSet.get("photoTemp"));
        isDouID(BaseinfoPeopleDataSet,stype);
    }else{
    	
          BaseinfoPeopleDataSet.newRecord();
          //BaseinfoPeopleDataSet.set("idCard",idCardValue);
          document.getElementById("idCard").value = idCardValue1;
          BaseinfoPeopleDataSet.set("idCard",idCardValue1);
          func_ShowBirthday();
          document.forms[0].flag.value="1";	
          commShowPhoto("../comm/default.jpg");
    }
	if(checkDoublePerson(idCardValue1)){
 		
        L5.Msg.alert("提示", "此人员已经存在黑名单内!");
        //document.forms[0].reset();
       // return false;
     }
}

function getBptState(state){
	switch (parseInt(state)){
		case 1:return "受理";
		break;
		case 2:return "享受待遇";
		break;
		case 3:return "身份认定不享受待遇";
		break;
		case 4:return "停发";
		break;
		case 5:return "迁移";
		break;
		case 6:return "不予认定";
		break;
		case 7:return "去世";
		break;
		case 8:return "取消";
		break;
		case 9:return "中止";
		break;
		default: return"";
	}
		
}
/**
 * 人员照片显示
**/
function commShowPhoto(path) {
	if(path != null && path != "") {
		var obj = document.getElementsByTagName("img");
		for(var i=0;i<obj.length;i++) {
			if(obj[i].getAttribute("name") == "RELATIONER_PHOTOC_IMG") {
				obj[i].src=path;
			}
		}
	}	
}

/**
 * 选择属地行政区划窗口
 
function func_ForDomicileSelect(){
		var revalue=window.showModalDialog(L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?organCode="+organCode+"&organName="+decodeURIComponent(encodeURIComponent(organName)),"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		BaseinfoPeopleDataSet.getCurrent().set("domicileCode",list[0]);
		BaseinfoPeopleDataSet.getCurrent().set("domicileName",list[1]);
		BaseinfoPeopleDataSet.getCurrent().set("apanageCode",list[0]);
		BaseinfoPeopleDataSet.getCurrent().set("apanageName",list[1]);
		}
}
*/
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
		BaseinfoPeopleDataSet.getCurrent().set("domicileCode", list[0]);
		BaseinfoPeopleDataSet.getCurrent().set("domicileName", list[4]);
		BaseinfoPeopleDataSet.getCurrent().set("apanageCode", list[0]);
		BaseinfoPeopleDataSet.getCurrent().set("apanageName", list[4]);
	}
}

/**
 * 选择住址行政区划窗口

function func_ForApanageSelect(){
		var revalue=window.showModalDialog(L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?organCode="+organCode+"&organName="+decodeURIComponent(encodeURIComponent(organName)),"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		BaseinfoPeopleDataSet.getCurrent().set("apanageCode",list[0]);
		BaseinfoPeopleDataSet.getCurrent().set("apanageName",list[1]);
	}
} */
/**
 * 选择住址行政区划窗口
 */
function func_ForApanageSelect() {
	queryOrganName();
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	// var
	// revalue=window.open("../../../../../jsp/cams/comm/diccity/dicCity.jsp?organCode="+organCode+"&organName="+escape(encodeURIComponent(organName)));
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		BaseinfoPeopleDataSet.getCurrent().set("apanageCode", list[0]);
		BaseinfoPeopleDataSet.getCurrent().set("apanageName", list[4]);
	}
}
/**
 * 省内迁移迁入地属地行政区划窗口
 */
function func_ForInDomicileSelect(){
	    var organCode = document.getElementById("ingoingCode").value;
	    var organName = document.getElementById("ingoingName").value;
	    if(organCode == "" || organCode == null) {
	    	L5.Msg.alert("提示","请先选择迁入地民政局!");
	    	return false;        
	    }
		var revalue=window.showModalDialog(L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?organCode="+organCode+"&organName="+escape(encodeURIComponent(organName)),"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		ProvinceMigrationDataSet.getCurrent().set("inDomicileCode",list[0]);
		ProvinceMigrationDataSet.getCurrent().set("domicileName",list[4]);
		}
}   

/**
 * 省内迁移迁入地住址行政区划窗口
 */
function func_ForInApanageSelect(){
		var organCode = "370000000000";
	    var organName = "山东省";
		var revalue=window.showModalDialog(L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?organCode="+organCode+"&organName="+escape(encodeURIComponent(organName)),"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		ProvinceMigrationDataSet.getCurrent().set("inApanageCode",list[0]);
		ProvinceMigrationDataSet.getCurrent().set("apanageName",list[4]);
	}
}

/**
* 省内迁移选择迁入民政局窗口
*/
function func_Ingoing(){
		var ingoingCode = _$("ingoingCode");
		var ingoingName = _$("ingoingName");
		var provinceName = escape(encodeURIComponent('山东省'));
		var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicCityCounty.jsp?organCode=370000000000&organName="+provinceName,"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
			 ProvinceMigrationDataSet.getCurrent().set("ingoingCode",list[0]);
			 ProvinceMigrationDataSet.getCurrent().set("ingoingName",list[4]);
			 var code = document.getElementById("domicileCode").value;
			 if(code != "" && code != null) {
			 	if(code.substring(0,6) != list[0]) {
			 		document.getElementById("domicileName").value="";
			 		document.getElementById("domicileCode").value="";
			 	}
			 }
		}
}

function changes(){
	document.getElementById("address").value = _$("domicileAddress");
}


function validateDateFormat(date) {
	if (!((/^\d{4}-\d{2}-\d{2}$/).test(date))) {
		return false;
	}
	var r = date.match(/\d{1,4}/g);
	if (r == null) {
		return false;
	};
	var d = new Date(r[0], r[1] - 1, r[2]);
	return (d.getFullYear() == r[0] && (d.getMonth() + 1) == r[1] && d
			.getDate() == r[2]);
}

function getTimes(item) {
	LoushangDate(item.previousSibling);
}

function getTimes1(item) {
	LoushangDate(item.previousSibling);
	var date = document.getElementByName(item.previousSibling);
}
//设置成固定月份
function setMoth(obj) {
	var temp = obj.value;
	if(temp!=""&&temp.length == 4)
	obj.value=temp + '-12';
}
 //dataset转化xml
function getXmlByDataSet(reportName,creater,createOrgan,dataset){

	var xmlStr="<?xml version='1.0' encoding='GBK' standalone='no'?>";
	xmlStr+="<Report ReportName='"+reportName+"' Creater='"+creater+"' CreateOrgan='"+createOrgan+"' ReportNo='' ReportType=''>";
	
	for(var i=0;i<dataset.getCount();i++){
		xmlStr +="<Info>";
		L5.each(dataset.getAt(i).fields.items,function(item,index){
			xmlStr+="<"+item.name+">"+dataset.getAt(i).get(item.name)+"</"+item.name+">";
		});
		xmlStr +="</Info>";
	}
	xmlStr +="</Report>";
	return xmlStr;
}

// 打印方法传递的record
function doReportPrint(reportName,currentUserName,organName,printDataset ,url){
	if(printDataset.getCount()>0){
	printReport(getXmlByDataSet(reportName,currentUserName,organName,printDataset),url);
	}else {
		alert("没有可打印的数据!");
	}
}
//打开导入窗口
function excelToTable(xmlPath,enumsPath,organCode){
	var url=L5.webPath+"/jsp/cams/bpt/excelToTable/excelToTable.jsp?xmlPath=" + xmlPath + '&enumsPath=' + enumsPath+ '&organCode=' + organCode ;
	var width = 500;
   	var height =80;
   	var msg = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	if (msg==null) {
		
		return;
	} 
	return msg;
}


/**
 * 查询页面中选择行政区划查询
 */
function query_selectDomicile() {
	queryOrganName();
	var revalue = window.showModalDialog(L5.webPath
					+ "/jsp/cams/comm/diccity/dicCity.jsp?organCode="
					+ organCode + "&radioMaxlevel=0&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileName").value = list[4];
		document.getElementById("domicileCode").value = list[0];
	}
}
function idCardIsSame(idCard){
	var command = new L5.Command("com.inspur.cams.bpt.excelToTable.ExcelToTableCommand");
	command.setParameter("idCard", idCard);
	command.execute("idCardIsSame");
	var b=command.getReturn("isSame");
	return b;
}
//手动输入时间格式 
var temp1 = -1;
function changeDateStyle(obj) {
	var temp = obj.value;
	var arr = temp.split("-");
	if (temp1<obj.value.length) {
		if(temp!=""&&temp.length == 4) {
			obj.value = temp + '-';
		} else if (obj.value.length == 8 && obj.value.split("-").length == 2) {
			obj.value = obj.value.substr(0,7)+'-'+ obj.value.substr(7,1);
		} else if (temp!=""&&temp.length==7) {
			obj.value = temp + '-';
		} else if (obj.value.length == 5 && obj.value.indexOf("-") == -1) {
			obj.value = obj.value.substr(0,4)+'-'+ obj.value.substr(4,1);
		} 
	} 
	temp1 = obj.value.length;
}
//手动输入时间格式(适用于月份) 
function changeDateStyle_Mon(obj) {
	var temp = obj.value;
	if(temp!=""&&temp.length == 4) {
		obj.value = temp + '-';
	} 
}

//通过姓名获得链接到人员基本信息明细页面
function openBptPeopleDetail(peopleId,username,idCard,objectType){
	var command = new L5.Command("com.inspur.cams.bpt.bptrecuperate.cmd.BptRecuperateCommand");
	command.setParameter("PEOPLE_ID", peopleId);
	command.execute("queryPeopleIdByFamilyId");
	var familyId = command.getReturn("familyId");
	var url = L5.webPath+"/jsp/cams/bpt/basicInfoView/basicInfoDetail.jsp?peopleId="+peopleId+"&familyId="+familyId+"&username="+name+"&idCard="+idCard+"&objectState=2&objectType="+objectType;
	var width = screen.width-60;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if (win==null) {
		return;
	}
}

function trim(str){ //删除左右两端的空格
    return str.replace(/(^\s*)|(\s*$)/g, "");
}



function writeAble(idCard,objectType,isApply) {
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleValidateCommand");
		command.setParameter("idCard",idCard);
		command.setParameter("objectType",objectType);
		command.setParameter("isApply",isApply);
		command.execute("writeAble");
		var wflag = command.getReturn("wflag");
		return wflag;
}


function addBlackList(){
	
	L5.MessageBox.confirm('确定', '确定要将此人员添加到黑名单吗?',function(state){
		if(state=="yes"){
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPerjuryCommand");
			command.setParameter("peopleId",peopleId);
			command.execute("checkDoublePerson");
			var flag = command.getReturn("flag");
			if ("1"==flag) {
				L5.Msg.alert('提示',"黑名单内已经存在此人员!");
				return ;
			}else if("0"==flag){
				var commandadd = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPerjuryCommand");
				commandadd.setParameter("peopleId",peopleId);
				commandadd.setParameter("serviceType",serviceType);
				commandadd.execute("savefromflow");
				if (!commandadd.error) {
					L5.Msg.alert('提示',"保存成功!");
				}else{
					L5.Msg.alert('提示',"保存时出现错误！"+commandadd.error);
				}
			}
		}else{
			return false;
		}
	});
}
//判段此身份证号是否在黑名单
function checkDoublePerson(idCard){
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPerjuryCommand");
	command.setParameter("idCard", idCard);
	command.execute("checkDoublePerson");
	var flag = command.getReturn("flag");//0;没有重复 ,1:有重复
	if ("1"==flag) {
		return true;
	}else if("0"==flag){
		return false;
	}
}