
function init(){
		var struTypeNameTitle=L5.getCmp("struTypeNameTitle");
		struTypeName = unescape(struTypeName);
		struTypeNameTitle.setTitle("组织结构树--"+struTypeName);
		parentOrganType.setParameter("PUB_ORGAN_TYPE.IN_USE@=","1");
		parentOrganType.load();
        var tree = L5.getCmp('strutree1');
        tree.root.expand();
    }
	var str=struTypeId;
	if(str=="null" || str==""){
		str="00";
	}
/**
 * 定义根节点结构
 */
var rootdata = {
	id : 'rootId',//唯一标志record,如果是前台配置生成record,需要指定id
	struId:'rootId',
	organId:'rootId',
	struType:str,
	parentId:'-1',
	struLevel:'0',
	struPath:'rootId',
	struOrder:'1',
	isLeaf:'0',
	inUseStru:'1',
	organId:'rootId',
	organName:'组织树',
	shortName:'根结点',
	organType:'1',
	organTypeName:'单位',
	struTypeName:'人力资源',
	inUseOrgan:'1',
	recordType : 'struRecord'
};

/**
 * 事件处理：获得 TreebaseParams的值
 */
function getStruParent(rec){
	var parentId = rec.get('parentId');
	return parentId;
}
function getStruId(rec){
	var struId=rec.get('struId');
	return struId?struId:"rootId";
}
function getStruType(rec){
	var struType=rec.get('struType');
	return struType?struType:"00";
}
function getStruTypeId(rec){
	return struTypeId?struTypeId:"00";
}
/**
 * 事件处理：设置organId为空
 */
function getStrudisabled(rec){
	return false;
}

function getIsLeaf(rec){
	var leaf1=rec.get('isLeaf');
	if(leaf1=='1'){
		return true;
	}else{
		return false;
	}
}
/**
* 事件处理：将节点信息添加到table中
*/
function selectedStru(record){
	formset.removeAll();
	formset.add(record);
	flag="detail";
	organextId=record.get("organId");
    loadOrganExt();
	L5.getCmp("detailpanel").show();
	if(record.get("struId")=="rootId"){
		L5.getCmp("detailpanel").hide();
	}
	L5.getCmp("updatePanel").hide();
	L5.getCmp("searchsubpanel").hide();
	L5.getCmp("rootPanel").hide();
	L5.getCmp("dao").hide();
}

function save(){
	//校验信息
	var validMsg = fieldValid();
	if(validMsg != null ){
	 	L5.Msg.alert("提示",validMsg);
		return false;
	}
	var record=formset.getCurrent();
	if(record){
		//保存数据
         var command=new L5.Command("org.loushang.bsp.organization.cmd.StruCommand");
         command.setParameter("record",record);
         var msg=setOrganExtParameter(command);
         if(msg!==true){
            return false;
         }
         var treerecord=L5.getCmp("strutree1").getCurrentRecord();
         command.setParameter("treerecord",treerecord);
         var parentStruId=L5.getCmp("strutree1").getCurrentRecord().get("struId");
         command.setParameter("parentStruId",parentStruId);
         if(flag=="insert"){
         	command.execute("insert");
         }else{
         	command.execute("update");
         }
         var elsefunction=function(){
					//更新树节点数据
					if(flag=="insert"){//增加
						var newRecord=command.getReturn("resultRecord");
						delete newRecord.javaClass;
						var rec = L5.tree.TreeRecord.createRecord("struRecord",newRecord);
			        	var treerecordup=L5.getCmp("strutree1").getCurrentRecord();//树的当前选中节点的record
			        	treerecordup.data.isLeaf="0";
						treerecordup.insert(rec);
						var organTypeName=command.getReturn("organTypeName");
						var mgr=formset.getCurrent();
	    				mgr.set("organTypeName",organTypeName);
	    				mgr.set("deptName",newRecord.deptName?newRecord.deptName:"");
	    				mgr.set("cropName",newRecord.cropName?newRecord.cropName:"");
	    				mgr.set("principalName",newRecord.principalName?newRecord.principalName:"");
					}
					if(flag=="update"){//修改
						var organType=record.get("organType");
						if(organType.substring(0,1)=="1"){//修改为“单位”组织类型
							record.set("cropName",record.get("organName"));
							record.set("deptName",record.get("organName"));
						}
						if(organType.substring(0,1)=="2"){//由单位修改为部门，所属部门名称不变，所属单位应该为父节点的所属单位
							record.set("deptName",record.get("organName"));
							record.set("cropName",command.getReturn('parentcorpName'));
						}
						var tree = L5.getCmp("strutree1");
						var node = tree.getNodeByRecordId(record.get("struId"), "struRecord");
						node.record.set("organName", record.get("organName"));
						//node.setText(record.get("principalName"));
						node.record.set("principalName",record.get("principalName"));
						node.record.set("organTypeName",command.getReturn("organTypeName"));
						node.record.commit();
						refreshNode("strutree1", record.get("struId"),record.recordType);
					}
					L5.Msg.alert("提示","保存成功！");
					formset.removeAll();
					formset.insert(0,record);
					loadOrganExt();
					//refreshOrganExt();
					L5.getCmp("detailpanel").show();
					L5.getCmp("updatePanel").hide();
					L5.getCmp("searchsubpanel").hide();
					L5.getCmp("rootPanel").hide();
					L5.getCmp("dao").hide();
					
				}
         	if(!command.error){
         		if(flag=="insert"){
					var organType = document.getElementById("organTypeinput").value;
					if(struTypeId=="00"&&organType.substring(0,1)=="8"){
	         			L5.MessageBox.confirm('确认','已创建员工，是否要增加员工对应的用户？',function(state){
							if(state=="yes"){
								var struId=command.getReturn("struId");
								var organName=escape(escape(command.getReturn("organName")));
								var revalue=window.showModalDialog("adduserinfo.jsp?struId="+struId+"&organName="+organName,"","dialogHeight:550px;dialogWidth:500px;resizable:no;scroll:yes;dialogLeft:"+(window.screen.width-300)/2+";dialogTop:"+(window.screen.height-400)/2);
							}
							elsefunction();
						});
					}else{
						elsefunction();
					}
         		}else{
         			elsefunction();
         		}
         	}else{
         		L5.Msg.alert("提示",command.error);
         	}
	}
}

//根据类型值获取图标路径
function getIcon(rec){
	var figpath=L5.webPath+"/skins/images";
	var file=figpath+"/l5/bsp_department&corporation.gif";
	if(!rec){
		return file;
	}
	var organType=rec.get('organType');
	var type=organType.substring(0, 1);
	var value=parseInt(type);
	switch(value){
			case 0: //根结点
				file =figpath+"/l5/root.gif";
				break;
			case 1: // 法人
				file =figpath+"/l5/bsp_department&corporation.gif";
				break;
			case 2: // 部门
				file =figpath+ "/l5/bsp_department&corporation.gif";
				break;
			case 6: // 岗位
				file = figpath+"/l5/bsp_post.png";
				break;
			case 8: // 职工
				file =figpath+ "/l5/bsp_employee.gif";
				break;
			default:
				file =figpath+ "/l5/other.gif";

	}
	if(rec.get('id') == 'rootId'){
		file = figpath+'/l5/root.gif';
	}
	return file;
}

function handler(record){
    if(record.get("struId")=="rootId"){
    	return true;
    }
    return false;
}

function handlerOther(record){
if(record.get("struType")!="00"){
    	return true;
    }
    return false;
}

function handlerEmployee(record){
if(record.get("organType").substring(0,1)=="8"){
    	return true;
    }
    return false;

}
//判断是增加还是修改方法
var flag="";
//树节点的id
var organextId=""
//页面值校验判断

function fieldValid(){
	//组织代码校验
	var organCode = document.getElementById("organCodeinput").value;
	if(organCode==null || organCode==""){
		return "组织代码不能为空！";
	}
	//组织名称校验

	var organName = document.getElementById("organNameinput").value;
	if(organName==null || organName==""){
		return "组织名称不能为空！";
	}
	//组织类型名称校验

	var organType = document.getElementById("organTypeinput").value;
	if(organType==null || organType==""){
		return "请选择组织类型！";
	}
 	var re = /\"|\'|\“|\”|\‘|\’|\%|\$|\￥|\……|\·|\—|\-|\——|\!|\！|\#|\@|\~|\^|\*|\,|\.|\，|\。|\?|\？|\;|\；|\:|\：|\{|\}|\\|\/|\[|\]|\(|\)|\+|\-|\、|\||\<|\>/;
	if(re.test(organName)){
		return  "组织名称不能包含特殊字符！";
	}
}
//增加下级
function  addSub(menuitem){
	var tree = menuitem.parentMenu.record;
	var command=new L5.Command("org.loushang.bsp.organization.cmd.StruCommand");
	L5.getCmp("detailpanel").hide();
	L5.getCmp("searchsubpanel").hide();
	L5.getCmp("rootPanel").hide();
	L5.getCmp("dao").hide();
	L5.getCmp("updatePanel").show();
	var struTypeName=tree.get("struTypeName");
	var struId=tree.get("struId");
	var parentOrganCode=tree.get("organCode");
	formset.removeAll();
	var mgr=formset.newRecord();
	mgr.set("struTypeName",struTypeName);
	command.setParameter("struId",struId);
	command.execute("getInitOrganCode");
	var organCode_a=command.getReturn("organCode");
	mgr.set("organCode",parentOrganCode+organCode_a);
	flag="insert";
	//var parentStruId=L5.getCmp("strutree1").getCurrentRecord().get("struId");
	var parentStruId=tree.get("struId");
	parentOrganType.setParameter("parentStruId",parentStruId);
	parentOrganType.setParameter("PUB_ORGAN_TYPE.IN_USE@=","1");
	parentOrganType.load();
	loadOrganExt();
}
//修改
function  update(menuitem){
	var tree = menuitem.parentMenu.record;
	//struId=tree.get("struId");
	formset.removeAll();
	L5.getCmp("detailpanel").hide();
	L5.getCmp("updatePanel").show();
	L5.getCmp("searchsubpanel").hide();
	L5.getCmp("rootPanel").hide();
	L5.getCmp("dao").hide();
	flag="update";
	var parentStruId=tree.get("struId");
	parentOrganType.setParameter("parentStruId",parentStruId);
	parentOrganType.setParameter("PUB_ORGAN_TYPE.IN_USE@=","1");
	parentOrganType.setParameter("flag",flag);
	parentOrganType.load();
	formset.add(tree);
	organextId=formset.getCurrent().get("organId");
    loadOrganExt();
}

function delStru(menuitem){
    L5.MessageBox.confirm('确认', '确定要删除所选组织吗？',function(sta){
		if(sta=="yes"){
			var record = menuitem.parentMenu.record;
			var command=new L5.Command("org.loushang.bsp.organization.cmd.StruCommand");
			command.setParameter("record",record);
			//setOrganExtParameter(command)

			command.execute("delStru");
			if(!command.error){
				var prec = record.parentRecord;
				if(prec){
					prec.remove(record);
				}
				L5.Msg.alert("提示","操作成功！");
			}else{
				L5.Msg.alert("提示",command.error);
			}
		}
		else{
		 	return false;
		}
	});

}
//选择下级
function selectStru(menuitem){
	var record = menuitem.parentMenu.record;
	var upstruId=record.get('struId');
	var struType=record.get('struType');
	var revalue=window.showModalDialog("selectsubtree.jsp?struType="+struType+"&upstruId="+upstruId,"","dialogHeight:550px;dialogWidth:500px;resizable:no;scroll:yes;dialogLeft:"+(window.screen.width-300)/2+";dialogTop:"+(window.screen.height-400)/2);
	if(revalue=="OK"){
		refreshNode("strutree1", upstruId,record.recordType);
	}
}
//下级排序
function forOrder(menuitem){
	var record = menuitem.parentMenu.record;
	var struId=record.get('struId');

	var url="ordersub.jsp?struId="+struId;
	var retValue=window.showModalDialog(url,"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;dialogLeft:"+(window.screen.width-450)/2+";dialogTop:"+(window.screen.height-500)/2);
	if(retValue=="OK"){
		refreshNode("strutree1", struId,record.recordType);
	}
}

//其他组织结构类型选择下级组织
function select(menuitem){
//	alert("从人力资源树选择下级");
	var record = menuitem.parentMenu.record;
	var upstruId=record.get('struId');
	var struType=record.get('struType');
	var revalue=window.showModalDialog("selectbasetree.jsp?struType="+struType+"&upstruId="+upstruId,"","dialogHeight:550px;dialogWidth:500px;resizable:no;scroll:yes;dialogLeft:"+(window.screen.width-300)/2+";dialogTop:"+(window.screen.height-400)/2);
	if(revalue=="OK"){
		refreshNode("strutree1", upstruId,record.recordType);
	}

}

//变更隶属关系
function forMergeTo(menuitem){
	var record = menuitem.parentMenu.record;
	var struId=record.get('struId');
	var organId=record.get('organId');
	var organType=record.get('organType');
	var struType=record.get('struType');
	var url="mergeroot.jsp?organId="+organId+"&struType="+struType+"&srcStruId="+struId+"&organType="+organType;
	var revalue=window.showModalDialog(url,"","dialogHeight:500px;dialogWidth:500px;resizable:no;scroll:yes;dialogLeft:"+(window.screen.width-500)/2+";dialogTop:"+(window.screen.height-500)/2);
	if(revalue){
	var list = revalue.split(";");
		if(list[0]=="OK"){
			refreshNodeForMerge("strutree1", list[1],list[2],record.recordType);
		}
	}

}

//搜索下级
function  searchSub(menuitem){
	var record = menuitem.parentMenu.record;
	var struId=record.get('struId');
	ds.setParameter("struId",struId);
	ds.setParameter("record",record);
    ds.load();
	L5.getCmp("detailpanel").hide();
	L5.getCmp("updatePanel").hide();
	L5.getCmp("rootPanel").hide();
	L5.getCmp("dao").hide();
	L5.getCmp("searchsubpanel").show();
	organTypeDs.setParameter("PUB_ORGAN_TYPE.IN_USE@=","1");
	organTypeDs.load();
}

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
//搜索下级中的查询
function query(){
//	var organTypeIdq=getParam("organTypequery");
	var organCodeq=getParam("organCodequery");
	var organNameq=getParam("organNamequery");
	if(organCodeq!=undefined&&organCodeq!==""&&organCodeq.indexOf("'")!=-1){//包含单引号
		L5.MessageBox.alert("提示",'查询条件中不能包含单引号字符');
        return;
	}
	if(organNameq!=undefined&&organNameq!==""&&organNameq.indexOf("'")!=-1){
		L5.MessageBox.alert("提示",'查询条件中不能包含单引号字符');
        return;
	}
	//ds.setParameter("organTypeIdq",organTypeIdq);
	ds.setParameter("organCodeq",organCodeq);
	ds.setParameter("organNameq",organNameq);
	var treerecord=L5.getCmp("strutree1").getCurrentRecord();
	var struId=treerecord.get("struId");
	ds.setParameter("struId",struId);
	ds.load();
}

//定位
function locate(menuitem){
	var record=ds.getCurrent();
	var command=new L5.Command("org.loushang.bsp.organization.cmd.StruCommand");
   	command.setParameter("record",record);
   	command.execute("locate");
   	var locatePath="/"+command.getReturn("locatePath");
	L5.getCmp("strutree1").selectPath(locatePath,"struPath");
}

//根节点增加
function add(menuitem){
	L5.getCmp("detailpanel").hide();
	L5.getCmp("updatePanel").hide();
	L5.getCmp("searchsubpanel").hide();
	
	L5.getCmp("dao").hide();
	L5.getCmp("rootPanel").show();
	var treerecord=L5.getCmp("strutree1").getCurrentRecord();
	var struTypeName=treerecord.get("struTypeName");
	var organType=treerecord.get("organType");
	var organTypeName=treerecord.get("organTypeName");
	formset.removeAll();
	var mgr=formset.newRecord();
	mgr.set("struTypeName",struTypeName);
	mgr.set("organType",organType);
	mgr.set("organTypeName",organTypeName);
	flag="insert";
}

function selectPrincipalId(){
	var treerecord=L5.getCmp("strutree1").getCurrentRecord();
	var struType = treerecord.get("struType");
	var struId = treerecord.get("struId");
	var choiceOrganType="8";
	var choiceBox="radiobox";
	var revalue=window.showModalDialog("selectstru.jsp?struType="+struType+"&struId="+struId+"&choiceOrganType="+choiceOrganType+"&choiceBox="+choiceBox,"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;dialogLeft:"+(window.screen.width-300)/2+";dialogTop:"+(window.screen.height-400)/2);
    var mgr=formset.getCurrent();
    if(revalue!=undefined){
    	var list = revalue.split(";");//list[0] == princiaplId,list[1]==principalName
      	mgr.set("principalName",list[1]);
   	 	mgr.set("principalId",list[0]);
    }
}

function updateSelectPrincipalId(){
	var treerecord=L5.getCmp("strutree1").getCurrentRecord();
	var struType = treerecord.get("struType");
	var struId = treerecord.get("struId");
	var choiceOrganType="8";
	var choiceBox="radiobox";
	var revalue=window.showModalDialog("selectstru.jsp?struType="+struType+"&struId="+struId+"&choiceOrganType="+choiceOrganType+"&choiceBox="+choiceBox,"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;dialogLeft:"+(window.screen.width-300)/2+";dialogTop:"+(window.screen.height-400)/2);
    var mgr=formset.getCurrent();
    if(revalue!=undefined&&revalue!=""){
    	var list = revalue.split(";");//list[0] == princiaplId,list[1]==principalName
      	mgr.set("principalName",list[1]);
   	 	mgr.set("principalId",list[0]);
   	 	L5.fly('principalName1').dom.value=list[1];
		L5.fireEvent("principalName1","blur");
		//L5.fly('principalId1').dom.value=list[1];
		//L5.fireEvent("principalId1","blur");
    }

}

//树的节点的刷新
function refreshNode(treeId, recordId,type) {

		var tree = L5.getCmp(treeId);
		var node = tree.getNodeByRecordId(recordId,type);
		var record = node.record;
		record.reload({callback:function(){node.expand();}});
}

//树的节点的刷新，变更隶属关系
function refreshNodeForMerge(treeId, recordId,srcRecordId,type) {

		var tree = L5.getCmp(treeId);
		//处理变更节点的源父节点:从源父节点上删除变更的节点
		var srcNode=tree.getNodeByRecordId(srcRecordId,type);
		var srcRecord=srcNode.record;
		var prec = srcRecord.parentRecord;
			if(prec){
				prec.remove(srcRecord);
			}
		//处理变更节点的目标父节点:
		//如果目标父节点已经被展开过（节点数据已被加载了），前台重新加载一次数据，刷新节点；
		//如果目标父节点没有被展开过（节点数据没有被加载），前台不做处理（在后台处理数据，变更节点关系），当展开节点时会重新请求一次数据，获取修改后的数据。
		var node = tree.getNodeByRecordId(recordId,type);
		if(node){
			var record = node.record;
			record.reload({callback:function(){node.expand();}});
		}

}

function setParams(menuitem){
	var record = menuitem.parentMenu.record;
	var organId=record.get('organId');
	var revalue=window.showModalDialog("../organization/organparms/puborganparms_listform.jsp?organId="+organId,"","dialogHeight:550px;dialogWidth:500px;resizable:no;scroll:yes;dialogLeft:"+(window.screen.width-300)/2+";dialogTop:"+(window.screen.height-400)/2);
}

function setStruOrder(menuitem){
	var record = menuitem.parentMenu.record;
	var struId=record.get("struId");
	var struOrder=record.get("struOrder").toString();
	var cmd=new L5.Command("org.loushang.bsp.organization.cmd.StruCommand");
	L5.MessageBox.prompt("", "请输入顺序号(大于等于0且长度小于等于9的整数)", function(e,corptext){
		if(e=="ok"){
			var valid_seq_reg=/^[0-9]+$/;
		    if(!corptext.match( valid_seq_reg)){
		    	L5.MessageBox.alert("提示",'序号只能为整数');
				return;
		    }
		    if(corptext.length > 9){
		    	L5.Msg.alert("提示","顺序号的长度超过最大值");
		    	return;
		    }
		cmd.setParameter("struId",struId);
		cmd.setParameter("struOrder",corptext);
		cmd.execute("updateStruOrder");
		
		if (!cmd.error) {
		   L5.MessageBox.alert("提示","顺序号修改成功");
		}else{
			L5.Msg.alert("提示","顺序号修改失败");
			return;
		}
		
		var sorder=cmd.getReturn("struOrder");
		var treerecordup=L5.getCmp("strutree1").getCurrentRecord();//树的当前选中节点的record
		treerecordup.data.struOrder=sorder;
	 }
	},this,false,struOrder);
	//刷新树上节点
}
//导入
function importStru(menuitem,e){
	var record = menuitem.parentMenu.record;
	var path=window.showModalDialog("selectimport.jsp","","dialogHeight:550px;dialogWidth:500px;resizable:no;scroll:yes;dialogLeft:"+(window.screen.width-300)/2+";dialogTop:"+(window.screen.height-400)/2);
	if(path!=undefined&&path!=""){
		if(path.indexOf(":")==0){
			L5.Msg.alert("提示","请选择正确的文件目录");
			return;
		}
		L5.getCmp("detailpanel").hide();
		L5.getCmp("updatePanel").hide();
		L5.getCmp("rootPanel").hide();
		L5.getCmp("searchsubpanel").hide();
		L5.getCmp("dao").show();
		e.stopEvent();
		var panel=L5.getCmp('dao');
		loadImportPage(panel,record,path);
	}
}

//组织导入时加载
function loadImportPage(panel,record,path) {
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
		path= encodeURI(encodeURI(path));
		var url="../permit/pap/function/importInfo.jsp?path="+path+"&dataType=organ";
		iframes[0].src =url;
	}	



//导出
function exportStru(menuitem,e){
	var record = menuitem.parentMenu.record;
	var path=window.showModalDialog("selectexport.jsp","","dialogHeight:550px;dialogWidth:500px;resizable:no;scroll:yes;dialogLeft:"+(window.screen.width-300)/2+";dialogTop:"+(window.screen.height-400)/2);
	if(path!=undefined&&path!=""){
		if(path.indexOf(":")==0){
			L5.Msg.alert("提示","请选择正确的文件目录");
			return;
		}
		L5.getCmp("detailpanel").hide();
		L5.getCmp("updatePanel").hide();
		L5.getCmp("rootPanel").hide();
		L5.getCmp("searchsubpanel").hide();
		L5.getCmp("dao").show();
		
		e.stopEvent();
		var panel=L5.getCmp('dao');
		loadExportPage(panel,record,path);
	}
}

//组织导出时加载
function loadExportPage(panel,record,path) {	
	var struId=record.get("struId");
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
	struId = encodeURI(encodeURI(struId));
	path= encodeURI(encodeURI(path));
	struTypeId=encodeURI(encodeURI(struTypeId));
	var url="../permit/pap/function/exportInfo.jsp?struId="+struId+"&struTypeId="+struTypeId+"&path="+path+"&dataType=organ";
	iframes[0].src =url;
}
