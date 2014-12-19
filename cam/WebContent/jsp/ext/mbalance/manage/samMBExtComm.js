function backMenu(){
	var url='jsp/ext/mbalance/login/head.jsp';
	var text = '首页';
	L5.forward(url,text);
}
//根据组件的ID得到组件的value
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
//纳入保险报销费用校验
function checkInsuranceExpense(value){
	if(value){
		if(!isFloat(value)){
			document.getElementById("insuranceExpense").value="";
			L5.Msg.alert("提示","请输入数字");
			return;
		}
		document.getElementById("insuranceExpense").value=changeTwoDecimal(value);
		if(Number(value)>Number(getParam("totalExpense"))){
			L5.Msg.alert('提示',"纳入保险报销费用不能大于住院总费用!");
			document.getElementById("insuranceExpense").value="";
		}
	}
}
//保险支付金额校验
function checkInsurancePay(value){
	if(value){
		if(!isFloat(value)){
			document.getElementById("insurancePay").value="";
			L5.Msg.alert("提示","请输入数字");
			return;
		}
		document.getElementById("insurancePay").value=changeTwoDecimal(value);
		if(Number(value)>Number(getParam("insuranceExpense"))){
			L5.Msg.alert('提示',"保险支付金额不能大于纳入保险报销费!");
			document.getElementById("insurancePay").value="";
		}
	}
}
//根据优抚类别代码得到优抚对象类别
function getBptName(bptType){
	if(bptType==1){
		return "伤残证";
	}else if(bptType==2){
			return "三属证";
		}else if(bptType==3){
			return "在乡复员军人证";
		}else if(bptType==4){
			return "参战、参试证";
		}
}

//处理输入金额的小数点位数
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
//弹出救助对象属地选择通用帮助
function forHelp(domId){
       var revalue=window.showModalDialog("../../../../jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=1&organType=11,12,13&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
       if(revalue!=""&&revalue!=undefined){
          var list = revalue.split(";");
          document.getElementById(domId).value = list[1];
           return list[0];
       }
}
//是否为数字校验
function checkNum(domId){
	if(document.getElementById(domId).value){
		if(!isFloat(document.getElementById(domId).value)){
			document.getElementById(domId).value="";
			L5.Msg.alert("提示","请输入数字");
			return;
		}
	}
}
var printTitle;
//打印预览调用方法
function printBill(balanceId,cityName){
	printTitle=cityName+"医疗救助结算单";
	var printDataset=L5.DatasetMgr.lookup("printDataset");
	printDataset.setParameter("balanceId",balanceId);
	printDataset.on('load',doPrint);
	printDataset.load();
	
}

// 打印方法传递的record
function doPrint(printDataset){
	var printRecord=printDataset.getAt(0);
	printRecord.set('SEX',getDicText(SexDataset,printRecord.get('SEX')));
	printRecord.set('ASSITANCE_TYPE',getDicText(assitanceTypeDataset,printRecord.get('ASSITANCE_TYPE')));
	printRecord.set('BPT_TYPE',getBptTypeName(printRecord.get('BPT_TYPE'),printRecord.get('DISABILITY_LEVEL_CODE')));
	printRecord.set('INSURANCE_TYPE',getDicText(SafeguardDataset,printRecord.get('INSURANCE_TYPE')));
	printRecord.set('DISEASE',printRecord.get('DISEASE'));
	printRecord.set('IN_DATE',dataFormatChange(printRecord.get("IN_DATE")));
	printRecord.set('LEAVE_DATE',dataFormatChange(printRecord.get("LEAVE_DATE")));
	printRecord.set('BALANCE_TIME',dataFormatChange(printRecord.get("BALANCE_TIME")));
	if(printRecord.get("BPT_TYPE")&&printRecord.get("ASSITANCE_TYPE")){
		printReport(getPrintDataByRecord(printTitle,userName,organName,printRecord),L5.webPath+'/jsp/ext/mbalance/manage/sambptBill20121125.fr3');
	}else if(printRecord.get("BPT_TYPE")){
		printReport(getPrintDataByRecord(printTitle,userName,organName,printRecord),L5.webPath+'/jsp/ext/mbalance/manage/bptBill20121125.fr3');
	}else if(printRecord.get("ASSITANCE_TYPE")){
		printReport(getPrintDataByRecord(printTitle,userName,organName,printRecord),L5.webPath+'/jsp/ext/mbalance/manage/samBill20130827.fr3');
	}
	
}
//优抚对象类别解析
function getBptTypeName(bptType,disLv){
	if(bptType==1){
		return getDicText(disbilityLevelDataset,disLv)+"伤残";
	}else if(bptType==2){
			return "三属";
		}else if(bptType==3){
			return "在乡复员军人";
		}else if(bptType==4){
			return "参战、参试";
		}
}
//字典表解析
function getDicText(dicDataSet,value){
	for (var i=0;i<dicDataSet.getTotalCount();i++){
		var record = dicDataSet.getAt(i);
		if(dicDataSet.getAt(i).get('value')==value){
			return record.get('text');
		}
	}
	return "";
}
//日期格式转院yyyy-mm-dd转换成yyyy年mm月-dd日
function dataFormatChange(date){
	return date.substring(0,date.indexOf("-"))+"年"+date.substring(date.indexOf("-")+1,date.lastIndexOf("-"))+"月"+date.substring(date.lastIndexOf("-")+1,date.length)+"日";
}

//将列表中的小数转换成百分比
function getPercent(value){
	return formatNum(value*100)+"%";
}

//显示费用明细窗口
function showExpDetails(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:showExpDetailsWin(\''+record.get("BALANCE_ID")+"&%^"+value+'\')">' + value + '</a>';
}

function showExpDetailsWin(balanceId){
	var expDetailDS=L5.DatasetMgr.lookup("expDetailDS");
	expDetailDS.setParameter("BALANCE_ID",balanceId.split("&%^")[0]);
	expDetailDS.load();
	var expDetailWin=L5.getCmp("expDetailWin");
	expDetailWin.show();
	document.getElementById("peoName").innerHTML=balanceId.split("&%^")[1];
}