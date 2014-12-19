function init() {
	hidetable();
	var BaseinfoPeopleDataSet= L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	BaseinfoPeopleDataSet.setParameter("PEOPLE_ID",peopleId);
	BaseinfoPeopleDataSet.load();
	if(objectType=='11'||objectType=='12'||objectType=='13'||objectType=='14'||objectType=='15'){
		var BptPeopleDisabilityDataSet= L5.DatasetMgr.lookup("BptPeopleDisabilityDataSet");
		BptPeopleDisabilityDataSet.setParameter("PEOPLE_ID",peopleId);
		BptPeopleDisabilityDataSet.load();
		L5.QuickTips.init();
	}else if(objectType=='21'||objectType=='22'||objectType=='23'){
		var DependantDataset= L5.DatasetMgr.lookup("DependantDataset");
		DependantDataset.setParameter("PEOPLE_ID",peopleId);
		DependantDataset.load();
	}else if(objectType=='41'){
		var PeopleDemobilizedDataset= L5.DatasetMgr.lookup("PeopleDemobilizedDataset");
		PeopleDemobilizedDataset.setParameter("peopleId",peopleId);
		PeopleDemobilizedDataset.load();
	}else if(objectType=='42'){
		DemobilizedIllnessDataset.setParameter("peopleId",peopleId);
		DemobilizedIllnessDataset.load();
	}else if(objectType=='51'){
		var dsWar= L5.DatasetMgr.lookup("dsWar");
		dsWar.setParameter("PEOPLE_ID",peopleId);
		dsWar.load();
	}else if(objectType=='61'){
		var dsTested= L5.DatasetMgr.lookup("dsTested");
		dsTested.setParameter("PEOPLE_ID",peopleId);
		dsTested.load();
	}else if(objectType=='B1'){
		var MartyrOffspringDataSet = L5.DatasetMgr.lookup("MartyrOffspringDataSet");
		MartyrOffspringDataSet.setParameter("peopleId",peopleId);
		MartyrOffspringDataSet.load();
	}else if(objectType=='81'){
		RetiredSoldierDataSet.setParameter("peopleId",peopleId);
	    RetiredSoldierDataSet.load();
	}
	
	var BaseinfoFamilyDataSet = L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
	BaseinfoFamilyDataSet.setParameter("FAMILY_ID",familyId);
	BaseinfoFamilyDataSet.load();
	var HouseSubsidyInfoDataset = L5.DatasetMgr.lookup("HouseSubsidyInfoDataset");
	HouseSubsidyInfoDataset.setParameter("FAMILY_ID@=",familyId);
	HouseSubsidyInfoDataset.load();
	
	
}
function hidetable(){
	 if(objectType=='11'||objectType=='12'||objectType=='13'||objectType=='14'||objectType=='15'){
		 document.getElementById("distable").style.display='';
		 document.getElementById("disdiv").style.display='';
	}else if(objectType=='21'||objectType=='22'||objectType=='23'){
		document.getElementById("deptable").style.display='';
		document.getElementById("depdiv").style.display='';
	}else if(objectType=='41'){
		document.getElementById("demotable").style.display='';
		document.getElementById("demodiv").style.display='';
	}else if(objectType=='42'){
		document.getElementById("demoilltable").style.display='';
		document.getElementById("demoilldiv").style.display='';
	}else if(objectType=='51'){
		document.getElementById("wartable").style.display='';
		document.getElementById("wardiv").style.display='';
	}else if(objectType=='61'){
		document.getElementById("testtable").style.display='';
		document.getElementById("testdiv").style.display='';
	}else if(objectType=='B1'){
		document.getElementById("martable").style.display='';
		document.getElementById("mardiv").style.display='';
	}else if(objectType=='81'){
		document.getElementById("rettable").style.display='';
		document.getElementById("retdiv").style.display='';
	}
}

function method(){//整个表格拷贝到EXCEL中 
	var tabs =document.getElementsByTagName("table");
	   var oXL = new ActiveXObject("Excel.Application"); 
	    //创建AX对象excel 
	var oWB = oXL.Workbooks.Add(); 
	   //获取workbook对象 
	         var oSheet = oWB.ActiveSheet; 
	         //oSheet.Cells(1,1).Value="heelo"; 
	         oSheet.Columns.ColumnWidth = 20; 
	     //激活当前sheet 
		 var p=1;
		 for(var i=2;i<tabs.length;i++){
			var sel = document.body.createTextRange(); 
			sel.moveToElementText(tabs[i]); 
			if(tabs[i].style.display!=''){
				continue;
			}
			//把表格中的内容移到TextRange中 
			sel.select(); 
			//全选TextRange中内容 
			sel.execCommand("Copy"); 
			
			if(i!=2){
				p=p+tabs[i-1].rows.length;
				oSheet.Range("A"+p).Select();
			}
			 //复制TextRange中内容 
			 
			// oSheet.Cells(0,13).Select();
		    oSheet.Paste(); 
			//粘贴到活动的EXCEL中     
			sel.collapse(true);
			sel.select();
		 }
	    
	     oXL.Visible = true; 
	     //设置excel可见属性 
	}