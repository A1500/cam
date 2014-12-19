//机构状态
var jgztDs = new L5.model.SimpleDataset({id:"jgztDs",
	fields: ['value','text']});
//业务模式
var ywmsDs = new L5.model.SimpleDataset({id:"ywmsDs",
	fields: ['value','text']});

// 完成组件初始化
function initCrjIssuedReport(){
	var sFileUpload = '\
	<div style="display:none">\
		<OBJECT\
		  classid="clsid:5F3F8089-770F-4482-9139-53B8F577942E"\
		  codebase="'+L5.webPath+'/jsp/dll/CrjIssuedReport.cab#version=2,0,1,0"\
		  width=239\
		  height=90\
		  align=center\
		  hspace=0\
		  vspace=0\
		  id="CrjIssuedReport"\
		>\
		</OBJECT>\
	</div>\
	';
	document.write(sFileUpload);
}

initCrjIssuedReport();

//初始化
function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}else if (method=="DETAILS"){
		jgztDs.loadData([['0','新增'],
			['1','有效'],
			['9','停用']],false);
		ywmsDs.loadData([['0','正常'],
			['1','快速']],false);
		
		var xbDs = L5.DatasetMgr.lookup("xbDs");
		xbDs.setParameter("PID@=", "700");
		xbDs.load();	
			
		var ryxzDs = L5.DatasetMgr.lookup("ryxzDs");
		ryxzDs.setParameter("PID@=", "860");
		ryxzDs.load();
		
		var djjgDs = L5.DatasetMgr.lookup("djjgDs");
		djjgDs.setParameter("DEPT_CODE@rlike@String", "37");
		djjgDs.load();
		var sflbDs = L5.DatasetMgr.lookup("sflbDs");
		sflbDs.setParameter("PID@=", "600");
		sflbDs.load();
		var gjDs = L5.DatasetMgr.lookup("gjDs");
		gjDs.setParameter("PID@=", "200");
		gjDs.load();
		var zjlxDs = L5.DatasetMgr.lookup("zjlxDs");
		zjlxDs.setParameter("PID@=", "620");
		zjlxDs.load();
		var mzDs = L5.DatasetMgr.lookup("mzDs");
		mzDs.setParameter("PID@=", "100");
		mzDs.load();
		var hyzkDs = L5.DatasetMgr.lookup("hyzkDs");
		hyzkDs.setParameter("PID@=", "640");
		hyzkDs.load();
		var zyDs = L5.DatasetMgr.lookup("zyDs");
		zyDs.setParameter("PID@=", "660");
		zyDs.load();
		var whcdDs = L5.DatasetMgr.lookup("whcdDs");
		whcdDs.setParameter("PID@=", "680");
		whcdDs.load();
		
		var jglxDs = L5.DatasetMgr.lookup("jglxDs");
		jglxDs.setParameter("PID@=", "1100");
		jglxDs.load();
		var jgxzDs = L5.DatasetMgr.lookup("jgxzDs");
		jgxzDs.setParameter("PID@=", "840");
		jgxzDs.load();
		var xzqhDs = L5.DatasetMgr.lookup("xzqhDs");
		xzqhDs.load();
		
		var personDs = L5.DatasetMgr.lookup("personDs");
		personDs.baseParams["DEPT_ID@=@String"]= code;
		personDs.on("load", function getPersonDs(){
			if(personDs.getCount() <= 0) {
				var tabpanel = L5.getCmp('tabpanel');
				tabpanel.remove(tabpanel.getComponent(1));
			}else {
				L5.getCmp("subPanel").setTitle("下属婚姻登记人员(" + personDs.getCount() + "名)");
			}
		});
		personDs.load();
		
		var ds = L5.DatasetMgr.lookup("ds");
		ds.baseParams["ID@=@String"]= idField;
		ds.load();
		
		//添加键盘控制页面关闭
		var _keymap = new L5.KeyMap('myPanel', {key : 27, fn : returnClick});
		_keymap.enable();
	}
}

//返回
function returnClick(){	
	window.close();
}

//打印
function print(){
	var tmpOCX = document.getElementById('CrjIssuedReport');
	//tmpOCX.IfPRE= true;
	//tmpOCX.IfGrid= true;
	tmpOCX.IfPreview = 1;		//设置打印是否预览。
	tmpOCX.RfrUrl= L5.webPath + "/jsp/dll/dept_0_1.fr3";
	
	try{
		receiptValue = getPrintInfo();
		tmpOCX.PrintValue= receiptValue;
		var vs=tmpOCX.PrintComReport();
		if (vs!="0"){
			alert(tmpOCX.ErrorInfo);
		}
	}catch(e) {
		alert("请安装打印插件程序!");
	}
}

//获取打印信息
function getPrintInfo() {
	var result = "<?xml version=\"1.0\" encoding=\"GBK\" standalone=\"no\"?>";
	result += "<MakeReport>";
	result += "<APPLY_INFO>";
	
	var ds = L5.DatasetMgr.lookup("ds");	
	var rec = ds.getAt(0);
	result += "<deptCode>" + rec.get("deptCode") + " </deptCode>";	
	result += "<name>" + rec.get("name") + " </name>";	
	
	var c = -1;
	c = xzqhDs.find("value", rec.get("regionCode"), 0);
	if(c > -1)
		result += "<regionCode>" + xzqhDs.getAt(c).get("text") + "</regionCode>";
	else
		result += "<regionCode> </regionCode>";
		
	result += "<docCode>" + rec.get("docCode") + " </docCode>";	
	
	c = -1;
	c = jglxDs.find("value", rec.get("adminType"), 0);
	if(c > -1)
		result += "<adminType>" + jglxDs.getAt(c).get("text") + "</adminType>";
	else
		result += "<adminType> </adminType>";
	
	c = -1;
	c = jgxzDs.find("value", rec.get("type"), 0);
	if(c > -1)
		result += "<type>" + jgxzDs.getAt(c).get("text") + "</type>";
	else
		result += "<type> </type>";

	result += "<feeType>" + rec.get("feeType") + " </feeType>";	

	c = -1;
	c = ywmsDs.find("value", rec.get("opMode"), 0);
	if(c > -1)
		result += "<opMode>" + ywmsDs.getAt(c).get("text") + "</opMode>";
	else
		result += "<opMode> </opMode>";

	result += "<creatDate>" + rec.get("creatDate") + " </creatDate>";	
	result += "<abolishDate>" + rec.get("abolishDate") + " </abolishDate>";	
	result += "<officeEmail>" + rec.get("officeEmail") + " </officeEmail>";	
	result += "<deptRoute>" + rec.get("deptRoute") + " </deptRoute>";	
	result += "<deptNumSj>" + rec.get("deptNumSj") + " </deptNumSj>";	
	result += "<officeArea>" + rec.get("officeArea") + " </officeArea>";	
	result += "<deptLeador>" + rec.get("deptLeador") + " </deptLeador>";	
	result += "<deptTel>" + rec.get("deptTel") + " </deptTel>";	
	result += "<deptFax>" + rec.get("deptFax") + " </deptFax>";	
	result += "<complainTel>" + rec.get("complainTel") + " </complainTel>";
	result += "<homeUrl>" + rec.get("homeUrl") + " </homeUrl>";
	result += "<deptCodeDesk>" + rec.get("deptCodeDesk") + " </deptCodeDesk>";	
	result += "<descript>" + rec.get("descript") + " </descript>";	
	
	c = -1;
	c = jgztDs.find("value", rec.get("validFlag"), 0);
	if(c > -1)
		result += "<validFlag>" + jgztDs.getAt(c).get("text") + "</validFlag>";
	else
		result += "<validFlag> </validFlag>";
	
	result += "<deptAddress>" + rec.get("deptAddress") + " </deptAddress>";	
	
	result += "</APPLY_INFO>";
	result += "</MakeReport>";
	
	//alert(result)
	return result;		
}

//打印下属登记人员
function printPerson(){
	var tmpOCX = document.getElementById('CrjIssuedReport');
	//tmpOCX.IfPRE= true;
	//tmpOCX.IfGrid= true;
	tmpOCX.IfPreview = 1;		//设置打印是否预览。
	tmpOCX.RfrUrl= L5.webPath + "/jsp/dll/dept_person_0_1.fr3";
	
		receiptValue = getPersonPrintInfo();
	try{
		tmpOCX.PrintValue= receiptValue;
		var vs=tmpOCX.PrintComReport();
		if (vs!="0"){
			alert(tmpOCX.ErrorInfo);
		}
	}catch(e) {
		alert("请安装打印插件程序!");
	}
}

//获取打印信息
function getPersonPrintInfo() {
	var result = "<?xml version=\"1.0\" encoding=\"GBK\" standalone=\"no\"?><MakeReport>";
	for( var i = 0; i < personDs.getCount(); i++) {
		var tmpRec = personDs.getAt(i);
		result += "<APPLY_INFO>";
		
		result += "<code>" + tmpRec.get("code") + " </code>";	
		result += "<name>" + tmpRec.get("name") + " </name>";	
		
		var c = -1;
		c = xbDs.find("value", tmpRec.get("sex"), 0);
		if(c > -1)
			result += "<sex>" + xbDs.getAt(c).get("text") + "</sex>";
		else
			result += "<sex> </sex>";
		
		result += "<birthDate>" + tmpRec.get("birthDate") + " </birthDate>";	
		result += "<cardNo>" + tmpRec.get("cardNo") + " </cardNo>";	
		result += "<nativePlace>" + tmpRec.get("nativePlace") + " </nativePlace>";	
		result += "<nation>" + tmpRec.get("nation") + " </nation>";	
		result += "<politics>" + tmpRec.get("politics") + " </politics>";	
		result += "<partyDate>" + tmpRec.get("partyDate") + " </partyDate>";	
		result += "<culture>" + tmpRec.get("culture") + " </culture>";	
		result += "<degree>" + tmpRec.get("degree") + " </degree>";	
		result += "<specialty>" + tmpRec.get("specialty") + " </specialty>";	
		result += "<college>" + tmpRec.get("college") + " </college>";	
		result += "<graduateDate>" + tmpRec.get("graduateDate") + " </graduateDate>";	
		result += "<marry>" + tmpRec.get("marry") + " </marry>";	
		result += "<technical>" + tmpRec.get("technical") + " </technical>";	
		result += "<duty>" + tmpRec.get("duty") + " </duty>";	
		result += "<workNo>" + tmpRec.get("workNo") + " </workNo>";
		result += "<officeTel>" + tmpRec.get("officeTel") + " </officeTel>";
		result += "<mobile>" + tmpRec.get("mobile") + " </mobile>";	
		result += "<workDate>" + tmpRec.get("workDate") + " </workDate>";	
		
		c = -1;
		c = djjgDs.find("value", tmpRec.get("deptCode"), 0);
		if(c > -1)
			result += "<deptCode>" + djjgDs.getAt(c).get("text") + "</deptCode>";
		else
			result += "<deptCode> </deptCode>";
		
		c = -1;
		c = ryxzDs.find("value", tmpRec.get("kind"), 0);
		if(c > -1)
			result += "<kind>" + ryxzDs.getAt(c).get("text") + "</kind>";
		else
			result += "<kind> </kind>";
			
		c = -1;
		c = jgztDs.find("value", tmpRec.get("validFlag"), 0);
		if(c > -1)
			result += "<validFlag>" + jgztDs.getAt(c).get("text") + "</validFlag>";
		else
			result += "<validFlag> </validFlag>";
			
		result += "<marryStartDate>" + tmpRec.get("marryStartDate") + " </marryStartDate>";
		result += "<marryEndDate>" + tmpRec.get("marryEndDate") + " </marryEndDate>";
		result += "<address>" + tmpRec.get("address") + " </address>";
		result += "<remark>" + tmpRec.get("remark") + " </remark>";	
	
		result += "</APPLY_INFO>";
	}
	result += "</MakeReport>";
	//alert(result);
	return result;	
}
