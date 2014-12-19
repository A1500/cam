var wFlag;
var ds2;
function init(){
	var ds=L5.DatasetMgr.lookup("ds");
	ds.setParameter('hospitalArea',organCode);
	ds.setParameter('sign','1');
	ds.setParameter("assitanceType" ,"01','02','03','11");
//	ds.load();
}
//查询
var beginTime;
var endTime;
function query(){
	beginTime=_$("beginTime");
	endTime=_$("endTime");
	var ds=L5.DatasetMgr.lookup("ds");
	if(_$("hosId")){
		ds.setParameter('hospitalId',_$("hosId"));
	}else{
		ds.setParameter('hospitalArea',organCode);
	}
	ds.setParameter('beginTime',beginTime);
	ds.setParameter('endTime',endTime);
	ds.load();
}

//修改时信息回填
function backfillMess(peopleId){
	var basePeopleDs=L5.DatasetMgr.lookup("basePeopleDs");
	basePeopleDs.setParameter("PEOPLE_ID",peopleId); 
	basePeopleDs.on("load",fillMess);
	basePeopleDs.load();
}
function fillMess(basePeopleDs){
	var num=basePeopleDs.getCount();
	if(num<1){
		L5.Msg.alert("提示","此人员不在享受优抚救助！");
		return;
	}
	var record=basePeopleDs.getCurrent();
	//三红
	var readFlag=record.get("readFlag");
	//伤残--伤残等级
	var disabilityFlag=record.get("disabilityFlag");
	var disabilityLevelCode=record.get("disabilityLevelCode");
	//遗属 
	var dependantFlag=record.get("dependantFlag");
	//在乡复员军人
	var demobilizedFlag=record.get("demobilizedFlag");
	//参战，参试
	var warFlag=record.get("warFlag");
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
	var sex=record.get("sex");
	if(sex==1){
		$("sex").innerHTML="男";
	}
	if(sex==2){
		$("sex").innerHTML="女";
	}
	var name=record.get("name");
	var peopleId=record.get("peopleId");
	var idCard=record.get("idCard");
	var birth=record.get("birthday");
	var bp_length=bptType.length;
	$("idCard").innerHTML=idCard;
	$("name").innerHTML=name;
	$("age").innerHTML=getAge(birth);
	$("bptType").innerHTML=bptType.substring(0,bp_length-1);
	$("peopleId").value=peopleId;
	basePeopleDs.removeAll();
}
//明细查看
function detail_rules(){
	var rulePanel=L5.getCmp("rule_Grid");
	var cell=rulePanel.getSelectionModel().getSelections();
	if(cell.length!=1){
		L5.Msg.alert("提示","请选择一条要查看的记录！");
		return;
	}
	var data=new L5.Map();
	
	data.put("hospitalId",cell[0].get("HOSPITAL_ID"));
	if(beginTime){
		data.put("beginTime",beginTime);
	}
	
	if(endTime){
		data.put("endTime",endTime);
	}
	var url='jsp/cams/drel/mbalance/samMBalanceOutpatientAssDetail.jsp';
	var text = '一站式救助优抚门规报表明细';
	L5.forward(url,text,data);
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