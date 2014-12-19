/**
*
*/
function init(){
	var EsureyFamilyDS=L5.DatasetMgr.lookup("EsureyFamilyDS");
	EsureyFamilyDS.baseParams['FAMILY_TYPE@=']='K';
	EsureyFamilyDS.baseParams['CUR_ACTIVITY@=']='02';
	EsureyFamilyDS.baseParams['CUR_STATE@in']='0'+","+'1';
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
    if(""!=qName){
    	EsureyFamilyDS.baseParams['FAMILY_NAME@=']=qName;
    }
    if(""!=qIdCard){
    	EsureyFamilyDS.baseParams['FAMILY_CARD_NO@=']=qIdCard;	
    }
	EsureyFamilyDS.baseParams['CUR_ACTIVITY@=']='02';
	EsureyFamilyDS.baseParams['CUR_STATE@in']='0'+","+'1';
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
	data.put("method","center");
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
	if(curActivity=="02"&&curState=="0"){
 
		L5.MessageBox.confirm("提示", "你确定要提交吗？",
			function(sta){
				if(sta=="yes"){
			 
					var familyId=selected[0].get("familyId");
					var checkOrgArea=organArea.substring(0,4)+"00000000";
					var command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyCmd");
					command.setParameter("familyId", familyId);
					command.setParameter("checkOrgArea",checkOrgArea);
					command.setParameter("flag","0");
					command.execute("centerSubmit");
				   
					if (!command.error) {
						EsureyFamilyDS.remove(selected[0]);
					}else{
						L5.MessageBox.alert("提示","提交时出错！"+command.error);
					}
				}
				else return ;
			});
	}else if(curActivity=="02"&&curState=="1"){//区县经济核对中心将核对结果反馈给区县民政局
		L5.MessageBox.confirm("提示", "你确定要提交吗？",
			function(sta){
				if(sta=="yes"){
					var familyId=selected[0].get("familyId");
					var checkOrgArea=organArea.substring(0,4)+"00000000";
					var command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyCmd");
					command.setParameter("familyId", familyId);
					command.setParameter("checkOrgArea",checkOrgArea);
					command.setParameter("flag","1");
					command.execute("centerSubmit");
					if (!command.error) {
						EsureyFamilyDS.remove(selected[0]);
					}else{
						L5.MessageBox.alert("提示","提交时出错！"+command.error);
					}
				}
				else return ;
			});
	}else{
		L5.MessageBox.alert("提示",'此记录不可以再被提交！');
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
	data.put("method","center");
	var text="查看困难家庭信息";
	var url="jsp/cams/drel/esurey/internal/esureyInfoDetail.jsp";
	L5.forward(url,text,data);
}