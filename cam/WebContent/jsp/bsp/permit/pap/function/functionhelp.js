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
/**
 * 页面初始函数
 */
function init() {
	L5.QuickTips.init();
	page.tree = L5.getCmp('functiontree');
   //page.poptree = L5.getCmp('functiontree2');
    page.mapLink.app.dataset = moduleDataset;
    page.mapLink.module.dataset=functionDataset;
    page.mapLink.func.dataset =operationDataset;
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
	if((rcdTp == "appRecord") &&
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
	if((rcdTp == "appRecord") ){
       		return true;
	}

	if((rcdTp == "moduleRecord")&&
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
	if((rcdTp == "moduleRecord") &&
		 record.get("isLeafModule") == "1" ){
                 if(page.popWin.loadStoped['module'] ){
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

function moduleName(record){
   return "<font color='red'>"+record.get("moduleName")+"</font>";
}

function confirmValue(){
    var tree = L5.getCmp('functiontree');
    var arr=new Array();
    if(choiceType=="moduleRecord"){
      var moduleCode=tree.getChecked("moduleCode");
      var moduleName=tree.getChecked("moduleName");
      //var parentModuleCode=tree.getChecked("parentModuleCode");
      //var modulePath=tree.getChecked("modulePath");
      //var modulePathName=tree.getChecked("modulePathName");
      if(moduleCode!="" && moduleName!=""){
        if(returnValueType=="array"){
          arr[0]=moduleCode;
          arr[1]=moduleName;
          window.returnValue=arr;
        }else{
         window.returnValue=moduleCode+";"+moduleName;
        }
        window.close();
      }
    }else if(choiceType=="functionRecord"){
	      var functionCode=tree.getChecked("functionCode");
	      var functionName=tree.getChecked("functionName");
	      if(functionCode!="" && functionName!=""){
	       if(returnValueType=="array"){
	          arr[0]=functionCode;
	          arr[1]=functionName;
              window.returnValue=arr;
           }else{
            window.returnValue=functionCode+";"+functionName;
           }
			window.close();
	      }
	    }else if(choiceType=="operationRecord"){
	      var operationCode=tree.getChecked("operationCode");
	      var operationName=tree.getChecked("operationName");
	      if(operationCode!="" && operationName!=""){
	        if(returnValueType=="array"){
	          arr[0]=operationCode;
	          arr[1]=operationName;
	          window.returnValue=arr;
	        }else{
	         window.returnValue=operationCode+";"+operationName;
	        }
			window.close();
	       }
	   	 }
}

function closew(){
	//return false;
	window.returnValue="";
	window.close();
}

function clears(){ 
	if(returnValueType=="array"){
		var arr = new Array();
		arr[0] = "";
		arr[1] = "";
		window.returnValue = arr;
	}else{
		window.returnValue=""+";"+"";
	}
	window.close();
}

function getChoiceBox(record){
  if(record.isRoot){
		return "text";
	}
  var type=record.recordType;
  if(choiceType=="app"){
    choiceType="appRecord";
  }
  if(choiceType=="module"){
    choiceType="moduleRecord";
  }
  if(choiceType=="function"){
   choiceType="functionRecord";
  }
  if(choiceType=="operation"){
   choiceType="operationRecord";
  }
  if(type==choiceType){
     if(isCheckBox=="0"){
			return  'radiobox';
		}else{
			return  'checkbox';
		}
  }
}