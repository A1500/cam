//人员状态
var ryztDs = new L5.model.SimpleDataset({id:"ryztDs",
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
		ryztDs.loadData([['0','新增'],
			['1','有效'],
			['9','停用']],false);
		
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
	tmpOCX.RfrUrl= L5.webPath + "/jsp/dll/person_0_1.fr3";
	
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
	result += "<code>" + rec.get("code") + " </code>";	
	result += "<name>" + rec.get("name") + " </name>";	
		
	var c = -1;
	c = xbDs.find("value", rec.get("sex"), 0);
	if(c > -1)
		result += "<sex>" + xbDs.getAt(c).get("text") + "</sex>";
	else
		result += "<sex> </sex>";	
		
	result += "<birthDate>" + rec.get("birthDate") + " </birthDate>";	
	result += "<cardNo>" + rec.get("cardNo") + " </cardNo>";	
	result += "<nativePlace>" + rec.get("nativePlace") + " </nativePlace>";	
	result += "<nation>" + rec.get("nation") + " </nation>";	
	result += "<politics>" + rec.get("politics") + " </politics>";	
	result += "<partyDate>" + rec.get("partyDate") + " </partyDate>";	
	result += "<culture>" + rec.get("culture") + " </culture>";	
	result += "<degree>" + rec.get("degree") + " </degree>";	
	result += "<specialty>" + rec.get("specialty") + " </specialty>";	
	result += "<college>" + rec.get("college") + " </college>";	
	result += "<graduateDate>" + rec.get("graduateDate") + " </graduateDate>";	
	result += "<marry>" + rec.get("marry") + " </marry>";	
	result += "<technical>" + rec.get("technical") + " </technical>";	
	result += "<duty>" + rec.get("duty") + " </duty>";	
	result += "<workNo>" + rec.get("workNo") + " </workNo>";
	result += "<officeTel>" + rec.get("officeTel") + " </officeTel>";
	result += "<mobile>" + rec.get("mobile") + " </mobile>";	
	result += "<workDate>" + rec.get("workDate") + " </workDate>";	
		
	c = -1;
	c = djjgDs.find("value", rec.get("deptCode"), 0);
	if(c > -1)
		result += "<deptCode>" + djjgDs.getAt(c).get("text") + "</deptCode>";
	else
		result += "<deptCode> </deptCode>";
	
	c = -1;
	c = ryxzDs.find("value", rec.get("kind"), 0);
	if(c > -1)
		result += "<kind>" + ryxzDs.getAt(c).get("text") + "</kind>";
	else
		result += "<kind> </kind>";
	
	c = -1;
	c = ryztDs.find("value", rec.get("validFlag"), 0);
	if(c > -1)
		result += "<validFlag>" + ryztDs.getAt(c).get("text") + "</validFlag>";
	else
		result += "<validFlag> </validFlag>";
		
	result += "<marryStartDate>" + rec.get("marryStartDate") + " </marryStartDate>";
	result += "<marryEndDate>" + rec.get("marryEndDate") + " </marryEndDate>";
	result += "<address>" + rec.get("address") + " </address>";
	result += "<remark>" + rec.get("remark") + " </remark>";		
	
	result += "</APPLY_INFO>";
	result += "</MakeReport>";
	
	//alert(result)
	return result;		
}
