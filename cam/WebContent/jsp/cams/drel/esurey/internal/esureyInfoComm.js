//户口性质---农村
var COUNTRY='1';
//户口性质---城市
var TOWN='2';

//弹出救助对象属地选择通用帮助
function forHelp(domId){
       var revalue=window.showModalDialog("../../../../../jsp/bsp/organization/getselect_code.jsp?rootId=1&showOrganType=11,12,13&isExact=1&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
       if(revalue!=""&&revalue!=undefined){
          var list = revalue.split(";");
          document.getElementById(domId).value = list[1];
          document.getElementById(domId+"h").value = list[0];
       }
       window.setTitle="";     
}

//取两位小数
function changeTwoDecimal(num){
    var f_Num=parseFloat(num);
    f_Num=Math.round(f_Num*100)/100;
    var s_Num=f_Num.toString();
    var pos_Num=s_Num.indexOf('.');
    if(pos_Num<0){
    	pos_Num=s_Num.length;
		s_Num+='.';
    }
    while(s_Num.length <= pos_Num + 2){
		s_Num += '0';
     }
    return s_Num;
}

//回填户主身份证号码
function check_FamilyCard(){
	if(checkIDCard($("familyCardNo")) == true){	
		$("hidCard").value=_$("familyCardNo");
		$("hcyIdCard").innerHTML=_$("familyCardNo");
	}else{
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		$("familyCardNo").value="";
		$("familyCardNo").focus();
		return;
		}
}
//返回
function return_list(){
	if(method=='insertLS'){
		var data=new L5.Map();
		data.put("familyId",idFeld);
		data.put("method","editL");
		var text="困难家庭信息";
		var url="jsp/cams/drel/esurey/internal/esureyInfoEdit.jsp";
		L5.forward(url,text,data);
	}else if(method=="editLS"){
		var data=new L5.Map();
		data.put("familyId",idFeld);
		data.put("method","editL");
		var text="困难家庭信息";
		var url="jsp/cams/drel/esurey/internal/esureyInfoEdit.jsp";
		L5.forward(url,text,data);
	}else if(method=="editT"){		
		var url="jsp/cams/drel/esurey/internal/esureyInfoTownList.jsp";
		L5.forward(url);
	}else if(method=='editL'){
		var url="jsp/cams/drel/esurey/internal/esureyInfoList.jsp";
		L5.forward(url);
	}else if(method=="insertL"){
		var url="jsp/cams/drel/esurey/internal/esureyInfoList.jsp";
		L5.forward(url);
	}else if(method=="insertTS"){
		var data=new L5.Map();
		data.put("familyId",idFeld);
		data.put("method","editT");
		var text="困难家庭信息";
		var url="jsp/cams/drel/esurey/internal/esureyInfoEdit.jsp";
		L5.forward(url,text,data);
	}else if(method=="editTS"){
		var data=new L5.Map();
		data.put("familyId",idFeld);
		data.put("method","editT");
		var text="困难家庭信息";
		var url="jsp/cams/drel/esurey/internal/esureyInfoEdit.jsp";
		L5.forward(url,text,data);
	}	
	
}
//回填户主信息
function back_name(src){
	if(src!=""){
		if(__isCN(src)!=true){
			L5.Msg.alert("提示","里面含有非中文字符！");
			$("familyName").value="";
			return;
		}
		$("hname").value=_$("familyName");
		$("hcyName").innerHTML=_$("familyName");
		$("hrelationshipType").value="01";
	}else{
		L5.Msg.alert("提示","请填写户主姓名！");
		return;
	}
}
//户主户籍性质
function backType(obj){
	var backType=obj.value;
	if(backType==TOWN){
		$("hdomicileType").value=TOWN;
		$("hincomeMonth").value="";
		$("hincomeYear").value="";
		$("hincomeMonth").disabled=false;
		$("hincomeYear").disabled=true;	
		if(method=="insertK"){
			$("yearSupportMon").value="";
			$("monthSupportMonon").value="";
			$("monthSupportMonon").disabled=false;
			$("yearSupportMon").disabled=true;	
		}	
	}else if(backType==COUNTRY){
		$("hdomicileType").value=COUNTRY;
		$("hincomeMonth").value="";
		$("hincomeYear").value="";
		$("hincomeMonth").disabled=true;
		$("hincomeYear").disabled=false;
		if(method=="insertK"){
			$("yearSupportMon").value="";
			$("monthSupportMonon").value="";
			$("yearSupportMon").disabled=false;
			$("monthSupportMonon").disabled=true;
		}		
	}
}
//户主户籍性质2
function backType2(obj){
	var backType=obj.value;
	if(backType==TOWN){
		$("incomeMonth").value="";
		$("incomeYear").value="";
		$("incomeMonth").disabled=false;
		$("incomeYear").disabled=true;		
	}else if(backType==COUNTRY){
		$("incomeMonth").value="";
		$("incomeYear").value="";
		$("incomeMonth").disabled=true;
		$("incomeYear").disabled=false;		
	}
}
//计算成员的收入
function workOutMIncome(){
	var hincomeYear=_$("hincomeYear");
	if(_$("hincomeYear")!=""){
		var hincomeYear2=checkMoneyFix(_$("hincomeYear"),2);
		if(hincomeYear2=="整数"){
			if(_$("hincomeYear").length>14){
				L5.Msg.alert("提示","校验未通过：年收入格式不正确，整数最长不超过14位！");
				$("hincomeYear").value="";
				$("hincomeYear").focus();
				return;
			}
		}	
		if(hincomeYear2==false){
			L5.Msg.alert("提示","校验未通过：年收入格式不正确，小数点后应保留两位！");
			$("hincomeYear").value="";
			$("hincomeYear").focus();
			return;
		}
	}
	if(hincomeYear!=""){
		$("hincomeMonth").value=changeTwoDecimal(Math.round(hincomeYear/12*100)/100);
	}
	if(hincomeYear==""){
		$("hincomeMonth").value="";
	}
}
function workOutYIncome(){
	var hincomeMonth=_$("hincomeMonth");
	if(_$("hincomeMonth")!=""){
		var hincomeMonth2=checkMoneyFix(_$("hincomeMonth"),2);
		if(hincomeMonth2=="整数"){
			if(_$("hincomeMonth").length>14){
				L5.Msg.alert("提示","校验未通过：月收入格式不正确，整数最长不超过14位！");
				$("hincomeMonth").value="";
				$("hincomeMonth").focus();
				return;
			}
		}	
		if(hincomeMonth2==false){
			L5.Msg.alert("提示","校验未通过：月收入格式不正确，小数点后应保留两位！");
			$("hincomeMonth").value="";
			$("hincomeMonth").focus();
			return;
		}
	}
	if(hincomeMonth!=""){
		$("hincomeYear").value=changeTwoDecimal(Math.round(hincomeMonth*12*100)/100);
	}
	if(hincomeMonth==""){
		$("hincomeYear").value="";
	}
}
//计算成员的收入
function workOutMIncome2(){
	var incomeYear=_$("incomeYear");
	if(_$("incomeYear")!=""){
		var incomeYear2=checkMoneyFix(_$("incomeYear"),2);
		if(incomeYear2=="整数"){
			if(_$("incomeYear").length>14){
				L5.Msg.alert("提示","校验未通过：年收入格式不正确，整数最长不超过14位！");
				$("incomeYear").value="";
				$("incomeYear").focus();
				return;
			}
		}	
		if(incomeYear2==false){
			L5.Msg.alert("提示","校验未通过：年收入格式不正确，小数点后应保留两位！");
			$("incomeYear").value="";
			$("incomeYear").focus();
			return;
		}
	}
	if(incomeYear!=""){
		$("incomeMonth").value=changeTwoDecimal(Math.round(incomeYear/12*100)/100);
	}
	if(incomeYear==""){
		$("incomeMonth").value="";
	}
}
function workOutYIncome2(){
	var incomeMonth=_$("incomeMonth");
	if(_$("incomeMonth")!=""){
		var incomeMonth2=checkMoneyFix(_$("incomeMonth"),2);
		if(incomeMonth2=="整数"){
			if(_$("incomeMonth").length>14){
				L5.Msg.alert("提示","校验未通过：月收入格式不正确，整数最长不超过14位！");
				$("incomeMonth").value="";
				$("incomeMonth").focus();
				return;
			}
		}	
		if(incomeMonth2==false){
			L5.Msg.alert("提示","校验未通过：月收入格式不正确，小数点后应保留两位！");
			$("incomeMonth").value="";
			$("incomeMonth").focus();
			return;
		}
	}
	if(incomeMonth!=""){
		$("incomeYear").value=changeTwoDecimal(Math.round(incomeMonth*12*100)/100);
	}
	if(incomeMonth==""){
		$("incomeYear").value="";
	}
}
//月赡养费
function workOutSupMIncome(){
	var yearSupportMon=_$("yearSupportMon");
	if(_$("yearSupportMon")!=""){
		var yearSupportMon2=checkMoneyFix(_$("yearSupportMon"),2);
		if(yearSupportMon2=="整数"){
			if(_$("yearSupportMon").length>14){
				L5.Msg.alert("提示","校验未通过：年赡养费用格式不正确，整数最长不超过14位！");
				$("yearSupportMon").value="";
				$("yearSupportMon").focus();
				return;
			}
		}	
		if(yearSupportMon2==false){
			L5.Msg.alert("提示","校验未通过：年赡养费用格式不正确，小数点后应保留两位！");
			$("yearSupportMon").value="";
			$("yearSupportMon").focus();
			return;
		}
	}
	if(yearSupportMon!=""){
		$("monthSupportMonon").value=changeTwoDecimal(Math.round(yearSupportMon/12*100)/100);
	}else if(yearSupportMon==""){
		$("monthSupportMonon").value="";
	}
}
//年赡养费
function workOutSupYIncome(){
	var monthSupportMonon=_$("monthSupportMonon");
	if(_$("monthSupportMonon")!=""){
		var monthSupportMonon2=checkMoneyFix(_$("monthSupportMonon"),2);
		if(monthSupportMonon2=="整数"){
			if(_$("monthSupportMonon").length>14){
				L5.Msg.alert("提示","校验未通过：月赡养费用格式不正确，整数最长不超过14位！");
				$("monthSupportMonon").value="";
				$("monthSupportMonon").focus();
				return;
			}
		}	
		if(monthSupportMonon2==false){
			L5.Msg.alert("提示","校验未通过：月赡养费用 格式不正确，小数点后应保留两位！");
			$("monthSupportMonon").value="";
			$("monthSupportMonon").focus();
			return;
		}
	}
	if(monthSupportMonon!=""){
		$("yearSupportMon").value=changeTwoDecimal(Math.round(monthSupportMonon*12*100)/100);
	}else if(monthSupportMonon==""){
		$("yearSupportMon").value="";
	}
}
//回填姓名
function backfillName(src){
	if(src!=""){
		if(__isCN(src)!=true){
			L5.Msg.alert("提示","里面含有非中文字符！");
			return;
		}
		$("cyName").innerHTML=_$("name");
	}else{
		L5.Msg.alert("提示","请填写姓名！");
	}
}
//检验家庭成员身份证号码和唯一性
function check_peopleIdCard(){
	if(_$('idCard')==''){
		return;
	}
	if(checkIDCard($("idCard"))==true){
		$("cyIdCard").innerHTML=_$("idCard");
	}else{
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		$("idCard").value="";
		$("idCard").focus();
		return;
	}
}
/*
//房屋信息联动
function changeHouse(obj){
  var value=obj.value;
  alert(value);
  var buildingDS=L5.DatasetMgr.lookup("buildingTypeDS");
  //有房0 无房1
  if(value=='0'){
  	$("buildingStructure").value="";
  	$("buildArea").value="";
  	$("buildingStructure").disabled=false;
  	$("buildArea").disabled=false;
  	buildingDS.loadData(['0','自有'],false);
  }else if(value=='1'){
  	$("buildingStructure").value="";
  	$("buildArea").value="";
  	$("buildingStructure").disabled=false;
  	$("buildArea").disabled=false;
  	buildingDS.setParameter("value","value='1' or value='2'");
  	buildingDS.load();
  }else{
  	$("buildingStructure").value="";
  	$("buildArea").value="";
  	$("buildingStructure").disabled=true;
  	$("buildArea").disabled=true;
  }
}
*/