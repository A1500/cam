function init(){
	var ForReading = 1;
if(dataType=="function"){
	var fcmd=new L5.Command("org.loushang.bsp.permit.pap.function.cmd.ImportExportCommand");
	var appfile,modulefile,functionfile,operationfile,urlfile;
	var appSqlList,moduleSqlList,functionSqlList,operationSqlList,urlSqlList;
	try{
		var fso = new ActiveXObject("Scripting.FileSystemObject");
		if(treeType=="app"){//应用节点导入
		 if(treeId=="-1"){//根节点
			appfile = fso.OpenTextFile(path+"PUB_APPS.sql", ForReading);
		    if(!appfile.atendofstream){
		       appSqlList=appfile.ReadAll();
		    }
		  }
			modulefile=fso.OpenTextFile(path+"PUB_MODULES.sql", ForReading);
			functionfile=fso.OpenTextFile(path+"PUB_FUNCTIONS.sql", ForReading);
			operationfile=fso.OpenTextFile(path+"PUB_OPERATIONS.sql", ForReading);
			urlfile=fso.OpenTextFile(path+"PUB_URLS.sql", ForReading);
			if(!modulefile.atendofstream){
			  moduleSqlList=modulefile.ReadAll();
			}
			if(!functionfile.atendofstream){
			  functionSqlList=functionfile.ReadAll();
			}
			if(!operationfile.atendofstream){
			  operationSqlList=operationfile.ReadAll();
			}
			if(!urlfile.atendofstream){
			 urlSqlList=urlfile.ReadAll();
			}
		}
		if(treeType=="module"){//模块节点导入
		 if(isLeafModule=="0"){//非末级模块
			modulefile=fso.OpenTextFile(path+"PUB_MODULES.sql", ForReading);
			moduleSqlList=modulefile.ReadAll();
			}
			functionfile=fso.OpenTextFile(path+"PUB_FUNCTIONS.sql", ForReading);
			operationfile=fso.OpenTextFile(path+"PUB_OPERATIONS.sql", ForReading);
			urlfile=fso.OpenTextFile(path+"PUB_URLS.sql", ForReading);
			functionSqlList=functionfile.ReadAll();
			operationSqlList=operationfile.ReadAll();
			urlSqlList=urlfile.ReadAll();
		}
		if(treeType=="function"){//功能节点导入，只导入下面的操作
			operationfile=fso.OpenTextFile(path+"PUB_OPERATIONS.sql", ForReading);
			urlfile=fso.OpenTextFile(path+"PUB_URLS.sql", ForReading);
			operationSqlList=operationfile.ReadAll();
			urlSqlList=urlfile.ReadAll();
		}
	}catch(e){
		alert(e.message);
		return;
	}
	fcmd.setParameter("treeId",treeId);
	fcmd.setParameter("treeType",treeType);
	fcmd.setParameter("appSqlList",appSqlList);
	fcmd.setParameter("moduleSqlList",moduleSqlList);
	fcmd.setParameter("functionSqlList",functionSqlList);
	fcmd.setParameter("operationSqlList",operationSqlList);
	fcmd.setParameter("urlSqlList",urlSqlList);
	fcmd.execute("importInfo");
	
	if(!fcmd.error&&fcmd.getReturn("complete")=="true"){
		alert("导入成功");
		return;
	}else{
		alert(fcmd.error);
	}
 }else if(dataType=="organ"){
	 var ocmd=new L5.Command("org.loushang.bsp.organization.cmd.StruCommand");
		var organSqlList,struSqlList,struExtSqlList;
		try{
			var fso = new ActiveXObject("Scripting.FileSystemObject");
			var organfile = fso.OpenTextFile(path+"PUB_ORGAN.sql", ForReading);
			var strufile=fso.OpenTextFile(path+"PUB_STRU.sql", ForReading);
			var struExtfile=fso.OpenTextFile(path+"PUB_STRU_EXT.sql", ForReading);
			organSqlList=organfile.ReadAll();
			struSqlList=strufile.ReadAll();
			struExtSqlList=struExtfile.ReadAll();
		}catch(e){
			L5.Msg.alert("提示",e.message);
			return;
		}
//		ocmd.setParameter("type","sql");
		ocmd.setParameter("organSqlList",organSqlList);
		ocmd.setParameter("struSqlList",struSqlList);
		ocmd.setParameter("struExtSqlList",struExtSqlList);
		ocmd.execute("importStru");
		
		if(!ocmd.error&&ocmd.getReturn("complete")=="true"){
			alert("导入成功");
			return;
		}else{
			alert(ocmd.error);
			return;
		}
	 
 }else if(dataType=="menu"){
	 var mcmd=new L5.Command("org.loushang.bsp.permit.menu.cmd.MenuStruCmd");
	 var menuStruSqlList,menuItemSqlList,menuTypeSqlList;
		try{
			var fso = new ActiveXObject("Scripting.FileSystemObject");
			var menuStrufile = fso.OpenTextFile(path+"PUB_MENU_STRU.sql", ForReading);
			var menuItemfile=fso.OpenTextFile(path+"PUB_MENU_ITEM.sql", ForReading);
//			if(menuTypeId!="1"){//如果不是系统内置菜单，则需要把菜单类型一同导入
//			  var menuTypefile = fso.OpenTextFile(path+"PUB_MENU_TYPE.sql", ForReading);
//			if(!menuTypefile.atendofstream){
//			  menuTypeSqlList=menuTypefile.ReadAll();
//			 }
//			}
		if(!menuStrufile.atendofstream){
			menuStruSqlList=menuStrufile.ReadAll();
		 }
		if(!menuItemfile.atendofstream){
			menuItemSqlList=menuItemfile.ReadAll();
	    	}
		}catch(e){
			alert(e.message);
			return;
		}
		mcmd.setParameter("menuTypeId",menuTypeId);
		mcmd.setParameter("menuItemSqlList",menuItemSqlList);
		mcmd.setParameter("menuStruSqlList",menuStruSqlList);
//		mcmd.setParameter("menuTypeSqlList",menuTypeSqlList);
		mcmd.execute("importInfo");
		if(!mcmd.error&&mcmd.getReturn("complete")=="true"){
			alert("导入成功");
			return;
		}else{
			alert(mcmd.error);
			return;
		}
	}else if(dataType=="menuType"){
		var cmd=new L5.Command("org.loushang.bsp.permit.menu.cmd.MenuTypeCmd");
		var menuStruSqlList,menuItemSqlList,menuTypeSqlList;
		try{
			var fso = new ActiveXObject("Scripting.FileSystemObject");
			var menuStrufile = fso.OpenTextFile(path+"PUB_MENU_STRU.sql", ForReading);
			var menuItemfile=fso.OpenTextFile(path+"PUB_MENU_ITEM.sql", ForReading);
			var menuTypefile = fso.OpenTextFile(path+"PUB_MENU_TYPE.sql", ForReading);
			if(!menuTypefile.atendofstream){
			  menuTypeSqlList=menuTypefile.ReadAll();
			 }
			if(!menuStrufile.atendofstream){
				menuStruSqlList=menuStrufile.ReadAll();
			 }
			if(!menuItemfile.atendofstream){
				menuItemSqlList=menuItemfile.ReadAll();
		    	}
		}catch(e){
			alert(e.message);
			return;
		}
		cmd.setParameter("menuItemSqlList",menuItemSqlList);
		cmd.setParameter("menuStruSqlList",menuStruSqlList);
		cmd.setParameter("menuTypeSqlList",menuTypeSqlList);
		cmd.execute("importMenu");
		if(!cmd.error&&cmd.getReturn("complete")=="true"){
			alert("导入成功");
			//刷新页面
			L5.forward("jsp/bsp/permit/menu/menusys/menutypemanager.jsp","");
			return;
		}else{
			alert(cmd.error);
			//刷新页面
			L5.forward("jsp/bsp/permit/menu/menusys/menutypemanager.jsp","");
			return;
		}
	}
	 
}
	