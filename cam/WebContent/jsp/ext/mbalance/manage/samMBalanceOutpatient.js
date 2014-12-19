var wFlag;
var ds2;
function init(){
	ds2=L5.DatasetMgr.lookup("ds2");
	var ds=L5.DatasetMgr.lookup("ds");
	ds.setParameter('hospitalId',hospitalId);
	ds.setParameter("assitanceType","05");
	//ds.load();
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
	ds.setParameter("assitanceType","05");
	ds.load();

}
//录入
var win;
function add_rules(){
	if(win==undefined){
		win=L5.getCmp("door_rule");
	}
	ds2.removeAll();
	wFlag="insert";
	var nowString=new Date().getTime();
	var nowDate=new Date();
	ds2.newRecord({
		id:nowString,
		dateBegin:nowDate,
		dateEnd:nowDate
	});
	win.show();
	$("idCard").innerHTML="";
	$("name").innerHTML="";
	$("sex").innerHTML="";
	$("age").innerHTML="";
	$("bptType").innerHTML="";
	$("peopleId").value="";
	typeDS=L5.DatasetMgr.lookup("typeDS");
	typeDS.reload();
}
var winP;
//查询人员信息
function queryPeople(){
	var idCard=_$("wIdCard");
	var name=_$("wName");
	var type=_$("wType");
	var code=_$("wCode");
	if(idCard==""&&name==""&&type==""&&code==""){
		L5.Msg.alert("提示","请输入身份证号码，姓名或证件编号，进行查询！");
		return;
	}
	if(winP==undefined){
		winP=L5.getCmp("people_help");
	}
	var basePeopleDs2=L5.DatasetMgr.lookup("basePeopleDs2");
	basePeopleDs2.setParameter('NAME',name);
	basePeopleDs2.setParameter('ID_CARD',idCard);
	if(type!=""){
		if(code==""){
			L5.Msg.alert("提示","请输入证件编号！");
			return;
		}
	}
	if(code!=""){
		if(type==""){
			L5.Msg.alert("提示","请输入优抚类型！");
			return;
		}
	}
	if(type=="1"){
		basePeopleDs2.setParameter('DISABILITY_NO',code);
	}else if(type=='2'){
		basePeopleDs2.setParameter('REDA_NO',code);
	}else if(type=='3'){
		basePeopleDs2.setParameter('DEPENDANT_NO',code);
	}else if(type=='4'){
		basePeopleDs2.setParameter('DEMOBILIZED_NO',code);
	}else if(type=='5'){
		basePeopleDs2.setParameter('WAR_NO',code);
	}else{	
	}
//	basePeopleDs2.purgeListeners();
	basePeopleDs2.on("load",checkMess);
	basePeopleDs2.load();
}
//是否为优抚对象
function checkMess(basePeopleDs2){
	var num=basePeopleDs2.getCount();
	if(num<1){
		L5.Msg.alert("提示","没有相应的记录！");
		return;
	}
		
	for(i=num-1;i>=0;i--){
		var record=basePeopleDs2.getAt(i);
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
			bptType=bptType+getDicText(disbilityLevelDataset,disabilityLevelCode)+"伤残人员、";
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
		var bp_length=bptType.length;
		if(bptType.length==0){
			basePeopleDs2.removeAt(i);
		}
	}
	var nm=basePeopleDs2.getCount();
	if(nm<1){
		L5.Msg.alert("提示","没有相应的记录！");
		return;
	}
	winP.show();
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
		bptType=bptType+getDicText(disbilityLevelDataset,disabilityLevelCode)+"伤残人员、";
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
//修改
function edit_rules(){
	var rulePanel=L5.getCmp("rule_Grid");
	var cell=rulePanel.getSelectionModel().getSelections();
	if(cell.length!=1){
		L5.Msg.alert("提示","请选择一条要修改的记录！");
		return;
	}
	if(win==undefined){
		win=L5.getCmp("door_rule");
	}
	var id=cell[0].get("ID");
	var peopleId=cell[0].get("PEOPLE_ID");
	var sign=cell[0].get("SIGN");
	if(sign=='已提交'){
		L5.Msg.alert("提示","已提交的数据不能修改！");
		return;
	}
	wFlag="update";
	ds2.setParameter("id",id);
	backfillMess(peopleId);
	ds2.load();
	win.show();
	$("wIdCard").value="";
	$("wName").value="";
	$("wType").value="";
	$("wCode").value="";
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
		L5.Msg.alert("提示","此人员不在享受优抚补助！");
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
		bptType=bptType+getDicText(disbilityLevelDataset,disabilityLevelCode)+"伤残人员、";
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
	win1.x=20;
	win1.y=50;
	var id=cell[0].get("ID");
	var ds3=L5.DatasetMgr.lookup("ds3");
	ds3.setParameter("id",id);
	ds3.load();
	win1.show();
}
//提交
function commit_rules(){
	var rulePanel=L5.getCmp("rule_Grid");
	var cell=rulePanel.getSelectionModel().getSelections();
	if(cell.length<1){
		L5.Msg.alert("提示","请选择要提交的记录！");
		return;
	}
	var ids=[];
	for(i=0;i<cell.length;i++){
		var sign=cell[i].get("SIGN");
		if(sign=='已提交'){
			L5.Msg.alert("提示","所选记录中包含已提交的记录，不可以提交！");
			return;
		}
		ids[i]=cell[i].get('ID');
	}
	
	L5.MessageBox.confirm("提示", "你确定要提交该记录！",
			function(sta){
				if(sta=="yes"){
					var command=new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMedicalClinicSpCmd");
					command.setParameter("ids", ids);
					command.execute("submitRule");
					if (!command.error) {
						L5.Msg.alert("提示","提交成功！",function(){
							var ds=L5.DatasetMgr.lookup("ds");
							ds.setParameter('hospitalId',hospitalId);
							ds.setParameter("assitanceType","05");
							ds.load();	
						});
					}else{
						L5.MessageBox.alert("提示","提交时出错！"+command.error);
					}
				}
				else return ;
			});
}
//删除
function detele_rules(){
	var ds=L5.DatasetMgr.lookup("ds");
	var rulePanel=L5.getCmp("rule_Grid");
	var cell=rulePanel.getSelectionModel().getSelections();
	if(cell.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	var ids=[];
	for(i=0;i<cell.length;i++){
		var sign=cell[i].get("SIGN");
		if(sign=='已提交'){
			L5.Msg.alert("提示","已提交的数据，不可以删除！");
			return;
		}
		ids[i]=cell[i].get("ID");
	}
	L5.MessageBox.confirm("提示", "你确定要删除这些记录！",
			function(sta){
				if(sta=="yes"){
					var command=new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMedicalClinicSpCmd");
					command.setParameter("ids", ids);
					command.execute("delete");
					if (!command.error) {
						L5.Msg.alert("提示","删除成功！",function(){
							for(i=cell.length-1;i>=0;i--){
								ds.remove(cell[i]);
							}
						});
					}else{
						L5.MessageBox.alert("提示","删除时出错！"+command.error);
					}
				}
				else return ;
			});
}
//确定
function save_win(){
	var record=ds2.getCurrent();
	record.set('hospitalId',hospitalId);
   	record.set("peopleId",document.forms[0].peopleId.value);
	record.set('regId',regId);
	record.set('hospitalArea',organCode);
	record.set('regPeople',regPeople);
	record.set('asstanceType','05');
	record.set('regTime',_$('regTime'));
	record.set("sign","0");
	if(_$("peopleId")==""){
		L5.Msg.alert("提示","请输入人员信息！");
		return;
	}	
	//总费用 
	if(_$("totalExpense")!=""){
		var totalExpense=checkMoneyFix(_$("totalExpense"),2);
		if(totalExpense=="整数"){
			if(_$("totalExpense").length>14){
				L5.Msg.alert("提示","校验未通过：总费用格式不正确，整数最长不超过8位！");
				$("totalExpense").value="";
				$("totalExpense").focus();
				return;
			}
		}	
		if(totalExpense==false){
			L5.Msg.alert("提示","校验未通过：总费用格式不正确，小数点后应保留两位！");
			$("totalExpense").value="";
			$("totalExpense").focus();
			return;
		}
	}
	//医院减免金额 
	if(_$("hospitalPay")!=""){
		var hospitalPay=checkMoneyFix(_$("hospitalPay"),2);
		if(hospitalPay=="整数"){
			if(_$("hospitalPay").length>14){
				L5.Msg.alert("提示","校验未通过：医院减免金额格式不正确，整数最长不超过8位！");
				$("hospitalPay").value="";
				$("hospitalPay").focus();
				return;
			}
		}	
		if(hospitalPay==false){
			L5.Msg.alert("提示","校验未通过：医院减免金额格式不正确，小数点后应保留两位！");
			$("hospitalPay").value="";
			$("hospitalPay").focus();
			return;
		}
	}
	//优抚补助金额
	if(_$("specialPay")!=""){
		var specialPay=checkMoneyFix(_$("specialPay"),2);
		if(specialPay=="整数"){
			if(_$("specialPay").length>14){
				L5.Msg.alert("提示","校验未通过：优抚补助金额格式不正确，整数最长不超过8位！");
				$("specialPay").value="";
				$("specialPay").focus();
				return;
			}
		}	
		if(specialPay==false){
			L5.Msg.alert("提示","校验未通过：优抚补助金额格式不正确，小数点后应保留两位！");
			$("specialPay").value="";
			$("specialPay").focus();
			return;
		}
	}
	//自付费用
	if(_$("personalPay")!=""){
		var personalPay=checkMoneyFix(_$("personalPay"),2);
		if(personalPay=="整数"){
			if(_$("personalPay").length>14){
				L5.Msg.alert("提示","校验未通过：自付费用格式不正确，整数最长不超过8位！");
				$("personalPay").value="";
				$("personalPay").focus();
				return;
			}
		}	
		if(personalPay==false){
			L5.Msg.alert("提示","校验未通过：自付费用格式不正确，小数点后应保留两位！");
			$("personalPay").value="";
			$("personalPay").focus();
			return;
		}
	}

	var isValidate=ds2.isValidate(true);
	if(isValidate!=true){
		L5.Msg.alert("提示","校验未通过！"+isValidate);
		return;
	}
	
	var command=new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMedicalClinicSpCmd");
	command.setParameter("medicalClinic",record);
	if(wFlag=="insert"){
		command.execute("insert");
	}
	if(wFlag=="update"){
		command.execute("update");
	}
	
	if(!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			ds2.removeAll();
			wFlag="";
			close_win();
		});
	}else{
		L5.Msg.alert("提示","保存时出错！"+command.error);
		return;
	}
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
	ds.setParameter("assitanceType","05");
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
