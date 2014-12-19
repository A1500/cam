var wFlag;
var ds2;
function init(){
	ds2=L5.DatasetMgr.lookup("ds2");
	var ds=L5.DatasetMgr.lookup("ds");
	
	if(beginTime!='null'){
		ds.setParameter('beginTime',beginTime);
	}
	
	if(endTime!='null'){
		ds.setParameter('endTime',endTime);
	}
	ds.setParameter('hospitalId',hospitalId);
	ds.setParameter('sign',"1");
	ds.setParameter("assitanceType","05");
	ds.load();
}
//返回优抚门规
function back_report(){
	var url='jsp/cams/drel/mbalance/samMBalanceOutpatientReport.jsp';
	L5.forward(url);
}
//查询
function query(){
	var name=_$("qName");
	var idCard=_$("qIdCard");
	var dateBegin=_$("qDateBegin");
	var dateEnd=_$("qDateEnd");
	
	var ds=L5.DatasetMgr.lookup("ds");
	ds.setParameter('name',name);
	ds.setParameter('idCard',idCard);
	ds.setParameter('dateBegin',dateBegin);
	ds.setParameter('dateEnd',dateEnd);
	ds.setParameter('hospitalId',hospitalId);
	ds.load();

}

//信息回填
function add_people(){
	var winHelp=L5.getCmp("base_people");
	var cell=winHelp.getSelectionModel().getSelections();
	if(cell.length!=1){
		L5.Msg.alert("提示","请选择一条记录！");
		return;
	}
	//三红
	var readFlag=cell[0].get("readFlag");
	//伤残--伤残等级
	var disabilityFlag=cell[0].get("disabilityFlag");
	var disabilityLevelCode=cell[0].get("disabilityLevelCode");
	//遗属 
	var dependantFlag=cell[0].get("dependantFlag");
	//在乡复员军人
	var demobilizedFlag=cell[0].get("demobilizedFlag");
	//参战，参试
	var warFlag=cell[0].get("warFlag");
	var bptType="";
	if(readFlag==1){
		bptType=bptType+"三红人员、";
	}
	if(disabilityFlag==1){
		bptType=bptType+getDisabilityLevel(disabilityLevelCode)+"伤残人员、";
	}
	if(dependantFlag==1){
		bptType=bptType+"遗属人员、";
	}
	if(demobilizedFlag==1){
		bptType=bptType+"在乡复员军人、";
	}
	if(warFlag==1){
		bptType=bptType+"参战参试人员、";
	}
	var sex=cell[0].get("sex");
	if(sex==1){
		$("sex").innerHTML="男";
	}
	if(sex==2){
		$("sex").innerHTML="女";
	}
	var peopleId=cell[0].get("peopleId");
	var idCard=cell[0].get("idCard");
	var bp_length=bptType.length;
	$("idCard").innerHTML=idCard;
	$("name").innerHTML=cell[0].get("name");
	var birthday=cell[0].get("birthday");
	$("age").innerHTML=getAge(birthday);
	$("bptType").innerHTML=bptType.substring(0,bp_length-1);
	$("peopleId").value=peopleId;
	winP.hide();
	var basePeopleDs2=L5.DatasetMgr.lookup("basePeopleDs2");
	basePeopleDs2.removeAll();
}
//关闭帮助窗口
function close_help(){
	if(winP==undefined){
		winP=L5.getCmp("people_help");
	}
	var basePeopleDs2=L5.DatasetMgr.lookup("basePeopleDs2");
	basePeopleDs2.removeAll();
	winP.hide();
}
//查看
var win1;
function detail_rules(){
	var rulePanel=L5.getCmp("rule_Grid");
	var cell=rulePanel.getSelectionModel().getSelections();
	if(cell.length!=1){
		L5.Msg.alert("提示","请选择一条要查看的记录！");
		return;
	}
	if(win1==undefined){
		win1=L5.getCmp("rule_detail");
	}
	var id=cell[0].get("ID");
	var ds3=L5.DatasetMgr.lookup("ds3");
	ds3.setParameter("id",id);
	ds3.load();
	win1.show();
}
//关闭
function  close_win(){
	if(win==undefined){
		win=L5.getCmp("door_rule");
	}
	ds2.removeAll();
	win.hide();
	var ds=L5.DatasetMgr.lookup("ds");
	ds.setParameter('hospitalId',hospitalId);
	ds.load();
}
//关闭1
function detail_rule(){
	if(win1==undefined){
		win1=L5.getCmp("rule_detail");
	}
	win1.hide();	
}
//检查人员信息
function check_people(src){
	if(src!=""){
	if(checkIDCard($('wIdCard'))!=true){
		L5.Msg.alert("提示","身份证号码不合法，请从新输入！");
		return;
	}
	}
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
function changeTwo(src){
	if(src!=""){
		if(isFloat(src)!=true){
			L5.Msg.alert("提示","格式不正确，请输入数字！",function(){
				$("totalExpense").value="";
				$("totalExpense").focus();
			});
			return;
		}
		var num=changeTwoDecimal(src);
		$("totalExpense").value=num;
	}
}
function changeTwo1(src){
	if(src!=""){
		if(isFloat(src)!=true){
			L5.Msg.alert("提示","格式不正确，请输入数字！",function(){
				$("hospitalPay").value="";
				$("hospitalPay").focus();
			});
			return;
		}
		var num=changeTwoDecimal(src);
		$("hospitalPay").value=num;
	}
}
function changeTwo2(src){
	if(src!=""){
		if(isFloat(src)!=true){
			L5.Msg.alert("提示","格式不正确，请输入数字！",function(){
				$("specialPay").value="";
				$("specialPay").focus();
			});
			return;
		}
		var num=changeTwoDecimal(src);
		$("specialPay").value=num;
	}
}
function changeTwo3(src){
	if(src!=""){
		if(isFloat(src)!=true){
			L5.Msg.alert("提示","格式不正确，请输入数字！",function(){
				$("personalPay").value="";
				$("personalPay").focus();
			});
			return;
		}
		var num=changeTwoDecimal(src);
		$("personalPay").value=num;
	}
}
//根据生日算年龄
function getAge(birth){
	var age;
	var nowDate=new Date();
	var thisYear=nowDate.getFullYear();
	var thisMonth=nowDate.getMonth()+1;
	var thisDay=nowDate.getDate();
	if(birth.length==10){
		brithy=birth.substring(0,4)*1;
		brithm=birth.substring(5,7)*1;
		brithd=birth.substring(8);
	}else if(birth.length==8){
		brithy=birth.substring(0,4)*1;
		brithm=birth.substring(4,6)*1;
		brithd=birth.substring(6);
	}else{
		return '0';
	}
	if(thisYear-brithy<0){
	       age='0';
	}else{
	       if(thisMonth-brithm<0){
	              age = thisYear-brithy;
	       }else{
	              if(thisDay-brithd>=0){
	                     age = thisYear-brithy+1;
	              }else{
	                     age = thisYear-brithy;
	              }
	       }
	}
	return age;
}
