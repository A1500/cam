var wFlag;
var ds2;
function init(){
	ds2=L5.DatasetMgr.lookup("ds2");
	var ds=L5.DatasetMgr.lookup("ds");
	ds.setParameter('hospitalId',hospitalId);
	ds.setParameter("01','02',03','11");
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
	ds.setParameter("01','02',03','11");
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
	assitanceTypeDataset=L5.DatasetMgr.lookup("assitanceTypeDataset");
	assitanceTypeDataset.reload();
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
	var queryPeoDS=L5.DatasetMgr.lookup("queryPeoDS");
	queryPeoDS.setParameter('name',_$("wName"));
	queryPeoDS.setParameter('idCard',_$("wIdCard"));
	queryPeoDS.setParameter('assitanceType',_$("wType"));
	queryPeoDS.setParameter('cardNo',_$("wCode"));
//	basePeopleDs2.purgeListeners();
	queryPeoDS.on("load",checkMess);
	queryPeoDS.load();
}
//是否为优抚对象
function checkMess(queryPeoDS){
	var num=queryPeoDS.getCount();
	if(num<1){
		L5.Msg.alert("提示","没有相应的记录！");
		return;
	}
	winP.show();
}
var assistanceType;
//信息回填
function add_people(){
	var winHelp=L5.getCmp("base_people");
	var cell=winHelp.getSelectionModel().getSelections();
	if(cell.length!=1){
		L5.Msg.alert("提示","请选择一条记录！");
		return;
	}
	var peopleId=cell[0].get("PEOPLE_ID");
	var idCard=cell[0].get("ID_CARD");
	$("idCard").innerHTML=idCard;
	$("name").innerHTML=cell[0].get("NAME");
	var birthday=cell[0].get("BIRTHDAY");
	$("age").innerHTML=getAge(birthday);
	$("peopleId").value=peopleId;
	assistanceType=cell[0].get("ASSISTANCE_TYPE");
	$("bptType").innerHTML=getDicText(assitanceTypeDataset,cell[0].get("ASSISTANCE_TYPE"));
	var sex=cell[0].get("SEX");
	if(sex==1){
		$("sex").innerHTML="男";
	}
	if(sex==2){
		$("sex").innerHTML="女";
	}
	winP.hide();
	var queryPeoDS=L5.DatasetMgr.lookup("queryPeoDS");
	queryPeoDS.removeAll();
}
//关闭帮助窗口
function close_help(){
	if(winP==undefined){
		winP=L5.getCmp("people_help");
	}
	var queryPeoDS=L5.DatasetMgr.lookup("queryPeoDS");
	queryPeoDS.removeAll();
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
	if(sign=='1'){
		L5.Msg.alert("提示","已提交的数据不能修改！");
		return;
	}
	wFlag="update";
//	var ds2=L5.DatasetMgr.lookup("ds2");
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
		L5.Msg.alert("提示","此人员不在享受救助！");
		return;
	}
	var record=basePeopleDs.getCurrent();
	var name=record.get("name");
	var peopleId=record.get("peopleId");
	var idCard=record.get("idCard");
	var birth=record.get("birthday");
	var bp_length=bptType.length;
	$("idCard").innerHTML=idCard;
	
	var sex=record.get("sex");
	if(sex==1){
		$("sex").innerHTML="男";
	}
	if(sex==2){
		$("sex").innerHTML="女";
	}
	var rulePanel=L5.getCmp("rule_Grid");
	var cell=rulePanel.getSelectionModel().getSelections();
	assistanceType=cell[0].get("ASSITANCE_TYPE");
	$("bptType").innerHTML=getDicText(assitanceTypeDataset,cell[0].get("ASSITANCE_TYPE"));
	$("name").innerHTML=name;
	$("age").innerHTML=getAge(birth);
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
		if(sign=='1'){
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
		if(sign=='1'){
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
	record.set('asstanceType',assistanceType);
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
	ds.setParameter("01','02',03','11");
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
//验证文本域的长度
function checkTextarea(num,name){
	elementTxt=document.getElementById(name);
	if(elementTxt.value.length>num){
	alert("输入的字符过多")
	elementTxt.focus();
	elementTxt.value="";
	return false;
	}
}
