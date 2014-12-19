var page;
if(!page) page = {
	popWin:{
 /**
  * record a map :recordtype-->recordId
  */
        currentNodeId:{
         module:'',
         func:'',
         opr:'',
         level:''//is module func opr
        },
        loadStoped:[],
        stopedOrder:['app','module','func',
        {
            'app':0,
            'module':1,
            'func':2
        }],
        stopLoadAt:function(recordType){//
           this.loadStoped[recordType] = true;
        },
        resumeLoad:function(){
            var leng = this.stopedOrder.length-1;
            for(var i=0; i<leng; i++){
                this.loadStoped[this.stopedOrder[i]] = false;
            }
        },
        loadTree:function(){
			page.poptree.root.record.reload();
			},
       	getLeaf:function(){
          if( this.loadStoped['app'] ){return 'app';}
          else
            if( this.loadStoped['module']){return 'module';}
            else
                if(this.loadStoped['func']) {return 'func';}
            else{return null;}
      	 }
       }
};
/**
*定义根节点
*/
var rootdata = {
	id : 'rootId',//唯一标志record,如果是前台配置生成record,则指定id
	appCode:'-1',
	appName:PUB_FUNCTIONS_TITLE,
	recordType:'appRecord',
	moduleCode:'-1'
};
var rootdata2 = {
	id : 'rootId',//唯一标志record,如果是前台配置生成record,则指定id
	appCode:'-1',
	appName:PUB_FUNCTIONS_TITLE,
	recordType:'appRecord2',
	moduleCode:'-1'
};

/**
 * 页面初始函数
 */
function init() {
	
	L5.QuickTips.init();
	page.tree = L5.getCmp('functiontree');
    page.poptree = L5.getCmp('functiontree2');
    page.mapLink.app.dataset = moduleDataset;
    page.mapLink.module.dataset=functionDataset;
    page.mapLink.func.dataset =operationDataset;
    appDataset.load();
    page.tree.root.expand();
}
function isApplikedModule(rcd){
	return rcd.parentRecord.get('moduleCode')=='-1' &&
				 rcd.parentRecord.get('appCode')=='-1';
}
/**
*  触发加载应用类型的record，只有点击根节点才加载应用
*/
function appLoaderTrigger(record){
	 var rcdTp = record.recordType;
	if((rcdTp == "appRecord" || rcdTp == "appRecord2") &&
		 record.get("appCode") == "-1"){
                  return true;
	}
	return false;
}

/**
*  触发加载模块类型的record，点击应用节点和非末级模块加载
*/
function moduleLoaderTrigger(record){
    var rcdTp = record.recordType;
    //under app
	if((rcdTp == "appRecord" || rcdTp =="appRecord2") ){
       		return true;
	}

	if((rcdTp == "moduleRecord" || rcdTp =="moduleRecord2")&&
	   record.get("isLeafModule") != "1"){
        //load but no under leaf module
            return true;
	}
	return false;
}

/**
*  触发加载功能类型的record，点击末级模块加载
*/
function functionLoaderTrigger(record){
    var rcdTp = record.recordType;
	if((rcdTp == "moduleRecord" || rcdTp=="moduleRecord2") &&
		 record.get("isLeafModule") == "1" ){
                 if(page.popWin.loadStoped['module'] && rcdTp=="moduleRecord2"){
		 	return false;
		 }
                 //for move module ,no function and no leaf module....,so
                 if(page.popWin.loadStoped['app']){
                     return false;
                 }
                 return true;
                 }

	return false;
}
/**
*  触发加载操作类型的record，点击功能加载
*/
function operationLoaderTrigger(record){
    var rcdTp = record.recordType;
	if( rcdTp== "functionRecord" || rcdTp =="functionRecord2"){
         if(page.popWin.loadStoped['func'] && rcdTp=="functionRecord2"){
		return false;
        }
           return true;
        }
	return false;
}
//获取不同类型树节点的显示图标
//configure node icon
function getIcon(record){
	var recordType = record.recordType;
	if(recordType == "appRecord" && record.get("appCode") == "-1"){
		return L5.webPath+"/skins/images/l5/root.gif";
	}

	if(recordType== "appRecord" && record.get("appCode") != "-1"){
		return L5.webPath+"/skins/images/l5/app.gif";
	}

	if(recordType == "moduleRecord"){
		return L5.webPath+"/skins/images/l5/module.gif";
	}

	if(recordType == "functionRecord"){
		return L5.webPath+"/skins/images/l5/function.gif";
	}

	if(recordType == "operationRecord"){
		return L5.webPath+"/skins/images/l5/operation.gif";
	}
}
function isWithLeaf(){//just for module
    if(page.popWin.loadStoped['app']){
        return 'n';
    }
    return 'y';
}
function getSelfParentId(){
	var level = page.popWin.getLeaf();
	var key = page.mapLink[level].key
	var record = page.currentRcd;
	var id = record.parentRecord.get(key);
	if (!id) {//is module
		if (record.get('isLeafModule')) {// leaf not load parent
			id = record.parentRecord.get(page.mapLink[level].childKey);
		}else{ //nonleaf not load self
			id = record.get(page.mapLink[level].childKey);
		}
	}
	if(record.recordType=='moduleRecord' && !(record.get('isleafModule'))){
		id = record.get(page.mapLink[level].childKey);
	}
	return id;
}
function ok(){
	L5.getCmp('zhuanyi').hide();
        //leaf is levle of destiny  for moving
        var leaf = page.popWin.getLeaf();
        var maplink = page.mapLink;
        var ins = maplink[leaf];
        var newParentId = page.poptree.getChecked(ins.key)[0];
		var appName;
        if(!newParentId ){
			newParentId = page.poptree.getChecked(ins.childKey);
			var k = 0;
			var node0 = page.poptree.getNodeByRecordId(newParentId,'moduleRecord2');
			var prcd  = node0.record.parentRecord; //prcd 可能是app
			while(prcd.recordType !='appRecord2' && k++<30 ){//直到找到app节点或者30次后不找了，没有哪个应用树有30层吧
				prcd = prcd.parentRecord;
			}
			appName =prcd.get('appName');
			if(prcd.get('appCode') == '-1' && prcd.get('moduleCode')=='-1'){
				appName = '';
			}
			var appId =prcd.get('appCode');
            var isModule = true;
        }else if(ins.key=='appCode'){//这是一个app
			var node0  = page.poptree.getNodeByRecordId(newParentId,'appRecord2');
			appName = node0.record.get('appName');
		}
       var rcd = ins.newRecord(page.currentRcd,newParentId,isModule,appName,appId);
        rcd.state = '3';
          var cmd = new L5.Command(ins.cmd);
          cmd.setParameter('appName',appName);
	        //对同步菜单的处理
	        	cmd.setParameter('isWithMenu','y');
	        	if( page.currentRcd.get('isDefault')=='1') {
	        			cmd.setParameter('isWithMenu','n');
	        	}
	        	if(page.currentRcd.recordType == 'operationRecord' && page.currentRcd.get('isDefault')!='1'){
	        		//和功能、模块不同的是srcMenuId取的是上级功能的menuId
	        		var srcMenuId = page.currentRcd.parentRecord.get('menuId');
	        		var tgtMenuId = page.poptree.getChecked('menuId')[0];
	        		if(srcMenuId && tgtMenuId){
						cmd.setParameter('deleteReqActionOf',srcMenuId);
	        		}else
	        		if(!srcMenuId && tgtMenuId){cmd.setParameter('isWithMenu','n');}//nothing happen
	        		else
	        		if(srcMenuId && !tgtMenuId){
	        			cmd.setParameter('deleteReqActionOf',srcMenuId);
	        		}else
	        		if(!srcMenuId && !tgtMenuId){cmd.setParameter('isWithMenu','n');}//nothing happen

	        	}else if(page.currentRcd.recordType == 'functionRecord' || page.currentRcd.recordType == 'moduleRecord'){
	        		var srcMenuId = page.currentRcd.get('menuId');
	        		var tgtMenuId = page.poptree.getChecked('menuId')[0];
					if(srcMenuId && tgtMenuId){

						cmd.setParameter('updateMenuPathOf',page.currentRcd.get('menuId'));
	        		}else
	        		if(!srcMenuId && tgtMenuId){
	        			cmd.setParameter('addMenu:',srcMenuId);
	        		}else
	        		if(srcMenuId && !tgtMenuId){
	        			cmd.setParameter('removeMenu:',srcMenuId);
	        		}else
	        		if(!srcMenuId && !tgtMenuId){cmd.setParameter('isWithMenu','n');}//nothing happen
	        	}

        cmd.setParameter('record',rcd);
		cmd.setParameter('moveUpdate','y');//告诉后台这是移动节点的模块操作
		var srcLevel = page.map[page.currentRcd.recordType];
		var method = page.javaCommand[srcLevel].move;
        cmd.execute(method);
        if(page.cmdHelper(cmd)){
	    var type = isModule?'moduleRecord2':page.map[leaf];//移动的目标节点要刷新
	    var node = page.tree.getNodeByRecordId(newParentId,type.split("2")[0]);//poptree recordtype is XX2
	      node.record.reload({callback:function(){node.expand();}});
	   var  node1 = page.tree.getNodeByRecord(page.currentRcd.parentRecord);//要移动的节点的上级要刷新
	  node1.record.reload({callback:function(){node1.expand()}});
	};
        page.popWin.resumeLoad();
		page.currentRcd = null;

 }

function closeWin(){
	L5.getCmp('zhuanyi').hide();
        page.popWin.resumeLoad();
}
/**
* 获取当前模块的应用，作为下级模块查询条件
*/
function getModuleApp(rec){
	var appId = rec.get("appCode");
	if(!appId)appId  = rec.get('moduleAppCode');
	return appId;
}
/**
* 获取当前模块编码，作为下级模块查询条件
*/
function getParentModule(rec){
	//顶级模块的上级模块存在
	if(rec.recordType=="appRecord" || rec.recordType=="appRecord2")
		return "-1";
	var parentModule = rec.get("moduleCode");
	return parentModule;
}
/**
* 获取当前模块编码，作为功能查询条件
*/
function getFunctionModule(rec){
	var module = rec.get("moduleCode");
	return module;
}

/**
* 获取当前功能编码，作为操作查询条件
*/
function getOperationFunction(rec){
	var module = rec.get("functionCode");
	return module;
}
/**
* 事件处理：点击节点显示维护页面
*/
function selectedNode(record){
	L5.getCmp("detail").show();
//	var win = window.frames["appFrame"].window;
//	var ds = win.L5.DatasetMgr.lookup("ds");
	if(record.recordType == "appRecord" && record.get("appCode") == "-1"){
		return ;
	}
	page.selectedRcd = record;
	page.selectNode = page.tree.getNodeByRecord(record);
	var url;
	var primeKey;
	var frame = document.getElementById("nodeFrame");
	if(record.recordType == "appRecord"){
		url = "pubapp_edit.jsp";
		primeKey = record.get("appCode");
	}else
	if(record.recordType == "moduleRecord"){
		url = "pubmodules_edit.jsp";
		primeKey = record.get("moduleCode");
		var appCode = record.get('moduleAppCode');

		var prcd = record.parentRecord;
		var t = prcd.get('moduleCode');
		var parentModule =t?t:'-1';
		t = prcd.get('moduleName');
		var parentModuleName=t?t:'-1';
		while(prcd.recordType !='appRecord'){
			prcd = prcd.parentRecord;
		}
		var appName;
		if(prcd.get("appCode") =='-1'){//如果不是在应用下面建立的模块，appName为默认应用的名称
			var index = appDataset.find("appCode","-1",0);
			appName = appDataset.getAt(index).get("appName");
		}else{
			appName = prcd.get('appName');
		}
		var url2 = '&appCode='+appCode+
					'&appName='+appName+
					'&parentModuleCode='+parentModule+
					'&parentModuleName='+parentModuleName;

	}else
	if(record.recordType == "functionRecord"){
		url = "pubfunctions_edit.jsp";
		primeKey = record.get("functionCode");
	}else
	if(record.recordType == "operationRecord"){
		url = "puboperations_edit.jsp";
		primeKey = record.get("operationCode");
	}
	url += '?method=UPDATE'+
					'&primeKey=' + primeKey+(url2?url2:'#');
	url = encodeURI(encodeURI(url));
	frame.src=url;

}
//主键校正
function updateInfo(menuitem) {
	var record=menuitem.parentMenu.record;
	if(record.get("parentModuleCode")=="-1") {
		var frame = document.getElementById("nodeFrame");
        var url="pubmenu_edit.jsp?method=INSERT&moduleCode=" + record.get("moduleCode");
		
		url = encodeURI(encodeURI(url));
		frame.setAttribute("src", url);
	}else {
   		L5.MessageBox.alert('提示：',"请选择子系统根节点！");
	}
}
/**
* 事件处理：点击添加节点
*/
function addNode(menuitem){
	var record=menuitem.parentMenu.record;
	page.currentRcd = record;
	var frame = document.getElementById("nodeFrame");
        var url;
	//根节点增加应用或者顶级模块
	if(record.recordType == "appRecord" && record.get("appCode") == "-1"){
		if(menuitem.text == page.addAppText){
			url = "pubapp_edit.jsp?method=INSERT&record="+record.get("appCode");
		}else if(menuitem.text == page.addModuleText){
			//获取当前应用的索引
			var index = appDataset.find("appCode","-1",0);
			var appName = appDataset.getAt(index).get("appName");
			url = "pubmodules_edit.jsp?method=INSERT&appCode=null&appName=" + appName;
		}

	}
	//应用节点增加模块
	if(record.recordType == "appRecord" && record.get("appCode") != "-1"){
		url = "pubmodules_edit.jsp?method=INSERT&appCode=" + record.get("appCode")
		+ "&appName=" + record.get("appName");

	}
//非末级模块节点增加模块
	if(record.recordType == "moduleRecord" && record.get("isLeafModule") != "1"){
		var moduleAppName ;
		var prcd = record.parentRecord;
		while(prcd.recordType !='appRecord'){
			prcd = prcd.parentRecord;
		}

		if(prcd.appCode =='-1'){//如果不是在应用下面建立的模块，appName=“”
			moduleAppName = "";
		}else{
			moduleAppName = prcd.get('appName');
		}
		url = "pubmodules_edit.jsp?method=INSERT&appCode=" + record.get("moduleAppCode")
		+ "&appName=" + moduleAppName + "&parentModuleCode=" + record.get("moduleCode")
		+ "&parentModuleName=" + record.get("moduleName");

	}
	//末级模块节点增加功能
	if(record.recordType == "moduleRecord" && record.get("isLeafModule") == "1"){
		url = "pubfunctions_edit.jsp?method=INSERT&moduleCode=" + record.get("moduleCode")
		+ "&moduleName=" + record.get("moduleName");
	}
	//功能节点增加操作
	if(record.recordType == "functionRecord"){
		url = "puboperations_edit.jsp?method=INSERT&functionCode=" + record.get("functionCode")
		+ "&functionName=" + record.get("functionName")
	}

	if(!(record.recordType == "appRecord" && record.get("appCode") == "-1")){
		if( !record.get('menuId')){
			url +="&withMenu=n";//let  synchronize Menu checkbox nondisplay
		}else{
			url+="&menuId="+record.get('menuId');
		}
	}
	url = encodeURI(encodeURI(url));
	frame.setAttribute("src", url);
}

/**
* 事件处理：点击删除节点
*/
function deleteNode(menuitem){
	var record=menuitem.parentMenu.record;
	if(record.recordType == "appRecord" && record.get("appCode") == "-1"){
		return ;
	}
	var cmd;
	var primeKey;
	var b,c;
	if(record.recordType == "appRecord"){
		cmd = "org.loushang.bsp.permit.pap.function.cmd.AppCommand";
		primeKey = record.get("appCode");
		b =page.deleteCheck(primeKey,cmd);
	}else
	if(record.recordType == "moduleRecord"){
		cmd = "org.loushang.bsp.permit.pap.function.cmd.ModuleCommand";
		primeKey = record.get("moduleCode");
		b =page.deleteCheck(primeKey,cmd);

	}else
	if(record.recordType == "functionRecord"){
		cmd = "org.loushang.bsp.permit.pap.function.cmd.FunctionCommand";
		primeKey = record.get("functionCode");
		b =page.deleteCheck(primeKey,cmd);
	}else
	if(record.recordType == "operationRecord"){
		cmd = "org.loushang.bsp.permit.pap.function.cmd.OperationCommand";
		primeKey = record.get("operationCode");
		b =true;
		var deleteFunctionCode = record.get('functionCode');

	}
	L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
		if(sta=="yes"){
			if(!b){
				L5.MessageBox.alert('提示：','存在下级节点，不能删除');
				return;
			}
			var command = new L5.Command(cmd);
			command.setParameter("id", primeKey);
			if(record.recordType == 'operationRecord'){
				if(record.parentRecord.get('menuId')){
					command.setParameter('needUpdateAction','y');
				}
			}else{
				if(record.get('menuId')){
					command.setParameter('isWithMenu','y');
				}
			}
			command.execute("delete");
			if (!command.error) {

            L5.MessageBox.alert('提示','删除成功');
			var node = page.tree.getNodeByRecord(record.parentRecord);
			node.record.reload({callback:function(){node.expand()}});
			}else{
				L5.MessageBox.alert('提示：',command.error);

			}
		}

	});
}
/**radiobox || ''
 */
function showNode(rcd){
    var rcdtype = rcd.recordType;
    var map = page.map;
    var level = map[rcdtype];
     if(!page.popWin.loadStoped['app'] && page.popWin.loadStoped[level]){
       if((rcdtype==map['module'] && rcd.get('isLeafModule')=='1')||
          (rcdtype == map['func'])){
            return 'radiobox';
           }
    }
   if(page.popWin.loadStoped['app']){
       if(rcdtype == map['module'] && rcd.get('isLeafModule') != '1'||
        (rcdtype == map['app'] && rcd.get('appCode')!='-1') ){
           return 'radiobox';
       }
   }
    return '';
}

/**
* 事件处理：点击上移节点
*/
function upNode(menuitem){
	var record=menuitem.parentMenu.record;
	var rcdtp = record.recordType
	var level = page.map[rcdtp];
	var seq = record.get('seq')-0;
	//应用没有上移功能，   如果节点已经是第一个就没有必要再上移
	if(level == 'app' || !(seq>0)){
		return ;
	}
	var pLever = page.typeLevel[level].up;
	var cmd = new L5.Command(page.mapLink[pLever].cmd);
	var childKey =page.mapLink[pLever].childKey;
	var upperRcd = page.findUpperRcd(record,childKey);
	if(!upperRcd){
		return;
	}
	//swap record.seq and upperRcd.seq
	var seq = record.get('seq')-0;
	record.set('seq',upperRcd.get('seq')-0);
	upperRcd.set('seq',seq);

	if(record.recordType!='operationRecord'  && record.get('menuId')){
		cmd.setParameter('isWithMenu','y');
	}
	cmd.setParameter('records',[record,upperRcd]);
	cmd.execute('changeSeq');
	if(page.cmdHelper(cmd)){
		var node = page.tree.getNodeByRecord(record.parentRecord);
		node.record.reload({callback:function(){node.expand()}});
	};
}
//得到指定节点的上临节点的record
page.findUpperRcd= function(rcd,rcdkey){
	var parentRcd = rcd.parentRecord;
	var brotherRcd = parentRcd.children.items;//brother record array
	var leng = brotherRcd.length;

	//find upper neibour rcd
	for(var i=1; i<leng; i++){
		if(brotherRcd[i].get(rcdkey)==rcd.get(rcdkey)){//if key=='the key',previous rcd is it;
			return brotherRcd[i-1];
		}
	}
}
/**
* 事件处理：点击下移节点
*/
function downNode(menuitem){
	var record=menuitem.parentMenu.record;
	var rcdtp = record.recordType
	var level = page.map[rcdtp];
	var seq = record.get('seq')-0;
	//应用没有下移功能，   如果节点已经是最后一个就没有必要再下移
	if(level == 'app' || !(seq < record.parentRecord.children.length)){
		return ;
	}
	var pLever = page.typeLevel[level].up;
	var cmd = new L5.Command(page.mapLink[pLever].cmd);
	var childKey =page.mapLink[pLever].childKey;
	var downerRcd = page.findDownerRcd(record,childKey);
	if(!downerRcd){
		return;
	}
	//swap record.seq and downerRcd.seq
	var seq = record.get('seq')-0;
	record.set('seq',downerRcd.get('seq')-0);
	downerRcd.set('seq',seq);

	if(record.recordType!='operationRecord'  &&
				record.get('menuId')){
		cmd.setParameter('isWithMenu','y');
	}
	cmd.setParameter('records',[record,downerRcd]);
	cmd.execute('changeSeq');
	if(page.cmdHelper(cmd)){
		var node = page.tree.getNodeByRecord(record.parentRecord);
		node.record.reload({callback:function(){node.expand()}})
	};
}
//得到指定节点的上临节点的record
page.findDownerRcd=function(rcd,rcdkey){
	var parentRcd = rcd.parentRecord;
	var brotherRcd = parentRcd.children.items;//brother record array
	var leng = brotherRcd.length;

	//find downer neibour rcd
	for(var i=0; i<leng-1; i++){
		if(brotherRcd[i].get(rcdkey)==rcd.get(rcdkey)){//if key=='the key',next rcd is it;
			return brotherRcd[i+1];
		}
	}
}
/**
* 事件处理：点击转移点
*/
function moveNode(menuitem){
    var record=menuitem.parentMenu.record;
    var rcdTp = record.recordType;
    var level = page.map[rcdTp];
    page.popWin.currentNodeId.level = level;
    page.popWin.currentNodeId[level] = record.get(page.mapLink[level].key)
    page.currentRcd = record;
    if(rcdTp == "appRecord" ){
        return ;
    }else
    if(rcdTp == "moduleRecord" ){
        page.popWin.stopLoadAt('app');// parent node is app or module
     }else
    if(rcdTp == "functionRecord" ){
        page.popWin.stopLoadAt('module');
     }else
    if(rcdTp == "operationRecord"){
        page.popWin.stopLoadAt('func');
     }
     page.popWin.loadTree();
     L5.getCmp('zhuanyi').show();
  }

/**
* 事件处理：点击导出数据
*/
function exportData(menuitem){
}

/**
* 事件处理：点击导入数据
*/
function importData(menuitem){

}
function isAppNode(rcd){
	return rcd.recordType == 'appRecord';//app record type
}
function isModuleNode(rcd){
	return rcd.recordType == 'moduleRecord';//module record type
}
function isFunctionNode(rcd){
	return rcd.recordType == 'functionRecord';//function record type
}
function isOprNode(rcd){
	return rcd.recordType == 'operationRecord';//function record type
}
function isRootNode(rcd){
	return page.tree.getNodeByRecord(rcd).isRoot;
}
function isLeafModule(rcd){
	return (rcd.recordType == 'moduleRecord' && rcd.get('isLeafModule') == '1');
}

/**
 * recordtype-----------level
 */
page.map={
    app:'appRecord2',
    module:'moduleRecord2',
    func:'functionRecord2',
    appRecord2:'app',
    moduleRecord2:'module',
    functionRecord2:'func',
	appRecord:'app',
    moduleRecord:'module',
    functionRecord:'func',
    operationRecord:'opr'
}
/**
 * level 上下级关系
 */
page.typeLevel={
	app:{
		up:undefined,
		down:'module'
	},
	module:{
		up:'app',
		down:'func'
	},
	func:{
		up:'module',
		down:'opr'
	},
	opr:{
		up:'func',
		down:undefined
	}
}
/**
 * level:{key,recordtype,childKey,dataset(initionlized in init()),newRecord }
 */
page.mapLink = {
    app:{
        key:'appCode',
        rcdType:'appRecord2',
        childKey:'moduleCode',
        cmd:'org.loushang.bsp.permit.pap.function.cmd.ModuleCommand',
		queryCmd:'org.loushang.bsp.permit.pap.function.cmd.ModuleQueryCommand',
        dataset:null,
        newRecord:function(rcd,parentId,isModule,appName,appCode){//module
              var r = this.dataset.newRecord({
                moduleCode:rcd.get('moduleCode'),
                moduleName:rcd.get('moduleName'),
                parentModuleCode:rcd.get('parentModuleCode'),
                isLeafModule:rcd.get('isLeafModule'),
                seq:rcd.get('seq'),
                moduleAppCode:appCode?appCode:rcd.get('moduleAppCode'),
				appName:appName,
				modulePath:rcd.get('modulePath'),
				modulePathName:rcd.get('modulePathName')
            });
            if(isModule){
                r.set('parentModuleCode',parentId);
            }else{
             r.set('moduleAppCode',parentId);
             r.set('parentModuleCode','-1')
            }
          return r;
         }
    },
    module:{
        key:'moduleCode',
        rcdType:'moduleRecord2',
        childKey:'functionCode',
        cmd:'org.loushang.bsp.permit.pap.function.cmd.FunctionCommand',
		queryCmd:'org.loushang.bsp.permit.pap.function.cmd.FunctionQueryCommand',
        dataset:null,
        newRecord:function(rcd,parentId){//for function
            var r =   this.dataset.newRecord({
                functionCode:rcd.get('functionCode'),
                functionName:rcd.get('functionName'),
                moduleCode:rcd.get('moduleCode'),
                seq:rcd.get('seq')
            });
            r.set('moduleCode',parentId);
            return r;
        }
    },
    func:{
        key:'functionCode',
        rcdType:'functionRecord2',
        childKey:'operationCode',
        cmd:'org.loushang.bsp.permit.pap.function.cmd.OperationCommand',
		queryCmd:'org.loushang.bsp.permit.pap.function.cmd.OperationQueryCommand',
        dataset:null,
        newRecord:function(rcd,parentId){//for operation

            var r =   this.dataset.newRecord({
                operationCode:rcd.get('operationCode'),
                operationName:rcd.get('operationName'),
                functionCode:rcd.get('functionCode'),
                operationType:rcd.get('operationType'),
                isDefault:rcd.get('isDefault'),
				seq:rcd.get('seq')
            });
           r.set('functionCode',parentId);
           return r;
        }
    },
    opr:{
        key:'operationCode',
        rcdType:'operationCode2'
    }
};

page.cmdHelper=function(cmd,okMsg){
    if(!cmd.error){
    	if(okMsg){
        	L5.MessageBox.alert('提示：',okMsg);
    	}
		return true;

    }else{
        L5.MessageBox.alert('提示',cmd.error);
	return false;
    }
}
//删除节点前检查该节点是否有下级节点，如果有，不能删除
//@id : 该节点id  cmd:下级command
page.deleteCheck=function(id,cmd){
	var command = new L5.Command(cmd);
	command.setParameter('id',id);
	command.execute('checkDelete');
	var c = command.getReturn('count');
	if(parseInt(c,10)<1) return true;
	return false;
}
page.addAppText='添加应用';
page.addModuleText='添加模块';
page.javaCommand={
	app:{add:'insert',update:'update',move:'update'},
	module:{add:'insert',update:'update',move:'update'},
	func:{add:'insert',update:'update',move:'update'},
	opr:{add:'addOperation',update:'updateOperation',move:'moveOperation'}

}
function moduleName(record){
   return "<font color='red'>"+record.get("moduleName")+"</font>";
}
function alterPath(menuitem){
	var record=menuitem.parentMenu.record;
	page.currentRcd = record;
	var frame = document.getElementById("nodeFrame");
	var url = "select_function_tree.jsp";
	var treeId;
	var treeType;
	var menuId;
	if(record.recordType == "moduleRecord"){
		treeId= record.get("moduleCode");
		treeType="module";
		menuId=record.get("menuId");
	}else if(record.recordType == "functionRecord"){
		treeId= record.get("functionCode");
		treeType="function";
		menuId=record.get("menuId");
	}else if(record.recordType == "operationRecord"){
		treeId= record.get("operationCode");
		treeType="operation";
	}
	url = encodeURI(encodeURI(url+"?treeId="+treeId+"&treeType="+treeType+"&menuId="+menuId));
	frame.src=url;
}

//导入
function importInfo(item,e){
	var record=item.parentMenu.record;
	var path=window.showModalDialog("../../../organization/selectimport.jsp","","dialogHeight:550px;dialogWidth:500px;resizable:no;scroll:yes;dialogLeft:"+(window.screen.width-300)/2+";dialogTop:"+(window.screen.height-400)/2);
	if(path!=undefined&&path!=""){
		if(path.indexOf(":")==0){
			L5.Msg.alert("提示","请选择正确的文件目录");
			return;
		}
		L5.getCmp("detail").hide();
		e.stopEvent();
		var panel=L5.getCmp('dao');
		loadImportPage(panel,record,path);	
  }
}
	//页面加载时候使用的加载loading展现。
  function loadImportPage(panel,record,path) {	
	  var treeId,treeType;
		if(record.recordType == "appRecord"){
			treeId= record.get("appCode");
				treeType="app";
		}else if(record.recordType == "moduleRecord"){
			treeId= record.get("moduleCode");
			treeType="module";
		}else if(record.recordType == "functionRecord"){
			treeId= record.get("functionCode");
			treeType="function";
		}else if(record.recordType == "operationRecord"){
			treeId= record.get("operationCode");
			treeType="operation";
		}
		
		var iframes=panel.body.query('iframe');
		var loading=L5.fly('loadmask',panel.body);
		loading.setStyle("display","block");
		iframes[0].style.visibility="hidden";
		iframes[0].onload=iframes[0].onreadystatechange=function(){
		if(this.readyState=="complete"||!this.readyState){
			(function(){
				loading.dom.style.display="none";
				iframes[0].style.visibility="visible";
			}).defer(50);
			}
		}
		treeId = encodeURI(encodeURI(treeId));
		treeType = encodeURI(encodeURI(treeType));
		path= encodeURI(encodeURI(path));
		isLeafModule=encodeURI(encodeURI(record.get("isLeafModule")));
		var url="importInfo.jsp?treeId="+treeId+"&treeType="+treeType+"&path="+path+"&isLeafModule="+isLeafModule+"&dataType=function";
		iframes[0].src =url;
	}


//导出
function exportInfo(item,e){
	var record=item.parentMenu.record;
	var path=window.showModalDialog("../../../organization/selectexport.jsp","","dialogHeight:550px;dialogWidth:500px;resizable:no;scroll:yes;dialogLeft:"+(window.screen.width-300)/2+";dialogTop:"+(window.screen.height-400)/2);	
	if(path!=undefined&&path!=""){
		if(path.indexOf(":")==0){
			L5.Msg.alert("提示","请选择正确的文件目录");
			return;
		}
		L5.getCmp("detail").hide();	
//		L5.getCmp("daoru").hide();
		e.stopEvent();
		var panel=L5.getCmp('dao');
		loadExportPage(panel, record,path);	
	}
}

//页面加载时候使用的加载loading展现。
function loadExportPage(panel, record,path) {	
	var treeId,treeType;
	if(record.recordType == "appRecord"){
		treeId= record.get("appCode");
			treeType="app";
	}else if(record.recordType == "moduleRecord"){
		treeId= record.get("moduleCode");
		treeType="module";
	}else if(record.recordType == "functionRecord"){
		treeId= record.get("functionCode");
		treeType="function";
	}else if(record.recordType == "operationRecord"){
		treeId= record.get("operationCode");
		treeType="operation";
	}
	var iframes=panel.body.query('iframe');
	var loading=L5.fly('loadmask',panel.body);
	loading.setStyle("display","block");
	iframes[0].style.visibility="hidden";
	iframes[0].onload=iframes[0].onreadystatechange=function(){
	if(this.readyState=="complete"||!this.readyState){
		(function(){
			loading.dom.style.display="none";
			iframes[0].style.visibility="visible";
		}).defer(50);
		}
	}
	treeId = encodeURI(encodeURI(treeId));
	treeType = encodeURI(encodeURI(treeType));
	path= encodeURI(encodeURI(path));
	var url="exportInfo.jsp?treeId="+treeId+"&treeType="+treeType+"&path="+path+"&dataType=function";
	iframes[0].src =url;
}

window.load=function(node){
	   if(node.href){
	 		var tabs=L5.getCmp('dao');
	 		loadPage(tabs, node.record);
	 	}
	};