 function init() {
	var grid=L5.getCmp('YgjzJtxxCyxxGridPanel');
	grid.on("rowdblclick",griddbclick);
	YgjzJtxxCyxxDataSet.load();
	var DmXzqhDataSetStreet = L5.DatasetMgr.lookup("DmXzqhDataSetStreet");
    DmXzqhDataSetStreet.setParameter("filterSql", "leve='3' and substr(id,1,6)= '" + organArea.substring(0, 6) + "'");
    DmXzqhDataSetStreet.load();
    var DmXzqhDataSetVillage = L5.DatasetMgr.lookup("DmXzqhDataSetVillage");
    var street = document.getElementsByName("dzZhen")[0].value;

    if (street.length > 9) {
        DmXzqhDataSetVillage.setParameter("filterSql", "leve='4' and substr(id,1,9)= '" + street.substring(0, 9) + "'");
        DmXzqhDataSetVillage.load();
    }
}

function setXzqhVillage() {
    var DmXzqhDataSetVillage = L5.DatasetMgr.lookup("DmXzqhDataSetVillage");
    var street = document.getElementsByName("dzZhen")[0].value;
    if (street.length > 9) {
        DmXzqhDataSetVillage.setParameter("filterSql", "leve='4' and substr(id,1,9)= '" + street.substring(0, 9) + "'");
        DmXzqhDataSetVillage.load();
    }
}


//审核提交
function examSave(){
	var YgjzJtxxDataSet = L5.DatasetMgr.lookup("YgjzJtxxDataSet");
	var YgjzJtxxRecord=YgjzJtxxDataSet.getCurrent();

 	var command = new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzJtxxCommand");
	command.setParameter("YgjzJtxxRecord", YgjzJtxxRecord);
	command.execute("exam");
	if (!command.error) {

		YgjzJtxxDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
		var url='jsp/sdmz/jtxx/ygjzjtxx_exam_list.jsp';
		var text="用户表";
		L5.forward(url,text);
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//登记提交
function saveClick(){
	var YgjzJtxxDataSet = L5.DatasetMgr.lookup("YgjzJtxxDataSet");
	var YgjzJtxxRecord=YgjzJtxxDataSet.getCurrent();
	var isValidate = YgjzJtxxDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.sdmz.jtxx.cmd.YgjzJtxxCommand");
	command.setParameter("YgjzJtxxRecord", YgjzJtxxRecord);
	command.execute("save");
	if (!command.error) {

		YgjzJtxxDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
		var url='jsp/sdmz/jtxx/ygjzjtxx_exam_list.jsp';
		var text="用户表";
		L5.forward(url,text);
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
 function Evt_butreturn_onclick(){
	 var url='jsp/sdmz/jtxx/ygjzjtxx_state_list.jsp';
	 var text = '家庭信息';
	 L5.forward(url,text);
 }
 //登记明细返回按钮
  function insert_onclick(){
	 var url='jsp/sdmz/jtxx/ygjzjtxx_list.jsp';
	 var text = '家庭信息';
	 L5.forward(url,text);
 }
 //更正明细返回
   function correct_onclick(){
	 var url='jsp/sdmz/jtxx/ygjzjtxx_correct_list.jsp';
	 var text = '家庭信息';
	 L5.forward(url,text);
 }
var isRender=false;
function griddbclick(grid,index,e){
	YgjzCyxxCjxxDataSet.baseParams["PEOPLE_ID@="] = YgjzJtxxCyxxDataSet.get("peopleId");
	YgjzCyxxCjxxDataSet.load();
	YgjzCyxxSgxxDataSet.baseParams["PEOPLE_ID@="] = YgjzJtxxCyxxDataSet.get("peopleId");
	YgjzCyxxSgxxDataSet.load();
	YgjzCyxxHbxxDataSet.baseParams["PEOPLE_ID@="] = YgjzJtxxCyxxDataSet.get("peopleId");
	YgjzCyxxHbxxDataSet.load();
	YgjzCyxxJyxxDataSet.baseParams["PEOPLE_ID@="] = YgjzJtxxCyxxDataSet.get("peopleId");
	YgjzCyxxJyxxDataSet.load();

	var win=L5.getCmp('cyxxEdit');
	win.show();
	if(!isRender){
		isRender=true;
		var formed = new L5.databind.Form(document.getElementById("test1"));
		formed.setValue(YgjzJtxxCyxxDataSet);

	}
}

// 灾害种类字典表
function get_Zhzl_Value(value){
	var dataSet=L5.DatasetMgr.lookup("DmZhzlDataSet");
	var record=dataSet.getById(value);
   	if(record){
   		return record.get("text");
   	}
	return value;
}


// 灾害损失字典表
function get_Zhss_Value(value){
	var dataSet=L5.DatasetMgr.lookup("DmZhssjeDataSet");
	var record=dataSet.getById(value);
   	if(record){
   		return record.get("text");
   	}
	return value;
}


// 受助种类字典表
function get_Szzl_Value(value){
	var dataSet=L5.DatasetMgr.lookup("DmJzlxDataSet");
	var record=dataSet.getById(value);
   	if(record){
   		return record.get("text");
   	}
	return value;
}

//审核状态字典表
function get_Shzt_Value(value){
	var dataSet=L5.DatasetMgr.lookup("DmShztDataSet");
	var record=dataSet.getById(value);
   	if(record){
   		return record.get("text");
   	}
	return value;
}

// 残疾类型字典表
function get_Cjlx_Value(value){
	var dataSet=L5.DatasetMgr.lookup("DmCjlxDataSet");
	var record=dataSet.getById(value);
   	if(record){
   		return record.get("text");
   	}
	return value;
}

// 残疾等级字典表
function get_Cjdj_Value(value){
	var dataSet=L5.DatasetMgr.lookup("DmCjdjDataSet");
	var record=dataSet.getById(value);
   	if(record){
   		return record.get("text");
   	}
	return value;
}

// 患病种类字典表
function get_Hbzl_Value(value){
	var dataSet=L5.DatasetMgr.lookup("DmHbzlDataSet");
	var record=dataSet.getById(value);
   	if(record){
   		return record.get("text");
   	}
	return value;
}
// 与户主关系字典表
function get_Hzgx_Value(value){
	var dataSet=L5.DatasetMgr.lookup("DmHzgxDataSet");
	var record=dataSet.getById(value);
   	if(record){
   		return record.get("text");
   	}
	return value;
}