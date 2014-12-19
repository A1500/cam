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
		var bfyyDs = L5.DatasetMgr.lookup("bfyyDs");
		bfyyDs.setParameter("PID@=", "800");
		bfyyDs.load();
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
		var ywlbDs = L5.DatasetMgr.lookup("ywlbDs");
		ywlbDs.setParameter("PID@=", "760");
		ywlbDs.load();
		
		//获取男方全部信息		
		var manAllDs = L5.DatasetMgr.lookup("manAllDs");
		manAllDs.baseParams["CERT_NUM_MAN@=@String"]= certNumMan;
		manAllDs.on("load", getManDs);
		manAllDs.load();
		
		//获取女方全部信息		
		var womanAllDs = L5.DatasetMgr.lookup("womanAllDs");
		womanAllDs.baseParams["CERT_NUM_WOMAN@=@String"]= certNumWoman;
		womanAllDs.on("load", getWomanDs);
		womanAllDs.load();
		
		//获取男方全部信息
		function getManDs() {
			var certNumManOther = "";
			if(certNumMan.length == 15) {
				certNumManOther = get18By15(certNumMan);
			}else {
				certNumManOther = get15By18(certNumMan);
			}
			var manAllDs2 = L5.DatasetMgr.lookup("manAllDs2");
			var rec = manAllDs.getAt(0);
			manAllDs2.baseParams["CERT_NUM_MAN@=@String"]= certNumManOther;
			manAllDs2.baseParams["NAME_MAN@=@String"]= rec.get("nameMan");
			manAllDs2.on("load", getManDs2);
			manAllDs2.load();
			
			function getManDs2() {
				var tabpanel = L5.getCmp('tabpanel');
				var manAllDs = L5.DatasetMgr.lookup("manAllDs");
				var manAllDs2 = L5.DatasetMgr.lookup("manAllDs2");
				manAllDs.add(manAllDs2.getAllRecords());
	
//				alert("nan:" + manAllDs.getCount())
				if(manAllDs.getCount() == 0) {	//改
					tabpanel.remove(tabpanel.getComponent(1));
				}else {
					//取出全部数据，依次分解
					var manIABDs = L5.DatasetMgr.lookup("manIABDs");
					var manICADs = L5.DatasetMgr.lookup("manICADs");
					var manICBDs = L5.DatasetMgr.lookup("manICBDs");
					var manICDs = L5.DatasetMgr.lookup("manICDs");
					var manIDDs = L5.DatasetMgr.lookup("manIDDs");
					
					var recManIAB = [];
					var recManICA = [];
					var recManICB = [];
					var recManIC = [];
					var recManID = [];
					
					for(i = 0; i < manAllDs.getCount(); i++) {
						var opType = manAllDs.getAt(i).get("opType");
						if(opType == "IA" || opType == "IB") 
							recManIAB.push(manAllDs.getAt(i));
						else if(opType == "ICA")
							recManICA.push(manAllDs.getAt(i));
						else if(opType == "ICB")
							recManICB.push(manAllDs.getAt(i));
						else if(opType == "IC")
							recManIC.push(manAllDs.getAt(i));
						else if(opType == "ID")
							recManID.push(manAllDs.getAt(i));
					}
					
					manIABDs.removeAll();
					manICADs.removeAll();
					manICBDs.removeAll();
					manICDs.removeAll();
					manIDDs.removeAll();
					
					manIABDs.add(recManIAB);
					manICADs.add(recManICA);
					manICBDs.add(recManICB);
					manICDs.add(recManIC);
					manIDDs.add(recManID);
					
					var tabpanelM = L5.getCmp('tabpanelM');
					if(recManIAB.length == 0)  {
						tabpanelM.getComponent(0).setDisabled(true);
						tabpanelM.getComponent(0).setTitle(tabpanelM.getComponent(0).title + "（无）");
					}
					if(recManICA.length == 0) {
						tabpanelM.getComponent(1).setDisabled(true);
						tabpanelM.getComponent(1).setTitle(tabpanelM.getComponent(1).title + "（无）");
					}
					if(recManICB.length == 0) {
						tabpanelM.getComponent(2).setDisabled(true);
						tabpanelM.getComponent(2).setTitle(tabpanelM.getComponent(2).title + "（无）");
					}
					if(recManIC.length == 0) {
						tabpanelM.getComponent(3).setDisabled(true);
						tabpanelM.getComponent(3).setTitle(tabpanelM.getComponent(3).title + "（无）");
					}
					if(recManID.length == 0) {
						tabpanelM.getComponent(4).setDisabled(true);
						tabpanelM.getComponent(4).setTitle(tabpanelM.getComponent(4).title + "（无）");
					}
					
					tabpanel.getComponent(1).setDisabled(false);
				}
			}
		}
		
		//获取女方全部信息
		function getWomanDs() {
			
			var certNumWomanOther = "";
			if(certNumWoman.length == 15) {
				certNumWomanOther = get18By15(certNumWoman);
			}else {
				certNumWomanOther = get15By18(certNumWoman);
			}
			
			var womanAllDs2 = L5.DatasetMgr.lookup("womanAllDs2");
			var recWoman = womanAllDs.getAt(0);
			womanAllDs2.baseParams["CERT_NUM_WOMAN@=@String"]= certNumWomanOther;
			womanAllDs2.baseParams["NAME_WOMAN@=@String"]= recWoman.get("nameWoman");
			womanAllDs2.on("load", getWomanDs2);
			womanAllDs2.load();
			
			function getWomanDs2() {
				var tabpanel = L5.getCmp('tabpanel');
				var womanAllDs = L5.DatasetMgr.lookup("womanAllDs");
				var womanAllDs2 = L5.DatasetMgr.lookup("womanAllDs2");
				womanAllDs.add(womanAllDs2.getAllRecords());
				
				//alert("nv:" + womanDs.getCount())
				if(womanAllDs.getCount() == 0) { //改
					if(tabpanel.items.length == 2)
						tabpanel.remove(tabpanel.getComponent(1));
					else
						tabpanel.remove(tabpanel.getComponent(2));
				}else {
					var womanIABDs = L5.DatasetMgr.lookup("womanIABDs");
					var womanICADs = L5.DatasetMgr.lookup("womanICADs");
					var womanICBDs = L5.DatasetMgr.lookup("womanICBDs");
					var womanICDs = L5.DatasetMgr.lookup("womanICDs");
					var womanIDDs = L5.DatasetMgr.lookup("womanIDDs");
					
					var recWomanIAB = [];
					var recWomanICA = [];
					var recWomanICB = [];
					var recWomanIC = [];
					var recWomanID = [];
					
					for(i = 0; i < womanAllDs.getCount(); i++) {
						var opType = womanAllDs.getAt(i).get("opType");
						if(opType == "IA" || opType == "IB") 
							recWomanIAB.push(womanAllDs.getAt(i));
						else if(opType == "ICA")
							recWomanICA.push(womanAllDs.getAt(i));
						else if(opType == "ICB")
							recWomanICB.push(womanAllDs.getAt(i));
						else if(opType == "IC")
							recWomanIC.push(womanAllDs.getAt(i));
						else if(opType == "ID")
							recWomanID.push(womanAllDs.getAt(i));
					}
					
					womanIABDs.removeAll();
					womanICADs.removeAll();
					womanICBDs.removeAll();
					womanICDs.removeAll();
					womanIDDs.removeAll();
					
					womanIABDs.add(recWomanIAB);
					womanICADs.add(recWomanICA);
					womanICBDs.add(recWomanICB);
					womanICDs.add(recWomanIC);
					womanIDDs.add(recWomanID);
					
					var tabpanelW = L5.getCmp('tabpanelW');
					if(recWomanIAB.length == 0) {
						tabpanelW.getComponent(0).setDisabled(true);
						tabpanelW.getComponent(0).setTitle(tabpanelW.getComponent(0).title + "（无）");
					}
					if(recWomanICA.length == 0) {
						tabpanelW.getComponent(1).setDisabled(true);
						tabpanelW.getComponent(1).setTitle(tabpanelW.getComponent(1).title + "（无）");
					}
					if(recWomanICB.length == 0) {
						tabpanelW.getComponent(2).setDisabled(true);
						tabpanelW.getComponent(2).setTitle(tabpanelW.getComponent(2).title + "（无）");
					}
					if(recWomanIC.length == 0) {
						tabpanelW.getComponent(3).setDisabled(true);
						tabpanelW.getComponent(3).setTitle(tabpanelW.getComponent(3).title + "（无）");
					}
					if(recWomanID.length == 0) {
						tabpanelW.getComponent(4).setDisabled(true);
						tabpanelW.getComponent(4).setTitle(tabpanelW.getComponent(4).title + "（无）");
					}
					if(tabpanel.items.length == 2)
						tabpanel.getComponent(1).setDisabled(false);
					else
						tabpanel.getComponent(2).setDisabled(false);
				}
			}
		}
		
		var ds = L5.DatasetMgr.lookup("ds");
		ds.baseParams["ID@=@String"]= idField;
		ds.load();
		
		//添加键盘控制页面关闭
		var _keymap = new L5.KeyMap('tabpanel', {key : 27, fn : returnClick});
		_keymap.enable();
	}
}

//function print(){
//	document.all.WebBrowser.ExecWB(7,1);
//}

//返回
function returnClick(){	
	window.close();
}

//打印女方婚史
function printWomanIAB(){
	var tmpOCX = document.getElementById('CrjIssuedReport');
	//tmpOCX.IfPRE= true;
	//tmpOCX.IfGrid= true;
	tmpOCX.IfPreview = 1;		//设置打印是否预览。
	tmpOCX.RfrUrl= L5.webPath + "/jsp/dll/dj_woman_IAB_0_1.fr3";
	
	try{
		receiptValue = getWomanIABPrintInfo();
		tmpOCX.PrintValue= receiptValue;
		var vs=tmpOCX.PrintComReport();
		if (vs!="0"){
			alert(tmpOCX.ErrorInfo);
		}
	}catch(e) {
		alert("请安装打印插件程序!");
	}
}

//获取女方婚史信息
function getWomanIABPrintInfo() {
	var result = "<?xml version=\"1.0\" encoding=\"GBK\" standalone=\"no\"?><MakeReport>";
	for( var i = 0; i < womanIABDs.getCount(); i++) {
		var tmpRec = womanIABDs.getAt(i);
		result += "<APPLY_INFO>";
		
		var c = ywlbDs.find("value", tmpRec.get("opType"), 0);
		if(c > -1)
			result += "<opType>" + ywlbDs.getAt(c).get("text") + "</opType>";
		else
			result += "<opType> </opType>";
			
		result += "<nameMan>" + tmpRec.get("nameMan") + " </nameMan>";
		
		c = -1;
		c = sflbDs.find("value", tmpRec.get("idTypeMan"), 0);
		if(c > -1)
			result += "<idTypeMan>" + sflbDs.getAt(c).get("text") + "</idTypeMan>";
		else
			result += "<idTypeMan> </idTypeMan>";
			
		c = -1;
		c = gjDs.find("value", tmpRec.get("nationMan"), 0);
		if(c > -1)
			result += "<nationMan>" + gjDs.getAt(c).get("text") + "</nationMan>";
		else
			result += "<nationMan> </nationMan>";

		result += "<birthMan>" + tmpRec.get("birthMan") + " </birthMan>";
		
		c = -1;
		c = zjlxDs.find("value", tmpRec.get("certTypeMan"), 0);
		if(c > -1)
			result += "<certTypeMan>" + zjlxDs.getAt(c).get("text") + "</certTypeMan>";
		else
			result += "<certTypeMan> </certTypeMan>";

		result += "<certNumMan>" + tmpRec.get("certNumMan") + " </certNumMan>";
		
		c = -1;
		c = mzDs.find("value", tmpRec.get("folkMan"), 0);
		if(c > -1)
			result += "<folkMan>" + mzDs.getAt(c).get("text") + "</folkMan>";
		else
			result += "<folkMan> </folkMan>";
			
		c = -1;
		c = hyzkDs.find("value", tmpRec.get("marryStatusMan"), 0);
		if(c > -1)
			result += "<marryStatusMan>" + hyzkDs.getAt(c).get("text") + "</marryStatusMan>";
		else
			result += "<marryStatusMan> </marryStatusMan>";
		
		c = -1;
		c = zyDs.find("value", tmpRec.get("jobMan"), 0);
		if(c > -1)
			result += "<jobMan>" + zyDs.getAt(c).get("text") + "</jobMan>";
		else
			result += "<jobMan> </jobMan>";
		
		c = -1;
		c = whcdDs.find("value", tmpRec.get("degreeMan"), 0);
		if(c > -1)
			result += "<degreeMan>" + whcdDs.getAt(c).get("text") + "</degreeMan>";
		else
			result += "<degreeMan> </degreeMan>";
		
		result += "<regDetailMan>" + tmpRec.get("regDetailMan") + " </regDetailMan>";
		result += "<opDate>" + tmpRec.get("opDate") + " </opDate>";
		result += "<deptName>" + tmpRec.get("deptName") + " </deptName>";
		
		result += "</APPLY_INFO>";
	}
	result += "</MakeReport>";
	//alert(result);
	return result;	
}


//打印女方补发结婚登记历史
function printWomanICA(){
	var tmpOCX = document.getElementById('CrjIssuedReport');
	//tmpOCX.IfPRE= true;
	//tmpOCX.IfGrid= true;
	tmpOCX.IfPreview = 1;		//设置打印是否预览。
	tmpOCX.RfrUrl= L5.webPath + "/jsp/dll/dj_woman_ICA_0_1.fr3";
	
	try{
		receiptValue = getWomanICAPrintInfo();
		tmpOCX.PrintValue= receiptValue;
		var vs=tmpOCX.PrintComReport();
		if (vs!="0"){
			alert(tmpOCX.ErrorInfo);
		}
	}catch(e) {
		alert("请安装打印插件程序!");
	}
}

//获取女方补发结婚登记历史
function getWomanICAPrintInfo() {
	var result = "<?xml version=\"1.0\" encoding=\"GBK\" standalone=\"no\"?><MakeReport>";
	for( var i = 0; i < womanICADs.getCount(); i++) {
		var tmpRec = womanICADs.getAt(i);
		result += "<APPLY_INFO>";
		
		var c = ywlbDs.find("value", tmpRec.get("opType"), 0);
		if(c > -1)
			result += "<opType>" + ywlbDs.getAt(c).get("text") + "</opType>";
		else
			result += "<opType> </opType>";
			
		result += "<nameMan>" + tmpRec.get("nameMan") + " </nameMan>";
		
		c = -1;
		c = sflbDs.find("value", tmpRec.get("idTypeMan"), 0);
		if(c > -1)
			result += "<idTypeMan>" + sflbDs.getAt(c).get("text") + "</idTypeMan>";
		else
			result += "<idTypeMan> </idTypeMan>";
			
		c = -1;
		c = gjDs.find("value", tmpRec.get("nationMan"), 0);
		if(c > -1)
			result += "<nationMan>" + gjDs.getAt(c).get("text") + "</nationMan>";
		else
			result += "<nationMan> </nationMan>";

		result += "<birthMan>" + tmpRec.get("birthMan") + " </birthMan>";
		
		c = -1;
		c = zjlxDs.find("value", tmpRec.get("certTypeMan"), 0);
		if(c > -1)
			result += "<certTypeMan>" + zjlxDs.getAt(c).get("text") + "</certTypeMan>";
		else
			result += "<certTypeMan> </certTypeMan>";

		result += "<certNumMan>" + tmpRec.get("certNumMan") + " </certNumMan>";
		
		c = -1;
		c = mzDs.find("value", tmpRec.get("folkMan"), 0);
		if(c > -1)
			result += "<folkMan>" + mzDs.getAt(c).get("text") + "</folkMan>";
		else
			result += "<folkMan> </folkMan>";
			
		c = -1;
		c = hyzkDs.find("value", tmpRec.get("marryStatusMan"), 0);
		if(c > -1)
			result += "<marryStatusMan>" + hyzkDs.getAt(c).get("text") + "</marryStatusMan>";
		else
			result += "<marryStatusMan> </marryStatusMan>";
		
		c = -1;
		c = zyDs.find("value", tmpRec.get("jobMan"), 0);
		if(c > -1)
			result += "<jobMan>" + zyDs.getAt(c).get("text") + "</jobMan>";
		else
			result += "<jobMan> </jobMan>";
		
		c = -1;
		c = whcdDs.find("value", tmpRec.get("degreeMan"), 0);
		if(c > -1)
			result += "<degreeMan>" + whcdDs.getAt(c).get("text") + "</degreeMan>";
		else
			result += "<degreeMan> </degreeMan>";
		
		result += "<regDetailMan>" + tmpRec.get("regDetailMan") + " </regDetailMan>";
		result += "<opDate>" + tmpRec.get("opDate") + " </opDate>";
		result += "<deptName>" + tmpRec.get("deptName") + " </deptName>";
		
		c = -1;
		c = bfyyDs.find("value", tmpRec.get("redoReason"), 0);
		if(c > -1)
			result += "<redoReason>" + bfyyDs.getAt(c).get("text") + "</redoReason>";
		else
			result += "<redoReason> </redoReason>";
		
		result += "</APPLY_INFO>";
	}
	result += "</MakeReport>";
	//alert(result);
	return result;	
}

//打印女方补发离婚登记历史
function printWomanICB(){
	var tmpOCX = document.getElementById('CrjIssuedReport');
	//tmpOCX.IfPRE= true;
	//tmpOCX.IfGrid= true;
	tmpOCX.IfPreview = 1;		//设置打印是否预览。
	tmpOCX.RfrUrl= L5.webPath + "/jsp/dll/dj_woman_ICB_0_1.fr3";
	
	try{
		receiptValue = getWomanICBPrintInfo();
		tmpOCX.PrintValue= receiptValue;
		var vs=tmpOCX.PrintComReport();
		if (vs!="0"){
			alert(tmpOCX.ErrorInfo);
		}
	}catch(e) {
		alert("请安装打印插件程序!");
	}
}

//获取女方补发离婚登记历史
function getWomanICBPrintInfo() {
	var result = "<?xml version=\"1.0\" encoding=\"GBK\" standalone=\"no\"?><MakeReport>";
	for( var i = 0; i < womanICBDs.getCount(); i++) {
		var tmpRec = womanICBDs.getAt(i);
		result += "<APPLY_INFO>";
		
		var c = ywlbDs.find("value", tmpRec.get("opType"), 0);
		if(c > -1)
			result += "<opType>" + ywlbDs.getAt(c).get("text") + "</opType>";
		else
			result += "<opType> </opType>";
			
		result += "<nameMan>" + tmpRec.get("nameMan") + " </nameMan>";
		
		c = -1;
		c = sflbDs.find("value", tmpRec.get("idTypeMan"), 0);
		if(c > -1)
			result += "<idTypeMan>" + sflbDs.getAt(c).get("text") + "</idTypeMan>";
		else
			result += "<idTypeMan> </idTypeMan>";
			
		c = -1;
		c = gjDs.find("value", tmpRec.get("nationMan"), 0);
		if(c > -1)
			result += "<nationMan>" + gjDs.getAt(c).get("text") + "</nationMan>";
		else
			result += "<nationMan> </nationMan>";

		result += "<birthMan>" + tmpRec.get("birthMan") + " </birthMan>";
		
		c = -1;
		c = zjlxDs.find("value", tmpRec.get("certTypeMan"), 0);
		if(c > -1)
			result += "<certTypeMan>" + zjlxDs.getAt(c).get("text") + "</certTypeMan>";
		else
			result += "<certTypeMan> </certTypeMan>";

		result += "<certNumMan>" + tmpRec.get("certNumMan") + " </certNumMan>";
		
		c = -1;
		c = mzDs.find("value", tmpRec.get("folkMan"), 0);
		if(c > -1)
			result += "<folkMan>" + mzDs.getAt(c).get("text") + "</folkMan>";
		else
			result += "<folkMan> </folkMan>";
			
		c = -1;
		c = hyzkDs.find("value", tmpRec.get("marryStatusMan"), 0);
		if(c > -1)
			result += "<marryStatusMan>" + hyzkDs.getAt(c).get("text") + "</marryStatusMan>";
		else
			result += "<marryStatusMan> </marryStatusMan>";
		
		c = -1;
		c = zyDs.find("value", tmpRec.get("jobMan"), 0);
		if(c > -1)
			result += "<jobMan>" + zyDs.getAt(c).get("text") + "</jobMan>";
		else
			result += "<jobMan> </jobMan>";
		
		c = -1;
		c = whcdDs.find("value", tmpRec.get("degreeMan"), 0);
		if(c > -1)
			result += "<degreeMan>" + whcdDs.getAt(c).get("text") + "</degreeMan>";
		else
			result += "<degreeMan> </degreeMan>";
		
		result += "<regDetailMan>" + tmpRec.get("regDetailMan") + " </regDetailMan>";
		result += "<opDate>" + tmpRec.get("opDate") + " </opDate>";
		result += "<deptName>" + tmpRec.get("deptName") + " </deptName>";
		
		c = -1;
		c = bfyyDs.find("value", tmpRec.get("redoReason"), 0);
		if(c > -1)
			result += "<redoReason>" + bfyyDs.getAt(c).get("text") + "</redoReason>";
		else
			result += "<redoReason> </redoReason>";
		
		result += "</APPLY_INFO>";
	}
	result += "</MakeReport>";
	//alert(result);
	return result;	
}

//打印女方补办婚姻登记历史
function printWomanIC(){
	var tmpOCX = document.getElementById('CrjIssuedReport');
	//tmpOCX.IfPRE= true;
	//tmpOCX.IfGrid= true;
	tmpOCX.IfPreview = 1;		//设置打印是否预览。
	tmpOCX.RfrUrl= L5.webPath + "/jsp/dll/dj_woman_IC_0_1.fr3";
	
	try{
		receiptValue = getWomanICPrintInfo();
		tmpOCX.PrintValue= receiptValue;
		var vs=tmpOCX.PrintComReport();
		if (vs!="0"){
			alert(tmpOCX.ErrorInfo);
		}
	}catch(e) {
		alert("请安装打印插件程序!");
	}
}

//获取女方补办婚姻登记历史
function getWomanICPrintInfo() {
	var result = "<?xml version=\"1.0\" encoding=\"GBK\" standalone=\"no\"?><MakeReport>";
	for( var i = 0; i < womanICDs.getCount(); i++) {
		var tmpRec = womanICDs.getAt(i);
		result += "<APPLY_INFO>";
		
		var c = ywlbDs.find("value", tmpRec.get("opType"), 0);
		if(c > -1)
			result += "<opType>" + ywlbDs.getAt(c).get("text") + "</opType>";
		else
			result += "<opType> </opType>";
			
		result += "<nameMan>" + tmpRec.get("nameMan") + " </nameMan>";
		
		c = -1;
		c = sflbDs.find("value", tmpRec.get("idTypeMan"), 0);
		if(c > -1)
			result += "<idTypeMan>" + sflbDs.getAt(c).get("text") + "</idTypeMan>";
		else
			result += "<idTypeMan> </idTypeMan>";
			
		c = -1;
		c = gjDs.find("value", tmpRec.get("nationMan"), 0);
		if(c > -1)
			result += "<nationMan>" + gjDs.getAt(c).get("text") + "</nationMan>";
		else
			result += "<nationMan> </nationMan>";

		result += "<birthMan>" + tmpRec.get("birthMan") + " </birthMan>";
		
		c = -1;
		c = zjlxDs.find("value", tmpRec.get("certTypeMan"), 0);
		if(c > -1)
			result += "<certTypeMan>" + zjlxDs.getAt(c).get("text") + "</certTypeMan>";
		else
			result += "<certTypeMan> </certTypeMan>";

		result += "<certNumMan>" + tmpRec.get("certNumMan") + " </certNumMan>";
		
		c = -1;
		c = mzDs.find("value", tmpRec.get("folkMan"), 0);
		if(c > -1)
			result += "<folkMan>" + mzDs.getAt(c).get("text") + "</folkMan>";
		else
			result += "<folkMan> </folkMan>";
			
		c = -1;
		c = hyzkDs.find("value", tmpRec.get("marryStatusMan"), 0);
		if(c > -1)
			result += "<marryStatusMan>" + hyzkDs.getAt(c).get("text") + "</marryStatusMan>";
		else
			result += "<marryStatusMan> </marryStatusMan>";
		
		c = -1;
		c = zyDs.find("value", tmpRec.get("jobMan"), 0);
		if(c > -1)
			result += "<jobMan>" + zyDs.getAt(c).get("text") + "</jobMan>";
		else
			result += "<jobMan> </jobMan>";
		
		c = -1;
		c = whcdDs.find("value", tmpRec.get("degreeMan"), 0);
		if(c > -1)
			result += "<degreeMan>" + whcdDs.getAt(c).get("text") + "</degreeMan>";
		else
			result += "<degreeMan> </degreeMan>";
		
		result += "<regDetailMan>" + tmpRec.get("regDetailMan") + " </regDetailMan>";
		result += "<opDate>" + tmpRec.get("opDate") + " </opDate>";
		result += "<deptName>" + tmpRec.get("deptName") + " </deptName>";
		
		result += "</APPLY_INFO>";
	}
	result += "</MakeReport>";
	//alert(result);
	return result;	
}

//打印女方撤销婚姻历史
function printWomanID(){
	var tmpOCX = document.getElementById('CrjIssuedReport');
	//tmpOCX.IfPRE= true;
	//tmpOCX.IfGrid= true;
	tmpOCX.IfPreview = 1;		//设置打印是否预览。
	tmpOCX.RfrUrl= L5.webPath + "/jsp/dll/dj_woman_ID_0_1.fr3";
	
	try{
		receiptValue = getWomanIDPrintInfo();
		tmpOCX.PrintValue= receiptValue;
		var vs=tmpOCX.PrintComReport();
		if (vs!="0"){
			alert(tmpOCX.ErrorInfo);
		}
	}catch(e) {
		alert("请安装打印插件程序!");
	}
}

//获取女方撤销婚姻历史
function getWomanIDPrintInfo() {
	var result = "<?xml version=\"1.0\" encoding=\"GBK\" standalone=\"no\"?><MakeReport>";
	for( var i = 0; i < womanIDDs.getCount(); i++) {
		var tmpRec = womanIDDs.getAt(i);
		result += "<APPLY_INFO>";
		
		var c = ywlbDs.find("value", tmpRec.get("opType"), 0);
		if(c > -1)
			result += "<opType>" + ywlbDs.getAt(c).get("text") + "</opType>";
		else
			result += "<opType> </opType>";
			
		result += "<nameMan>" + tmpRec.get("nameMan") + " </nameMan>";
		
		c = -1;
		c = sflbDs.find("value", tmpRec.get("idTypeMan"), 0);
		if(c > -1)
			result += "<idTypeMan>" + sflbDs.getAt(c).get("text") + "</idTypeMan>";
		else
			result += "<idTypeMan> </idTypeMan>";
			
		c = -1;
		c = gjDs.find("value", tmpRec.get("nationMan"), 0);
		if(c > -1)
			result += "<nationMan>" + gjDs.getAt(c).get("text") + "</nationMan>";
		else
			result += "<nationMan> </nationMan>";

		result += "<birthMan>" + tmpRec.get("birthMan") + " </birthMan>";
		
		c = -1;
		c = zjlxDs.find("value", tmpRec.get("certTypeMan"), 0);
		if(c > -1)
			result += "<certTypeMan>" + zjlxDs.getAt(c).get("text") + "</certTypeMan>";
		else
			result += "<certTypeMan> </certTypeMan>";

		result += "<certNumMan>" + tmpRec.get("certNumMan") + " </certNumMan>";
		
		c = -1;
		c = mzDs.find("value", tmpRec.get("folkMan"), 0);
		if(c > -1)
			result += "<folkMan>" + mzDs.getAt(c).get("text") + "</folkMan>";
		else
			result += "<folkMan> </folkMan>";
			
		c = -1;
		c = hyzkDs.find("value", tmpRec.get("marryStatusMan"), 0);
		if(c > -1)
			result += "<marryStatusMan>" + hyzkDs.getAt(c).get("text") + "</marryStatusMan>";
		else
			result += "<marryStatusMan> </marryStatusMan>";
		
		c = -1;
		c = zyDs.find("value", tmpRec.get("jobMan"), 0);
		if(c > -1)
			result += "<jobMan>" + zyDs.getAt(c).get("text") + "</jobMan>";
		else
			result += "<jobMan> </jobMan>";
		
		c = -1;
		c = whcdDs.find("value", tmpRec.get("degreeMan"), 0);
		if(c > -1)
			result += "<degreeMan>" + whcdDs.getAt(c).get("text") + "</degreeMan>";
		else
			result += "<degreeMan> </degreeMan>";
		
		result += "<regDetailMan>" + tmpRec.get("regDetailMan") + " </regDetailMan>";
		result += "<opDate>" + tmpRec.get("opDate") + " </opDate>";
		result += "<deptName>" + tmpRec.get("deptName") + " </deptName>";
		result += "<cancelProof>" + tmpRec.get("cancelProof") + " </cancelProof>";
		
		result += "</APPLY_INFO>";
	}
	result += "</MakeReport>";
	//alert(result);
	return result;	
}


//打印男方婚史
function printManIAB(){
	var tmpOCX = document.getElementById('CrjIssuedReport');
	//tmpOCX.IfPRE= true;
	//tmpOCX.IfGrid= true;
	tmpOCX.IfPreview = 1;		//设置打印是否预览。
	tmpOCX.RfrUrl= L5.webPath + "/jsp/dll/dj_man_IAB_0_1.fr3";
	
	try{
		receiptValue = getManIABPrintInfo();
		tmpOCX.PrintValue= receiptValue;
		var vs=tmpOCX.PrintComReport();
		if (vs!="0"){
			alert(tmpOCX.ErrorInfo);
		}
	}catch(e) {
		alert("请安装打印插件程序!");
	}
}

//获取男方婚史信息
function getManIABPrintInfo() {
	var result = "<?xml version=\"1.0\" encoding=\"GBK\" standalone=\"no\"?><MakeReport>";
	for( var i = 0; i < manIABDs.getCount(); i++) {
		var tmpRec = manIABDs.getAt(i);
		result += "<APPLY_INFO>";
		
		var c = ywlbDs.find("value", tmpRec.get("opType"), 0);
		if(c > -1)
			result += "<opType>" + ywlbDs.getAt(c).get("text") + "</opType>";
		else
			result += "<opType> </opType>";
			
		result += "<nameWoman>" + tmpRec.get("nameWoman") + " </nameWoman>";
		
		c = -1;
		c = sflbDs.find("value", tmpRec.get("idTypeWoman"), 0);
		if(c > -1)
			result += "<idTypeWoman>" + sflbDs.getAt(c).get("text") + "</idTypeWoman>";
		else
			result += "<idTypeWoman> </idTypeWoman>";
			
		c = -1;
		c = gjDs.find("value", tmpRec.get("nationWoman"), 0);
		if(c > -1)
			result += "<nationWoman>" + gjDs.getAt(c).get("text") + "</nationWoman>";
		else
			result += "<nationWoman> </nationWoman>";

		result += "<birthWoman>" + tmpRec.get("birthWoman") + " </birthWoman>";
		
		c = -1;
		c = zjlxDs.find("value", tmpRec.get("certTypeWoman"), 0);
		if(c > -1)
			result += "<certTypeWoman>" + zjlxDs.getAt(c).get("text") + "</certTypeWoman>";
		else
			result += "<certTypeWoman> </certTypeWoman>";

		result += "<certNumWoman>" + tmpRec.get("certNumWoman") + " </certNumWoman>";
		
		c = -1;
		c = mzDs.find("value", tmpRec.get("folkWoman"), 0);
		if(c > -1)
			result += "<folkWoman>" + mzDs.getAt(c).get("text") + "</folkWoman>";
		else
			result += "<folkWoman> </folkWoman>";
			
		c = -1;
		c = hyzkDs.find("value", tmpRec.get("marryStatusWoman"), 0);
		if(c > -1)
			result += "<marryStatusWoman>" + hyzkDs.getAt(c).get("text") + "</marryStatusWoman>";
		else
			result += "<marryStatusWoman> </marryStatusWoman>";
		
		c = -1;
		c = zyDs.find("value", tmpRec.get("jobWoman"), 0);
		if(c > -1)
			result += "<jobWoman>" + zyDs.getAt(c).get("text") + "</jobWoman>";
		else
			result += "<jobWoman> </jobWoman>";
		
		c = -1;
		c = whcdDs.find("value", tmpRec.get("degreeWoman"), 0);
		if(c > -1)
			result += "<degreeWoman>" + whcdDs.getAt(c).get("text") + "</degreeWoman>";
		else
			result += "<degreeWoman> </degreeWoman>";
		
		result += "<regDetailWoman>" + tmpRec.get("regDetailWoman") + " </regDetailWoman>";
		result += "<opDate>" + tmpRec.get("opDate") + " </opDate>";
		result += "<deptName>" + tmpRec.get("deptName") + " </deptName>";
		
		result += "</APPLY_INFO>";
	}
	result += "</MakeReport>";
	//alert(result);
	return result;	
}


//打印男方补发结婚登记历史
function printManICA(){
	var tmpOCX = document.getElementById('CrjIssuedReport');
	//tmpOCX.IfPRE= true;
	//tmpOCX.IfGrid= true;
	tmpOCX.IfPreview = 1;		//设置打印是否预览。
	tmpOCX.RfrUrl= L5.webPath + "/jsp/dll/dj_man_ICA_0_1.fr3";
	
	try{
		receiptValue = getManICAPrintInfo();
		tmpOCX.PrintValue= receiptValue;
		var vs=tmpOCX.PrintComReport();
		if (vs!="0"){
			alert(tmpOCX.ErrorInfo);
		}
	}catch(e) {
		alert("请安装打印插件程序!");
	}
}

//获取男方补发结婚登记历史
function getManICAPrintInfo() {
	var result = "<?xml version=\"1.0\" encoding=\"GBK\" standalone=\"no\"?><MakeReport>";
	for( var i = 0; i < manICADs.getCount(); i++) {
		var tmpRec = manICADs.getAt(i);
		result += "<APPLY_INFO>";
		
		var c = ywlbDs.find("value", tmpRec.get("opType"), 0);
		if(c > -1)
			result += "<opType>" + ywlbDs.getAt(c).get("text") + "</opType>";
		else
			result += "<opType> </opType>";
			
		result += "<nameWoman>" + tmpRec.get("nameWoman") + " </nameWoman>";
		
		c = -1;
		c = sflbDs.find("value", tmpRec.get("idTypeWoman"), 0);
		if(c > -1)
			result += "<idTypeWoman>" + sflbDs.getAt(c).get("text") + "</idTypeWoman>";
		else
			result += "<idTypeWoman> </idTypeWoman>";
			
		c = -1;
		c = gjDs.find("value", tmpRec.get("nationWoman"), 0);
		if(c > -1)
			result += "<nationWoman>" + gjDs.getAt(c).get("text") + "</nationWoman>";
		else
			result += "<nationWoman> </nationWoman>";

		result += "<birthWoman>" + tmpRec.get("birthWoman") + " </birthWoman>";
		
		c = -1;
		c = zjlxDs.find("value", tmpRec.get("certTypeWoman"), 0);
		if(c > -1)
			result += "<certTypeWoman>" + zjlxDs.getAt(c).get("text") + "</certTypeWoman>";
		else
			result += "<certTypeWoman> </certTypeWoman>";

		result += "<certNumWoman>" + tmpRec.get("certNumWoman") + " </certNumWoman>";
		
		c = -1;
		c = mzDs.find("value", tmpRec.get("folkWoman"), 0);
		if(c > -1)
			result += "<folkWoman>" + mzDs.getAt(c).get("text") + "</folkWoman>";
		else
			result += "<folkWoman> </folkWoman>";
			
		c = -1;
		c = hyzkDs.find("value", tmpRec.get("marryStatusWoman"), 0);
		if(c > -1)
			result += "<marryStatusWoman>" + hyzkDs.getAt(c).get("text") + "</marryStatusWoman>";
		else
			result += "<marryStatusWoman> </marryStatusWoman>";
		
		c = -1;
		c = zyDs.find("value", tmpRec.get("jobWoman"), 0);
		if(c > -1)
			result += "<jobWoman>" + zyDs.getAt(c).get("text") + "</jobWoman>";
		else
			result += "<jobWoman> </jobWoman>";
		
		c = -1;
		c = whcdDs.find("value", tmpRec.get("degreeWoman"), 0);
		if(c > -1)
			result += "<degreeWoman>" + whcdDs.getAt(c).get("text") + "</degreeWoman>";
		else
			result += "<degreeWoman> </degreeWoman>";
		
		result += "<regDetailWoman>" + tmpRec.get("regDetailWoman") + " </regDetailWoman>";
		result += "<opDate>" + tmpRec.get("opDate") + " </opDate>";
		result += "<deptName>" + tmpRec.get("deptName") + " </deptName>";
		
		c = -1;
		c = bfyyDs.find("value", tmpRec.get("redoReason"), 0);
		if(c > -1)
			result += "<redoReason>" + bfyyDs.getAt(c).get("text") + "</redoReason>";
		else
			result += "<redoReason> </redoReason>";
		
		result += "</APPLY_INFO>";
	}
	result += "</MakeReport>";
	//alert(result);
	return result;	
}

//打印男方补发离婚登记历史
function printManICB(){
	var tmpOCX = document.getElementById('CrjIssuedReport');
	//tmpOCX.IfPRE= true;
	//tmpOCX.IfGrid= true;
	tmpOCX.IfPreview = 1;		//设置打印是否预览。
	tmpOCX.RfrUrl= L5.webPath + "/jsp/dll/dj_man_ICB_0_1.fr3";
	
	try{
		receiptValue = getManICBPrintInfo();
		tmpOCX.PrintValue= receiptValue;
		var vs=tmpOCX.PrintComReport();
		if (vs!="0"){
			alert(tmpOCX.ErrorInfo);
		}
	}catch(e) {
		alert("请安装打印插件程序!");
	}
}

//获取男方补发离婚登记历史
function getManICBPrintInfo() {
	var result = "<?xml version=\"1.0\" encoding=\"GBK\" standalone=\"no\"?><MakeReport>";
	for( var i = 0; i < manICBDs.getCount(); i++) {
		var tmpRec = manICBDs.getAt(i);
		result += "<APPLY_INFO>";
		
		var c = ywlbDs.find("value", tmpRec.get("opType"), 0);
		if(c > -1)
			result += "<opType>" + ywlbDs.getAt(c).get("text") + "</opType>";
		else
			result += "<opType> </opType>";
			
		result += "<nameWoman>" + tmpRec.get("nameWoman") + " </nameWoman>";
		
		c = -1;
		c = sflbDs.find("value", tmpRec.get("idTypeWoman"), 0);
		if(c > -1)
			result += "<idTypeWoman>" + sflbDs.getAt(c).get("text") + "</idTypeWoman>";
		else
			result += "<idTypeWoman> </idTypeWoman>";
			
		c = -1;
		c = gjDs.find("value", tmpRec.get("nationWoman"), 0);
		if(c > -1)
			result += "<nationWoman>" + gjDs.getAt(c).get("text") + "</nationWoman>";
		else
			result += "<nationWoman> </nationWoman>";

		result += "<birthWoman>" + tmpRec.get("birthWoman") + " </birthWoman>";
		
		c = -1;
		c = zjlxDs.find("value", tmpRec.get("certTypeWoman"), 0);
		if(c > -1)
			result += "<certTypeWoman>" + zjlxDs.getAt(c).get("text") + "</certTypeWoman>";
		else
			result += "<certTypeWoman> </certTypeWoman>";

		result += "<certNumWoman>" + tmpRec.get("certNumWoman") + " </certNumWoman>";
		
		c = -1;
		c = mzDs.find("value", tmpRec.get("folkWoman"), 0);
		if(c > -1)
			result += "<folkWoman>" + mzDs.getAt(c).get("text") + "</folkWoman>";
		else
			result += "<folkWoman> </folkWoman>";
			
		c = -1;
		c = hyzkDs.find("value", tmpRec.get("marryStatusWoman"), 0);
		if(c > -1)
			result += "<marryStatusWoman>" + hyzkDs.getAt(c).get("text") + "</marryStatusWoman>";
		else
			result += "<marryStatusWoman> </marryStatusWoman>";
		
		c = -1;
		c = zyDs.find("value", tmpRec.get("jobWoman"), 0);
		if(c > -1)
			result += "<jobWoman>" + zyDs.getAt(c).get("text") + "</jobWoman>";
		else
			result += "<jobWoman> </jobWoman>";
		
		c = -1;
		c = whcdDs.find("value", tmpRec.get("degreeWoman"), 0);
		if(c > -1)
			result += "<degreeWoman>" + whcdDs.getAt(c).get("text") + "</degreeWoman>";
		else
			result += "<degreeWoman> </degreeWoman>";
		
		result += "<regDetailWoman>" + tmpRec.get("regDetailWoman") + " </regDetailWoman>";
		result += "<opDate>" + tmpRec.get("opDate") + " </opDate>";
		result += "<deptName>" + tmpRec.get("deptName") + " </deptName>";
		
		c = -1;
		c = bfyyDs.find("value", tmpRec.get("redoReason"), 0);
		if(c > -1)
			result += "<redoReason>" + bfyyDs.getAt(c).get("text") + "</redoReason>";
		else
			result += "<redoReason> </redoReason>";
		
		result += "</APPLY_INFO>";
	}
	result += "</MakeReport>";
	//alert(result);
	return result;	
}

//打印男方补办婚姻登记历史
function printManIC(){
	var tmpOCX = document.getElementById('CrjIssuedReport');
	//tmpOCX.IfPRE= true;
	//tmpOCX.IfGrid= true;
	tmpOCX.IfPreview = 1;		//设置打印是否预览。
	tmpOCX.RfrUrl= L5.webPath + "/jsp/dll/dj_man_IC_0_1.fr3";
	
	try{
		receiptValue = getManICPrintInfo();
		tmpOCX.PrintValue= receiptValue;
		var vs=tmpOCX.PrintComReport();
		if (vs!="0"){
			alert(tmpOCX.ErrorInfo);
		}
	}catch(e) {
		alert("请安装打印插件程序!");
	}
}

//获取男方补办婚姻登记历史
function getManICPrintInfo() {
	var result = "<?xml version=\"1.0\" encoding=\"GBK\" standalone=\"no\"?><MakeReport>";
	for( var i = 0; i < manICDs.getCount(); i++) {
		var tmpRec = manICDs.getAt(i);
		result += "<APPLY_INFO>";
		
		var c = ywlbDs.find("value", tmpRec.get("opType"), 0);
		if(c > -1)
			result += "<opType>" + ywlbDs.getAt(c).get("text") + "</opType>";
		else
			result += "<opType> </opType>";
			
		result += "<nameWoman>" + tmpRec.get("nameWoman") + " </nameWoman>";
		
		c = -1;
		c = sflbDs.find("value", tmpRec.get("idTypeWoman"), 0);
		if(c > -1)
			result += "<idTypeWoman>" + sflbDs.getAt(c).get("text") + "</idTypeWoman>";
		else
			result += "<idTypeWoman> </idTypeWoman>";
			
		c = -1;
		c = gjDs.find("value", tmpRec.get("nationWoman"), 0);
		if(c > -1)
			result += "<nationWoman>" + gjDs.getAt(c).get("text") + "</nationWoman>";
		else
			result += "<nationWoman> </nationWoman>";

		result += "<birthWoman>" + tmpRec.get("birthWoman") + " </birthWoman>";
		
		c = -1;
		c = zjlxDs.find("value", tmpRec.get("certTypeWoman"), 0);
		if(c > -1)
			result += "<certTypeWoman>" + zjlxDs.getAt(c).get("text") + "</certTypeWoman>";
		else
			result += "<certTypeWoman> </certTypeWoman>";

		result += "<certNumWoman>" + tmpRec.get("certNumWoman") + " </certNumWoman>";
		
		c = -1;
		c = mzDs.find("value", tmpRec.get("folkWoman"), 0);
		if(c > -1)
			result += "<folkWoman>" + mzDs.getAt(c).get("text") + "</folkWoman>";
		else
			result += "<folkWoman> </folkWoman>";
			
		c = -1;
		c = hyzkDs.find("value", tmpRec.get("marryStatusWoman"), 0);
		if(c > -1)
			result += "<marryStatusWoman>" + hyzkDs.getAt(c).get("text") + "</marryStatusWoman>";
		else
			result += "<marryStatusWoman> </marryStatusWoman>";
		
		c = -1;
		c = zyDs.find("value", tmpRec.get("jobWoman"), 0);
		if(c > -1)
			result += "<jobWoman>" + zyDs.getAt(c).get("text") + "</jobWoman>";
		else
			result += "<jobWoman> </jobWoman>";
		
		c = -1;
		c = whcdDs.find("value", tmpRec.get("degreeWoman"), 0);
		if(c > -1)
			result += "<degreeWoman>" + whcdDs.getAt(c).get("text") + "</degreeWoman>";
		else
			result += "<degreeWoman> </degreeWoman>";
		
		result += "<regDetailWoman>" + tmpRec.get("regDetailWoman") + " </regDetailWoman>";
		result += "<opDate>" + tmpRec.get("opDate") + " </opDate>";
		result += "<deptName>" + tmpRec.get("deptName") + " </deptName>";
		
		result += "</APPLY_INFO>";
	}
	result += "</MakeReport>";
	//alert(result);
	return result;	
}

//打印男方撤销婚姻历史
function printManID(){
	var tmpOCX = document.getElementById('CrjIssuedReport');
	//tmpOCX.IfPRE= true;
	//tmpOCX.IfGrid= true;
	tmpOCX.IfPreview = 1;		//设置打印是否预览。
	tmpOCX.RfrUrl= L5.webPath + "/jsp/dll/dj_man_ID_0_1.fr3";
	
	try{
		receiptValue = getManIDPrintInfo();
		tmpOCX.PrintValue= receiptValue;
		var vs=tmpOCX.PrintComReport();
		if (vs!="0"){
			alert(tmpOCX.ErrorInfo);
		}
	}catch(e) {
		alert("请安装打印插件程序!");
	}
}

//获取男方撤销婚姻历史
function getManIDPrintInfo() {
	var result = "<?xml version=\"1.0\" encoding=\"GBK\" standalone=\"no\"?><MakeReport>";
	for( var i = 0; i < manIDDs.getCount(); i++) {
		var tmpRec = manIDDs.getAt(i);
		result += "<APPLY_INFO>";
		
		var c = ywlbDs.find("value", tmpRec.get("opType"), 0);
		if(c > -1)
			result += "<opType>" + ywlbDs.getAt(c).get("text") + "</opType>";
		else
			result += "<opType> </opType>";
			
		result += "<nameWoman>" + tmpRec.get("nameWoman") + " </nameWoman>";
		
		c = -1;
		c = sflbDs.find("value", tmpRec.get("idTypeWoman"), 0);
		if(c > -1)
			result += "<idTypeWoman>" + sflbDs.getAt(c).get("text") + "</idTypeWoman>";
		else
			result += "<idTypeWoman> </idTypeWoman>";
			
		c = -1;
		c = gjDs.find("value", tmpRec.get("nationWoman"), 0);
		if(c > -1)
			result += "<nationWoman>" + gjDs.getAt(c).get("text") + "</nationWoman>";
		else
			result += "<nationWoman> </nationWoman>";

		result += "<birthWoman>" + tmpRec.get("birthWoman") + " </birthWoman>";
		
		c = -1;
		c = zjlxDs.find("value", tmpRec.get("certTypeWoman"), 0);
		if(c > -1)
			result += "<certTypeWoman>" + zjlxDs.getAt(c).get("text") + "</certTypeWoman>";
		else
			result += "<certTypeWoman> </certTypeWoman>";

		result += "<certNumWoman>" + tmpRec.get("certNumWoman") + " </certNumWoman>";
		
		c = -1;
		c = mzDs.find("value", tmpRec.get("folkWoman"), 0);
		if(c > -1)
			result += "<folkWoman>" + mzDs.getAt(c).get("text") + "</folkWoman>";
		else
			result += "<folkWoman> </folkWoman>";
			
		c = -1;
		c = hyzkDs.find("value", tmpRec.get("marryStatusWoman"), 0);
		if(c > -1)
			result += "<marryStatusWoman>" + hyzkDs.getAt(c).get("text") + "</marryStatusWoman>";
		else
			result += "<marryStatusWoman> </marryStatusWoman>";
		
		c = -1;
		c = zyDs.find("value", tmpRec.get("jobWoman"), 0);
		if(c > -1)
			result += "<jobWoman>" + zyDs.getAt(c).get("text") + "</jobWoman>";
		else
			result += "<jobWoman> </jobWoman>";
		
		c = -1;
		c = whcdDs.find("value", tmpRec.get("degreeWoman"), 0);
		if(c > -1)
			result += "<degreeWoman>" + whcdDs.getAt(c).get("text") + "</degreeWoman>";
		else
			result += "<degreeWoman> </degreeWoman>";
		
		result += "<regDetailWoman>" + tmpRec.get("regDetailWoman") + " </regDetailWoman>";
		result += "<opDate>" + tmpRec.get("opDate") + " </opDate>";
		result += "<deptName>" + tmpRec.get("deptName") + " </deptName>";
		result += "<cancelProof>" + tmpRec.get("cancelProof") + " </cancelProof>";
		
		result += "</APPLY_INFO>";
	}
	result += "</MakeReport>";
	//alert(result);
	return result;	
}



