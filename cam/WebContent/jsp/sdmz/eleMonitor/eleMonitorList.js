function init() {
   //行政区划过滤
	if(sign=="1"){
		 var DmXzqhDataSetQu = L5.DatasetMgr.lookup("DmXzqhDataSetQu");
		DmXzqhDataSetQu.setParameter("filterSql"," leve='2' and substr(id,0,4)= '"+organArea1+"'");
	    L5.DatasetMgr.lookup("DmXzqhDataSetQu").load();
	}else{
		document.getElementById("quQuery").disabled="disabled";
	    var DmXzqhDataSetQu = L5.DatasetMgr.lookup("DmXzqhDataSetQu");
	    var DmXzqhDataSetStreet = L5.DatasetMgr.lookup("DmXzqhDataSetStreet");
	    
		DmXzqhDataSetStreet.setParameter("filterSql"," leve='3' and substr(id,1,6)= '"+organArea+"'");
	    DmXzqhDataSetStreet.load();
	    
	    DmXzqhDataSetQu.setParameter("filterSql"," leve='2' and  id= '"+organArea2+"'");
	    DmXzqhDataSetQu.on("load", function onDmXzqhDataSetQuLoad() {
	    	document.getElementById("quQuery").selectedIndex=1;
	    });
	    DmXzqhDataSetQu.load();
	    }
}
//导出EXCEL-测试用
function forExcel(){
    	 
	 if(win==undefined){
	   var win=L5.getCmp("socialWin");
	 }
     win=L5.getCmp("socialWin");
	 win.show();
}
//导出EXCEL
function forExcel1(){
	var ds = L5.DatasetMgr.lookup("ds");
	
    var xm = document.getElementById("xmquery").value;//姓名
    var sfzh = document.getElementById("sfzhquery").value;//身份证
   	var hzxm = document.getElementById("hzxmquery").value;//户主姓名
    var quQuery = document.getElementById("quQuery").value;//区县
    var dzZhenquery = document.getElementById("dzZhenquery").value;//街道
   	var dzCunquery = document.getElementById("dzCunquery").value;//村
    var relationshipType = document.getElementById("relationshipType").value;//与户主关系
   	var sex = document.getElementById("sex").value;//性别
    var birthday = document.getElementById("birthday").value;//出生日期
   	var domicileType = document.getElementById("domicileType").value;//户籍性质
    var nation = document.getElementById("nation").value; //民族
   	var marriageCode = document.getElementById("marriageCode").value;//婚姻
    var politicalCode = document.getElementById("politicalCode").value;//政治面貌
   	var safeguardType = document.getElementById("safeguardType").value;//医疗状况
    var employmentCode = document.getElementById("employmentCode").value;//职业状况
    var assistanceType = document.getElementById("jzlxquery").value;//救助类型
    var regTimeS = document.getElementById("regTimeS").value;//登记时间起
    var regTimeT = document.getElementById("regTimeT").value;//登记时间止
    var peopleNum = document.getElementById("peopleNum").value;//家庭人口数量
    var ageStageS = document.getElementById("ageStageS").value;//查询年龄段起
    var ageStageT = document.getElementById("ageStageT").value;//查询年龄段止
	
    var importNumS = document.getElementById("impS").value;//条目起
    var importNumT = document.getElementById("impT").value;//条目起
    if(importNumS==""&&importNumT==""){
      alert("请输入导出条数的起始条数和截止条数！");
      return;
    }
    
    //查询添加前提条件，必须输入查询条件 开始
    var i = 0;
    if(xm!="" && xm!=undefined)	i++;
    if(sfzh!="" && sfzh!=undefined)	i++;
    if(hzxm!="" && hzxm!=undefined)	i++;
    if(quQuery!="" && quQuery!=undefined)	i++;
    if(dzZhenquery!="" && dzZhenquery!=undefined)	i++;
    if(dzCunquery!="" && dzCunquery!=undefined)	i++;
    if(relationshipType!="" && relationshipType!=undefined)	i++;
    if(sex!="" && sex!=undefined)	i++;
    if(birthday!="" && birthday!=undefined)	i++;
    if(domicileType!="" && domicileType!=undefined)	i++;
    if(nation!="" && nation!=undefined)	i++;
    if(marriageCode!="" && marriageCode!=undefined)	i++;
    if(politicalCode!="" && politicalCode!=undefined)	i++;
    if(safeguardType!="" && safeguardType!=undefined)	i++;
    if(employmentCode!="" && employmentCode!=undefined)	i++;
    if(assistanceType!="" && assistanceType!=undefined)	i++;
    if(regTimeS!="" && regTimeS!=undefined)	i++;
    if(regTimeT!="" && regTimeT!=undefined)	i++;
    if(peopleNum!="" && peopleNum!=undefined)	i++;
    if(ageStageS!="" && ageStageS!=undefined)	i++;
    if(ageStageT!="" && ageStageT!=undefined)	i++;
     if(i == 0) {
		alert("必须选择输入一种查询条件！");
		return false;
	}
    if(xm=="") xm=undefined;
    ds.setParameter("xm", xm);//姓名
   	  if(sfzh=="") sfzh=undefined;
    ds.setParameter("sfzh", sfzh);//身份证号
       if(hzxm=="") hzxm=undefined;
    ds.setParameter("hzxm", hzxm);//户主姓名
        if(quQuery=="") quQuery=undefined;
    ds.setParameter("quQuery", quQuery);//区县
        if(dzZhenquery=="") dzZhenquery=undefined;
    ds.setParameter("dzZhenquery", dzZhenquery);//街道
        if(dzCunquery=="") dzCunquery=undefined;
    ds.setParameter("dzCunquery", dzCunquery);//居委会
       if(relationshipType=="") relationshipType=undefined;
    ds.setParameter("relationshipType", relationshipType);//与户主关系
       if(sex=="") sex=undefined;
    ds.setParameter("sex", sex);//性别
       if(birthday=="") birthday=undefined;
    ds.setParameter("birthday", birthday);//出生日期
       if(domicileType=="") domicileType=undefined;
    ds.setParameter("domicileType", domicileType);//户籍性质
       if(nation=="") nation=undefined;
    ds.setParameter("nation", nation);//民族
       if(marriageCode=="") marriageCode=undefined;
    ds.setParameter("marriageCode", marriageCode);//婚姻状况
       if(politicalCode=="") politicalCode=undefined;
    ds.setParameter("politicalCode", politicalCode);//政治面貌   
       if(safeguardType=="") safeguardType=undefined;
    ds.setParameter("safeguardType", safeguardType);//医疗状况   
       if(employmentCode=="") employmentCode=undefined;
    ds.setParameter("employmentCode", employmentCode);//职业状况  
     if(assistanceType=="") assistanceType=undefined;
    ds.setParameter("assistanceType", assistanceType);//救助类型  
     if(regTimeS=="") regTimeS=undefined;
    ds.setParameter("regTimeS", regTimeS);//登记时间起
     if(regTimeT=="") regTimeT=undefined;
    ds.setParameter("regTimeT", regTimeT);//登记时间止 
      if(peopleNum=="") peopleNum=undefined;
    ds.setParameter("peopleNum", peopleNum);//家庭人口数量 
      if(ageStageS=="") ageStageS=undefined;
    ds.setParameter("ageStageS", ageStageS);//查询年龄段起
      if(ageStageT=="") ageStageT=undefined;
     ds.setParameter("ageStageT", ageStageT);//查询年龄段止
     ds.setParameter("organCode",organCode);
     //输入导出数目
     if(importNumS=="") importNumS=undefined;
    ds.setParameter("importNumS", importNumS);//导出数起
      if(importNumT=="") importNumT=undefined;
    ds.setParameter("importNumT", importNumT);//导出数止
	ds.load();
  	var pageSize = ds.pageInfo.pageSize;
	var pageIndex = ds.pageInfo.pageIndex;
	var startCursor = ds.pageInfo.startCursor;
	var total = ds.getTotalCount();
	ds.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	ds.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	ds.baseParams["limitExcel"]=total;  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	L5.dataset2excel(ds, "/jsp/sdmz/eleMonitor/forExcel.jsp");
	ds.baseParams["excelType"]="reset"; //重置导出类型
    document.getElementById("impS").value="";
    document.getElementById("impT").value="";
}
//确认按钮
function Evt_butsave_onclick(){
	var importNumS = document.getElementById("importNumS").value;//条目起
	var importNumT = document.getElementById("importNumT").value;//条目起
	var dsImport = L5.DatasetMgr.lookup("dsImport");
	var xm = document.getElementById("xmquery").value;//姓名
	alert(xm);
    dsImport.setParameter("importNumS", '100');//导出数起
    dsImport.setParameter("importNumT", '201');//导出数止
    dsImport.load();
    dsImport.on("load",function(){
		 alert(dsImport.getTotalCount());
		  //导出EXCEL
	var pageSize = dsImport.pageInfo.pageSize;
	var pageIndex = dsImport.pageInfo.pageIndex;
	var startCursor = dsImport.pageInfo.startCursor;
	var total = dsImport.getTotalCount();
	alert("total="+total);
	dsImport.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dsImport.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dsImport.baseParams["limitExcel"]=total;  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	L5.dataset2excel(dsImport, "/jsp/sdmz/eleMonitor/forExcel.jsp");
	dsImport.baseParams["excelType"]="reset"; //重置导出类型
	 });
	
 alert("111");
}
//关闭社保信息录入窗口
function Evt_butreturn_onclick(){
	if(win==undefined){
		var win=L5.getCmp("socialWin");
	}
	win=L5.getCmp("socialWin");
	win.hide();
}
//区县选择过滤街道
function getDzStreet(){
    var DmXzqhDataSetStreet = L5.DatasetMgr.lookup("DmXzqhDataSetStreet");
	var DzQuQuery=document.getElementById("quQuery").value;
	DmXzqhDataSetStreet.setParameter("filterSql"," leve='3' and substr(id,1,6)= '"+DzQuQuery.substr(0,6)+"'");
    L5.DatasetMgr.lookup("DmXzqhDataSetStreet").load();

}
//街道选择过滤居委会
function getDzCun() {
	 var DmXzqhDataSetVillage = L5.DatasetMgr.lookup("DmXzqhDataSetVillage");
	var dzZhenquery = document.getElementById("dzZhenquery").value;
	DmXzqhDataSetVillage.setParameter("filterSql"," leve='4' and substr(id,1,9)= '"+dzZhenquery.substr(0,9)+"'");
    L5.DatasetMgr.lookup("DmXzqhDataSetVillage").load();
}
function query(){
 	var ds = L5.DatasetMgr.lookup("ds");
 	var jtcyNumDs = L5.DatasetMgr.lookup("jtcyNumDs");
    var xm = document.getElementById("xmquery").value;//姓名
    var sfzh = document.getElementById("sfzhquery").value;//身份证
   	var hzxm = document.getElementById("hzxmquery").value;//户主姓名
    var quQuery = document.getElementById("quQuery").value;//区县
    var dzZhenquery = document.getElementById("dzZhenquery").value;//街道
   	var dzCunquery = document.getElementById("dzCunquery").value;//村
    var relationshipType = document.getElementById("relationshipType").value;//与户主关系
   	var sex = document.getElementById("sex").value;//性别
    var birthday = document.getElementById("birthday").value;//出生日期
   	var domicileType = document.getElementById("domicileType").value;//户籍性质
    var nation = document.getElementById("nation").value; //民族
   	var marriageCode = document.getElementById("marriageCode").value;//婚姻
    var politicalCode = document.getElementById("politicalCode").value;//政治面貌
   	var safeguardType = document.getElementById("safeguardType").value;//医疗状况
    var employmentCode = document.getElementById("employmentCode").value;//职业状况
    var assistanceType = document.getElementById("jzlxquery").value;//救助类型
    var regTimeS = document.getElementById("regTimeS").value;//登记时间起
    var regTimeT = document.getElementById("regTimeT").value;//登记时间止
    var peopleNum = document.getElementById("peopleNum").value;//家庭人口数量
    var ageStageS = document.getElementById("ageStageS").value;//查询年龄段起
    var ageStageT = document.getElementById("ageStageT").value;//查询年龄段止
            
    //查询添加前提条件，必须输入查询条件 开始
    var i = 0;
    if(xm!="" && xm!=undefined)	i++;
    if(sfzh!="" && sfzh!=undefined)	i++;
    if(hzxm!="" && hzxm!=undefined)	i++;
    if(quQuery!="" && quQuery!=undefined)	i++;
    if(dzZhenquery!="" && dzZhenquery!=undefined)	i++;
    if(dzCunquery!="" && dzCunquery!=undefined)	i++;
    if(relationshipType!="" && relationshipType!=undefined)	i++;
    if(sex!="" && sex!=undefined)	i++;
    if(birthday!="" && birthday!=undefined)	i++;
    if(domicileType!="" && domicileType!=undefined)	i++;
    if(nation!="" && nation!=undefined)	i++;
    if(marriageCode!="" && marriageCode!=undefined)	i++;
    if(politicalCode!="" && politicalCode!=undefined)	i++;
    if(safeguardType!="" && safeguardType!=undefined)	i++;
    if(employmentCode!="" && employmentCode!=undefined)	i++;
    if(assistanceType!="" && assistanceType!=undefined)	i++;
    if(regTimeS!="" && regTimeS!=undefined)	i++;
    if(regTimeT!="" && regTimeT!=undefined)	i++; 
    if(peopleNum!="" && peopleNum!=undefined)	i++;
    if(ageStageS!="" && ageStageS!=undefined)	i++;
    if(ageStageT!="" && ageStageT!=undefined)	i++;

     if(i == 0) {
		alert("必须选择输入一种查询条件！");
		return false;
	}
    //查询添加前提条件，必须输入查询条件 结束
      if(xm=="") xm=undefined;
    ds.setParameter("xm", xm);//姓名
    jtcyNumDs.setParameter("xm", xm);//姓名
   	  if(sfzh=="") sfzh=undefined;
    ds.setParameter("sfzh", sfzh);//身份证号
    jtcyNumDs.setParameter("sfzh", sfzh);//身份证号
       if(hzxm=="") hzxm=undefined;
    ds.setParameter("hzxm", hzxm);//户主姓名
    jtcyNumDs.setParameter("hzxm", hzxm);//户主姓名
        if(quQuery=="") quQuery=undefined;
    ds.setParameter("quQuery", quQuery);//区县
    jtcyNumDs.setParameter("quQuery", quQuery);//区县
        if(dzZhenquery=="") dzZhenquery=undefined;
    ds.setParameter("dzZhenquery", dzZhenquery);//街道
    jtcyNumDs.setParameter("dzZhenquery", dzZhenquery);//街道
        if(dzCunquery=="") dzCunquery=undefined;
    ds.setParameter("dzCunquery", dzCunquery);//居委会
    jtcyNumDs.setParameter("dzCunquery", dzCunquery);//居委会
       if(relationshipType=="") relationshipType=undefined;
    ds.setParameter("relationshipType", relationshipType);//与户主关系
    jtcyNumDs.setParameter("relationshipType", relationshipType);//与户主关系
       if(sex=="") sex=undefined;
    ds.setParameter("sex", sex);//性别
    jtcyNumDs.setParameter("sex", sex);//性别
       if(birthday=="") birthday=undefined;
    ds.setParameter("birthday", birthday);//出生日期
    jtcyNumDs.setParameter("birthday", birthday);//出生日期
       if(domicileType=="") domicileType=undefined;
    ds.setParameter("domicileType", domicileType);//户籍性质
    jtcyNumDs.setParameter("domicileType", domicileType);//户籍性质
       if(nation=="") nation=undefined;
    ds.setParameter("nation", nation);//民族
    jtcyNumDs.setParameter("nation", nation);//民族
       if(marriageCode=="") marriageCode=undefined;
    ds.setParameter("marriageCode", marriageCode);//婚姻状况
    jtcyNumDs.setParameter("marriageCode", marriageCode);//婚姻状况
       if(politicalCode=="") politicalCode=undefined;
    ds.setParameter("politicalCode", politicalCode);//政治面貌  
    jtcyNumDs.setParameter("politicalCode", politicalCode);//政治面貌  
       if(safeguardType=="") safeguardType=undefined;
    ds.setParameter("safeguardType", safeguardType);//医疗状况  
    jtcyNumDs.setParameter("safeguardType", safeguardType);//医疗状况 
       if(employmentCode=="") employmentCode=undefined;
    ds.setParameter("employmentCode", employmentCode);//职业状况 
    jtcyNumDs.setParameter("employmentCode", employmentCode);//职业状况  
     if(assistanceType=="") assistanceType=undefined;
    ds.setParameter("assistanceType", assistanceType);//救助类型  
     jtcyNumDs.setParameter("assistanceType", assistanceType);//救助类型  
     if(regTimeS=="") regTimeS=undefined;
    ds.setParameter("regTimeS", regTimeS);//登记时间起
    jtcyNumDs.setParameter("regTimeS", regTimeS);//登记时间起
     if(regTimeT=="") regTimeT=undefined;
    ds.setParameter("regTimeT", regTimeT);//登记时间止 
    jtcyNumDs.setParameter("regTimeT", regTimeT);//登记时间止 
      if(peopleNum=="") peopleNum=undefined;
    ds.setParameter("peopleNum", peopleNum);//家庭人口数量 
    jtcyNumDs.setParameter("peopleNum", peopleNum);//家庭人口数量 
      if(ageStageS=="") ageStageS=undefined;
    ds.setParameter("ageStageS", ageStageS);//查询年龄段起
    jtcyNumDs.setParameter("ageStageS", ageStageS);//查询年龄段起
      if(ageStageT=="") ageStageT=undefined;
    ds.setParameter("ageStageT", ageStageT);//查询年龄段止
    jtcyNumDs.setParameter("ageStageT", ageStageT);//查询年龄段止
    ds.setParameter("organCode",organCode);
    jtcyNumDs.setParameter("organCode",organCode);
    
    ds.load();
    jtcyNumDs.load();
}
//救助类型双击清空
function jzlxDbClick() {
	document.getElementById("jzlx").value="";
	document.getElementById("jzlxquery").value="";
}

//help帮助
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
		var multiItem_search=new L5.SearchArea();
		//multiItem_search.addTextField("DM_JZLX.JZLXDM","编号","jzlxdm");
		//multiItem_search.addTextField("DM_JZLX.JZLXMC","名称","jzlxmc");
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
//设置帮主栏值
function setValue(result) {
	var jzlx = document.getElementById("jzlx");
	var jzlxquery = document.getElementById("jzlxquery");
	jzlx.value="";
	jzlxquery.value="";
	var reValue = "";
	if(result.length) {
		for(var i=0;i<result.length;i++) {
			var record = result[i];
			if(jzlx.value=="") {
				jzlx.value += (record.get("text"));
				jzlxquery.value += (record.get("value"));
			} else {
				jzlx.value += (","+record.get("text"));
				jzlxquery.value += (","+record.get("value"));
			}
		}	
	} else {
		jzlx.value = result.get("text");
		jzlxquery.value = result.get("value");
	}
}
//打印结算单
function printBillClick(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
		printBill(selected[0].get("PEOPLE_ID"));
}

var printTitle;
//打印预览调用方法
function printBill(peopleId){
	var printDataset=L5.DatasetMgr.lookup("printDataset");
	printDataset.setParameter("PEOPLE_ID",peopleId);
	printDataset.on('load',doPrint);
	printDataset.load();
	
}

// 打印方法传递的record
function doPrint(printDataset){
	var editGrid = L5.getCmp('editGridPanel');
	selected = editGrid.getSelectionModel().getSelections();
	var printRecord=selected[0];
	
	printRecord.set('NAME',printRecord.get('NAME'));
	printRecord.set('ID_CARD',printRecord.get('ID_CARD'));
	printRecord.set('NATION',getDicText(DmMzDataSet,printRecord.get('NATION')));
	printRecord.set('RELATIONSHIP_TYPE',getDicText(DmHzgxDataSet,printRecord.get('RELATIONSHIP_TYPE')));
	printRecord.set('SEX',getDicText(DmXbDataSet,printRecord.get('SEX')));
	printRecord.set('BIRTHDAY',printRecord.get('BIRTHDAY'));
	printRecord.set('DOMICILE_TYPE',getDicText(domicileDataset,printRecord.get('DOMICILE_TYPE')));
	printRecord.set('MARRIAGE_CODE',getDicText(DmHyzkDataSet,printRecord.get('MARRIAGE_CODE')));
	printRecord.set('TEL_MOBILE',printRecord.get('TEL_MOBILE'));
	printRecord.set('SAFEGUARD_TYPE',getDicText(DmYlzkDataSet,printRecord.get('SAFEGUARD_TYPE')));
	printRecord.set('CAREER_CODE',getDicText(DmZyDataSet,printRecord.get('CAREER_CODE')));
	printRecord.set('INCOME_YEAR',printRecord.get('INCOME_YEAR'));
	printRecord.set('WORK_UNIT_NAME',printRecord.get('WORK_UNIT_NAME'));
	printRecord.set('ASSISTANCE_TYPE',szlxRef(printRecord.get('ASSISTANCE_TYPE')));
	printRecord.set('BPT_TYPE',getDicText(DmFxdxlxDataSet,printRecord.get('BPT_TYPE')));
	printRecord.set('BPT_NUM',printRecord.get('BPT_NUM'));
	printRecord.set('DISABILITY_TYPE',getDicText(DmCjlxDataSet,printRecord.get('DISABILITY_TYPE')));
	printRecord.set('EDUCATION',getDicText(DmJyzkDataSet,printRecord.get('EDUCATION')));
	printRecord.set('DISEASE_TYPE',getDicText(DmHbzlDataSet,printRecord.get('DISEASE_TYPE')));
	printRecord.set('COST_MON',printRecord.get('COST_MON'));
	printRecord.set('ACCIDENT_TYPE',getDicText(DmSgzlDataSet,printRecord.get('ACCIDENT_TYPE')));
	printRecord.set('LOSS_MON',printRecord.get('LOSS_MON'));
	printReport(getPrintDataByRecord(printTitle,printRecord),L5.webPath+'/jsp/sdmz/eleMonitor/peopleInfoPrint.fr3');
	
	var ds = L5.DatasetMgr.lookup("ds");
    ds.setParameter("organCode",organArea);
    ds.reload();
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

//受助类型
function szlxRef(values) {
 if(values.length==0){
       return "";
    }
var DmJzlxDataSet = L5.DatasetMgr.lookup("DmJzlxDataSet");
	var texts=new Array();
	if (!(values instanceof Array)) {
		if(!values||values=="") {
			return;
		}
		values = values.split(',');
	}
	var records = DmJzlxDataSet.getAllRecords();
	var record=DmJzlxDataSet.find();
	if(records) {
		for(var r=0;r<records.length;r++) {
			if(values.indexOf(records[r].get("value"))!=-1) {
				texts.push(records[r].get("text"));
			}
		}
	}
	return texts.join(",");
}