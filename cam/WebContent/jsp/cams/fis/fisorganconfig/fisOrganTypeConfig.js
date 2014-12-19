var fisFuneralCode;
var fisCemeCode;
var funeralOrganCode;
function init(){
	var fisOrganTypeConfig = L5.DatasetMgr.lookup("fisOrganTypeConfig");
	if(method=="insert"){     
	    fisOrganTypeConfig.newRecord();
	}
	if(method=="update"){
		var fisOrganTypeConfig = L5.DatasetMgr.lookup("fisOrganTypeConfig");
		      fisOrganTypeConfig.setParameter("CONFIG_ID@=",configIdOld);
		      fisOrganTypeConfig.load(true);
		      funeralOrganCode= fisOrganTypeConfig.get("funeralOrgan");
	}
    if(method=="detail"){
		var fisOrganTypeConfig = L5.DatasetMgr.lookup("fisOrganTypeConfig");
	      fisOrganTypeConfig.setParameter("CONFIG_ID@=",configIdDet);
	      fisOrganTypeConfig.load(true);
	      document.getElementById("funeralOrgan").value=fisOrganTypeConfig.get("funeralOrgan");
	      document.getElementById("funeralOrganName").value=fisOrganTypeConfig.get("funeralOrganName");
	      document.getElementById("cemeteryOrgan").value=fisOrganTypeConfig.get("cemeteryOrgan");
	      document.getElementById("cemeteryOrganName").value=fisOrganTypeConfig.get("cemeteryOrganName");
	      document.getElementById("configTime").value=fisOrganTypeConfig.get("configTime");
    }
}

function saveCemeFuneralInfo(){
	var fisOrganTypeConfig = L5.DatasetMgr.lookup("fisOrganTypeConfig");
    var fisOrganTypeConfigRecord=fisOrganTypeConfig.getCurrent();
    var cmd=new L5.Command("com.inspur.cams.fis.base.cmd.FisOrganTypeConfigCmd");
		    if(method=="insert"){
				    fisOrganTypeConfigRecord.set("configId",configId);
		    }
		    if(method=="update"){
			    fisOrganTypeConfigRecord.set("configId",configIdOld);
		    }
            fisOrganTypeConfigRecord.set("configTime",time);
		    fisOrganTypeConfigRecord.set("funeralOrgan",fisOrganTypeConfigRecord.get("funeralOrgan"));
		    fisOrganTypeConfigRecord.set("funeralOrganName",fisOrganTypeConfigRecord.get("funeralOrganName"));
		    fisOrganTypeConfigRecord.set("cemeteryOrgan",fisOrganTypeConfigRecord.get("cemeteryOrgan"));
		    fisOrganTypeConfigRecord.set("cemeteryOrganName",fisOrganTypeConfigRecord.get("cemeteryOrganName"));
          cmd.setParameter("record",fisOrganTypeConfigRecord);
          if(method=="insert"){
          cmd.execute("insert");
          }
          if(method=="update"){
        	  cmd.execute("update");
          }
			if (!cmd.error){
				L5.Msg.alert("提示","保存成功！");
				window.location="fisOrganTypeConfigList.jsp";
			    }else{
				L5.Msg.alert("提示","保存出错！"+cmd.error);
			        }
}

function getFuneralInfo(){
	if(method=="insert"){
	var reValue = openFuneralChoose();
	if (reValue != "" && reValue != undefined) {
		var arrs = reValue.split(",");
			fisFuneralCode=arrs[0].substring(2,6);
		var fisOrganTypeConfig = L5.DatasetMgr.lookup("fisOrganTypeConfig");
		fisOrganTypeConfig.set("funeralOrgan",arrs[0]);
        /*document.getElementById("funeralOrgan").innerHTML=arrs[0];
        document.getElementById("funeralOrganName").innerHTML=arrs[1];*/
        fisOrganTypeConfig.set("funeralOrganName",arrs[1]);
	}
	}
	
	if(method=="update"){
		fisFuneralCode=funeralOrganCode.substring(2,6);
		var reValue = openFuneralChoose();
		if (reValue != "" && reValue != undefined) {
			var arrs = reValue.split(",");
			var fisOrganTypeConfig = L5.DatasetMgr.lookup("fisOrganTypeConfig");
			fisOrganTypeConfig.set("funeralOrgan",arrs[0]);
	        /*document.getElementById("funeralOrgan").innerHTML=arrs[0];
	        document.getElementById("funeralOrganName").innerHTML=arrs[1];*/
	        fisOrganTypeConfig.set("funeralOrganName",arrs[1]);
		}
	}
}
//点击选择公墓后加载
function getCemeInfo(){
	if(method=="update"){
		fisCemeCode=funeralOrganCode.substring(2,6);
		var reValue = openCemeChoose();
		if (reValue != "" && reValue != undefined) {
			var arrs = reValue.split(",");
			//arrs[2] 为公墓记录编码
			var fisOrganTypeConfig = L5.DatasetMgr.lookup("fisOrganTypeConfig");
			fisOrganTypeConfig.set("cemeteryOrgan",arrs[0]);
	        fisOrganTypeConfig.set("cemeteryOrganName",arrs[1]);
	       /* document.getElementById("cemeteryOrgan").innerHTML=arrs[0];
	        document.getElementById("cemeteryOrganName").innerHTML=arrs[1];*/
		}
	}
	if(method=="insert"){
		var reValue = openCemeChoose();
		if (reValue != "" && reValue != undefined) {
			var arrs = reValue.split(",");
			//arrs[2] 为公墓记录编码
				fisCemeCode=arrs[0].substring(2,6);
			var fisOrganTypeConfig = L5.DatasetMgr.lookup("fisOrganTypeConfig");
			fisOrganTypeConfig.set("cemeteryOrgan",arrs[0]);
	        fisOrganTypeConfig.set("cemeteryOrganName",arrs[1]);
	       /* document.getElementById("cemeteryOrgan").innerHTML=arrs[0];
	        document.getElementById("cemeteryOrganName").innerHTML=arrs[1];*/
		}
	}
	
}
function openCemeChoose(){
	if(method=="insert"){
	return window.showModalDialog("../fisorganconfig/fisCemeInfo.jsp?fisCemeCodeRec="+fisFuneralCode, "","dialogHeight:400px;dialogWidth:400px;resizable:yes;scroll:yes;status:no;");
	}
	if(method=="update"){
		return window.showModalDialog("../fisorganconfig/fisCemeInfo.jsp?fisCemeCodeRec="+fisCemeCode, "","dialogHeight:400px;dialogWidth:400px;resizable:yes;scroll:yes;status:no;");
	}
}

function openFuneralChoose(){
	if(method=="insert"){
	return window.showModalDialog("../fisorganconfig/fisFuneralInfo.jsp?fisFuneralCodeRec="+fisCemeCode, "","dialogHeight:400px;dialogWidth:400px;resizable:yes;scroll:yes;status:no;");
	}
	if(method=="update"){
		return window.showModalDialog("../fisorganconfig/fisFuneralInfo.jsp?fisFuneralCodeRec="+fisFuneralCode, "","dialogHeight:400px;dialogWidth:400px;resizable:yes;scroll:yes;status:no;");
	}
}

function click_back(){
	window.location="fisOrganTypeConfigList.jsp";
}