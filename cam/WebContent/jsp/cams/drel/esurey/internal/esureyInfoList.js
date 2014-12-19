/**
*
*/
function init(){
	var EsureyFamilyDS=L5.DatasetMgr.lookup("EsureyFamilyDS");
	EsureyFamilyDS.baseParams['FAMILY_TYPE@=']='K';
	EsureyFamilyDS.baseParams['CUR_ACTIVITY@=']='01';
	EsureyFamilyDS.baseParams['CUR_STATE@=']='0';
	EsureyFamilyDS.baseParams['REG_ORG_ID@=']=organId;
	EsureyFamilyDS.load();
}

/**
*查询
*/
function query(){

	var EsureyFamilyDS=L5.DatasetMgr.lookup("EsureyFamilyDS");
    var qName=_$("qName"); 
    var qIdCard=_$("qIdCard");

	EsureyFamilyDS.baseParams['FAMILY_NAME@=']=qName;
	EsureyFamilyDS.baseParams['FAMILY_CARD_NO@=']=qIdCard;	
	EsureyFamilyDS.baseParams['CUR_ACTIVITY@=']='01';
	EsureyFamilyDS.baseParams['CUR_STATE@=']='0';
	EsureyFamilyDS.baseParams['FAMILY_TYPE@=']='K';
	EsureyFamilyDS.baseParams['REG_ORG_ID@=']=organId;
	
	EsureyFamilyDS.load();
}
/**
*新增
*/
function add_esurey(){
	var data=new L5.Map();
	data.put("method","insertK");
	var url="jsp/cams/drel/esurey/internal/esureyInfoInsert.jsp";
	var text="";
	L5.forward(url,text,data);
}

/*
*修改
*/
function edit_esurey(){
	var grid=L5.getCmp("esurey_Grid");
	var selected = grid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.MessageBox.alert("提示",'请选择要修改的记录');
		return false;
	}
	//限制
	var curActivity=selected[0].get("curActivity");
	var curState=selected[0].get("curState");
	if(curActivity=="01"&&curState=="0"){
		var familyId=selected[0].get("familyId");		
		var data=new L5.Map();
		data.put("familyId",familyId);
		data.put('method','editL');
		var text="困难家庭信息";
		var url="jsp/cams/drel/esurey/internal/esureyInfoEdit.jsp";
		L5.forward(url,text,data);
	}else{
		L5.MessageBox.alert("提示",'此记录不可以被修改！');
		return false;
	}
}
/**
*详情
*/
function detail_esurey(){
	var grid=L5.getCmp("esurey_Grid");
	var selected = grid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.MessageBox.alert("提示",'请选择要查看的记录');
		return false;
	}
	var familyId=selected[0].get("familyId");
	var data=new L5.Map();
	data.put("familyId",familyId);
	data.put("method","detailL");
	var text="查看困难家庭信息";
	var url="jsp/cams/drel/esurey/internal/esureyInfoDetail.jsp";
	L5.forward(url,text,data);
}

/**
*删除
*/
function delete_esurey(){
	var EsureyFamilyDS=L5.DatasetMgr.lookup("EsureyFamilyDS");
	var grid=L5.getCmp("esurey_Grid");
	var selected = grid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.MessageBox.alert("提示",'请选择要删除的记录');
		return false;
	}
	var curActivity=selected[0].get("curActivity");
	var curState=selected[0].get("curState");
	if(curActivity=="01"&&curState=="0"){
	L5.MessageBox.confirm("提示", "你确定要删除该记录！",
			function(sta){
				if(sta=="yes"){
					var familyId=selected[0].get("familyId");
					var command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyCmd");
					command.setParameter("familyId", familyId);
					command.execute("delete");
					if (!command.error) {
						EsureyFamilyDS.remove(selected[0]);
					}else{
						L5.MessageBox.alert("提示","删除时出错！"+command.error);
					}
				}
				else return ;
			});
	}else{
		L5.MessageBox.alert("提示",'此记录不可以被删除！');
		return false;
	}	
}
/**
* 提交
* 流程变更，区县民政局发起的核对转发到区县的经济核对中心，区县经济核对中心在将核对上报到市经济核对中心
*/
function submit_esurey(){
	var EsureyFamilyDS=L5.DatasetMgr.lookup("EsureyFamilyDS");
	var grid=L5.getCmp("esurey_Grid");
	var selected = grid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.MessageBox.alert("提示",'请选择要提交的记录!');
		return false;
	}
	//限制
	var curActivity=selected[0].get("curActivity");
	var curState=selected[0].get("curState");
	if(curActivity=="01"&&curState=="0"){
		L5.MessageBox.confirm("提示", "你确定要提交吗？",
			function(sta){
				if(sta=="yes"){
					var familyId=selected[0].get("familyId");
					var familyAddress=selected[0].get("familyAddress");
					var flag="";
					var checkOrgArea=organArea;
					if(needCountyCenter=="false"){//不需要区县核对中心，直接提交至县核对中心。
						flag="0";
					} else {
						if(familyAddress.substring(4,12)=="00000000"){
						    flag="0";
						}else if(familyAddress.substring(6,12)=="000000"&&familyAddress.substring(4,12)!="00000000"){
						    flag="1";
						}
						checkOrgArea=organArea.substring(0,4)+"00000000";
					}
					
					var command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyCmd");
					command.setParameter("familyId", familyId);
					command.setParameter("checkOrgArea",checkOrgArea);
					command.setParameter("flag",flag);
					command.execute("submit");
					if (!command.error) {
						EsureyFamilyDS.remove(selected[0]);
					}else{
						L5.MessageBox.alert("提示","提交时出错！"+command.error);
					}
				}
				else return ;
			});
	}else{
		L5.MessageBox.alert("提示",'此记录不可以在被提交！');
		return false;
	}
}
/**
 *  事件处理：点击户主姓名链接
 *
 */
function FamilyDetailHref(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:familyDetail(\''+record.data["familyId"]+'\')">' + value + '</a>';
}
function familyDetail(familyId){
	var data=new L5.Map();
	data.put("familyId",familyId);
	data.put("method","detailL");
	var text="查看困难家庭信息";
	var url="jsp/cams/drel/esurey/internal/esureyInfoDetail.jsp";
	L5.forward(url,text,data);
}
//模板下载
function onLoad(){
    var url = L5.webPath + "/fileDownload?filePath=jsp/cams/drel/esurey/internal/jjxx.xls&fileName=jjxx.xls&project=1";
    window.location = url;
}
//导入
function accountImport(){
	var win = L5.getCmp("importExcelWin");
	win.show();
}
//点击导入Excel文件
function click_import(){
	var excelFile = document.getElementById("excelFile").value;
	if(!excelFile){
		L5.Msg.alert("提示","导入文件不能为空！");
		return;
	}else if(excelFile.lastIndexOf(".xls")==-1){
		L5.Msg.alert("提示","请导入Excel文件！");
		return;
	}
	var command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyCmd");
	
	command.setParameter("FAMILY_TYPE","K");
	command.setParameter("CUR_ACTIVITY","01");
	command.setParameter("CUR_STATE","0");
	command.setParameter("REG_ORG_ID",organId);
	command.setParameter("REG_ADDRESS",organArea);
	command.setParameter("FAMILY_ADDRESS",organArea);
	command.setParameter("REG_ORG_NAME",organArea);
	command.setParameter("excelFile",excelFile);
	command.setForm("form_content");
	command.execute("importExcel");
	command.afterExecute=function(){
		if(!command.error){
			var erro = command.getReturn("erro");
			if(typeof(erro)=="undefined"){
				L5.Msg.alert("提示","导入成功!",function(){
					var win=L5.getCmp("importExcelWin");
					win.hide();
					query();
				});
			}else{
				L5.Msg.alert("提示",erro,{});
			}
		}else{
	        L5.Msg.alert("提示",(''+command.error).replace("出现系统异常",""),{});
        }
	}
}
//点击导入窗口关闭
function click_close(){
	var win = L5.getCmp("importExcelWin");
	win.hide();
}