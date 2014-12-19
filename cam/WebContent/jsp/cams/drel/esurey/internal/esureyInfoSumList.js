/**
*
*/
function init(){
	var esureySurveyDS=L5.DatasetMgr.lookup("esureySurveyDS");
    esureySurveyDS.setParameter("surveyOrg",organId);
	esureySurveyDS.baseParams["surveyOrg@like@String"]=organId.substring(0,6);
	//esureySurveyDS.baseParams['CHECK_FLG@=']='0';
	esureySurveyDS.load();
}

/**
*查询
*/
function query(){
	var esureySurveyDS=L5.DatasetMgr.lookup("esureySurveyDS");
	esureySurveyDS.setParameter("surveyOrg",organId);
	esureySurveyDS.baseParams["surveyOrg@like@String"]=organId.substring(0,6);
    var qName=_$("qName"); 
    var qIdCard=_$("qIdCard");
    if(qName=="") qName=undefined;
	esureySurveyDS.setParameter("name",qName);
	
	if(qIdCard=="") qIdCard=undefined;	
	esureySurveyDS.setParameter("idCard",qIdCard);
	esureySurveyDS.load();
}
//汇总审核
function see_summary(){
	var grid=L5.getCmp("esurey_Grid");
	var selected = grid.getSelectionModel().getSelections();
	//if(selected[0].get("CUR_ACTIVITY")!=3||selected[0].get("CUR_STATE")!=1){
	//	L5.Msg.alert("提示","已经审核完毕或该记录不在当前环节！");
	//	return;
	//}
	var surveyId=selected[0].get("SURVEY_ID");
	
	var EsureyFeedbackDS=L5.DatasetMgr.lookup("EsureyFeedbackDS");
	
	EsureyFeedbackDS.setParameter("SURVEY_ID",surveyId);
	EsureyFeedbackDS.load();
	EsureyFeedbackDS.on('load',getCheckFlg);
	
}
//提交标志校验
function getCheckFlg(EsureyFeedbackDS){
	var records=EsureyFeedbackDS.getAllRecords();
	var flag=1;
	for(i=0;i<records.length;i++){
		if(records[i].get("checkFlg")==0){
			flag=0;
			break;
		}
	}
	if(flag==0){
		if(window.confirm('有单位未提交，是否汇总审核？')){
			var grid=L5.getCmp("esurey_Grid");
			var selected = grid.getSelectionModel().getSelections();
			var familyId=selected[0].get("FAMILY_ID");
			var surveyId=selected[0].get("SURVEY_ID");
			var data=new L5.Map();
			data.put("familyId",familyId);
			data.put("surveyId",surveyId);
			var text="审核汇总困难家庭信息";
			var url="jsp/cams/drel/esurey/internal/esureyInfoSum.jsp";
			L5.forward(url,text,data);
            return true;
        }else{
        	return false;
        }
	}else{
		var grid=L5.getCmp("esurey_Grid");
		var selected = grid.getSelectionModel().getSelections();
		var familyId=selected[0].get("FAMILY_ID");
		var surveyId=selected[0].get("SURVEY_ID");
		var data=new L5.Map();
		data.put("familyId",familyId);
		data.put("surveyId",surveyId);
		var text="审核汇总困难家庭信息";
		var url="jsp/cams/drel/esurey/internal/esureyInfoSum.jsp";
		L5.forward(url,text,data);
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
			}
		);
}
//查看外部单位提交情况
function seeExtOrgCheckIn(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:extCheckInDetail(\''+record.get("SURVEY_ID")+'\')">' + value + '</a>';
}
//显示外部单位提交状况详细信息
function extCheckInDetail(surveyId){
	//显示外部单位提交状况详细信息窗口
	if(win==undefined){
		var win=L5.getCmp("feedbackDetailWin");
	}
	win=L5.getCmp("feedbackDetailWin");
	win.show();
	var EsureyFeedbackDS1=L5.DatasetMgr.lookup("EsureyFeedbackDS1");
	EsureyFeedbackDS1.setParameter("SURVEY_ID",surveyId);
	EsureyFeedbackDS1.load();
	EsureyFeedbackDS1.on('load',setExtOrgCheck);
}
//未填写的外部单位的名字
var unCheckedExtOrgName="";
//已填写/未填写外部单位
var inPerOut;

function setExtOrgCheck(EsureyFeedbackDS){
//	var records=EsureyFeedbackDS.getAllRecords();
	//for(i=;i<records.length;i++){
	//	if(records[i].get("CHECK_FLG")==1){
		
	//	}else{
	//		unCheckedExtOrg=unCheckedExtOrgName+reocrds[i].get("CHECK_ORG_ID");
	//		alert(unCheckedExtOrg);
	//	}
//	}
}











