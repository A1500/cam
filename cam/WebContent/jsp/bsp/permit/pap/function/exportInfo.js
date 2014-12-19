
function init(){
var ForWriting = 2;	
var fso = new ActiveXObject("Scripting.FileSystemObject");	
if(dataType=="function"){
	var appfile,modulefile,functionfile,operationfile,urlfile;
	if(treeType == "app"){
		appfile = fso.OpenTextFile(path+"PUB_APPS.sql", ForWriting, true);
		modulefile = fso.OpenTextFile(path+"PUB_MODULES.sql", ForWriting, true);
		functionfile = fso.OpenTextFile(path+"PUB_FUNCTIONS.sql", ForWriting, true);
		operationfile = fso.OpenTextFile(path+"PUB_OPERATIONS.sql", ForWriting, true);
		urlfile = fso.OpenTextFile(path+"PUB_URLS.sql", ForWriting, true);
	}else if(treeType== "module"){
		if(treeId=="-1"){//顶级模块
		   appfile = fso.OpenTextFile(path+"PUB_APPS.sql", ForWriting, true);	
		}
		modulefile = fso.OpenTextFile(path+"PUB_MODULES.sql", ForWriting, true);
		functionfile = fso.OpenTextFile(path+"PUB_FUNCTIONS.sql", ForWriting, true);
		operationfile = fso.OpenTextFile(path+"PUB_OPERATIONS.sql", ForWriting, true);
		urlfile = fso.OpenTextFile(path+"PUB_URLS.sql", ForWriting, true);
	}else if(treeType == "function"){
		functionfile = fso.OpenTextFile(path+"PUB_FUNCTIONS.sql", ForWriting, true);
		operationfile = fso.OpenTextFile(path+"PUB_OPERATIONS.sql", ForWriting, true);
		urlfile = fso.OpenTextFile(path+"PUB_URLS.sql", ForWriting, true);
	}else if(treeType== "operation"){
		operationfile = fso.OpenTextFile(path+"PUB_OPERATIONS.sql", ForWriting, true);
		urlfile = fso.OpenTextFile(path+"PUB_URLS.sql", ForWriting, true);
	}
	var fcmd=new L5.Command("org.loushang.bsp.permit.pap.function.cmd.ImportExportCommand");
	fcmd.setParameter("treeId",treeId);
	fcmd.setParameter("treeType",treeType);	
	fcmd.execute("exportInfo");
	var appSqlList=fcmd.getReturn("appSqlList");
	var moduleSqlList=fcmd.getReturn("moduleSqlList");
	var functionSqlList=fcmd.getReturn("functionSqlList");
	var operationSqlList=fcmd.getReturn("operationSqlList");
	var urlSqlList=fcmd.getReturn("urlSqlList");
	var appSqlLen=appSqlList.size();
	var moduleSqlLen=moduleSqlList.size();
	var functionSqlLen=functionSqlList.size();
	var operationSqlLen=operationSqlList.size();
	var urlSqlLen=urlSqlList.size();
	if(appSqlLen>0){
	 for(var i=0;i<appSqlLen;i++){
		appfile.Write(appSqlList.get(i));
		}
		appfile.Close(); 	
	}
	if(moduleSqlLen>0){
		for(var j=0;j<moduleSqlLen;j++){
			modulefile.Write(moduleSqlList.get(j));
		}
		modulefile.Close(); 	
	}
	if(functionSqlLen>0){
	 for(var k=0;k<functionSqlLen;k++){
		 functionfile.Write(functionSqlList.get(k));
	   }
	  functionfile.Close(); 
	}
	if(operationSqlLen>0){
	 for(var t=0;t<operationSqlLen;t++){
		 operationfile.Write(operationSqlList.get(t));
	 }
		operationfile.Close(); 	
	}
	if(urlSqlLen>0){
	 for(var h=0;h<urlSqlList.size();h++){
		 urlfile.Write(urlSqlList.get(h));
	 }
		urlfile .Close(); 	
	}
	if(fcmd.getReturn("complete")=="true"){
		alert("导出成功");
	}else{
		alert("导出失败");
	 } 
 }else if(dataType=="organ"){
		var ocmd=new L5.Command("org.loushang.bsp.organization.cmd.StruCommand");
		ocmd.setParameter("struId",struId);
		ocmd.setParameter("struType",struTypeId);
		ocmd.execute("exportStru");
		var struSqlList=ocmd.getReturn("struSqlList");
		var organSqlList=ocmd.getReturn("organSqlList");
		var struExtSqlList=ocmd.getReturn("struExtSqlList");
		var fso = new ActiveXObject("Scripting.FileSystemObject");	
		var organf = fso.OpenTextFile(path+"PUB_ORGAN.sql", ForWriting, true);
		for(var i=0;i<organSqlList.size();i++){
			organf.Write(organSqlList.get(i));
			}
		organf.Close(); 
		var struf = fso.OpenTextFile(path+"PUB_STRU.sql", ForWriting, true);
		for(var j=0;j<struSqlList.size();j++){
			struf.Write(struSqlList.get(j));
		}
        struf.Close(); 
		var struExtf = fso.OpenTextFile(path+"PUB_STRU_EXT.sql", ForWriting, true);
		for(var k=0;k<struExtSqlList.size();k++){
			struExtf.Write(struExtSqlList.get(k));
		}
		struExtf.Close(); 
		if(!ocmd.error&&ocmd.getReturn("complete")=="true"){
			alert("导出成功");
			return;
		}else{
			alert(ocmd.error);
			return;
	} 
 }else if(dataType=="menu"){
	   var mcmd=new L5.Command("org.loushang.bsp.permit.menu.cmd.MenuStruCmd");
		mcmd.setParameter("menuStruId",menuStruId);
		mcmd.setParameter("menuTypeId",menuTypeId);
		mcmd.execute("exportInfo");
		var menuStruSqlList=mcmd.getReturn("menuStruSqlList");
		var menuItemSqlList=mcmd.getReturn("menuItemSqlList");
		var menuTypeSqlList=mcmd.getReturn("menuTypeSqlList");
		var menuStrufile = fso.OpenTextFile(path+"PUB_MENU_STRU.sql", ForWriting, true);
		for(var i=0;i<menuStruSqlList.size();i++){
			menuStrufile.Write(menuStruSqlList.get(i));
			}
		menuStrufile.Close(); 
		var menuItemfile = fso.OpenTextFile(path+"PUB_MENU_ITEM.sql", ForWriting, true);
		for(var j=0;j<menuItemSqlList.size();j++){
			menuItemfile.Write(menuItemSqlList.get(j));
		}
		menuItemfile.Close(); 
		if(menuTypeSqlList!=null&&menuTypeSqlList!=undefined){
			var menuTypefile = fso.OpenTextFile(path+"PUB_MENU_TYPE.sql", ForWriting, true);
			for(var k=0;k<menuTypeSqlList.size();k++){
				menuTypefile.Write(menuTypeSqlList.get(k));
			}
			menuTypefile.Close(); 
		}
		if(!mcmd.error&&mcmd.getReturn("complete")=="true"){
			alert("导出成功");
			return;
		}else{
			alert(mcmd.error);
			return;
		}
	}else if(dataType=="menuType"){
		var cmd=new L5.Command("org.loushang.bsp.permit.menu.cmd.MenuTypeCmd");
		cmd.setParameter("menuTypeId",menuTypeId);
		cmd.execute("exportMenu");
		var menuStruSqlList=cmd.getReturn("menuStruSqlList");
		var menuItemSqlList=cmd.getReturn("menuItemSqlList");
		var menuTypeSqlList=cmd.getReturn("menuTypeSqlList");
		var menuTypefile = fso.OpenTextFile(path+"PUB_MENU_TYPE.sql", ForWriting, true);
		for(var k=0;k<menuTypeSqlList.size();k++){
			menuTypefile.Write(menuTypeSqlList.get(k));
		}
		menuTypefile.Close(); 
		var menuStrufile = fso.OpenTextFile(path+"PUB_MENU_STRU.sql", ForWriting, true);
		for(var i=0;i<menuStruSqlList.size();i++){
			menuStrufile.Write(menuStruSqlList.get(i));
			}
		menuStrufile.Close(); 
		var menuItemfile = fso.OpenTextFile(path+"PUB_MENU_ITEM.sql", ForWriting, true);
		for(var j=0;j<menuItemSqlList.size();j++){
			menuItemfile.Write(menuItemSqlList.get(j));
		}
		menuItemfile.Close(); 
		
		if(!cmd.error&&cmd.getReturn("complete")=="true"){
			alert("导出成功");
			//刷新页面
			L5.forward("jsp/bsp/permit/menu/menusys/menutypemanager.jsp","");
			return;
		}else{
			alert(mcmd.error);
			//刷新页面
			L5.forward("jsp/bsp/permit/menu/menusys/menutypemanager.jsp","");
			return;
		}
	}
} 