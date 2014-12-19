var forupdateIsGlobal="";
function init() {
	if (method==null||method==""){
		//L5.Msg.alert('提示',"方法名为空!");
		L5.Msg.alert(alerttitle,methodnull);
		back();
		}
	else if (method=="INSERT"){
		var record=ds.newRecord();
		var isGlobal = document.getElementById("isGlobal");
		isGlobal.checked="true";
		isGlobal.value="1";
		record.set("isGlobal","1");
	}
	else if (method=="UPDATE"){
		var idinput = document.getElementById("idInput");
		idinput.readOnly="true";
		var isGlobalInput = document.getElementById("isGlobal");
		isGlobalInput.readOnly="true";
        idField = decodeURIComponent(idField);
		ds.baseParams["ID_ID@="]=idField;
		ds.baseParams["ORGAN_ID@="]=idorganId;
		ds.load();
		var idPrefix = document.getElementById("idPrefix");
		var idSuffix = document.getElementById("idSuffix");
		var organId = document.getElementById("organId");
		var imgSrc = document.getElementById("imgSrc");
		ds.on("load",function(){
			var rec=ds.getCurrent();
			//对是否前缀的复选框设置
			var isPrefix=rec.get("isPrefix");
			if(isPrefix=="1"){
				var isPrefixcheck = document.getElementById("isPrefix");
				isPrefixcheck.checked="true";
				isPrefixcheck.value="1";
				idPrefix.style.display="inline";
			}
			//对是否后缀的复选框设置
			var isSuffix=rec.get("isSuffix");
			if(isSuffix=="1"){
				var isSuffixcheck = document.getElementById("isSuffix");
				isSuffixcheck.checked="true";
				isSuffixcheck.value="1";
				idSuffix.style.display="inline";
			}
			//对是否全局流水的复选框设置
			forupdateIsGlobal=rec.get("isGlobal");
			if(forupdateIsGlobal=="1"){
				var isGlobalcheck = document.getElementById("isGlobal");
				isGlobalcheck.checked="true";
				isGlobalcheck.value="1";
			}else{
				organId.style.display="inline";
				imgSrc.style.display="inline";
				var cmd = new L5.Command("org.loushang.bsp.organization.cmd.StruCommand");
				cmd.setParameter("organId",idorganId);
				cmd.execute("getOrganName");
				document.getElementById("organId").value=cmd.getReturn("organName");
			}
		});

	}
	else{
		//L5.Msg.alert('提示',"未知的页面命令!");
		L5.Msg.alert(alerttitle,unknownorder);
		back();
	}
	//var idType=document.getElementById("idType");
	//L5.fly(idType).on("change",changeIdDate());
	L5.QuickTips.init();
}

function checkIdValue(args){
	var val1 = document.getElementById("idValue").value;
	if(isNaN(val1)){
		return "必须为整数值";
	}else{
		return true;
	}
}

function checkIdLength(args){
	var val1 = document.getElementById("idLength").value;
	if(isNaN(val1)){
		return "必须为整数值";
	}else{
		return true;
	}
}
function save(){
	//校验
	var records = ds.getAllChangedRecords();

	if(records.length<1){
		L5.Msg.alert('提示',"没有需要保存的数据");
		return false;
	}
	var valid = ds.isValidate();
	if(valid != true){
		if(valid.indexOf("idId")!=-1){
			valid=valid.replace("idId","编码");
		}
		if(valid.indexOf("idName")!=-1){
			valid=valid.replace("idName","名称");
		}
		if(valid.indexOf("idLength")!=-1){
			valid=valid.replace("idLength","业务流水号长度");
		}
		if(valid.indexOf("idValue")!=-1){
			valid=valid.replace("idValue","当前值");
		}
		if(valid.indexOf("number")!=-1){
			valid=valid.replace("number","数字");
		}
		//L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		L5.Msg.alert(alerttitle,failedverify+" "+valid);
		return false;
	}
	var fieldval = feildvalid();
	if(fieldval != null){
	 	L5.Msg.alert(alerttitle,fieldval);
		return false;
	}
	var id_id = document.getElementById('idInput').value;
	var cached= id_id.match(/\$|@|&|#|\?/g);
	if( cached !== null){
		  L5.MessageBox.alert(alerttitle,"流水号编码包含非法字符"+cached);
		return;
	}
	var rcd = ds.getCurrent();
	if(rcd.state === 1) {//新增记录
		 if( !checkAdd()) {
			 var msg = "该流水号已经存在：";
			 msg += '编号：'+rcd.get('idId');
			 if( rcd.get('organId').length > 0) {
				 msg += '组织编号：'+rcd.get('organId');
			 }
			 rcd.get('organId');
			 L5.MessageBox.alert(alerttitle, msg);
			 return;
		 }
	}
	var command=new L5.Command("org.loushang.bsp.id.cmd.PubIdtableCommand");
	command.setParameter("record",rcd);
	command.setParameter("forupdateIsGlobal",forupdateIsGlobal);//记录修改之前的“是否全局流水”字段的值
	command.setParameter("forupdateOrganId",idorganId);//记录修改之前的组织内码
	//command.execute("insert");
	command.execute("save");
	if (!command.error) {
		//L5.Msg.alert('提示',"保存成功!");
		L5.Msg.alert(alerttitle,savesuccessful);
        rcd.state="3";
		//back();
	}else{
		L5.Msg.alert(alerttitle,command.error);
	}
}
 function back()
 {	 	var url='jsp/bsp/id/pubidtable_list.jsp';
		//var title = '业务流水管理';
		L5.forward(url,title);
 }

//字段值校验
function feildvalid(){


	//如果选择了使用前缀，则需要设置前缀，如果设置了前缀而没有选择使用前缀，则需要确认是否使用前缀
	var isPrefix = document.getElementById("isPrefix").value;
	var idPrefix = document.getElementById("idPrefix").value;
	var idLength= document.getElementById("idLength").value;
	//var prefixlable="选择了使用前缀，请设置前缀!";
	if(isPrefix=="1"){
		if(idPrefix==null || idPrefix==""){
			return setprefix;
		}
	}
	//var idper="设置了前缀，但没有选择使用前缀，如不使用前缀，请删除前缀信息!";
	if(idPrefix!="" && idPrefix!=null){
		if(isPrefix!="1"){
			return delprefix;
		}
	}
	//如果选择了使用后缀，则需要设置后缀
	var isSuffix = document.getElementById("isSuffix").value;
	var idSuffix = document.getElementById("idSuffix").value;
	//var suffixlable="选择了使用后缀，请设置后缀!";
	if(isSuffix=="1"){
		if(idSuffix==null || idSuffix==""){
			return setsuffix;
		}
	}
	//var idsuf="设置了后缀，但没有选择使用后缀，如不使用后缀，请删除后缀信息!";
	if(idSuffix!="" && idSuffix!=null){
		if(isSuffix!="1"){
			return delsuffix;
		}
	}
	//如果不使用全局流水，则需要选择组织内码
	var isGlobal = document.getElementById("isGlobal").value;
	var organId = document.getElementById("organId").value;
	//var organIdlable="不使用全局流水，请选择组织内码!";
	if(isGlobal=="0"){
		if(organId==null || organId==""){
			return setorganid;
		}
	}
	//var idglobal="设置了组织内码，但选择了全局流水，如使用全局流水，请删除组织内码信息!";
	if(organId!="" && organId!=null){
		if(isGlobal=="1"){
			return delorganid;
		}
	}

	//如果选择了流水类型，即按年流水、按月流水或按日流水，则需要使用前缀，并且如果是按年流水，前缀必须包含YYYY，
	//如果按月流水，前缀必须包含YYYYMM，如果按日流水，前缀必须包含YYYYMMDD
	var idType = document.getElementById("idType").value;
	if(idType!="" && idType!=null){
		if(idType=="01"){
			if(idPrefix.toUpperCase().indexOf("YYYY")==-1){
				return prefixincludeyyyy;
			}
		}
		if(idType=="02"){
			if(idPrefix.toUpperCase().indexOf("YYYYMM")==-1){
				return prefixincludeyyyymm;
			}
		}
		if(idType=="03"){
			if(idPrefix.toUpperCase().indexOf("YYYYMMDD")==-1){
				return prefixincludeyyyymmdd;
			}
		}
	}
	//前缀后缀的长度不能超过10位数字
	if(idPrefix!=="" && idPrefix!=null){
		if(idPrefix.length>60){
			return prelength;
		}
	}
	if(idSuffix!="" && idSuffix!=null){
		if(idSuffix.length>60){
			return suflength;
		}
	}
   if((idPrefix!=="" && idPrefix!=null)&&(idSuffix!=="" && idSuffix!=null)){
      if((idSuffix.length+idPrefix.length)>idLength){
         return  '前缀加后缀的长度超过了流水长度!';
      }
   }

}
//选择组织内码
function selectOrganId(){
	var struType="";
	var struId ="";
	var choiceOrganType="1,2";
	var choiceBox="radiobox";
	var revalue=window.showModalDialog(L5.webPath+"/jsp/bsp/organization/selectstru.jsp?struType="+struType+"&struId="+struId+"&choiceOrganType="+choiceOrganType+"&choiceBox="+choiceBox,"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;dialogLeft:"+(window.screen.width-300)/2+";dialogTop:"+(window.screen.height-400)/2);
    if(revalue!=""){
	    var list = revalue.split(";");//list[0] == princiaplId,list[1]==principalName
	    var mgr=ds.getCurrent();
	    ds.set("organId",list[0]);
		document.getElementById("organId").value=list[1];
    }
}

//checkbox的联动
//设置前缀的选择
function setisPrefix(src){
	var records = ds.getCurrent();
	var idPrefix = document.getElementById("idPrefix");
	if(src.checked){
		src.value = '1';
		records.set("isPrefix","1");
		/*隐藏表的某一行
		//var table = document.all.tags('table')[0];
		var tbl=document.getElementById("idTable");
		tbl.rows[1].style.display="none";
		tbl.rows[0].cells[1].style.display="none";

		//table.rows[0].cells[0].rowSpan=2;
		*/


		idPrefix.style.display="inline";


	}else{
		records.set("isPrefix","0");
		src.value = "0";
		idPrefix.style.display="none";
		idPrefix.value="";
		records.set("idPrefix","");
	}
}
//设置后缀的选择
function setisSuffix(src){
	var records = ds.getCurrent();
	var idSuffix = document.getElementById("idSuffix");
	if(src.checked){
		src.value = '1';
		records.set("isSuffix","1");
		idSuffix.style.display="inline";
	}else{
		records.set("isSuffix","0");
		src.value = "0";
		idSuffix.style.display="none";
		idSuffix.value="";
		records.set("idSuffix","");
	}
}
//设置全局流水的选择
function setisGlobal(src){
	var records = ds.getCurrent();
	var organId = document.getElementById("organId");
	var imgSrc = document.getElementById("imgSrc");
	if (src.checked) {
		src.value = '1';
		records.set("isGlobal","1");
		organId.style.display="none";
		organId.value="";
		records.set("organId","");
		imgSrc.style.display="none";
	} else {
		records.set("isGlobal","0");
		src.value = "0";
		organId.style.display="inline";
		imgSrc.style.display="inline";
	}
}

function checkSpecialChar(id_id) {
	var value = id_id.value ;
	var catched = value.match(/\$|@|&|#|\?/g);
	if(catched !== null) {
		L5.MessageBox.alert(alerttitle,"包含非法字符"+catched);
	}
}
/**
 * 是否已经加入了相同编号的流水号
 * @return
 */
function checkAdd() {
	var cmd = new L5.Command('org.loushang.bsp.id.cmd.PubIdtableCommand');
	var rcd = ds.getCurrent();

	cmd.setParameter('id_id@=',rcd.get('idId'));
	cmd.setParameter('organ_id@=',rcd.get('organId'));
	cmd.execute('checkAdd');
	var added = cmd.getReturn('added');
	return added !== 'true';
}
