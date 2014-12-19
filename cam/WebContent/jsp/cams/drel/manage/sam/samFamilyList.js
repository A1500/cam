function init() {
    var ds = L5.DatasetMgr.lookup("ds");
    ds.load();
    L5.QuickTips.init();
};

function getParam(ElementId) {
    var value = document.getElementById(ElementId).value;
    if (value == "") value = undefined;
    return value;
}

/**
 *  事件处理：点击登记按钮
 *  困难户家庭登记列表--登记
 *  licb
 */
function insert() {
    var data = new L5.Map();
    data.put("method", "INSERT");

    var url = 'jsp/cams/drel/manage/sam/samFamilyInsert.jsp';
    var text = '增加社会救助_家庭信息';
    L5.forward(url, text, data);

}
/**
 *  事件处理：点击变更按钮
 *  困难户家庭登记列表--变更
 *  licb
 */
function update() {
    var editGrid = L5.getCmp('editGridPanel');
    var selected = editGrid.getSelectionModel().getSelections();
    if (selected.length != 1) {
        L5.Msg.alert('提示', "请选择一条记录修改!");
        return false;
    }
    var data = new L5.Map();
    data.put("method", "UPDATE");
    data.put("dataBean", selected[0].get('FAMILY_ID'));
    data.put("peopleId", selected[0].get('PEOPLE_ID'));
     data.put("photoId", selected[0].get('PHOTO_ID'));   
    var url = 'jsp/cams/drel/manage/sam/samFamilyUpdate.jsp';
    var text = '修改社会救助_家庭信息';
    L5.forward(url, text, data);
}
/**
 *  事件处理：点击移交到审核按钮
 *  困难户家庭登记列表--移交到审核
 *  licb
 */
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
			var command=new L5.Command("com.inspur.cams.drel.sam.cmd.SamBaseFamilyCmd");
			command.setParameter("jtids", jtids);
			command.execute("toExam");
			if (!command.error) {
		        ds.setParameter("QUERYFLAG", "ACCEPT");
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


function jtxxCorrectHref(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:jtxxCorrectDetail(\'' + record.data["jtid"] + '\')">' + value + '</a>';
}
function jtxxCorrectDetail( jtid ) {
    var data = new L5.Map();
    data.put("method", "UPDATE");
    data.put("dataBean", jtid);
    var url = 'jsp/cams/drel/manage/sam/samFamilyUpdate.jsp';
    var text = '审核社会救助_家庭信息';
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


/**
 *  事件处理：点击重置按钮
 *  困难户家庭登记列表
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
	var revalue=window.showModalDialog("../../../../bsp/organization/getselect.jsp?rootId="+struId+"&showOrganType=0&organType=1&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		//list[0] == organId,list[1]==organName,list[2]==struId
//		var userDataset = L5.DatasetMgr.lookup("userDataset");
//		var userRecord = userDataset.getCurrent();
		document.getElementById("regOrg").value = list[0];
		document.getElementById("regOrgName").value = list[1];

	}
}

/********************************************家庭信息主要事件开始********************************************************/
/**
 * 困难户家庭登记查询、
 */
function jtxxQuery(){
	var dataset = L5.DatasetMgr.lookup("ds");
	var familyName = document.getElementById("familyName").value;//户主姓名
	var familyCardNo = document.getElementById("familyCardNo").value;//身份证号码
	var regOrg = document.getElementById("regOrg").value;//录入单位ID
	var assistanceType = document.getElementById("assistanceType").value;//救助类型
	var regTimeS=document.getElementById("regTimeS").value;//录入时间开始时间
	var regTimeT=document.getElementById("regTimeT").value;//录入时间终止时间


	if(familyName=="") familyName=undefined;
	dataset.setParameter("FAMILY_NAME",familyName);

	if(familyCardNo=="") familyCardNo=undefined;
	dataset.setParameter("FAMILY_CARD_NO",familyCardNo);

	if(regOrg=="") regOrg=undefined;
	dataset.setParameter("REG_ORG",regOrg);

	if(regTimeS=="") regTimeS=undefined;
	dataset.setParameter("REG_TIMES", regTimeS);

	if(regTimeT=="") regTimeT=undefined;
    dataset.setParameter("REG_TIMET", regTimeT);

	if(assistanceType=="") assistanceType=undefined;
	dataset.setParameter("ASSISTANCE_TYPE",assistanceType);

	dataset.load();
}
/**
 *  事件处理：点击注销按钮
 *
 */
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
                delIds[i] = selected[i].get("FAMILY_ID");
            }
            var command = new L5.Command("com.inspur.cams.drel.sam.cmd.SamBaseFamilyCmd");
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
 *  事件处理：点击户主姓名链接
 *
 */
function familyDetailHref(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:familyDetail(\'' + record.data["FAMILY_ID"] + '\',\''+record.data["PHOTO_ID"]+'\')">' + value + '</a>';
}

function familyDetail(familyId,photoId) {
    var data = new L5.Map();
    data.put("method", "EXAM");
    data.put("familyId", familyId);
    data.put("photoId",photoId);
    var url = 'jsp/cams/drel/manage/sam/samFamilyDetail.jsp';
    var text = '社会救助_家庭信息';
    L5.forward(url, text, data);
}
/********************************************家庭信息主要事件结束********************************************************/
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
		var multiItem_search=new L5.SearchAreaM();
		multiItem_search.addTextField("jzlxdm","编号","DM_JZLX.JZLXDM");
		multiItem_search.addTextField("jzlxmc","名称","DM_JZLX.JZLXMC");
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

function jzlxDbClick() {
	document.getElementById("jzlx").value="";
	document.getElementById("jzlxquery").value="";
}