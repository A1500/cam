  var birthDate="";
  var certificate="";
  var cultureCertificate="";
  var bzyzgzh="";
  var firstCard="";
  var culture="";
  var foreignLanguage="";
  var duty="";
  var kind="";
  var marryStartDate="";
  var name="";
  var nation="";
  var photo="";
  var certificateId="";
  var djyccfzsj="";
  var registorCertificate="";
  var sex="";
  var trainRecord="";
  var deptName="";
  var webObj;
  var activeDocument;
  var marksNames;

function init(){
	var nowFileName ="/jsp/cams/marry/person/print/mrmBasePerson.doc";
	webObj = document.getElementById("webOfficeNt");
	webObj.Titlebar = false;
	webObj.OpenFromURL(L5.webPath+nowFileName);
	activeDocument = webObj.activeDocument;
	activeDocument.Application.ActiveWindow.View.ShowBookmarks = false;
	var showMap=new L5.Map("java.util.HashMap");
	var ds=L5.DatasetMgr.lookup("ds");
	ds.setParameter("PERSON_ID",personId);
	ds.load();
	ds.on('load',function(){
		getMarks();
		showMap.put("name",ds.get("name"));
		showMap.put("sex",ds.get("sex"));
		showMap.put("birthDate",ds.get("birthDate"));
		showMap.put("culture",ds.get("culture"));
		showMap.put("marryStartDate",ds.get("marryStartDate"));
		showMap.put("deptName",ds.get("deptName"));
		showMap.put("duty",ds.get("duty"));
		showMap.put("certificateId",ds.get("certificateId"));
		showMap.put("djyccfzsj",ds.get("djyccfzsj"));
		showMap.put("bzyzgzh",ds.get("bzyzgzh"));
		showMap.put("firstCard",ds.get("firstcard"));
		switch(ds.get("sex")){
     	  case "1" : showMap.put("sex","男"); break;
     	  case "2" : showMap.put("sex","女"); break;
	    }
		switch(ds.get("culture")){
		    case "10": showMap.put("culture","研究生"); break;
		    case "20": showMap.put("culture","大学本科"); break;
		    case "30": showMap.put("culture","大学专科和专科学校"); break;
		    case "40": showMap.put("culture","中等专业学校或中等技术学校"); break;
		    case "50": showMap.put("culture","技工学校"); break;
		    case "60": showMap.put("culture","高中"); break;
		    case "70": showMap.put("culture","初中"); break;
		    case "80": showMap.put("culture","小学"); break;
		    case "90": showMap.put("culture","文盲或半文盲"); break;
		}
		switch(ds.get("kind")){
		   case "01":  showMap.put("kind","公务员"); break;
		   case "02":  showMap.put("kind","全额事业编"); break;
		   case "03":  showMap.put("kind","参公管理事业编"); break;
		}
		var mrmElectronicDataSet=L5.DatasetMgr.lookup("mrmElectronicDataSet");
		mrmElectronicDataSet.setParameter("applyId",personId);
		mrmElectronicDataSet.load();
		mrmElectronicDataSet.on('load',function(){
			for(var i=0;i<mrmElectronicDataSet.getCount();i++){
				var record=mrmElectronicDataSet.getCurrent();
				var electronicId=record.get("electronicId");
				if(record.get("catalogCode")=='8a898b8b3c197c54013c197d0de30002'){
					writeTR(electronicId);
					mrmElectronicDataSet.moveNext();
				}else if(record.get("catalogCode")=='8a898b8b3c197c54013c197c54b70000'){
					writeCC(electronicId);
					mrmElectronicDataSet.moveNext();
				}else if(record.get("catalogCode")=='8a898b8b3c197c54013c197cbabb0001'){
					writeRC(electronicId);
					mrmElectronicDataSet.moveNext();
				}else if(record.get("catalogCode")=='8a898b8b3c197c54013c197d5cc80003'){
					writeFL(electronicId);
					mrmElectronicDataSet.moveNext();
				}else{
					writeC(electronicId);
					mrmElectronicDataSet.moveNext();
				}
			}
		});
		var NationDataset =L5.DatasetMgr.lookup("NationDataset");
		NationDataset.setParameter("CODE",ds.get("nation"));
		NationDataset.load();
		NationDataset.on('load',function(){
			showMap.put("nation",NationDataset.get("text"));
		writeDoc(showMap);
	});
	});	
}
  
function writeDoc(mp){
	//遍历map的值
	for(var key in mp.map)
	{
		//分割标签
		var marks=marksNames.split("&");
		
		//遍历所有标签
		for(var i=0;i<marks.length;i++)
		{
				//分离标签和标记
				var marksStr = marks[i].split("__");
				//标签和预含义标签相等的场合
				if(marksStr[0]==key)
				{
					//获取标签值
		  			var bkmkObj = activeDocument.Bookmarks(marks[i]);
					//向模板中写数据
					if(bkmkObj)
					{
						var inputValue = mp.get(key);						
						var saverange = bkmkObj.Range;
						saverange.Text = inputValue;
						//saverange.InsertBefore(""); //之前写内容
					}		  			

			    }
		}
	
	}
	var marks = marksNames.split("&");
	for (var i = 0; i < marks.length; i++) {
		var marksStr = marks[i].split("__");
		var bkmkObj = activeDocument.Bookmarks(marks[i]);
		if (bkmkObj) {
			if (marksStr[0] == "photo") {
				try {
					var photoId=ds.get("photo");
					var src = rootPath+"download?table=COM_PHOTO_" + photoId.substring(0, 6)+ "&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='" + photoId + "'";
					if (src != "" && src != null && photoId != null && photoId != '') {
						webObj.ActiveDocument.Application.Selection.GoTo(-1, 0, 0, bkmkObj);
						webObj.AddPicFromURL(src, false, 0, 0, 1, 100, 0);
					}
				} catch (e) {
				}
			}

		}
	}
}
function writeCC(electronicId){
	var marks = marksNames.split("&");
	for (var i = 0; i < marks.length; i++) {
		var marksStr = marks[i].split("__");
		var bkmkObj = activeDocument.Bookmarks(marks[i]);
		if (bkmkObj) {
			if(marksStr[0]=="cultureCertificate"){
				try {
					var src = rootPath+"download?table=MRM_ELECTRONIC&column=FILES&pk=ELECTRONIC_ID&ELECTRONIC_ID='"+electronicId+"'";
					if (src != "" && src != null) {
						webObj.ActiveDocument.Application.Selection.GoTo(-1, 0, 0, bkmkObj);
						webObj.AddPicFromURL(src, false, 0, 0, 1, 100, 0);
					}
				} catch (e) {
				}
			}
		}
	}
}

function writeC(electronicId){
	var marks = marksNames.split("&");
	for (var i = 0; i < marks.length; i++) {
		var marksStr = marks[i].split("__");
		var bkmkObj = activeDocument.Bookmarks(marks[i]);
		if (bkmkObj) {
			if(marksStr[0]=="certificate"){
				try {
					var src = rootPath+"download?table=MRM_ELECTRONIC&column=FILES&pk=ELECTRONIC_ID&ELECTRONIC_ID='"+electronicId+"'";
					if (src != "" && src != null) {
						webObj.ActiveDocument.Application.Selection.GoTo(-1, 0, 0, bkmkObj);
						webObj.AddPicFromURL(src, false, 0, 0, 1, 100, 0);
					}
				} catch (e) {
				}
			}
		}
	}
}


function writeTR(electronicId){
	var marks = marksNames.split("&");
	for (var i = 0; i < marks.length; i++) {
		var marksStr = marks[i].split("__");
		var bkmkObj = activeDocument.Bookmarks(marks[i]);
		if (bkmkObj) {
			if(marksStr[0]=="trainRecord"){
				try {
					var src = rootPath+"download?table=MRM_ELECTRONIC&column=FILES&pk=ELECTRONIC_ID&ELECTRONIC_ID='"+electronicId+"'";
					if (src != "" && src != null) {
						webObj.ActiveDocument.Application.Selection.GoTo(-1, 0, 0, bkmkObj);
						webObj.AddPicFromURL(src, false, 0, 0, 1, 100, 0);
					}
				} catch (e) {
				}
			}
		}
	}
}

function writeFL(electronicId){
	var marks = marksNames.split("&");
	for (var i = 0; i < marks.length; i++) {
		var marksStr = marks[i].split("__");
		var bkmkObj = activeDocument.Bookmarks(marks[i]);
		if (bkmkObj) {
			if(marksStr[0]=="foreignLanguage"){
				try {
					var src = rootPath+"download?table=MRM_ELECTRONIC&column=FILES&pk=ELECTRONIC_ID&ELECTRONIC_ID='"+electronicId+"'";
					if (src != "" && src != null) {
						webObj.ActiveDocument.Application.Selection.GoTo(-1, 0, 0, bkmkObj);
						webObj.AddPicFromURL(src, false, 0, 0, 1, 100, 0);
					}
				} catch (e) {
				}
			}
		}
	}
}

function writeRC(electronicId){
	var marks = marksNames.split("&");
	for (var i = 0; i < marks.length; i++) {
		var marksStr = marks[i].split("__");
		var bkmkObj = activeDocument.Bookmarks(marks[i]);
		if (bkmkObj) {
			if(marksStr[0]=="registorCertificate"){
				try {
					var src = rootPath+"download?table=MRM_ELECTRONIC&column=FILES&pk=ELECTRONIC_ID&ELECTRONIC_ID='"+electronicId+"'";
					if (src != "" && src != null) {
						webObj.ActiveDocument.Application.Selection.GoTo(-1, 0, 0, bkmkObj);
						webObj.AddPicFromURL(src, false, 0, 0, 1, 100, 0);
					}
				} catch (e) {
				}
			}
		}
	}
}



//function loadPhoto(photoId) {
//	var src = "table=COM_PHOTO_" + photoId.substring(0, 6)
//			+ "&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='" + photoId + "'";
//}

/**
获得 模板中的标签并组成串 "name1__1&code1__1";  标签定义格式 字段代码 + __ + 序号 
*/        
function getMarks(){	
	marksNames = "";
	var count = activeDocument.Bookmarks.Count;
	for(var i=1;i<=count;i++)
	{
		if(i<count){
			marksNames = marksNames + activeDocument.Bookmarks(i).Name + "&";
		}
		else{
			marksNames = marksNames + activeDocument.Bookmarks(i).Name;
		}
	}
	//alert(marksNames);
}




function  returnButton(){
	webObj = document.getElementById("webOfficeNt");
	webObj.close();
	window.close();  //如果本界面为独立窗口显示，可放开这个注释
}
/**
打印（参数可以控制是前台打印还是后台打印）
*/
function printdoc(isBackground)
{
	var oldOption;	
	try
	{
		var objOptions =  activeDocument.Application.Options;
		oldOption = objOptions.PrintBackground;
		objOptions.PrintBackground = isBackground;
	}
	catch(err){};
	webObj.printout(true);
	try
	{
		var objOptions =  activeDocument.Application.Options;
		objOptions.PrintBackground = oldOption;
	}
	catch(err){};	
}