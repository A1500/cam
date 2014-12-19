function init() {
 var ygjzJzzsConfDataset=L5.DatasetMgr.lookup("ygjzJzzsConfDataset");
 
 var organArea1=organArea.substring(0,6)+"000000";
 ygjzJzzsConfDataset.setParameter("HELP_INDEX_CONF.HELP_ORGAN_REGION@=",organArea1);		
 ygjzJzzsConfDataset.load();
 L5.QuickTips.init();
};
/**
 * 事件处理：点击增加按钮
 */
 function Evt_butadd_click() {
	//获取指定的dataSet:
	var ygjzJzzsConfDataset=L5.DatasetMgr.lookup("ygjzJzzsConfDataset");
	//往dataset里增加一条空记录,在最后一行
	var p=ygjzJzzsConfDataset.newRecord();
	//获取grid对象
	var custGrid = L5.getCmp('editGridPanel');
	//停止grid的编辑状态
	custGrid.stopEditing();
}

//function Evt_butadd_click() {
//	//获取指定的dataSet:
//	var ygjzJzzsConfDataset=L5.DatasetMgr.lookup("ygjzJzzsConfDataset");
//	
//	//往dataset里增加一条空记录,在最后一行
//	var p=ygjzJzzsConfDataset.newRecord();
//	p.set("helpType","医疗，住房，事故，教育，养老，自然灾害，残疾，失业，单亲");
//	//获取grid对象
//	var custGrid = L5.getCmp('editGridPanel');
//	//停止grid的编辑状态
//	custGrid.stopEditing();
//}

function Evt_butexcel_click() {
	var custGrid = L5.getCmp('editGridPanel');
	L5.ux.Grid2Excel.save2excel(custGrid);
}
/**
 * 事件处理：点击增加按钮,转向增加页面
 */
function Evt_butadd2_click() {
	var data = new L5.Map();
	var url='jsp/demo/cust/cust_insert.jsp';
	var text = '增加客户';
	L5.forward(url,text,data);

}
/**
 * 事件处理：点击增加按钮,转向增加页面
 */
function Evt_butdetail_click() {
	var grid=L5.getCmp('editGridPanel');
	var cell=grid.getSelectionModel().getSelections();
	if(cell.length!=1){
		L5.Msg.alert("提示","请选择一条记录查看!");
		return false;
	}
	var selected=cell[0];
	var data = new L5.Map();
	var url='jsp/demo/cust/cust_detail.jsp'+'?id='+selected.get('id');
	var text = '客户信息';
	L5.forward(url,text,data);
}
/**
 * 事件处理：点击增加按钮,转向增加页面
 */
function Evt_butupdate_click() {
	var grid=L5.getCmp('editGridPanel');
	var cell=grid.getSelectionModel().getSelections();
	if(cell.length!=1){
		L5.Msg.alert("提示","请选择一条记录修改！");
		return false;
	}
	var selected=cell[0];
	var data = new L5.Map();
	var url='jsp/sdmz/jzzsCs/jzzsCs_update.jsp'+'?dwqh='+selected.get('dwqh');

	var text = '修改救助指数配置';
	L5.forward(url,text,data);

}
/**
 * 事件处理：点击删除按钮
 */
function Evt_butremove_click() {
	var ds = L5.DatasetMgr.lookup("ygjzJzzsConfDataset");
    var editGrid = L5.getCmp('editGridPanel');
    var selected = editGrid.getSelectionModel().getSelections();
    if (selected.length < 1) {
        L5.Msg.alert('提示', "请选择要删除的记录!");
        return false;
    }
    L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',
    function(state) {
        if (state == "yes") {
           var ygjzJzzsConfDataset=L5.DatasetMgr.lookup("ygjzJzzsConfDataset");
	//获取grid对象
	var grid = L5.getCmp('editGridPanel');
	//停止grid的编辑状态
	grid.stopEditing();
	//获取grid的选择模型并从选择模型里获取选中单元格：
	var cells = grid.getSelectionModel().getSelections();
	if (cells) {
		//获取对应的record对象并删除之：
		for(var i = 0; i < cells.length; i++){
			ygjzJzzsConfDataset.remove(cells[i]);
		}
	}
	var records = ygjzJzzsConfDataset.getAllChangedRecords();
	//构造Command对象,并将修改的record数组作为参数,并执行
	var command = new L5.Command("com.inspur.sdmz.jzzs.cmd.YgjzJzzsConfCommand");
	command.setParameter("records",records);
	command.execute("remove");
	//如果执行没有错误,dataset接受所有修改,否则弹出错误信息：
	if (!command.error) {
		ygjzJzzsConfDataset.commitChanges();
		L5.Msg.alert("提示","删除成功");
	}else{
		L5.Msg.alert("错误",command.error);
	}
        } else {
            return false;
        }
    });
}
/**
 * 事件处理：点击保存按钮
 */
function Evt_butsave_click() {
	var ygjzJzzsConfDataset=L5.DatasetMgr.lookup("ygjzJzzsConfDataset");
	//获取所有被修改的record:增加的、删除的、修改的
	var records = ygjzJzzsConfDataset.getAllChangedRecords();
	if(records.length<1){//没有做任何修改,返回
		L5.Msg.alert('提示','没有需要保存的数据！');
		return false;
	}
	var isValidate = ygjzJzzsConfDataset.isValidate(true);
	if(isValidate !== true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+isValidate);
		return false;
	}

	//构造Command对象,并将修改的record数组作为参数,并执行
	var command = new L5.Command("com.inspur.sdmz.jzzs.cmd.YgjzJzzsConfCommand");
	command.setParameter("records", records);
	command.execute();
	//如果执行没有错误,dataset接受所有修改,否则弹出错误信息：
	if (!command.error) {
		ygjzJzzsConfDataset.commitChanges();
		L5.Msg.alert("提示","保存成功");
	}else{
		L5.Msg.alert("错误",command.error);
	}
}
/**
 * 事件处理：点击取消按钮
 */
function Evt_butundo_click() {
	var ygjzJzzsConfDataset=L5.DatasetMgr.lookup("ygjzJzzsConfDataset");
	//dataset取消所有修改：
	ygjzJzzsConfDataset.rejectChanges();
}

/**
 * 事件处理：点击查询按钮
 */
var win;//查询窗口对象
function Evt_butquery_click(){
	if(win==undefined){//没有构造查询框就重新构造一个
		//名称、地址、出生日期3个查询条件的配置
		var namecfg={name:"NAME",desc:"名称",type:"text",operator:"like"};
		var addrcfg={name:"ADDRESS",desc:"地址",type:"text",operator:"like"};
		var datecfg={name:"BIRTHDAY",desc:"出生日期",type:"date",operator:"=@Date",format:"Y-m-d"}; //如果日期的数据库类型为字符串，那么operator可以写作operator:"="或者operator:"=@String"
		//查看框的总配置
		var config = {dataset:"custDataset",title:"查询客户信息",conditions:[namecfg,addrcfg,datecfg]};
		win=new L5.QueryWindow(config);
	}
	//显示查询窗口
	win.show();
}

//事故种类
function jzfxRef(values) {
	if(values.length==0){
	       return "";
	    }
    var DmJzfxDataset = L5.DatasetMgr.lookup("DmJzfxDataset");
    
    DmJzfxDataset.getCount();
	var texts=new Array();
	if (!(values instanceof Array)) {
		if(!values||values=="") {
			return;
		}
		values = values.split(',');
	}
	var records = DmJzfxDataset.getAllRecords();
 
	if(records) {
		for(var r=0;r<records.length;r++) {
			if(values.indexOf(records[r].get("value"))!=-1) {
				texts.push(records[r].get("text"));
			}
		}
	}
	return texts.join(",");
} 