function init() {
    var ds = L5.DatasetMgr.lookup("ds");
    var queryFlag = document.getElementById("queryFlag").value;
    ds.setParameter("QUERYFLAG",queryFlag);
    ds.setParameter("organCode",organArea);
     if(sign!=1){
    	ds.load();
    }
    L5.QuickTips.init();
};

function getParam(ElementId) {
    var value = document.getElementById(ElementId).value;
    if (value == "") value = undefined;
    return value;
}
function query() {
    var hzxm = document.getElementById("hzxmquery").value;
    var sfzh = document.getElementById("sfzhquery").value;

    ds.setParameter("BASEINFO_FAMILY.FAMILY_NAME@=", hzxm);
    ds.setParameter("BASEINFO_FAMILY.FAMILY_CARD_NO@=", sfzh);
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
    var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要移交的记录!");
		return false;
	}

	var jtids=[];
	for(var i=0;i<selected.length;i++){
		jtids[i]=selected[i].get("familyId");
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
    data.put("dataBean", selected[0].get('familyId'));
    var url = 'jsp/sdmz/jtxx/ygjzjtxx_update.jsp';
    var text = '修改阳光救助_家庭信息';
    L5.forward(url, text, data);
}
function jtxxCorrectHref(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:jtxxCorrectDetail(\'' + record.data["FAMILY_ID"] + '\')">' + value + '</a>';
}
function jtxxCorrectDetail(familyId,photoid) {
    var data = new L5.Map();
    data.put("method", "UPDATE");
    data.put("dataBean", familyId);
    data.put("photoId", photoid);
    var url = 'jsp/sdmz/jtxx/ygjzjtxx_correct.jsp';
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
    jtxxCorrectDetail(selected[0].get('familyId'));
}
function jtxxExamHref(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:jtxxExamDetail(\'' + record.data["FAMILY_ID"] + '\')">' + value + '</a>';
}
function jtxxExamDetail( familyId ) {
    var data = new L5.Map();
    data.put("method", "EXAM");
    data.put("dataBean", familyId);
    var url = 'jsp/sdmz/jtxx/ygjzjtxx_exam.jsp';
    var text = '审核阳光救助_家庭信息';
    L5.forward(url, text, data);
}
function jtxxListCorrect() {
    var editGrid = L5.getCmp('editGridPanel');
    var selected = editGrid.getSelectionModel().getSelections();
    if (selected.length != 1) {
        L5.Msg.alert('提示', "请选择一条记录更正!");
        return false;
    }
    jtxxCorrectDetail(selected[0].get('FAMILY_ID'),selected[0].get('PHOTO_ID'));
}

function del() {
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
                delIds[i] = selected[i].get("familyId");
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
 * 家庭信息查询
 */
function jtxxQuery(){
	var dataset = L5.DatasetMgr.lookup("ds");
	var lrrqQ=document.getElementById("lrrqQ").value;//录入时间
	var lrrqZ=document.getElementById("lrrqZ").value;//录入时间
    var hzxm = document.getElementById("hzxmquery").value;
    var sfzh = document.getElementById("sfzhquery").value;
    var shbz = document.getElementById("shbzquery").value;
    var lrdwId = document.getElementById("lrdwIdquery").value;
    var jzlxdm = document.getElementById("jzlxquery").value;
	var queryFlag = document.getElementById("queryFlag").value;

	if(hzxm=="") hzxm=undefined;
	dataset.setParameter("FAMILY_NAME",hzxm);
	if(lrrqQ=="") lrrqQ=undefined;
	dataset.setParameter("REG_TIMEQ", lrrqQ);
	if(lrrqZ=="") lrrqZ=undefined;
    dataset.setParameter("REG_TIMEZ", lrrqZ)
	if(sfzh=="") sfzh=undefined;
	dataset.setParameter("FAMILY_CARD_NO",sfzh);

	if(shbz=="") shbz=undefined;
	dataset.setParameter("SHBZ",shbz);

	if(lrdwId=="") lrdwId=undefined;
	dataset.setParameter("REG_ORG",lrdwId);

	if(jzlxdm=="") jzlxdm=undefined;
	dataset.setParameter("ASSISTANCE_TYPE",jzlxdm);

	if(queryFlag=="") queryFlag=undefined;
	dataset.setParameter("QUERYFLAG",queryFlag);
	dataset.setParameter("organCode",organArea);
	dataset.load();
}
function jtxxDetailHref(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:jtxxDetail(\'' + record.data["FAMILY_ID"] + '\')">' + value + '</a>';
}
function jtxxDetail( familyId ) {
    var data = new L5.Map();
    data.put("method", "EXAM");
    data.put("dataBean", familyId);
    var url = 'jsp/sdmz/jtxx/ygjzjtxx_correctDetail.jsp';
    var text = '审核阳光救助_家庭信息';
    L5.forward(url, text, data);
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

function jzlxDbClick() {
	document.getElementById("jzlx").value="";
	document.getElementById("jzlxquery").value="";
}

/*
 * 通用帮助
 */
function forHelp(){
	var revalue=window.showModalDialog("../../bsp/organization/getselect.jsp?rootId="+struId+"&showOrganType=0&organType=12,13,14,15&isExact=1&isCheckBox=1&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		//list[0] == organId,list[1]==organName,list[2]==struId
//		var userDataset = L5.DatasetMgr.lookup("userDataset");
//		var userRecord = userDataset.getCurrent();
		document.getElementById("lrdwId").value = list[0];
		document.getElementById("lrdwmc").value = list[1];

	}
}
/**
 * 选择属地行政区划窗口
 */
function func_ForDomicileSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&radioType=checkbox&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("lrdwId").value = list[0];
		document.getElementById("lrdwmc").value = list[1];
	}
}