//救助比例、封顶线批量设定为去年的标注
function setPerTopLine(dataset1,dataset2,cmd){
	var records=dataset1.getAllRecords();
	cmd.setParameter("records",records);
	cmd.execute("save");
	
	if (!cmd.error) {	
		L5.Msg.alert("提示","保存成功！",function(){
		dataset2.setParameter("domicile_Code@=",organCode);
		dataset2.setParameter("year@=",document.getElementById('year').value);
		dataset2.load();
		});
	}else{
		L5.Msg.alert("错误",cmd.error);
	}
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
	if(Number(value)>Number(getParam("totalExpense"))){
		L5.Msg.alert('提示',"纳入保险报销费用不能大于住院总费用!");
		document.getElementById("insuranceExpense").value="";
	}
}
//保险支付金额校验
function checkInsurancePay(value){
	if(Number(value)>Number(getParam("insuranceExpense"))){
		L5.Msg.alert('提示',"保险支付金额不能大于纳入保险报销费!");
		document.getElementById("insurancePay").value="";
	}
}
//根据救助类型编码得到救助名称
function getAssName(assistanceType){
	if(assistanceType==01){
		return "城市低保";
	}else if(assistanceType==02){
			return "农村低保";
		}else if(assistanceType==03){
			return "农村五保";
		}else{
			return "优抚";
		}
}
//根据保险类型代码得到保险名称
function getSafeName(safeguardType){
	if(safeguardType==0){
		return "城镇职工基本医疗保险";
	}else if(safeguardType==1){
			return "城镇居民基本医疗保险";
		}else if(safeguardType==2){
			return "新型农村合作医疗";
		}else{
			return "无";
		}
}
//根据优抚类别代码得到优抚对象类别
function getBptName(bptType){
	if(bptType==0){
		return "伤残证";
	}else if(bptType==1){
			return "三属证";
		}else if(bptType==2){
			return "在乡复员军人证";
		}else if(bptType==3){
			return "参战、参试证";
		}
}
//本年历史救助信息加载
function getHistoryAss(peopleId){
	getAss(peopleId);
	return totalPersonAssYearPay;
}
function getAss(peopleId){
	//历史救助信息加载
	var hosDataset=L5.DatasetMgr.lookup("hosDataset");
	hosDataset.baseParams["leaveTime@like@String"]=getCurDate().substring(0,4);	
	hosDataset.baseParams["peopleId"]=peopleId;
	hosDataset.load();
	hosDataset.on('load',totalPersonAssPay);
}
//个人本年补助费用
var totalPersonAssYearPay;
//计算并回填个人本年补助费用
function totalPersonAssPay(hosDataset){
	totalPersonAssYearPay=0;
	var records=hosDataset.getAllRecords();
	for(i=0;i<records.length;i++){
		totalPersonAssYearPay=totalPersonAssYearPay+records[i].get("ASSITANCE_PAY");
	}
}
//将阿拉伯数字转换成大写数字
function Chinese(num) { 
	if(!/^\d*(\.\d*)?$/.test(num)) 
	{ 
		alert("你输入的不是数字，请重新输入!"); 
		return false; 
	} 
	if(num==0){
		return "零";
	}
	var AA = new Array("零","壹","贰","叁","肆","伍","陆","柒","捌","玖"); 
	var BB = new Array("","拾","佰","仟","万","亿","点",""); 
	var a = (""+ num).replace(/(^0*)/g, "").split("."), k = 0, re = ""; 
	for(var i=a[0].length-1; i>=0; i--) { 
		switch(k) { 
			case 0 : 
				re = BB[7] + re; 
				break; 
			case 4 : 
				if(!new RegExp("0{4}\\d{"+ (a[0].length-i-1) +"}$").test(a[0])) 
				re = BB[4] + re; 
				break; 
			case 8 : 
				re = BB[5] + re; 
				BB[7] = BB[5]; 
				k = 0; 
				break; 
		} 
		if(k%4 == 2 && a[0].charAt(i)=="0" && a[0].charAt(i+2) != "0") re = AA[0] + re; 
		if(a[0].charAt(i) != 0) re = AA[a[0].charAt(i)] + BB[k%4] + re; 
		k++; 
	} 
	if(a.length>1) { 
		re += BB[6]; 
		for(var i=0; i<a[1].length; i++) re += AA[a[1].charAt(i)]; 
	} 
	return re; 
} 

//根据伤残等级编码得到伤残等级
function getDisabilityLevel(disabilityLevelCode){
	var disabilityLevelChinese = new Array("一级","二级","三级","四级","五级","六级","七级","八级","九级","十级"); 
	return disabilityLevelChinese[disabilityLevelCode*1-1];
}
//弹出救助对象属地选择通用帮助
function forHelp(domId){
       var revalue=window.showModalDialog("../../../../jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=11,12&organType=11,12,13&isExact=1&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
       if(revalue!=""&&revalue!=undefined){
          var list = revalue.split(";");
         document.getElementById(domId+"Code").value = list[0];
          document.getElementById(domId).value = list[1];
       }
      
}
//弹出本地的行政区划
function  forCityHelp(domId){
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?level=4&radioMaxlevel=0&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById(domId+"Code").value = list[0];
        document.getElementById(domId).value = list[1];
	}
}
//金额小数点位数处理
function checkAssMon(domId){
	if(document.getElementById(domId).value){
		if(!isFloat(document.getElementById(domId).value)){
			document.getElementById(domId).value="";
			L5.Msg.alert("提示","请输入数字");
			return;
		}
		document.getElementById(domId).value=changeTwoDecimal(document.getElementById(domId).value);
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
//医院选择窗口
var win;
//显示医院选择窗口并加载医院
function backHos(){
	extOrganDs.baseParams["organ_type"]="30";
	extOrganDs.baseParams["area_code@like@String"]=organCode.substring(0,organCode.indexOf("000"));
	extOrganDs.load();
	if(win==undefined){
		win=L5.getCmp("selectHosWin");
	}
	win.show();
	
}
//医院查询
function selectHos(){
	extOrganDs.setParameter("organ_Name",getParam("qhosName"));
	extOrganDs.load();
}
//医院选择，并回填
function pickHos(){
	var hosGrid=L5.getCmp("hosGrid");
	var cell=hosGrid.getSelectionModel().getSelections();
	if(cell.length!=1){
		L5.Msg.alert("提示","请选择一条要查看的记录！");
		return;
	}
	document.getElementById("hosId").value=cell[0].get("organId");
	document.getElementById("hosName").value=cell[0].get("organName");
	colseWin();
}
//医院选择窗口关闭
function colseWin(){
	if(win==undefined){
		win=L5.getCmp("selectHosWin");
	}
	win.hide();
}
//医院选择窗口清除按钮
function removeName(){
	document.getElementById("hosId").value="";
	document.getElementById("hosName").value="";
	colseWin();
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
