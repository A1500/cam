function init() {
	if(sign=="1"){
		 var DmXzqhDataSetQu = L5.DatasetMgr.lookup("DmXzqhDataSetQu");
		DmXzqhDataSetQu.setParameter("filterSql"," leve='2' and substr(id,0,4)= '"+organArea1+"'");
	    L5.DatasetMgr.lookup("DmXzqhDataSetQu").load();
	}else{
		document.getElementById("quQuery").disabled="disabled";
	    var DmXzqhDataSetQu = L5.DatasetMgr.lookup("DmXzqhDataSetQu");
	    var DmXzqhDataSetStreet = L5.DatasetMgr.lookup("DmXzqhDataSetStreet");
	    
		DmXzqhDataSetStreet.setParameter("filterSql"," leve='3' and substr(id,1,6)= '"+organArea+"'");
	    DmXzqhDataSetStreet.load();
	    
	    DmXzqhDataSetQu.setParameter("filterSql"," leve='2' and  id= '"+organArea2+"'");
	    DmXzqhDataSetQu.on("load", function onDmXzqhDataSetQuLoad() {
	    	document.getElementById("quQuery").selectedIndex=1;
	    });
	    DmXzqhDataSetQu.load();
	    
    }
    var ds = L5.DatasetMgr.lookup("ds");
    var jzfx = document.getElementById("jzfx").value;
    ds.setParameter("JZFX",jzfx);
    ds.load();
    L5.QuickTips.init();
    
};
function getDzStreet(){
    var DmXzqhDataSetStreet = L5.DatasetMgr.lookup("DmXzqhDataSetStreet");
	var DzQuQuery=document.getElementById("quQuery").value;
	DmXzqhDataSetStreet.setParameter("filterSql"," leve='3' and substr(id,1,6)= '"+DzQuQuery.substr(0,6)+"'");
    L5.DatasetMgr.lookup("DmXzqhDataSetStreet").load();

}

function getParam(ElementId) {
    var value = document.getElementById(ElementId).value;
    if (value == "") value = undefined;
    return value;
}
function query() {
    var hzxm = document.getElementById("hzxmquery").value;
    var sfzh = document.getElementById("sfzhquery").value;
    var shbz = document.getElementById("shbzquery").value;
    var lrdwId = document.getElementById("lrdwIdquery").value;
 
    ds.setParameter("YGJZ_JTXX.HZXM@=", hzxm);
    ds.setParameter("YGJZ_JTXX.SFZH@=", sfzh);
    ds.setParameter("YGJZ_JTXX.SHBZ@=", shbz);
    ds.setParameter("YGJZ_JTXX.LRDW_ID@=", lrdwId);
    
    ds.load();
}

function insert() {
    var data = new L5.Map();
    data.put("method", "INSERT");

    var url = 'jsp/sdmz/jtxx/ygjzjtxx_insert.jsp';
    var text = '增加阳光救助_家庭信息';
    L5.forward(url, text, data);

}
function toExam() {
	var ds = L5.DatasetMgr.lookup("ds");
    var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要移交的记录!");
		return false;
	}
	
	var jtids=[];
	for(var i=0;i<selected.length;i++){
		jtids[i]=selected[i].get("JTID");
	}
			
	L5.MessageBox.confirm('确定', '确定要移交选中的' + jtids.length + '条记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzJtxxCommand");
			command.setParameter("jtids", jtids);
			command.execute("toExam");
			if (!command.error) {
				ds.load();
			}else{
				L5.Msg.alert('提示',"提交时出现错误！"+command.error);
				return false;
			}
		}else{
			return false;
		}
	});
}

function update() {
    var editGrid = L5.getCmp('editGridPanel');
    var selected = editGrid.getSelectionModel().getSelections();
    if (selected.length != 1) {
        L5.Msg.alert('提示', "请选择一条记录修改!");
        return false;
    }
    var data = new L5.Map();
    data.put("method", "UPDATE");
    data.put("dataBean", selected[0].get('JTID'));
    var url = 'jsp/sdmz/jtxx/ygjzjtxx_update.jsp';
    var text = '修改阳光救助_家庭信息';
    L5.forward(url, text, data);
}
function jtxxCorrectHref(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:jtxxCorrectDetail(\'' + record.data["jtid"] + '\')">' + value + '</a>';
}
function jtxxCorrectDetail( jtid ) {
    var data = new L5.Map();
    data.put("method", "UPDATE");
    data.put("dataBean", jtid);
    var url = 'jsp/sdmz/jtxx/ygjzjtxx_update.jsp';
    var text = '审核阳光救助_家庭信息';
    L5.forward(url, text, data);
}
function jtxxCorrect() {
    var editGrid = L5.getCmp('editGridPanel');
    var selected = editGrid.getSelectionModel().getSelections();
    if (selected.length != 1) {
        L5.Msg.alert('提示', "请选择一条记录审核!");
        return false;
    }
    jtxxCorrectDetail(selected[0].get('jtid'));
}
function jtxxExamHref(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:jtxxExamDetail(\'' + record.data["JTID"] + '\')">' + value + '</a>';
}
function jtxxDetailHref(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:jtxxDetail(\'' + record.data["JTID"] + '\')">' + value + '</a>';
}
function jtxxStateHref(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:jtxxStateDetail(\'' + record.data["JTID"] + '\')">' + value + '</a>';
}
function jtxxDetail( jtid ) {
    var data = new L5.Map();
    data.put("method", "EXAM");
    data.put("dataBean", jtid);
    var url = 'jsp/sdmz/jtxx/ygjzjtxx_forDetail.jsp';
    var text = '审核阳光救助_家庭信息';
    L5.forward(url, text, data);
}
function jtxxExamDetail( jtid ) {
    var data = new L5.Map();
    data.put("method", "EXAM");
    data.put("dataBean", jtid);
    var url = 'jsp/sdmz/jtxx/ygjzjtxx_exam.jsp';
    var text = '审核阳光救助_家庭信息';
    L5.forward(url, text, data);
}
function jtxxStateDetail( jtid ) {
    var data = new L5.Map();
    data.put("method", "EXAM");
    data.put("dataBean", jtid);
    var url = 'jsp/sdmz/jtxx/ygjzjtxx_exam_detail.jsp';
    var text = '审核阳光救助_家庭信息';
    L5.forward(url, text, data);
}

function jtxxExam() {
    var editGrid = L5.getCmp('editGridPanel');
    var selected = editGrid.getSelectionModel().getSelections();
    if (selected.length != 1) {
        L5.Msg.alert('提示', "请选择一条记录审核!");
        return false;
    }
    jtxxExamDetail(selected[0].get('JTID'));
}

function del() {
	var ds = L5.DatasetMgr.lookup("ds");
    var editGrid = L5.getCmp('editGridPanel');
    var selected = editGrid.getSelectionModel().getSelections();
    if (selected.length < 1) {
        L5.Msg.alert('提示', "请选择要删除的记录!");
        return false;
    }
    L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',
    function(state) {
        if (state == "yes") {
            var delIds = [];
            for (var i = 0; i < selected.length; i++) {
                delIds[i] = selected[i].get("JTID");
            }
            var command = new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzJtxxCommand");
            command.setParameter("delIds", delIds);
            command.execute("delete");
            if (!command.error) {
                for (var i = 0; i < selected.length; i++) {
                    ds.remove(selected[i]);
                }
                ds.commitChanges();
            } else {
                L5.Msg.alert('提示', "保存时出现错误！" + command.error);
            }
        } else {
            return false;
        }
    });
}
/**
 * 事件处理：点击重置按钮
 *  licb
 */
function reset(){
	var form=L5.getDom("queryForm");
	form.reset();
}
/*
 * 通用帮助
 */
function forHelp(){
	var revalue=window.showModalDialog("../../bsp/organization/getselect.jsp?rootId=rootId&showOrganType=0&organType=1&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		//list[0] == organId,list[1]==organName,list[2]==struId
//		var userDataset = L5.DatasetMgr.lookup("userDataset");
//		var userRecord = userDataset.getCurrent();
		document.getElementById("lrdwId").value = list[0];
		document.getElementById("lrdwmc").value = list[1];
 
	}
}

function getDzCun() {
	 var DmXzqhDataSetVillage = L5.DatasetMgr.lookup("DmXzqhDataSetVillage");
	var dzZhenquery = document.getElementById("dzZhenquery").value;
	DmXzqhDataSetVillage.setParameter("filterSql"," leve='4' and substr(id,1,9)= '"+dzZhenquery.substr(0,9)+"'");
    L5.DatasetMgr.lookup("DmXzqhDataSetVillage").load();
}
/**
 * 救助指数查询
 */
function jzzsQuery(){
	var dataset = L5.DatasetMgr.lookup("ds");
	var hzxm = document.getElementById("hzxm").value;//户主姓名
	var sfzh = document.getElementById("sfzh").value;//身份证号
    var dzZhen = document.getElementById("dzZhenquery").value;//镇
    var dzCun = document.getElementById("dzCunquery").value;//村居
    var jzlx = document.getElementById("jzlxquery").value;//救助类型
    var houseQuality = document.getElementById("houseQuality").value;//住房类型
    var houseStatus = document.getElementById("houseStatus").value;//房屋状况
    var buildingStructure = document.getElementById("buildingStructure").value;//住房结构
    var sgzl = document.getElementById("sgzlquery").value;//事故种类
    var sgss = document.getElementById("sgssquery").value;//事故损失
    var jyzk = document.getElementById("jyzk").value;//教育阶段
    var zhzl = document.getElementById("zhzl").value;//灾害种类
    var zhssje = document.getElementById("zhssje").value;//灾害损失金额
    var cjlx = document.getElementById("cjlx").value;//残疾种类
    var cjdj = document.getElementById("cjdj").value;//残疾等级
    var hbzl = document.getElementById("hbzl").value;//患病种类
    var ylzc = document.getElementById("ylzc").value;//医疗支出
    var sylv = document.getElementById("sylv").value;//失业率
    var ylnl = document.getElementById("ylnl").value;//老人年龄
    var jzfx = document.getElementById("jzfx").value;//救助方向
    var quQuery = document.getElementById("quQuery").value;//救助方向
    
    if(hzxm=="") hzxm=undefined;
	dataset.setParameter("HZXM",hzxm);
	
	if(sfzh=="") sfzh=undefined;
	dataset.setParameter("SFZH",sfzh);
    
	if(dzZhen=="") dzZhen=undefined;
	dataset.setParameter("DZZHEN",dzZhen);
	
	if(dzCun=="") dzCun=undefined;
	dataset.setParameter("DZCUN",dzCun);
	
	if(jzlx=="") jzlx=undefined;
	dataset.setParameter("JZLX",jzlx);
	
	if(houseQuality=="") houseQuality=undefined;
	dataset.setParameter("HOUSE_QUALITY",houseQuality);
	
	if(houseStatus=="") houseStatus=undefined;
	dataset.setParameter("HOUSE_STATUS",houseStatus);
	
	if(buildingStructure=="") buildingStructure=undefined;
	dataset.setParameter("BUILDING_STRUCTURE",buildingStructure);
	
	if(sgzl=="") sgzl=undefined;
	dataset.setParameter("SGZL",sgzl);
	
	if(sgss=="") sgss=undefined;
	dataset.setParameter("SGSS",sgss);
	
	if(jyzk=="") jyzk=undefined;
	dataset.setParameter("JYZK",jyzk);
	
	if(zhzl=="") zhzl=undefined;
	dataset.setParameter("ZHZL",zhzl);
	
	if(zhssje=="") zhssje=undefined;
	dataset.setParameter("ZHSSJE",zhssje);
	
	if(cjlx=="") cjlx=undefined;
	dataset.setParameter("CJLX",cjlx);
	
	if(cjdj=="") cjdj=undefined;
	dataset.setParameter("CJDJ",cjdj);
	
	if(hbzl=="") hbzl=undefined;
	dataset.setParameter("HBZL",hbzl);
	
	if(ylzc=="") ylzc=undefined;
	dataset.setParameter("YLZC",ylzc);
	
	if(sylv=="") sylv=undefined;
	dataset.setParameter("SYLV",sylv);
 
	if(ylnl=="") ylnl=undefined;
	dataset.setParameter("YLNL",ylnl);
	
	if(jzfx=="") jzfx=undefined;
	dataset.setParameter("JZFX",jzfx);
	
	if(quQuery=="") quQuery=undefined;
	dataset.setParameter("DZQU",quQuery);
 
	dataset.load();
}
//help帮助
 function mutiHelp() {
	var itemWin = L5.getCmp("multiItem_help");
	if(itemWin) {
		itemWin.show();
		return;
	} else {
		var itemDs = L5.DatasetMgr.lookup("DmJzlxDataSet");
		var item_config={};
		item_config.id="multiItem_help";
		item_config.dataset = itemDs;
		item_config.gridColumns=[{header:"编号",sortable:true,field:"value"},{header:"名称",sortable:true,field:"text"}];
		var multiItem_search=new L5.SearchArea();
		//multiItem_search.addTextField("DM_JZLX.JZLXDM","编号","jzlxdm");
		//multiItem_search.addTextField("DM_JZLX.JZLXMC","名称","jzlxmc");
		itemWin = new L5.MultiGridHelpWindow1(item_config,multiItem_search);
		itemWin.show();
	}
	//进行调用
	itemWin.afterExecute=function(){
		var result=this.getReturn();
    	if(result!=null&&!itemWin.isClear){
    		setValue(result);
    	}
	}
}
//设置帮主栏值
function setValue(result) {
	var jzlx = document.getElementById("jzlx");
	var jzlxquery = document.getElementById("jzlxquery");
	jzlx.value="";
	jzlxquery.value="";
	var reValue = "";
	if(result.length) {
		for(var i=0;i<result.length;i++) {
			var record = result[i];
			if(jzlx.value=="") {
				jzlx.value += (record.get("text"));
				jzlxquery.value += (record.get("value"));
			} else {
				jzlx.value += (","+record.get("text"));
				jzlxquery.value += (","+record.get("value"));
			}
		}	
	} else {
		jzlx.value = result.get("text");
		jzlxquery.value = result.get("value");
	}
}

 
function calamityTypeRef(values) {
 if(values.length==0){
       return "";
    }
var DmXzqhDataSetStreet = L5.DatasetMgr.lookup("DmXzqhDataSetStreet");
	var texts=new Array();
	if (!(values instanceof Array)) {
		if(!values||values=="") {
			return;
		}
		values = values.split(',');
	}
	var records = DmXzqhDataSetStreet.getAllRecords();
	var record=DmXzqhDataSetStreet.find();
	if(records) {
		for(var r=0;r<records.length;r++) {
			if(values.indexOf(records[r].get("value"))!=-1) {
				texts.push(records[r].get("text"));
			}
		}
	}
	return texts.join(">");
}
//患病类型
function hblxRef(values) {
 if(values.length==0){
       return "";
    }
var DmHbzlDataSet = L5.DatasetMgr.lookup("DmHbzlDataSet");
	var texts=new Array();
	if (!(values instanceof Array)) {
		if(!values||values=="") {
			return;
		}
		values = values.split(',');
	}
	var records = DmHbzlDataSet.getAllRecords();
	var record=DmHbzlDataSet.find();
	if(records) {
		for(var r=0;r<records.length;r++) {
			if(values.indexOf(records[r].get("value"))!=-1) {
				texts.push(records[r].get("text"));
			}
		}
	}
	return texts.join(",");
}
//受助类型
function szlxRef(values) {
 if(values.length==0){
       return "";
    }
var DmJzlxDataSet = L5.DatasetMgr.lookup("DmJzlxDataSet");
	var texts=new Array();
	if (!(values instanceof Array)) {
		if(!values||values=="") {
			return;
		}
		values = values.split(',');
	}
	var records = DmJzlxDataSet.getAllRecords();
	var record=DmJzlxDataSet.find();
	if(records) {
		for(var r=0;r<records.length;r++) {
			if(values.indexOf(records[r].get("value"))!=-1) {
				texts.push(records[r].get("text"));
			}
		}
	}
	return texts.join(",");
}
//help帮助
 function mutiHelp() {
	var itemWin = L5.getCmp("multiItem_help");
	if(itemWin) {
		itemWin.show();
		return;
	} else {
		var itemDs = L5.DatasetMgr.lookup("DmJzlxDataSet");
		var item_config={};
		item_config.id="multiItem_help";
		item_config.dataset = itemDs;
		item_config.gridColumns=[{header:"编号",sortable:true,field:"value"},{header:"名称",sortable:true,field:"text"}];
		var multiItem_search=new L5.SearchArea();
		//multiItem_search.addTextField("DM_JZLX.JZLXDM","编号","jzlxdm");
		//multiItem_search.addTextField("DM_JZLX.JZLXMC","名称","jzlxmc");
		itemWin = new L5.MultiGridHelpWindow1(item_config,multiItem_search);
		itemWin.show();
	}
	//进行调用
	itemWin.afterExecute=function(){
		var result=this.getReturn();
    	if(result!=null&&!itemWin.isClear){
    		setValue(result);
    	}
	}
}
//设置帮主栏值
function setValue(result) {
	var jzlx = document.getElementById("jzlx");
	var jzlxquery = document.getElementById("jzlxquery");
	jzlx.value="";
	jzlxquery.value="";
	var reValue = "";
	if(result.length) {
		for(var i=0;i<result.length;i++) {
			var record = result[i];
			if(jzlx.value=="") {
				jzlx.value += (record.get("text"));
				jzlxquery.value += (record.get("value"));
			} else {
				jzlx.value += (","+record.get("text"));
				jzlxquery.value += (","+record.get("value"));
			}
		}	
	} else {
		jzlx.value = result.get("text");
		jzlxquery.value = result.get("value");
	}
}
//住房类型
function zfzkRef(values) {
 if(values.length==0){
       return "";
    }
var DmZfzklxDataSet = L5.DatasetMgr.lookup("DmZfzklxDataSet");
	var texts=new Array();
	if (!(values instanceof Array)) {
		if(!values||values=="") {
			return;
		}
		values = values.split(',');
	}
	var records = DmZfzklxDataSet.getAllRecords();
	var record=DmZfzklxDataSet.find();
	if(records) {
		for(var r=0;r<records.length;r++) {
			if(values.indexOf(records[r].get("value"))!=-1) {
				texts.push(records[r].get("text"));
			}
		}
	}
	return texts.join(",");
}
//残疾类型
function cjxxRef(values) {
 if(values.length==0){
       return "";
    }
var DmCjlxDataSet = L5.DatasetMgr.lookup("DmCjlxDataSet");
	var texts=new Array();
	if (!(values instanceof Array)) {
		if(!values||values=="") {
			return;
		}
		values = values.split(',');
	}
	var records = DmCjlxDataSet.getAllRecords();
	var record=DmCjlxDataSet.find();
	if(records) {
		for(var r=0;r<records.length;r++) {
			if(values.indexOf(records[r].get("value"))!=-1) {
				texts.push(records[r].get("text"));
			}
		}
	}
	return texts.join(",");
}
//住房类型
function jyjdRef(values) {
 if(values.length==0){
       return "";
    }
var DmJyzkDataSet = L5.DatasetMgr.lookup("DmJyzkDataSet");
	var texts=new Array();
	if (!(values instanceof Array)) {
		if(!values||values=="") {
			return;
		}
		values = values.split(',');
	}
	var records = DmJyzkDataSet.getAllRecords();
	var record=DmJyzkDataSet.find();
	if(records) {
		for(var r=0;r<records.length;r++) {
			if(values.indexOf(records[r].get("value"))!=-1) {
				texts.push(records[r].get("text"));
			}
		}
	}
	return texts.join(",");
}

 function jyzhRef(values) {
  if(values.length==0){
       return "";
    }
var DmZhzlDataSet = L5.DatasetMgr.lookup("DmZhzlDataSet");
	var texts=new Array();
	if (!(values instanceof Array)) {
		if(!values||values=="") {
			return;
		}
		values = values.split(',');
	}
	var records = DmZhzlDataSet.getAllRecords();
	var record=DmZhzlDataSet.find();
	if(records) {
		for(var r=0;r<records.length;r++) {
			if(values.indexOf(records[r].get("value"))!=-1) {
				texts.push(records[r].get("text"));
			}
		}
	}
	return texts.join(",");
}
//灾害种类
 function zrzhRef(values) {
  if(values.length==0){
       return "";
    }
var DmZhzlDataSet = L5.DatasetMgr.lookup("DmZhzlDataSet");
	var texts=new Array();
	if (!(values instanceof Array)) {
		if(!values||values=="") {
			return;
		}
		values = values.split(',');
	}
	var records = DmZhzlDataSet.getAllRecords();
	var record=DmZhzlDataSet.find();
	if(records) {
		for(var r=0;r<records.length;r++) {
			if(values.indexOf(records[r].get("value"))!=-1) {
				texts.push(records[r].get("text"));
			}
		}
	}
	return texts.join(",");
}

//事故种类
function sgzlRef(values) {
 if(values.length==0){
       return "";
    }
var DmSgzlDataSet = L5.DatasetMgr.lookup("DmSgzlDataSet");
	var texts=new Array();
	if (!(values instanceof Array)) {
		if(!values||values=="") {
			return;
		}
		values = values.split(',');
	}
	var records = DmSgzlDataSet.getAllRecords();
	var record=DmSgzlDataSet.find();
	if(records) {
		for(var r=0;r<records.length;r++) {
			if(values.indexOf(records[r].get("value"))!=-1) {
				texts.push(records[r].get("text"));
			}
		}
	}
	return texts.join(",");
}
function selectStructure(){
	var DmFwjgDataSet = L5.DatasetMgr.lookup("DmFwjgDataSet");
	var zfzklxdm=document.getElementById("zfzklxdm").value; 
	if(zfzklxdm==""){
		document.getElementById("fwzk").innerHTML="房屋结构:";
	}
	if(zfzklxdm=="1"){
		document.getElementById("fwzk").innerHTML="房屋结构:";
		DmFwjgDataSet.setParameter("filterSql", "code between 1 and 5");
		DmFwjgDataSet.load();
	}
	if(zfzklxdm=="2"){
		document.getElementById("fwzk").innerHTML="危险程度:";
		DmFwjgDataSet.setParameter("filterSql", "code='6' or code='7'");
		DmFwjgDataSet.load();
		
	}
	if(zfzklxdm=="3"){
		document.getElementById("fwzk").innerHTML="居住状况:";
		DmFwjgDataSet.setParameter("filterSql", "code='8' or code='9'");
		DmFwjgDataSet.load();
	}
	
}
//救助类型双击清空
function jzlxDbClick() {
	document.getElementById("jzlx").value="";
	document.getElementById("jzlxquery").value="";
}
function downloadExcel( type ) {
	var ds = L5.DatasetMgr.lookup("ds");
	if(ds.getTotalCount()==0) {
		//L5.Msg.alert("消息","无可导出数据！");
		return;
	}
	if(type==undefined) return;
	var pageSize = ds.pageInfo.pageSize;
	//var pageIndex = ds.pageInfo.pageIndex;
	var startCursor = ds.pageInfo.startCursor;
	ds.baseParams["excelType"]="0";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	ds.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	ds.baseParams["limitExcel"]=pageSize;  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	L5.dataset2excel(ds, "/jsp/sdmz/jzzs/downloadJzzsExcel.jsp?type="+type);
	ds.baseParams["excelType"]="reset"; //重置导出类型
}
function JzzsCjExcel() {  //残疾救助指数excel导出
	downloadExcel("cj");
}
function JzzsDqExcel() {  //单亲救助指数excel导出
	downloadExcel("dq");
}
function JzzsJyExcel() {  //教育救助指数excel导出
	downloadExcel("jy");
}
function JzzsJyeExcel() {  //就业救助指数excel导出
	downloadExcel("jye");
}
function JzzsSgExcel() {  //事故救助指数excel导出
	downloadExcel("sg");
}
function JzzsYlExcel() {  //医疗救助指数excel导出
	downloadExcel("yl");
}
function JzzsYlaoExcel() {  //养老救助指数excel导出
	downloadExcel("ylao");
}
function JzzsZhfExcel() {  //住房救助指数excel导出
	downloadExcel("zhf");
}
function JzzsZrzhExcel() {  //自然灾害救助指数excel导出
	downloadExcel("zrzh");
}
function JzzsZhExcel() {  //综合
	downloadExcel("zh");
}