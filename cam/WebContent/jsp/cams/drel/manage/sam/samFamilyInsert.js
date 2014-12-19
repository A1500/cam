function init() {
    var BaseinfoPeopleDS2 = L5.DatasetMgr.lookup("BaseinfoPeopleDS2");
    var DmXzqhDataSetStreet = L5.DatasetMgr.lookup("DmXzqhDataSetStreet");
    DmXzqhDataSetStreet.setParameter("filterSql", "xzqhjb='3' and substr(xzqhdm,1,6)= '" + organArea.substring(0, 6) + "'");
    DmXzqhDataSetStreet.load();
     L5.QuickTips.init();

    if (method == null || method == "") {
        L5.Msg.alert('提示', "未知的页面命令!");
        back();
    } else if (method == "INSERT") {
      BaseinfoPeopleDS2.newRecord({
        peopleId: document.forms[0].peopleId.value,
        familyId: document.forms[0].familyId.value
    });

        BaseinfoFamilyDS.newRecord({
            familyId: document.forms[0].familyId.value
        });
        return;
    } else if (method == "UPDATE" || method == "addMember") {
        if (method == "addMember") {
            L5.getCmp("tabPanels").setActiveTab(1);
        }
        BaseinfoFamilyDS.baseParams["FAMILY_ID@="] = idField;
        BaseinfoFamilyDS.on("load", getValue);
        BaseinfoFamilyDS.load();
        return;
    } else if (method == "EXAM") {
        BaseinfoFamilyDS.baseParams["FAMILY_ID@="] = idField;
        BaseinfoFamilyDS.on("load", getValue);
        BaseinfoFamilyDS.load();
        return;
    }
    function getValue() {
    	showJzlx();
        //如果起先数据为空，则直接调用增加方法
        if (BaseinfoFamilyDS.getCount() == 0) {
            BaseinfoFamilyDS.newRecord();
            return;
        }
        BaseinfoPeopleDS.baseParams["FAMILY_ID@="] = idField;
        BaseinfoPeopleDS.load();

        SamFamilyCalamityDataSet.baseParams["FAMILY_ID@="] = idField;
        SamFamilyCalamityDataSet.load();

    }
}
//根据选择的街道过滤村居
function setXzqhVillage() {
    var DmXzqhDataSetVillage = L5.DatasetMgr.lookup("DmXzqhDataSetVillage");
    var street=document.getElementById("town").value;
    if (street.length > 9) {
        DmXzqhDataSetVillage.setParameter("filterSql", "xzqhjb='4' and substr(xzqhdm,1,9)= '" + street.substring(0, 9) + "'");
        DmXzqhDataSetVillage.load();
    }
}

 /**
 *  困难户家庭登记
 *  事件处理：关于选择 住房状况类型 联动'房屋结构'-------jiang
 *
 */
function selectStructure(){
	var DmFwjgDataSet = L5.DatasetMgr.lookup("DmFwjgDataSet");
	var houseStatus=document.getElementById("houseStatus").value;
	if(houseStatus==""){
		document.getElementById("fwzk").innerHTML="房屋结构：";
	}
	if(houseStatus=="1"){
		document.getElementById("fwzk").innerHTML="房屋结构：";
		DmFwjgDataSet.setParameter("filterSql", "fwjgdm between 1 and 5");
		DmFwjgDataSet.load();
	}
	if(houseStatus=="2"){
		document.getElementById("fwzk").innerHTML="危险程度：";
		DmFwjgDataSet.setParameter("filterSql", "fwjgdm='6' or fwjgdm='7'");
		DmFwjgDataSet.load();

	}
	if(houseStatus=="3"){
		document.getElementById("fwzk").innerHTML="居住状况：";
		DmFwjgDataSet.setParameter("filterSql", "fwjgdm='8' or fwjgdm='9'");
		DmFwjgDataSet.load();
	}
}

///----------------------jiang???????????????
function submit() {
	var records = BaseinfoPeopleDS.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据！');
		return false;
	}
	var command = new L5.Command("com.inspur.cams.drel.sam.cmd.SamBasePeopleCmd");
	command.setParameter("BaseinfoPeopleRecords", records);
	command.execute("save");
	if (!command.error) {
		BaseinfoPeopleDS.commitChanges();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
	var records = SamFamilyAssistanceDataSet.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据！');
		return false;
	}
	var command = new L5.Command("com.inspur.cams.drel.jtxx.cmd.SamFamilyAssistanceCmd");
	command.setParameter("ygjzjtxxszlxRecords", records);
	command.execute("save");
	if (!command.error) {
		SamFamilyAssistanceDataSet.commitChanges();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
	var records = YgjzJtxxZrzhDataSet.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据！');
		return false;
	}
	var command = new L5.Command("com.inspur.cams.drel.jtxx.cmd.YgjzJtxxZrzhCommand");
	command.setParameter("ygjzjtxxzrzhRecords", records);
	command.execute("save");
	if (!command.error) {
		YgjzJtxxZrzhDataSet.commitChanges();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
	var records = YgjzJzzsDataSet.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据！');
		return false;
	}
	var command = new L5.Command("com.inspur.cams.drel.jzzs.cmd.YgjzJzzsCommand");
	command.setParameter("ygjzjzzsRecords", records);
	command.execute("save");
	if (!command.error) {
		YgjzJzzsDataSet.commitChanges();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

var peopleIdx = 0;

//成员提交----jiang???
function confirm() {
	if(saveJtcy()){
		var win=L5.getCmp("hello-win");
		win.hide(this);
	    BaseinfoPeopleDS.on("load", updatePeopleNum);
	    BaseinfoPeopleDS.load();
	}
}

// 关闭窗口----jiang????
function hide() {
	var win=L5.getCmp("hello-win");
	win.hide(this);
}


/******************************关于家庭登记公共校验开始**************************************************/
 /**
 *  困难户家庭登记
 *  事件处理：计算人均年收入、人均建筑面积---jiang
 *
 */
function updatePeopleNum(){
	if(BaseinfoPeopleDS.getCount() > 0){
    	var BaseinfoFamilyRecord = BaseinfoFamilyDS.getCurrent();
    	BaseinfoFamilyDS.set("peopleNum",BaseinfoPeopleDS.getCount());
    	BaseinfoFamilyDS.set("yearAverageIncome",decimalRound(BaseinfoFamilyRecord.get("yearIncome")/BaseinfoPeopleDS.getCount(),2) );
    	BaseinfoFamilyDS.set("monthIncome",decimalRound(BaseinfoFamilyRecord.get("yearIncome")/12,2) );
    	BaseinfoFamilyDS.set("monthAverageIncome",decimalRound(BaseinfoFamilyRecord.get("yearIncome")/(BaseinfoPeopleDS.getCount()*12),2) );
    	BaseinfoFamilyDS.set("buildAverageArea",decimalRound(BaseinfoFamilyRecord.get("buildArea")/BaseinfoPeopleDS.getCount(),2) );

    }else{
        BaseinfoFamilyDS.set("peopleNum",0);
        BaseinfoFamilyDS.set("yearAverageIncome",0);
    	BaseinfoFamilyDS.set("monthIncome",decimalRound(BaseinfoFamilyRecord.get("yearIncome")/12,2) );
    	BaseinfoFamilyDS.set("monthAverageIncome",0 );
    	BaseinfoFamilyDS.set("buildAverageArea",0);
    }
}
 /**
 *  困难户家庭登记
 *  事件处理：小数截取-----jiang???
 *
 */
function decimalRound(num,decimalNum){
    var decimal2 = 1;
	while(decimalNum > 0){
		decimal2 = 10 * decimal2;
		decimalNum = decimalNum - 1;
	}
	return Math.round(num*decimal2)/decimal2;
}
  /**
 *  困难户家庭登记
 *  事件处理：救助类型通用帮助---jiang?????
 *
 */
 function mutiHelp() {
	var itemWin = L5.getCmp("multiItem_help");
	if(itemWin) {
		itemWin.show();
		return;
	} else {
		var itemDs = L5.DatasetMgr.lookup("DmJzlxDataSet");
		var item_config={};
		item_config.id="multiItem_help";
		item_config.dataset = itemDs;
		item_config.gridColumns=[{header:"编号",sortable:true,field:"value"},{header:"名称",sortable:true,field:"text"}];
		var multiItem_search=new L5.SearchAreaM();
		multiItem_search.addTextField("jzlxdm","编号","DM_JZLX.JZLXDM");
		multiItem_search.addTextField("jzlxmc","名称","DM_JZLX.JZLXMC");
		itemWin = new L5.MultiGridHelpWindow1(item_config,multiItem_search);
		itemWin.show();
	}
	//进行调用
	itemWin.afterExecute=function(){
		var result=this.getReturn();
    	if(result!=null&&!itemWin.isClear){
    		setValue(result);
    	}
	}
}
 /**
 *  困难户家庭登记
 *  事件处理：救助类型通用帮助--设置显示value-----jiang  ???????
 *
 */
function setValue(result) {
	var jzlx = document.getElementById("jzlx");
//	var assistanceTypeCode = document.getElementById("assistanceTypeCode");
	jzlx.value="";
	assistanceTypeCode.value="";
	var reValue = "";
	if(result.length) {
		for(var i=0;i<result.length;i++) {
			var record = result[i];
			if(jzlx.value=="") {
				jzlx.value += (record.get("text"));
				assistanceTypeCode.value += (record.get("value"));
			} else {
				jzlx.value += (","+record.get("text"));
				assistanceTypeCode.value += (","+record.get("value"));
			}
		}
	} else {
		jzlx.value = result.get("text");
		assistanceTypeCode.value = result.get("value");
	}
}
 /**
 *  困难户家庭登记
 *  事件处理：单独校验身份证---jiang-------??????
 *
 */
function  checkFamilyId(familyCardNo){
  var msg="";
  if(familyCardNo!=""){
	 var idmsg=checkIdcard(familyCardNo);
     msg=msg+"身份证号"+idmsg;
  }
  return true;
}
  /**
 *  困难户家庭登记
 *  事件处理：根据身份证回填出生日期---jiang
 *
 */
function getBirthdayByIdCard(){
    var idCard = document.getElementById("familyCardNo").value;
	document.getElementById("birthday").value= idCard.substring(6,14);
 }
  /**
 *  困难户家庭登记
 *  事件处理：固定电话校验----jiang
 *
 */
function __isFixedTelephone(s){
	return /^(\d{2,4}-)?((\(\d{3,5}\))|(\d{3,5}-))?\d{3,8}(-\d+)?$/g.test(s);
}
 /**
 *  困难户家庭登记
 *  事件处理：手机校验----jiang
 *
 */
function __isMobileTelephone(s) {
	return /^1(3\d|(58|59|56|52|53|50))\d{8}$/g.test(s);
}
 /**
 *  困难户家庭登记
 *  事件处理：固定电话----jiang
 *
 */
function checkDhhm(){
  var familyPhone = document.getElementById("familyPhone");
    if(trim(familyPhone.value)!=""&&!__isFixedTelephone(trim(familyPhone.value)))
  {
     L5.Msg.alert('提示',"请输入正确的电话号码！");
  	 familyPhone.value="";
     familyPhone.focus();
     return false;
  }
  return true;
}
//窗口固定电话
function checkWinDhhm(){
  var workUnitTel = document.getElementById("workUnitTel");
    if(trim(workUnitTel.value)!=""&&!__isFixedTelephone(trim(workUnitTel.value)))
  {
     alert("请输入正确的电话号码！");
  	 workUnitTel.value="";
     workUnitTel.focus();
     return false;
  }
  return true;
}
 /**
 *  困难户家庭登记
 *  事件处理：空格清空---jiang
 *
 */
function trim(str){
   var start = -1,
   end = str.length;
   while (str.charCodeAt(--end) < 33);
   while (str.charCodeAt(++start) < 33);
   return str.slice(start, end + 1);
}
 /**
 *  困难户家庭登记
 *  事件处理：手机校验---jiang
 *
 */
 function checkSjhm(){
  var familyMobile = document.getElementById("familyMobile");
    if(trim(familyMobile.value)!=""&&!__isMobileTelephone(trim(familyMobile.value)))
  {
     L5.Msg.alert('提示',"请输入正确的手机号码！");
  	 familyMobile.value="";
     familyMobile.focus();
     return false;
  }
  return true;
}
//窗口手机
 function checkWinSjhm(){
  var telMobile = document.getElementById("telMobile");
    if(trim(telMobile.value)!=""&&!__isMobileTelephone(trim(telMobile.value)))
  {
     alert("请输入正确的手机号码！");
  	 telMobile.value="";
     telMobile.focus();
     return false;
  }
  return true;
}
  /**
 *  困难户家庭登记
 *  事件处理：家庭信息户主身份证重复校验----jiang
 *
 */
function checkIfRepeat(){
	var BaseinfoFamilyDS1=L5.DatasetMgr.lookup("BaseinfoFamilyDS1");
	//获取身份证号
	var  idCard=document.getElementById('familyCardNo').value;
    if(idCard=='')return;
	BaseinfoFamilyDS1.setParameter("BASEINFO_FAMILY.FAMILY_CARD_NO@=",idCard);
	BaseinfoFamilyDS1.load();
	BaseinfoFamilyDS1.on('load',queryIdCard);
}
//---jiang
function queryIdCard(BaseinfoFamilyDS1){
	if(BaseinfoFamilyDS1.getCount()!=0){
		L5.Msg.alert("提示","您输入的身份证已经存在！");
		document.getElementById('familyCardNo').value="";
	}else{

	}
}
  /**
 *  困难户家庭登记
 *  事件处理：自动获取身份证号码----jiang
 *
 */
function getMaxCode(familyCardNo){

   var familyCardNo= document.getElementById(familyCardNo);

   var command = new L5.Command("com.inspur.cams.drel.sam.cmd.SamBaseFamilyCmd");
   command.execute("getMaxCode");
   var idCardExtend=command.getReturn('idCardExtend');
   if(idCardExtend==undefined){
     L5.Msg.alert("提示","当前编号已经最大，请联系管理员！");
   }

   document.getElementById("familyCardNo").value=idCardExtend;
   	BaseinfoFamilyDS.set('familyCardNo',idCardExtend);

    BaseinfoPeopleDS2.set('idCard',idCardExtend);

	BaseinfoPeopleDS2.set('relationshipType','1');

}
 /**
 *  困难户家庭登记
 *  事件处理：根据家庭信息回填户主姓名---jiang
 *
 */
function changeCyHzxm(){
BaseinfoPeopleDS2.set('name',document.getElementById('familyName').value);
}
 /**
 *  困难户家庭登记
 *  事件处理：根据家庭信息回填户主的身份证、出生日期、户主关系----jiang
 *
 */
function changeCySfzh(){
var idCard=document.getElementById('familyCardNo').value;
BaseinfoPeopleDS2.set('idCard',idCard);
BaseinfoPeopleDS2.set('birthday',idCard.substring(6,14));
BaseinfoPeopleDS2.set('relationshipType','1');
}
//------------------------------------------------救助类型信息----------------------------------
//城市低保
function setCityMi(src){
	if(src.checked){
		src.value = '01';
		$("countryMi").checked=false;
		$("fiveMi").checked=false;
		$("isDetail").style.display="none";
		$("isCity").style.display="none";
		$("isCountry").style.display="none";
		$("isFive").style.display="none";

		$("isDetail").style.display="block";
		$("isCity").style.display="block";
	}else{
		src.value = '';
		$("isDetail").style.display="none";
		$("isCity").style.display="none";
	}
}

//农村低保
function setCountryMi(src){
	if(src.checked){
		src.value = '02';
		$("cityMi").checked=false;
		$("fiveMi").checked=false;
		$("isDetail").style.display="none";
		$("isCity").style.display="none";
		$("isCountry").style.display="none";
		$("isFive").style.display="none";

		$("isDetail").style.display="block";
		$("isCountry").style.display="block";
	}else{
		src.value = '';
		$("isDetail").style.display="none";
		$("isCountry").style.display="none";
	}
}
//农村五保
function setFiveMi(src){
	if(src.checked){
		src.value = '03';
		$("cityMi").checked=false;
		$("countryMi").checked=false;
		$("isDetail").style.display="none";
		$("isCity").style.display="none";
		$("isCountry").style.display="none";
		$("isFive").style.display="none";

		$("isDetail").style.display="block";
		$("isFive").style.display="block";
	}else{
		src.value = '';
		$("isDetail").style.display="none";
		$("isFive").style.display="none";
	}
}
//优抚
function setGiveMi(src){
	if(src.checked){
		src.value = '05';
	}else{
		src.value = '';
	}
}
//残疾人
function setHandicapped(src){
	if(src.checked){
		src.value = '06';
	}else{
		src.value = '';
	}
}
//单亲特困母亲
function setPmother(src){
	if(src.checked){
		src.value = '07';
	}else{
		src.value = '';
	}
}
//困难学生
function setKstudent(src){
	if(src.checked){
		src.value = '08';
	}else{
		src.value = '';
	}
}
//“三无”对象
function setThreeNothing(src){
	if(src.checked){
		src.value = '09';
	}else{
		src.value = '';
	}
}
//特困职工
function setTemployee(src){
	if(src.checked){
		src.value = '10';
	}else{
		src.value = '';
	}
}
//其他
function setOther(src){
	if(src.checked){
		src.value = '11';
	}else{
		src.value = '';
	}
}

//function saveAssistanceType(familyId){

//}

 /***--------------------------------------困难户家庭登记开始------------------------------------------******/
 /**
 *  困难户家庭登记
 *  事件处理：点击保存并录入成员按钮------jiang
 *  保存家庭信息转向变更JSP
 *
 */
function saveClick(){
 	var BaseinfoFamilyDS = L5.DatasetMgr.lookup("BaseinfoFamilyDS");
	var BaseinfoFamilyRecord=BaseinfoFamilyDS.getCurrent();

 	var familyId=document.forms[0].familyId.value;
 	var peopleId=document.forms[0].peopleId.value;
	var photoTemp = document.forms[0].photoTemp.value;
	var photoPeople = document.forms[0].photoPeople.value;

 	var BaseinfoPeopleRecord=BaseinfoPeopleDS2.getCurrent();
 	BaseinfoPeopleDS2.set("familyId",familyId);
    BaseinfoFamilyRecord.set("familyId",familyId);
	BaseinfoFamilyRecord.set("curActivity","ACCEPT");
	BaseinfoFamilyRecord.set("checkFlag","1");
	BaseinfoFamilyRecord.set("photoTemp",photoTemp);

    BaseinfoPeopleRecord.set("familyId",familyId);
    BaseinfoPeopleRecord.set("peopleId",peopleId);
    BaseinfoPeopleRecord.set("photoTemp",photoPeople);

	if(!checkIDCard('familyCardNo',"身份证")){return;}

	var assistanceTypeList=new Array();
	var assistanceTypeDS=L5.DatasetMgr.lookup("assistanceTypeDS");
	if($("cityMi").checked){
		var record1=assistanceTypeDS.newRecord();
		record1.set("assistanceId","01"+familyId);
		record1.set("familyId",familyId);
		record1.set("assistanceType","01");
		record1.set("cardNo",_$("cardNo"));
		record1.set("signOrgName",_$("signOrgName"));
		record1.set("signDate",_$("signDate"));
		record1.set("cardValidateBegin",_$("cardValidateBegin"));
		record1.set("cardValidateEnd",_$("cardValidateEnd"));
		record1.set("assistanceBegin",_$("assistanceBegin"));
		record1.set("bank",_$("bank"));
		record1.set("accountName",_$("accountName"));
		record1.set("accountCode",_$("accountCode"));
		record1.set("assistanceMon",_$("assistanceMon"));
		record1.set("assistanceClassMon",_$("assistanceClassMon"));
		record1.set("cardStatus","0");
		assistanceTypeList[0]=record1;
	}
	if($("countryMi").checked){
		var record2=assistanceTypeDS.newRecord();
		record2.set("assistanceId","02"+familyId);//------
		record2.set("familyId",familyId);
		record2.set("assistanceType","02");
		record2.set("cardNo",_$("cardNo"));
		record2.set("signOrgName",_$("signOrgName"));
		record2.set("signDate",_$("signDate"));
		record2.set("cardValidateBegin",_$("cardValidateBegin"));
		record2.set("cardValidateEnd",_$("cardValidateEnd"));
		record2.set("assistanceBegin",_$("assistanceBegin"));
		record2.set("bank",_$("bank"));
		record2.set("accountName",_$("accountName"));
		record2.set("accountCode",_$("accountCode"));
		record2.set("assistanceMon",_$("nassistanceMon"));
		record2.set("assistanceClassMon",_$("nassistanceClassMon"));
		record2.set("cardStatus","0");
		assistanceTypeList[1]=record2;
	}
	if($("fiveMi").checked){
		var record3=assistanceTypeDS.newRecord();
		record3.set("assistanceId","03"+familyId);//------
		record3.set("familyId",familyId);
		record3.set("assistanceType","03");
		record3.set("cardNo",_$("cardNo"));
		record3.set("signOrgName",_$("signOrgName"));
		record3.set("signDate",_$("signDate"));
		record3.set("cardValidateBegin",_$("cardValidateBegin"));
		record3.set("cardValidateEnd",_$("cardValidateEnd"));
		record3.set("assistanceBegin",_$("assistanceBegin"));
		record3.set("bank",_$("bank"));
		record3.set("accountName",_$("accountName"));
		record3.set("accountCode",_$("accountCode"));
		record3.set("supportWay",_$("supportWay"));
		record3.set("assistanceMon",_$("cassistanceMon"));
		record3.set("cardStatus","0");
		assistanceTypeList[2]=record3;
	}
	if($("giveMi").checked){
		var record4=assistanceTypeDS.newRecord();
		record4.set("assistanceId","04"+familyId);//------
		record4.set("familyId",familyId);
		record4.set("assistanceType","05");
		record4.set("cardStatus","0");
		assistanceTypeList[3]=record4;
	}
	if($("handicapped").checked){
		var record5=assistanceTypeDS.newRecord();
		record5.set("assistanceId","05"+familyId);//------
		record5.set("familyId",familyId);
		record5.set("assistanceType","06");
		record5.set("cardStatus","0");
		assistanceTypeList[4]=record5;
	}
	if($("pmother").checked){
		var record6=assistanceTypeDS.newRecord();
		record6.set("assistanceId","06"+familyId);//------
		record6.set("familyId",familyId);
		record6.set("assistanceType","07");
		record6.set("cardStatus","0");
		assistanceTypeList[5]=record6;
	}
	if($("kstudent").checked){
		var record7=assistanceTypeDS.newRecord();
		record7.set("assistanceId","07"+familyId);//------
		record7.set("familyId",familyId);
		record7.set("assistanceType","08");
		record7.set("cardStatus","0");
		assistanceTypeList[6]=record7;
	}
	if($("threeNothing").checked){
		var record8=assistanceTypeDS.newRecord();
		record8.set("assistanceId","08"+familyId);//------
		record8.set("familyId",familyId);
		record8.set("assistanceType","09");
		record8.set("cardStatus","0");
		assistanceTypeList[7]=record8;
	}
	if($("temployee").checked){
		var record9=assistanceTypeDS.newRecord();
		record9.set("assistanceId","09"+familyId);//------
		record9.set("familyId",familyId);
		record9.set("assistanceType","10");
		record9.set("cardStatus","0");
		assistanceTypeList[8]=record9;
	}
	if($("other").checked){
		var record10=assistanceTypeDS.newRecord();
		record10.set("assistanceId","10"+familyId);//------
		record10.set("familyId",familyId);
		record10.set("assistanceType","11");
		record10.set("cardStatus","0");
		record10.set("modTime","");
		assistanceTypeList[9]=record10;
	}
	var command = new L5.Command("com.inspur.cams.drel.sam.cmd.SamBaseFamilyCmd");
	//户主信息
	var BaseinfoPeopleRecords = BaseinfoPeopleDS2.getAllChangedRecords();
	command.setParameter("BaseinfoPeopleRecords", BaseinfoPeopleRecords);
	//自然灾害
	var YgjzJtxxZrzhRecords = SamFamilyCalamityDataSet.getAllChangedRecords();
	command.setParameter("YgjzJtxxZrzhRecords", YgjzJtxxZrzhRecords);
	//成员残疾
    var YgjzCyxxCjxxRecords = SamPeopleDisabilityDataSet.getAllChangedRecords();
	command.setParameter("YgjzCyxxCjxxRecords", YgjzCyxxCjxxRecords);
	//成员教育
	var YgjzCyxxJyxxRecords = SamPeopleEduDataSet.getAllChangedRecords();
	command.setParameter("YgjzCyxxJyxxRecords", YgjzCyxxJyxxRecords);
	//成员患病
	var YgjzCyxxHbxxRecords = SamPeopleDiseaseDataSet.getAllChangedRecords();
	command.setParameter("YgjzCyxxHbxxRecords", YgjzCyxxHbxxRecords);
	//成员事故
	var YgjzCyxxSgxxRecords = SamPeopleAccidentDataSet.getAllChangedRecords();
    command.setParameter("YgjzCyxxSgxxRecords", YgjzCyxxSgxxRecords);

	command.setParameter("BaseinfoFamilyRecord", BaseinfoFamilyRecord);
	command.setParameter("BaseinfoPeopleRecord", BaseinfoPeopleRecord);
	command.setParameter("assistanceTypeList",assistanceTypeList);
	command.execute("save");
	if (!command.error) {

        SamFamilyCalamityDataSet.commitChanges();  //自然灾害
		BaseinfoPeopleDS2.commitChanges();         //户主信息
        SamPeopleDisabilityDataSet.commitChanges();//成员残疾
		SamPeopleEduDataSet.commitChanges();       //成员教育
		SamPeopleDiseaseDataSet.commitChanges();   //成员患病
		SamPeopleAccidentDataSet.commitChanges();  //成员事故

		BaseinfoFamilyDS.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
		var data = new L5.Map();
		data.put("method", "addMember");
    	data.put("dataBean", familyId);
    	data.put("peopleId",peopleId);
    	data.put("photoId",photoTemp);
    	var url = 'jsp/cams/drel/manage/sam/samFamilyUpdate.jsp';
		var text="家庭成员";
		L5.forward(url,text,data);
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
 /**
 *  困难户家庭登记
 *  事件处理：点击返回按钮----jiang
 *  返回困难户家庭登记列表
 *
 */
function returnClick(){
	var url='jsp/cams/drel/manage/sam/samFamilyList.jsp';
	var text='阳光救助_家庭信息';
	L5.forward(url,text);
}

 /**
 *  困难户家庭登记--自然灾害
 *  事件处理：点击 社会救助_家庭信息_自然灾害 的增加按钮
 *
 */
function addYgjzJtxxZrzh() {
	SamFamilyCalamityDataSet.newRecord({
		familyId : document.forms[0].familyId.value

	});
}
 /**
 *  困难户家庭登记--自然灾害
 *  事件处理：点击 社会救助_家庭信息_自然灾害 的删除按钮
 *
 */
function removeYgjzJtxxZrzh() {
	var editGrid=L5.getCmp('YgjzJtxxZrzhEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.cams.drel.sam.cmd.SamFamilyCalamityCmd");
			for(var i=0;i<selected.length;i++){
				var delId=selected[i].get("familyId");
				command.setParameter("delId", delId);
				command.execute("delete");
				SamFamilyCalamityDataSet.remove(selected[i]);
			}
		}else{
			return false;
		}
	});
}
 /**
 *  困难户家庭登记--自然灾害
 *  事件处理：点击 社会救助_家庭信息_自然灾害 的取消按钮
 *
 */
function undoJtxxZrzh() {
	SamFamilyCalamityDataSet.rejectChanges();
}

 /**
 *  困难户家庭登记--残疾信息
 *  事件处理：点击 社会救助_家庭信息_残疾信息 的增加按钮
 *
 */
function addYgjzCyxxCjxx() {
	var SamPeopleDisabilityDataSet=L5.DatasetMgr.lookup("SamPeopleDisabilityDataSet");
	if(method=="INSERT"){
		SamPeopleDisabilityDataSet.newRecord({
			peopleId : document.forms[0].peopleId.value
		});
	}else{
		YgjzJtxxCyxxRecord=BaseinfoPeopleDS2.getCurrent()
	    SamPeopleDisabilityDataSet.newRecord({
	        peopleId: YgjzJtxxCyxxRecord.get("peopleId")
	    });
	}
}

/**
 *  困难户家庭登记--残疾信息
 *  事件处理：点击 阳光救助_家庭信息_残疾信息 的删除按钮
 *
 */
function removeYgjzCyxxCjxx() {
	var editGrid=L5.getCmp('YgjzCyxxCjxxEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.cams.drel.sam.cmd.SamPeopleDisabilityCmd");
			for(var i=0;i<selected.length;i++){
				var delId=selected[i].get("peopleId");
				command.setParameter("delId", delId);
				command.execute("delete");
				SamPeopleDisabilityDataSet.remove(selected[i]);
			}
		}else{
			return false;
		}
	});
}

 /**
 *  困难户家庭登记--残疾信息
 *  事件处理：点击 阳光救助_家庭信息_残疾信息 的取消按钮
 *
 */
function undoCyxxCjxx() {
	SamPeopleDisabilityDataSet.rejectChanges();
}

/**
 *  困难户家庭登记--教育信息
 *  事件处理：点击 阳光救助_家庭信息_教育信息 的增加按钮
 *
 */
function addYgjzCyxxJyxx() {
	var SamPeopleEduDataSet=L5.DatasetMgr.lookup("SamPeopleEduDataSet");
	if(method=="INSERT"){
		SamPeopleEduDataSet.newRecord({
			peopleId : document.forms[0].peopleId.value
		});
	}else{
		YgjzJtxxCyxxRecord=BaseinfoPeopleDS2.getCurrent()
	    SamPeopleEduDataSet.newRecord({
	        peopleId: YgjzJtxxCyxxRecord.get("peopleId")
	    });
	}
}
 /**
 *  困难户家庭登记--教育信息
 *  事件处理：点击 阳光救助_家庭信息_教育信息 的删除按钮
 *
 */
function removeYgjzCyxxJyxx() {
	var editGrid=L5.getCmp('YgjzCyxxJyxxEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.cams.drel.sam.cmd.SamPeopleEduCmd");
			for(var i=0;i<selected.length;i++){
				var delId=selected[i].get("peopleId");
				command.setParameter("delId", delId);
				command.execute("delete");
				SamPeopleEduDataSet.remove(selected[i]);
			}
		}else{
			return false;
		}
	});
}
 /**
 *  困难户家庭登记--教育信息
 *  事件处理：点击 阳光救助_家庭信息_教育信息 的取消按钮
 *
 */
function undoCyxxJyxx() {
	SamPeopleEduDataSet.rejectChanges();
}

/**
 *  困难户家庭登记--患病信息
 *  事件处理：点击 阳光救助_家庭信息_患病信息 的增加按钮
 *
 */
function addYgjzCyxxHbxx() {
    var SamPeopleDiseaseDataSet=L5.DatasetMgr.lookup("SamPeopleDiseaseDataSet");
	if(method=="INSERT"){
		SamPeopleDiseaseDataSet.newRecord({
			peopleId : document.forms[0].peopleId.value
		});
	}else{
		YgjzJtxxCyxxRecord=BaseinfoPeopleDS2.getCurrent()
	    SamPeopleDiseaseDataSet.newRecord({
	        peopleId: YgjzJtxxCyxxRecord.get("peopleId")
	    });
	}
}
/**
 *  困难户家庭登记--患病信息
 *  事件处理：点击 阳光救助_家庭信息_患病信息 的删除按钮
 *
 */
function removeYgjzCyxxHbxx() {
	var editGrid=L5.getCmp('YgjzCyxxHbxxEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzCyxxHbxxCommand");
			for(var i=0;i<selected.length;i++){
				var delId=selected[i].get("peopleId");
				command.setParameter("delId", delId);
				command.execute("delete");
				SamPeopleDiseaseDataSet.remove(selected[i]);
			}
		}else{
			return false;
		}
	});
}
/**
 *  困难户家庭登记--患病信息
 *  事件处理：点击 阳光救助_家庭信息_患病信息 的取消按钮
 *
 */
function undoCyxxHbxx() {
	SamPeopleDiseaseDataSet.rejectChanges();
}

/**
 *  困难户家庭登记--事故信息
 *  事件处理：点击 阳光救助_家庭信息_事故信息 的取消按钮
 *
 */
function addYgjzCyxxSgxx() {
  	var SamPeopleAccidentDataSet=L5.DatasetMgr.lookup("SamPeopleAccidentDataSet");
	if(method=="INSERT"){
		SamPeopleAccidentDataSet.newRecord({
			peopleId : document.forms[0].peopleId.value
		});
	}else{
		YgjzJtxxCyxxRecord=BaseinfoPeopleDS2.getCurrent()
	    SamPeopleAccidentDataSet.newRecord({
	        peopleId: YgjzJtxxCyxxRecord.get("peopleId")
	    });
	}
}
/**
 *  困难户家庭登记--事故信息
 *  事件处理：点击 阳光救助_家庭信息_事故信息 的删除按钮
 *
 */
function removeYgjzCyxxSgxx() {
	var editGrid=L5.getCmp('YgjzCyxxSgxxEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.cams.drel.sam.cmd.SamFamilyAssistanceCmd");
			for(var i=0;i<selected.length;i++){
				var delId=selected[i].get("peopleId");
				command.setParameter("delId", delId);
				command.execute("delete");
				SamPeopleAccidentDataSet.remove(selected[i]);
			}
		}else{
			return false;
		}
	});
}
/**
 *  困难户家庭登记--事故信息
 *  事件处理：点击 阳光救助_家庭信息_事故信息 的取消按钮
 *
 */
function undoCyxxSgxx() {
	SamPeopleAccidentDataSet.rejectChanges();
}