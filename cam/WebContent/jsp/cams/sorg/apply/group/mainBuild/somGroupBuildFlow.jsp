<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.comm.util.StrUtil,org.loushang.next.skin.SkinUtils"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.loushang.workflow.api.WfQuery" %>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="com.inspur.cams.sorg.apply.group.cmd.GroupBuildCmd"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>社会团体流程</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js") %>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>

<script type="text/javascript">
<%
	String primaryKey=request.getParameter("primaryKey");
    if(primaryKey==null){
    	primaryKey="";
    }
	String assignmentId=(String)request.getParameter("assignmentId");
	String procDefUniqueId=(String)request.getParameter("procDefUniqueId");
	String actDefUniqueId=(String)request.getParameter("actDefUniqueId");
	String actname=(String)request.getParameter("actname");
	//然调用接口
	List<Map> list = new WfQuery().getActButtons(actDefUniqueId);
	String method = request.getParameter("method");
	Boolean flag = false;
	if("yiban".equals(method) || "jieshu".equals(method)){
		Map<String,String> map = new HashMap<String,String>();
		map.put("buttonName","返回");
		map.put("buttonFunName","goBack()");
		List<Map> lists = new ArrayList<Map>();
		lists.add(map);
		list = lists;
		flag = true;
	}
	List<Map> list1=new WfQuery().getActFields(actDefUniqueId);
	//遍历list，如果该页面上某个域是需要隐藏的，则设置该域为不显示
	//如果域是只读的则显示为只读
	//如果是非空的，则在点击按钮时进行校验 ，若为空弹出提示框
	String fieldId,fieldName,isHidden,isReadOnly,isNotNull;
	//boolean isHidden,isReadOnly,isNotNull;
	String processId=(String)request.getParameter("processId");
	if(processId == null){
		processId = new GroupBuildCmd().getProcessId(assignmentId);
	}
	StringBuffer localStringBuffer = new StringBuffer();
%>
	var processId = '<%=processId%>';
	var procDefUniqueId = '<%=(String)request.getParameter("procDefUniqueId")%>';
	var assignmentId="<%=assignmentId%>";
	var currentUserName = '<%=GetBspInfo.getBspInfo().getUserName()%>';
	var actDefUniqueId ="<%=actDefUniqueId%>";
	var taskCode='';
	var sorgId = "";
	var actname='<%=actname%>';
	var flag = <%=flag%>;
	var applyType = "002";
	var somApplyType="002";
</script>
<script type="text/javascript">
var fetchPeople='';//领证人
var fetchDate='';//领证日期
var fetchPhone='';//领证人联系电话
var PrintDate='';//发证日期
var beginDate='';//有效期限起
var endDate='';//有效期限止
var sorgCode='';
var regDate='';
var business='';//证书上业务范围
var issueReasonDesc='';//发证原因描述
var legalRecord="";
var legalDuties="00012";
var legalDutyId='';
var fileCode="S018";//负责人fileCode
var fileCodeF="S017";//法定代表人fileCode
var end=false;
//初始化
function init(){
	L5.getCmp("tab").setActiveTab("2");
	L5.getCmp("tab").setActiveTab("0");
	L5.getCmp("sorgTab").setActiveTab("0");
	//流程意见
	somApplyDataSet.setParameter("PROCESS_ID@=",processId);
	somApplyDataSet.load();
	somApplyDataSet.on('load',loadInfo);

	//过滤流程意见
	if(actname=='print' || actname=='issue'){
		opinionSelect.filterBy(function(record, id){
			if("1".indexOf(record.get('value'))>-1){
				return record;
			}
		});
	}

	//过滤tab页
	if(flag == true){
		L5.getCmp("tab").remove(2);
	}
}
//加载页面
function loadInfo(){
	sorgId=somApplyDataSet.getCurrent().get("sorgId");
	taskCode=somApplyDataSet.getCurrent().get("taskCode");
	somApplyDataSet.getCurrent().set("curOpinionId","1");
	somSessionDataSet.setParameter("TASK_CODE@=", taskCode);
	somSessionDataSet.load();

	somFlowListDataSet.setParameter("TASK_CODE@=", taskCode);
	somFlowListDataSet.setParameter("SORG_ID@=", sorgId);
	somFlowListDataSet.setParameter("APPLY_TYPE@=", "002");
	somFlowListDataSet.load();

	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	//somOrganDataSet.setParameter("TASK_CODE@=", taskCode);
	somOrganDataSet.load();

	somRule.setParameter("TASK_CODE@=", taskCode);
	somRule.load();

	somFee.setParameter("TASK_CODE@=", taskCode);
	somFee.load();

	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	var somResumeLegalDataSet=L5.DatasetMgr.lookup("somResumeLegalDataSet");
	somResumeDataSet.setParameter("TASK_CODE", taskCode);
	somResumeDataSet.load();
	somResumeDataSet.on('load',function(){
		somDutyDataSet.setParameter("TASK_CODE", taskCode);
		somDutyDataSet.load();
		somDutyDataSet.on('load',function(){
			var peopleId="";
			var sorgOpinion="";
			var sorgCheckDate="";
			somDutyDataSet.each(function(record, index){
				if(record.get('sorgDuties') == legalDuties){
					peopleId=record.get('peopleId');
					sorgOpinion=record.get("sorgOpinion");
					sorgCheckDate=record.get("sorgCheckDate");
					legalDutyId=record.get('dutyId');
					//回填法定代表人简历
					var j=0;
					for(var i=somResumeDataSet.getCount()-1;i>=0;i--){
						var somResumeRecord =somResumeDataSet.getAt(i);
						if(record.get('dutyId') == somResumeRecord.get('dutyId')){
								somResumeLegalDataSet.insert(j,somResumeRecord);
								j++;
							}
					}
						//回填法定代表人简历结束
				}
			});
			somDutyDataSet.filterBy(function(record, id){
				if(record.get('sorgDuties') != legalDuties){
					if(record.get('peopleId') == peopleId){
						legalRecord=record.copy();
						record.set("ifLegal","1");
						legalRecord.set("sorgOpinion",sorgOpinion);
						legalRecord.set("sorgCheckDate",sorgCheckDate);
					}
					return record;
				}
			});
			somDutyDataSet.commitChanges();
			LegalPeopleDataSet.insert(0,legalRecord);
			LegalPeopleDataSet.set("dutyId",legalDutyId);
			document.getElementById("labelAge").innerHTML=getAgeByCode(legalRecord.get("idCard"));
			synPhotoDetail(LegalPeopleDataSet.get("photoId"),null);
			somLegalPeopleElectronicDataSet_load();//同步法定代表人法律要件
		});
	});

	somPartyMemberDataSet.setParameter('SORG_ID',sorgId);
	somPartyMemberDataSet.load();
	var mIds='';
	somPartyMemberDataSet.on('load',function(ds){
		ds.filterBy(function(record, id){
			if(record.get('inOrOut')=='' || record.get('inOrOut')=='1'){
				return record;
			}
		});
		if(ds.getCount()>0){
			for(var i=0;i<ds.getCount();i++){
				var mId=ds.getAt(i).get('memberId');
				mId+=',';
				mIds+=mId;
			}
			var somPartyPraiseDataSet=L5.DatasetMgr.lookup("somPartyPraiseDataSet");
			somPartyPraiseDataSet.setParameter('MEMBER_ID@IN',mIds);
			somPartyPraiseDataSet.load();
		}
	});
	somElectronicDataSet_load();//同步法律要件
	if(actname=='print'){
		opinionSelect.filterBy(function(record, id){
				if("1".indexOf(record.get('value'))>-1){
					return record;
				}
		});
	}
}
//查看负责人
function detailPeople(){
	var grid = L5.getCmp("peopleGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	dutyId=record.get('dutyId');
	somDutyInsertDataSet.removeAll();
	somDutyInsertDataSet.insert(0,record);

	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeInsertDataSet.removeAll();
	var j=0;
	for(var i=somResumeDataSet.getCount()-1;i>=0;i--){
		var somResumeRecord =somResumeDataSet.getAt(i);
		if(record.get('dutyId')==somResumeRecord.get('dutyId')){
				somResumeInsertDataSet.insert(j,somResumeRecord);
				j++;
			}
	}
	somPeopleElectronicDataSet_load(fileCode,dutyId);//同步负责人法律要件
	var win = L5.getCmp("peopleWin");
	win.show();
	$("peopleAge").innerHTML = getAgeByCode(record.get("idCard"));
}

//负责人窗户关闭
function winClosePeople(){
	var win = L5.getCmp("peopleWin");
	win.hide();
}
//保存
function saveApply(){
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	if(somApplyDataSetIsValidate != true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		L5.getCmp("tab").setActiveTab("2");
		return false;
	}
	//业务意见
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupBuildCmd");
	var somApplyDataSetRd = somApplyDataSet.getCurrent();
	command.setParameter("somApplyDataSetRd",somApplyDataSetRd);
	//保存
	command.execute("updateApply");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			goBack();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//保存并提交
function send(){
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	if(somApplyDataSetIsValidate != true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		L5.getCmp("tab").setActiveTab("2");
		return false;
	}
	if(actname=='print'){
		if(fetchPeople=='' || fetchDate==''||fetchPhone==''){
			L5.Msg.alert("提示","请先填写领证信息！");
			return false;
		}
	}
	//业务意见
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupBuildCmd");
	var somApplyDataSetRd = somApplyDataSet.getCurrent();
	command.setParameter("fetchPeople", fetchPeople);
	command.setParameter("fetchDate", fetchDate);
	command.setParameter("fetchPhone", fetchPhone);
	command.setParameter("somApplyDataSetRd",somApplyDataSetRd);
	//保存并提交
	command.execute("send");
	if (!command.error) {
		if(actname=='issue' || end){//是发证环节流程结束
			L5.Msg.alert("提示","成功结束流程!",function(){
				goBack();
			});
		}else{
			L5.Msg.alert("提示","成功提交至下一环节!",function(){
				goBack();
			});
		}
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}
//返回
function goBack(){
	history.go(-1);
}
//打印不予受理通知
function printNoAccept(){
	var url=L5.webPath+"/jsp/cams/sorg/comm/print/noAcceptForPrint.jsp?sorgType=S";
	url+="&taskCode="+taskCode+"&applyType="+somApplyType+"&printPeople="+currentUserName;
	window.open(url);
}
//打印受理通知
function printAccept(){
	var url=L5.webPath+"/jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=S";
	url+="&taskCode="+taskCode+"&applyType="+somApplyType+"&printPeople="+currentUserName;
	window.open(url);
}
//弹出打印证书窗口
function printCert(){
	var win=L5.getCmp("forPrint");
	win.show();
	$('sorgCode').value = somOrganDataSet.get("sorgCode");
	$('regDate').value = somOrganDataSet.get("regDate");
	$('business').value = somOrganDataSet.get("business");
}
//关闭打印证书窗口
function winCloseCert(){
	var win = L5.getCmp("forPrint");
	win.setVisible(false);
}
//打印证书
function forCertType(){
	var certType=_$('certType');
	endDate=_$('endDate');
	beginDate=_$('beginDate');
	PrintDate=_$('PrintDate');
	sorgCode = _$('sorgCode');
	regDate = _$('regDate');
	//业务范围可能会导致url过长，不能正确传递
	business = _$('business');
	var organCode=_$('organCode');
	if(sorgCode=='' ){
		L5.Msg.alert('提示',"请输入登记证号！");
		return;
	}
	if(regDate=='' ){
		L5.Msg.alert('提示',"请输入登记日期！");
		return;
	}
	if(organCode.length > 10 ){
		L5.Msg.alert('提示',"组织机构代码长度不得超过10个字符！");
		return;
	}
	if(business=='' ){
		L5.Msg.alert('提示',"请输入业务范围！");
		return;
	}
	issueReasonDesc=_$('issueReasonDesc');
	if(issueReasonDesc.length > 200 ){
		L5.Msg.alert('提示',"发证原因描述长度不得超过200个字符！");
		return;
	}
	if(certType!='' && endDate!='' && beginDate!='' && PrintDate!='' ){
		if(endDate<beginDate){
			L5.Msg.alert('提示',"有效期限止不得早于有效期限起！");
			return;
		}
		var url=L5.webPath+"/jsp/cams/sorg/comm/print/groupBuildForPrint.jsp?id="+sorgId+"&PrintDate="+PrintDate+"&beginDate="+beginDate+"&endDate="+endDate+"&certType="+certType+"&organCode="+organCode+"&sorgCode="+sorgCode+"&business="+encodeURIComponent(business);
		PostNewWin(url);
	}else{
		L5.Msg.alert('提示',"填入所需数据！");
		return;
	}
	if(certType == '0'){

	}else if(certType == '1'){

	}
}
//打印证书环节提交
function sendForPrint(){
	if(endDate=='' || beginDate=='' || PrintDate==''){
		L5.Msg.alert("提示","请先打印证书!");
		return;
	}
	if(actname=='print'){
		if(fetchPeople=='' || fetchDate==''||fetchPhone==''){
			L5.Msg.alert("提示","请先填写领证信息！");
			return false;
		}
	}
	var somApplyDataSet = L5.DatasetMgr.lookup("somApplyDataSet");
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	var somApplyDataSetRd = somApplyDataSet.getCurrent();
	if(somApplyDataSetIsValidate != true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupBuildCmd");
	command.setParameter("certType", _$("certType"));
	command.setParameter("organCode", _$("organCode"));
	command.setParameter("endDate", endDate);
	command.setParameter("beginDate", beginDate);
	command.setParameter("PrintDate", PrintDate);
	command.setParameter("sorgCode", sorgCode);
	command.setParameter("regDate", regDate);
	command.setParameter("business", business);
	command.setParameter("issueReasonDesc", issueReasonDesc);
	command.setParameter("somApplyDataSetRd", somApplyDataSetRd);
	command.setParameter("fetchPeople", fetchPeople);
	command.setParameter("fetchDate", fetchDate);
	command.setParameter("fetchPhone", fetchPhone);
	command.execute("printForSend");
	if (!command.error) {
		L5.Msg.alert("提示","成功提交至下一环节!",function(){
			window.history.go(-1);
		});
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}
//填写领证信息
function choseIssuePeople(){
	var win=L5.getCmp('forchoseIssuePeople');
	win.show();
}
//填写领证信息里面的确认按钮
function buttonForFetch(){
	fetchPeople=document.getElementById('fetchPeople').value;
	fetchDate=document.getElementById('fetchDate').value;
	fetchPhone=document.getElementById('fetchPhone').value;
	if(fetchPeople==''){
		L5.Msg.alert('提示',"领证人不能为空！");return;
	}else if(fetchDate==''){
		L5.Msg.alert('提示',"领证日期不能为空！");return;
	}else if(fetchPhone==''){
		L5.Msg.alert('提示',"领证人联系电话不能为空！");return;
	}
	var win=L5.getCmp('forchoseIssuePeople');
	win.hide();
}
function closeForFetch(){
	var win=L5.getCmp('forchoseIssuePeople');
	win.hide();
}

function detailPartyMember(){
	var grid = L5.getCmp("partyMemberGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	var partyMemberRecord = record;
	var memberId=record.get('memberId');
	winPartyMemberDataSet.removeAll();
	winPartyMemberDataSet.insert(0,record);

	//处理奖惩
	var somPartyPraiseInsertDataSet=L5.DatasetMgr.lookup("somPartyPraiseInsertDataSet");
	var somPartyPraiseDataSet=L5.DatasetMgr.lookup("somPartyPraiseDataSet");
	somPartyPraiseInsertDataSet.removeAll();
	var j=0;
	for(var i=somPartyPraiseDataSet.getCount()-1;i>=0;i--){
		var somPartyPraiseRecord =somPartyPraiseDataSet.getAt(i);
		if(partyMemberRecord.get('memberId')==somPartyPraiseRecord.get('memberId')){
			somPartyPraiseInsertDataSet.insert(j,somPartyPraiseRecord);
			j++;
		}
	}
	var win = L5.getCmp("partyMemberWin");
	win.show();

	var peopleType=record.get('peopleType');
 	var dangyuan=$("dangyuanDiv");
 	var yubei=$("yubeiDiv");
 	var fazhan=$("fazhanDiv");
 	var jijifenzi=$("jijifenziDiv");
 	var shenqingren=$("shenqingrenDiv");
 	if(peopleType==5){
 		dangyuan.style.display="none";
 		yubei.style.display="none";
 		fazhan.style.display="none";
 		jijifenzi.style.display="none";
 		shenqingren.style.display="block";
 	}else if(peopleType==4){
 		dangyuan.style.display="none";
 		yubei.style.display="none";
 		fazhan.style.display="none";
 		jijifenzi.style.display="block";
 		shenqingren.style.display="none";
 	}else if(peopleType==3){
 		dangyuan.style.display="none";
 		yubei.style.display="none";
 		fazhan.style.display="block";
 		jijifenzi.style.display="none";
 		shenqingren.style.display="none";
 	}else if(peopleType==2){
 		dangyuan.style.display="none";
 		yubei.style.display="block";
 		fazhan.style.display="none";
 		jijifenzi.style.display="none";
 		shenqingren.style.display="none";
 	}else{
 		dangyuan.style.display="block";
 		yubei.style.display="none";
 		fazhan.style.display="none";
 		jijifenzi.style.display="none";
 		shenqingren.style.display="none";
 	}
}
//窗口关闭
function winClosePartyMember(){
	var win = L5.getCmp("partyMemberWin");
	win.setVisible(false);
}
function download_praise(value,cellmeta,record,rowindex,colindex,dataset){
	var paths = document.location.pathname.split("/");
	var id = record.get("praiseId");
	if(record.get('fileName')){
	    var url0=paths[0]+'/'+paths[1]+"/download?table=som_party_praise&column=files&pk=praise_id&filename=file_name&praise_id='"+id+"'";
		return '<a id="download"  href='+url0+'>'+'点击下载'+'</a>';
	}else{
		return '';
	}
}
</script>
</head>
<body>
<%--定义dataset--%>
<model:datasets>
	<%--查询业务流程意见表--%>
	<model:dataset id="flowDataSet">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<%--基本信息--%>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryOrgan">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<!-- 届次信息 -->
	<model:dataset id="somSessionDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomSessionQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSession"></model:record>
	</model:dataset>
	<!-- 法定代表人信息 -->
	<model:dataset id="LegalPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"  method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 负责人信息 -->
	<model:dataset id="somDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"  method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 负责人详情窗口 -->
	<model:dataset id="somDutyInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"  method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 章程核准信息 -->
	<model:dataset id="somRule"cmd="com.inspur.cams.sorg.base.cmd.SomRuleQueryCmd" global="true" method="queryRule">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomRule"></model:record>
	</model:dataset>
	<%--会费标准信息--%>
	<model:dataset id="somFee"  cmd="com.inspur.cams.sorg.base.cmd.SomFeeQueryCmd" global="true" method="queryFee">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFee"></model:record>
	</model:dataset>
	<model:dataset id="somPartyMemberDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyMemberQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyMember"></model:record>
	</model:dataset>
	<model:dataset id="winPartyMemberDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyMemberQueryCmd" global='true'>
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyMember">
		</model:record>
	</model:dataset>
	<model:dataset id="somPartyPraiseInsertDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyPraiseQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyPraise"></model:record>
	</model:dataset>
	<model:dataset id="somPartyPraiseDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyPraiseQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyPraise"></model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--人员电子档案--%>
	<model:dataset id="somPeopleElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryPeopleCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--法定代表人员电子档案--%>
	<model:dataset id="somLegalPeopleElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryPeopleCatalog" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--流程处理--%>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
			<%--业务意见信息验证--%>
			<model:field name="curOpinionId" type="string" rule="require"/>
		    <model:field name="curOpinion" type="string" rule="length{200}"/>
		</model:record>
	</model:dataset>
	<%--流程历史意见--%>
	<model:dataset id="somFlowListDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd" global="true" sortField="COMMIT_TIME">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<model:dataset id="somFlowQuery" cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<%--人员简历 --%>
	<model:dataset id="somResumeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand" sortField="startDate" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<%--法定代表人人员简历 --%>
	<model:dataset id="somResumeLegalDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<%--人员简历 --%>
	<model:dataset id="somResumeInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<%--定义字典表--%>
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_GROUP_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="politicsSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="resideSourceSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RESIDE_SOURCE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="ifServeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DUTY_IF_SERVE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgDutiesSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="ifFulltimeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 党员专兼职 -->
	<model:dataset id="ifPartyMemberFulltimeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_PARTY_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="folkSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>

		</model:params>
	</model:dataset>
	<model:dataset id="certTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CERT_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="cardTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CARD_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="pubOrganDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='PUB_ORGAN'></model:param>
			<model:param name="value" value='ORGAN_ID'></model:param>
			<model:param name="text" value='ORGAN_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 会议类型 -->
	<model:dataset id="meetingType" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_MEETING_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="sexSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 文化程度 -->
	<model:dataset id="educationSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EDUCATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="peopleTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_PARTY_PEOPLE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="belongOrgTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_PARTY_BELONG_ORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="workFlowOpinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="normalInfoSelect" enumName="SORG.PARTY.NORMAL_INFO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<%
			//从后台获取环节按钮权限，显示要显示按钮
			for(int i=0;i<list.size();i++){
				Map map=(Map)list.get(i);
				String buttonName=(String)map.get("buttonName");
				String buttonFunName=(String)map.get("buttonFunName");
				String buttonIcon = "";
				if("saveApply()".equals(buttonFunName)){
					buttonIcon = "save";
				}
				if("send()".equals(buttonFunName)){
					buttonIcon = "select";
				}
				if("sendForPrint()".equals(buttonFunName)){
					buttonIcon = "select";
				}
				if("printNoAccept()".equals(buttonFunName)){
					buttonIcon = "print";
				}
				if("printAccept()".equals(buttonFunName)){
					buttonIcon = "print";
				}
				if("printCert()".equals(buttonFunName)){
					buttonIcon = "print";
				}
				if("choseIssuePeople()".equals(buttonFunName)){
					buttonIcon = "select";
				}
				if("goBack()".equals(buttonFunName)){
					buttonIcon = "return";
				}
		%>
				<next:ToolBarItem iconCls="<%=buttonIcon%>" text="<%=buttonName%>" handler="<%=buttonFunName%>" />
		<%
			}
		%>
	</next:TopBar>
	<next:TabPanel width="100%" height="100%" id="tab">
		<next:Tabs>
			<next:Panel title="成立登记详细信息" width="100%" >
				<next:TabPanel width="100%" height="100%" id="sorgTab" activeTab="1">
					<next:Tabs>
						<next:Panel title="登记申请书" width="100%" >
							<next:Panel width="100%" height="100%" autoScroll="true">
								<next:Html>
								<fieldset>
								<legend>登记申请书</legend>
									<form method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
									<table width="100%">
									<tr>
										<td class="FieldLabel">社会团体中文名称：</td>
										<td class="FieldInput" colspan="3"><label  field="cnName"/></td>
										<td class="FieldLabel">登记证号：</td>
										<td class="FieldInput"><label  field="sorgCode"/></td>
									</tr>
									<tr>
										<td class="FieldLabel" style="width:17%">社会团体英文名称：</td>
										<td class="FieldInput"  style="width:17%"><label  field="enName"/></td>
										<td class="FieldLabel" style="width:17%">社会团体英文名称缩写：</td>
										<td class="FieldInput" style="width:17%"><label  field="abName"/></td>
										<td class="FieldLabel" style="width:17%">登记日期：</td>
										<td class="FieldInput" style="width:17%"><label  field="regDate"/></td>
									</tr>
									<tr>
										<td class="FieldLabel">社会团体类型：</td>
										<td class="FieldInput"><label  field="sorgKind" dataset="sorgKindSelect"/></td>
										<td class="FieldLabel">所属行（事）业：</td>
										<td class="FieldInput"><label  field="busScope" dataset="busScopeSelect"/></td>
										<td class="FieldLabel">成立日期：</td>
										<td class="FieldInput"><label  field="buildDate"/></td>
									</tr>
									<tr>
										<td class="FieldLabel" style="width:17%">住所来源：</td>
										<td class="FieldInput" style="width:17%"><label  field="resideSource" dataset="resideSourceSelect"/></td>
										<td class="FieldLabel">住所：</td>
										<td class="FieldInput" colspan="3"><label  field="residence"/></td>
									</tr>
									<tr>
										<td class="FieldLabel" style="width:17%">社会团体邮编：</td>
										<td class="FieldInput" style="width:17%"><label  field="sorgPost"/></td>
										<td class="FieldLabel">社会团体电话：</td>
										<td class="FieldInput"><label  field="sorgPhone"/></td>
										<td class="FieldLabel">活动地域：</td>
										<td class="FieldInput"><label  field="actArea"/></td>
									</tr>
									<tr>
										<td class="FieldLabel">业务主管单位：</td>
										<td class="FieldInput"><label  field="borgName" dataset="businessOrganSelect"/></td>
										<td class="FieldLabel">业务主管单位联系人：</td>
										<td class="FieldInput"><label  field="borgPeople"/></td>
										<td class="FieldLabel">业务主管单位电话：</td>
										<td class="FieldInput"><label  field="borgPhone"/></td>
									</tr>
									<tr>
										<td class="FieldLabel">社会团体宗旨：</td>
										<td class="FieldInput" colspan="5"><textarea rows="5" name='社会团体宗旨' field="purpose" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;"  readonly="readonly"></textarea></td>
									</tr>
									<tr>
										<td class="FieldLabel">业务范围：</td>
										<td class="FieldInput" colspan="5"><textarea rows="5" name='业务范围' field="business"  style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly="readonly"></textarea></td>
									</tr>
									<tr>
										<td class="FieldLabel">单位会员数：</td>
										<td class="FieldInput"><label  field="unitsNum"/></td>
										<td class="FieldLabel">个人会员数：</td>
										<td class="FieldInput"><label  field="peopleNum"/></td>
										<td class="FieldLabel">理事数：</td>
										<td class="FieldInput"><label  field="councilNum"/></td>
									</tr>
									<tr>
										<td class="FieldLabel">常务理事数：</td>
										<td class="FieldInput"><label  field="standCouncilNum"/></td>
										<td class="FieldLabel">活动资金数额：</td>
										<td class="FieldInput" colspan="3"><label  field="regMon"/>万元</td>
									</tr>
									<tr>
										<td class="FieldLabel">出资人：</td>
										<td class="FieldInput" colspan="5"><textarea name='出资人' field="fundingPeople" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly="readonly"></textarea></td>
									</tr>
									<tr>
										<td class="FieldLabel">验资单位：</td>
										<td class="FieldInput" colspan="5"><label  field="checkCapitalOrgan"/></td>
									</tr>
									<tr>
										<td class="FieldLabel">经费来源：</td>
										<td class="FieldInput" colspan="5"><label  field="moneySource"/></td>
									</tr>
									<tr>
										<td class="FieldLabel">住所产权单位：</td>
										<td class="FieldInput" colspan="3"><label  field="housingOrgan"/></td>
										<td class="FieldLabel">用房面积：</td>
										<td class="FieldInput"><label  field="housingArea"/>平方米</td>
									</tr>
									<tr>
										<td class="FieldLabel">租（借）期限：</td>
										<td class="FieldInput" colspan="5"><label  field="leasePeriod"/></td>
									</tr>
									<tr>
										<td class="FieldLabel">社会团体通信地址：</td>
										<td class="FieldInput"><label  field="sorgAdds"/></td>
										<td class="FieldLabel">社会团体电子邮箱：</td>
										<td class="FieldInput"><label  field="sorgEmail"/></td>
										<td class="FieldLabel" style="width:15%">社会团体传真：</td>
										<td class="FieldInput" style="width:17%"><label  field="sorgFax"/></td>
									</tr>
								</table>
									</form>
									</fieldset>
									<fieldset>
							<legend>历史处理意见</legend>
							<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
							<table width="100%">
								<tr>
									<td class="FieldLabel" style="width:17%">承办人意见：</td>
									<td class="FieldInput" style="width:17%">
										<label field="acceptOpinionId" name='"承办人意见"' style="width:90%" dataset="hisOpinionDataSet"/>
									</td>
									<td class="FieldLabel" style="width:17%">承办人：</td>
									<td class="FieldInput" style="width:17%"><label type="text" field="acceptPeopleName" name='承办人'  style="width:90%" />
									</td>
									<td class="FieldLabel" style="width:17%">承办时间：</td>
									<td class="FieldInput" style="width:17%"><label type="text" name='承办时间' field="acceptTime" style="width:90%" />
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">承办补充意见：</td>
									<td class="FieldInput" colspan="5"><textarea rows="3" name='承办补充意见' field="acceptOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">初审意见：</td>
									<td class="FieldInput" style="width:17%">
										<label type="text"  field="examinOpinionId" name='"初审意见"' style="width:90%" dataset="hisOpinionDataSet"  />
									</td>
									<td class="FieldLabel" style="width:17%">初审人：</td>
									<td class="FieldInput" style="width:17%"><label type="text" field="examinPeopleName" name='初审人'  style="width:90%" />
									</td>
									<td class="FieldLabel" style="width:17%">初审时间：</td>
									<td class="FieldInput" style="width:17%"><label type="text" name='初审时间' field="examinTime" style="width:90%" />
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">初审补充意见：</td>
									<td class="FieldInput" colspan="5"><textarea rows="3" name='初审补充意见' field="examinOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">审核意见：</td>
									<td class="FieldInput" style="width:17%">
										<label type="text"  field="checkOpinionId" name='"审核意见"' style="width:90%" dataset="hisOpinionDataSet" />
									</td>
									<td class="FieldLabel" style="width:17%">审核人：</td>
									<td class="FieldInput" style="width:17%"><label type="text" field="checkPeopleName" name='审核人' style="width:90%" />
									</td>
									<td class="FieldLabel" style="width:17%">审核时间：</td>
									<td class="FieldInput" style="width:17%"><label type="text" name='审核时间' field="checkTime" style="width:90%" />
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">审核补充意见：</td>
									<td class="FieldInput" colspan="5"><textarea rows="3" name='审核补充意见' field="checkOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">批准意见：</td>
									<td class="FieldInput" style="width:17%">
										<label type="text"  field="auditOpinionId" name='"批准意见"' style="width:90%" dataset="hisOpinionDataSet"  />
									</td>
									<td class="FieldLabel" style="width:17%">批准人：</td>
									<td class="FieldInput" style="width:17%"><label type="text" field="auditPeopleName" name='批准人' style="width:90%" />
									</td>
									<td class="FieldLabel" style="width:17%">批准时间：</td>
									<td class="FieldInput" style="width:17%"><label type="text" name='批准时间' field="auditTime" style="width:90%" />
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">批准补充意见：</td>
									<td class="FieldInput" colspan="5"><textarea rows="3" name='批准补充意见' field="auditOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
									</td>
								</tr>
							</table>
							</form>
							</fieldset>
								</next:Html>
							</next:Panel>
						</next:Panel>
						<next:Panel title="法定代表人登记表" >
							<next:TabPanel  width="100%" height="100%">
								<next:Tabs>
									<next:Panel title="基本信息"  width="100%" height="100%" autoScroll="true">
										<next:Html>
											<form  method="post" dataset="LegalPeopleDataSet" onsubmit="return false" class="L5form">
											<table width="100%">
												<tr>
													<td class="FieldLabel" style="width:15%">身份证号码：</td>
													<td class="FieldInput" style="width:21%"><label id="labelIdCard" field="idCard"/></td>
													<td class="FieldLabel" style="width:14%">姓名：</td>
													<td class="FieldInput" style="width:17%"><label field="name"/></td>
													<td class="FieldLabel" style="width:14%" rowspan="4">照片:</td>
													<td class="FieldInput" style="width:19%" nowrap colspan="1" rowspan="4">
													<div id="photoDiv">
														<img id="img" name="RELATIONER_PHOTOC_IMG" width=82.5 height=110 src="<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg"
														align="top" ondblclick="editPhoto(1,'photoId','RELATIONER_PHOTOC_IMG');"
														onerror="javascript:this.src='<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg'" alt="暂无图片" />
														<input type="hidden" id="photoId" name="photoId"/>
													</div>
													</td>
												</tr>
												<tr>
													<td class="FieldLabel">曾用名：</td>
													<td class="FieldInput"><label field="aliasName"/></td>
													<td class="FieldLabel">年龄：</td>
													<td class="FieldInput"><label id="labelAge" name='年龄'/></td>
												</tr>
												<tr>
													<td class="FieldLabel">性别：</td>
													<td class="FieldInput"><label field="sex" dataset="sexSelect"/></td>
													<td class="FieldLabel">出生年月：</td>
													<td class="FieldInput"><label field="birthday"/></td>
												</tr>
												<tr>
													<td class="FieldLabel">政治面貌：</td>
													<td class="FieldInput"><label field="politics" dataset="politicsSelect"/></td>
													<td class="FieldLabel">民族：</td>
													<td class="FieldInput"><label field="folk" dataset="folkSelect"/></td>
												</tr>
												<tr>
													<td class="FieldLabel">家庭住址：</td>
													<td class="FieldInput" colspan="3"><label field="adds"/></td>
													<td class="FieldLabel">户口所在地：</td>
													<td class="FieldInput"><label field="populace"/></td>
												</tr>
												<tr>
													<td class="FieldLabel">邮编：</td>
													<td class="FieldInput"><label field="postCode"/></td>
													<td class="FieldLabel">电话：</td>
													<td class="FieldInput"><label field="phone"/></td>
													<td class="FieldLabel">专/兼职：</td>
													<td class="FieldInput"><label field="ifFulltime"  dataset="ifFulltimeSelect" /></td>
												</tr>
												<tr>
													<td class="FieldLabel">工作单位：</td>
													<td class="FieldInput" colspan="3"><label field="workName"/></td>
													<td class="FieldLabel">工作单位职务：</td>
													<td class="FieldInput"><label field="workDuties"/></td>
												</tr>
												<tr>
													<td class="FieldLabel">社团职务：</td>
													<td class="FieldInput"><label field="sorgDuties" dataset="sorgDutiesSelect"/></td>
													<td class="FieldLabel">任职开始日期：</td>
													<td class="FieldInput"><label field="startDate"/></td>
													<td class="FieldLabel"><label>任职结束日期：</label></td>
													<td class="FieldInput"></td>
												</tr>
												<tr>
													<td class="FieldLabel">是否党政机关领导干部：</td>
													<td class="FieldInput"><label field="ifPartyLeader" dataset="comm_yesorno"/></td>
													<td class="FieldLabel">批准机关：</td>
													<td class="FieldInput"><label field="promiseOrgan"/></td>
													<td class="FieldLabel">批准文号：</td>
													<td class="FieldInput"><label field="promiseCode" /></td>
												</tr>
												<tr>
													<td class="FieldLabel">本人所在单位人事部门审查意见：</td>
													<td class="FieldInput" colspan="5"><textarea rows="2" name='"所在单位人事部门审查意见"' readonly="readonly" field="workOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" ></textarea></td>
												</tr>
												<tr>
													<td class="FieldLabel">审查工作单位：</td>
													<td class="FieldInput" colspan="3"><label  field="workName"/></td>
													<td class="FieldLabel">审查日期：</td>
													<td class="FieldInput"><label  field="workCheckDate"/></td>
												</tr>
												<tr>
														<td class="FieldLabel"><label>按照本社会团体章程会议产生通过情况：</label></td>
														<td class="FieldInput" colspan="5"><textarea   rows="2" name='"按照本社会团体章程会议产生通过情况"' field="sorgOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;"  readonly="readonly"></textarea></td>
													</tr>
													<tr>
														<td class="FieldLabel"><label>签署日期：</label></td>
														<td class="FieldInput" colspan="5"><label  field="sorgCheckDate"/></td>
												</tr>
												<tr>
													<td class="FieldLabel">备注：</td>
													<td class="FieldInput" colspan="5"><textarea rows="2" name='"备注"' readonly="readonly" field="note" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" ></textarea></td>
												</tr>
											</table>
											</form>
										</next:Html>
									</next:Panel>
									<next:EditGridPanel id="somResumeLegalGrid" dataset="somResumeLegalDataSet" stripeRows="true" title="本人简历" width="100%" height="100%" autoScroll="true">
										<next:TopBar>
											<next:ToolBarItem symbol="->"></next:ToolBarItem>
										</next:TopBar>
										<next:Columns>
											<next:RowNumberColumn/>
											<next:Column header="内码" field="id" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
											<next:Column header="开始年月" field="startDate" width="10%" editable="false"><next:TextField/></next:Column>
											<next:Column header="结束年月" field="endDate" width="10%" editable="false"><next:TextField/></next:Column>
											<next:Column header="在何地区何单位" field="workOrgan" width="45%" editable="false"><next:TextField/></next:Column>
											<next:Column header="任（兼）何职" field="duty" width="20%" editable="false"><next:TextField/></next:Column>
										</next:Columns>
										<next:BottomBar>
											<next:PagingToolBar dataset="somResumeLegalDataSet"/>
										</next:BottomBar>
									</next:EditGridPanel>
									<next:EditGridPanel id="uploadLegalPeopleGrid" title="法律要件" stripeRows="true" dataset="somLegalPeopleElectronicDataSet" width="100%" height="100%" autoScroll="true">
										<next:TopBar>
											<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
											<next:ToolBarItem symbol="->"></next:ToolBarItem>
										</next:TopBar>
										<next:Columns>
											<next:RowNumberColumn />
											<next:RadioBoxColumn></next:RadioBoxColumn>
											<next:Column header="档案目录名" field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect">
												<next:TextField />
											</next:Column>
											<next:Column header="附件名称" field="fileName" width="30%" editable="false">
												<next:TextField />
											</next:Column>
											<next:Column header="附件描述" field="fileMess" width="20%" editable="false">
												<next:TextField />
											</next:Column>
											<next:Column header="下载附件" field="" width="10%" editable="false" renderer="clickDownloadLegalPeopleHref">
												<next:TextField />
											</next:Column>
										</next:Columns>
										<next:BottomBar>
											<next:PagingToolBar dataset="somLegalPeopleElectronicDataSet" />
										</next:BottomBar>
									</next:EditGridPanel>
								</next:Tabs>
							</next:TabPanel>
						</next:Panel>
						<next:Panel title="社团负责人备案表">
							<next:Panel>
								<next:Html>
									<fieldset>
										<legend>社会团体信息</legend>
										<form onsubmit="return false" dataset="somSessionDataSet" class="L5form">
											<table width="100%">
												<tr>
													<td class="FieldLabel">届次名称：</td>
													<td class="FieldInput" colspan="3"><label  field="sessionName" /></td>
													<td class="FieldLabel" style="width:17%">本届任期（年）：</td>
													<td class="FieldInput" style="width:17%"><label  field="tenure" /></td>
												</tr>
												<tr>
													<td class="FieldLabel" style="width:17%">本届开始日期：</td>
													<td class="FieldInput" style="width:17%"><label  field="startDate" /></td>
													<td class="FieldLabel" style="width:17%">规定换届日期：</td>
													<td class="FieldInput" style="width:15%"><label  field="endDate" /></td>
													<td class="FieldLabel" style="width:17%"></td>
													<td class="FieldInput" style="width:17%"></td>
												</tr>
											</table>
										</form>
									</fieldset>
								</next:Html>
							</next:Panel>
							<next:EditGridPanel id="peopleGrid" width="100%" stripeRows="true" height="100%" dataset="somDutyDataSet">
								<next:TopBar>
									<next:ToolBarItem symbol="->"></next:ToolBarItem>
									<next:ToolBarItem iconCls="detail" text="查看" handler="detailPeople"></next:ToolBarItem>
								</next:TopBar>
								<next:Columns>
									<next:RowNumberColumn/>
									<next:RadioBoxColumn></next:RadioBoxColumn>
									<next:Column header="内码" field="id" width="15%" editable="false" hidden="true"><next:TextField/></next:Column>
									<next:Column header="身份证号" field="idCard" width="20%" editable="false"><next:TextField/></next:Column>
									<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
									<next:Column header="性别" field="sex" width="10%" editable="false"><next:ComboBox dataset="sexSelect"/></next:Column>
									<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:TextField/></next:Column>
									<next:Column header="担任职务" field="sorgDuties" width="20%" editable="false"><next:ComboBox dataset="sorgDutiesSelect"/></next:Column>
									<next:Column header="是否在任" field="ifServe"width="10%" editable="false"><next:TextField/><next:ComboBox dataset="ifServeSelect"/></next:Column>
									<next:Column header="是否法定代表人" field="ifLegal" width="15%" editable="false"><next:TextField/><next:ComboBox dataset="comm_yesorno"/></next:Column>
									<next:Column header="任职开始日期" field="startDate" width="15%" editable="false"><next:TextField/></next:Column>
									<next:Column header="任职结束日期" field="endDate" width="15%" editable="false"><next:TextField/></next:Column>
								</next:Columns>
								<next:BottomBar>
									<next:PagingToolBar dataset="somDutyDataSet"/>
								</next:BottomBar>
							</next:EditGridPanel>
						</next:Panel>
						<next:Panel title="章程核准表"  width="100%" autoScroll="true">
							<next:Html>
									<fieldset>
									<legend>社会团体章程</legend>
								<form id="ruleForm" method="post" dataset="somRule" onsubmit="return false" class="L5form">
									<input type="hidden" id="sorgId" field="sorgId" value="社团ID">
									<table width="100%">
										<tr>
											<td class="FieldLabel">会议名称：</td>
											<td class="FieldInput"><label  field="meetingName"/></td>
											<td class="FieldLabel">会议形式：</td>
											<td class="FieldInput" colspan="3"><label  field="meetingFormat"/></td>
										</tr>
										<tr>
											<td class="FieldLabel" style="width:17%">时间：</td>
											<td class="FieldInput" style="width:17%"><label  field="meetingDate"/></td>
											<td class="FieldLabel" style="width:17%">应到人数：</td>
											<td class="FieldInput" style="width:15%"><label  field="shouldNum"/></td>
											<td class="FieldLabel" style="width:17%">实到人数：</td>
											<td class="FieldInput" style="width:17%"><label  field="realNum"/></td>
										</tr>
										<tr>
											<td class="FieldLabel">同意人数：</td>
											<td class="FieldInput"><label  field="passNum"/></td>
											<td class="FieldLabel">反对人数：</td>
											<td class="FieldInput"><label  field="nopassNum"/></td>
											<td class="FieldLabel">弃权人数：</td>
											<td class="FieldInput"><label  field="giveupNum"/></td>
										</tr>
										<tr>
											<td class="FieldLabel">需说明的主要问题：</td>
											<td class="FieldInput" colspan="5"><textarea name="需说明的主要问题" id=mainQuestion field="mainQuestion" cols="65" rows="4" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;"  readonly></textarea></td>
										</tr>
									</table>
								</form>
									</fieldset>	<fieldset>
									<legend>审查意见</legend>
								<form id="form2" method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form">
									<table width="100%">
										<tr>
											<td class="FieldLabel">业务主管单位审查意见：</td>
											<td class="FieldInput" colspan="5"><textarea field="borgOpinion" cols="65" rows="2" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea></td>
										</tr>
										<tr>
											<td class="FieldLabel" style="width:17%">业务主管单位：</td>
											<td class="FieldInput" style="width:49%"><label  field="borgName" dataset="businessOrganSelect"/></td>
											<td class="FieldLabel" style="width:17%">业务主管单位审查日期：</td>
											<td class="FieldInput" style="width:17%"><label  field="borgCheckDate"/></td>
										</tr>
									</table>
								</form>
									</fieldset>
							</next:Html>
						</next:Panel>
						<next:Panel title="会费标准备案表"  width="100%" autoScroll="true">
							<next:Html>
								<fieldset>
									<legend>社会团体会费标准备案</legend>
								<form method="post" onsubmit="return false" dataset="somFee" class="L5form">
									<input type="hidden" id="sorgId" field="sorgId" value="社团ID">
									<table width="100%">
										<tr>
											<td class="FieldLabel">联系人：</td>
											<td class="FieldInput"><label id="linkPeople" field="linkPeople"/></td>
											<td class="FieldLabel">联系电话：</td>
											<td class="FieldInput" colspan="3"><label id="linkPhone" field="linkPhone"/></td>
										</tr>
										<tr>
											<td class="FieldLabel" style="width:17%">会议名称：</td>
											<td class="FieldInput" style="width:17%"><label field="meetingName"/></td>
											<td class="FieldLabel" style="width:17%">召开日期：</td>
											<td class="FieldInput" style="width:15%"><label field="meetingDate"/></td>
											<td class="FieldLabel" style="width:17%">召开地点：</td>
											<td class="FieldInput" style="width:17%"><label field="meetingPlace"/></td>
										</tr>
										<tr>
											<td class="FieldLabel">应到人数：</td>
											<td class="FieldInput"><label field="shouldNum"/></td>
											<td class="FieldLabel">实到人数：</td>
											<td class="FieldInput" colspan="3"><label field="realNum"/></td>
										</tr>
										<tr>
											<td class="FieldLabel">同意：</td>
											<td class="FieldInput"><label field="passNum"/></td>
											<td class="FieldLabel">不同意：</td>
											<td class="FieldInput"><label field="nopassNum"/></td>
											<td class="FieldLabel">弃权：</td>
											<td class="FieldInput"><label field="giveupNum"/></td>
										</tr>
										<tr>
											<td class="FieldLabel">会费标准：</td>
											<td class="FieldInput" colspan="5"><textarea name="会费标准" id="fee" field="fee" cols="75" rows="12" readonly="readonly" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" ></textarea>
										</tr>
									</table>
								</form>
								</fieldset>
							</next:Html>
						</next:Panel>
						<next:Panel title="党员情况">
							<next:EditGridPanel id="partyMemberGrid" dataset="somPartyMemberDataSet" width="100%" stripeRows="true" height="99.9%">
								<next:TopBar>
									<next:ToolBarItem symbol="社会组织党员情况调查表"></next:ToolBarItem>
									<next:ToolBarItem symbol="->"></next:ToolBarItem>
									<next:ToolBarItem iconCls="detail" text="查看" handler="detailPartyMember"></next:ToolBarItem>
								</next:TopBar>
								<next:Columns>
									<next:RowNumberColumn/>
									<next:RadioBoxColumn></next:RadioBoxColumn>
									<next:Column header="内码" field="memberId" width="15%" editable="false" hidden="true"><next:TextField/></next:Column>
									<next:Column header="身份证号" field="idCard" width="20%" editable="false"><next:TextField/></next:Column>
									<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
									<next:Column header="人员类别" field="peopleType" width="10%" editable="false"><next:ComboBox dataset="peopleTypeSelect"/></next:Column>
									<next:Column header="性别" field="sex" width="10%" editable="false"><next:ComboBox dataset="sexSelect"/></next:Column>
									<next:Column header="出生日期" field="birthday" width="10%" editable="false"><next:TextField/></next:Column>
									<next:Column header="社会组织职务" field="sorgDuties" width="20%" editable="false"><next:ComboBox dataset="sorgDutiesSelect"/></next:Column>
									<next:Column header="主要任职单位" field="workName" width="20%" editable="false"><next:TextField/></next:Column>
									<next:Column header="主要任职单位职务" field="workDuties" width="20%" editable="false"><next:TextField /></next:Column>
								</next:Columns>
								<next:BottomBar>
									<next:PagingToolBar dataset="somPartyMemberDataSet"/>
								</next:BottomBar>
							</next:EditGridPanel>
						</next:Panel>
						<next:Panel title="法律要件">
							<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
								<next:TopBar>
									<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
									<next:ToolBarItem symbol="->"></next:ToolBarItem>
								</next:TopBar>

								<next:Columns>
									<next:RowNumberColumn />
									<next:RadioBoxColumn></next:RadioBoxColumn>
									<next:Column header="档案目录名"  field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect" ><next:TextField /></next:Column>
									<next:Column header="附件名称"    field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
									<next:Column header="附件描述"    field="fileMess" width="20%" editable="false"><next:TextField /></next:Column>
									<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
								</next:Columns>
								<next:BottomBar>
									<next:PagingToolBar dataset="somElectronicDataSet" />
								</next:BottomBar>
							</next:EditGridPanel>
						</next:Panel>
					</next:Tabs>
				</next:TabPanel>
			</next:Panel>
			<next:Panel title="流程历史意见" width="100%" >
				<next:GridPanel id="flowGrid" width="100%" stripeRows="true" height="100%" dataset="somFlowListDataSet" >
					<next:Columns>
						<next:RowNumberColumn/>
						<next:Column id="activity" header="流程环节" field="activity" width="13%" editable="false"></next:Column>
						<next:Column id="organId" header="处理单位" field="organId" width="13%" editable="false" dataset="pubOrganDataSet"></next:Column>
						<next:Column id="deptId" header="处理部门" field="deptId" width="13%" editable="false" dataset="pubOrganDataSet"></next:Column>
						<next:Column id="actorId" header="处理人" field="actorId" width="10%" editable="false" dataset="pubOrganDataSet"></next:Column>
						<next:Column id="commitTime" header="处理时间" field="commitTime" width="18%" editable="false"></next:Column>
						<next:Column id="opinionId" header="处理意见" field="opinionId" width="10%" editable="false" dataset="workFlowOpinionSelect"></next:Column>
						<next:Column id="opinion" header="处理补充意见" field="opinion" width="40%" editable="false"></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somFlowListDataSet" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
			<next:Panel title="处理意见" width="100%" >
				<next:Html>
					<fieldset style="width:100%">
				<form method="post" onsubmit="return false" class="L5form" dataset="somApplyDataSet">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width:13%"><label>处理意见：</label></td>
								<td class="FieldInput" colspan="5">
								<select id='curOpinionId'field="curOpinionId" name='"处理意见"' style="width:150px" default="0">
									<option dataset="opinionSelect"></option>
								</select><span style="color:red">*</span>
								</td>

							</tr>
							<tr>
								<td class="FieldLabel"><label>处理补充意见：</label></td>
								<td class="FieldInput" colspan="5">
									<textarea rows="10" name='"处理补充意见"' field="curOpinion" style="width:98%"></textarea>
								</td>
							</tr>
						</table>
				</form>
					</fieldset>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<!-- 负责人信息窗口 -->
<next:Window id="peopleWin" title="主要负责人" resizable="false" width="800" height="430" closeAction="hide" modal="true">
	<next:TabPanel id="tabSomOrgan">
		<next:Tabs>
			<next:Panel id="panel_win" title="基本信息" autoScroll="true" width="770" height="85%">
				<next:Html>
					<form title="负责人信息" id="addForm" method="post" dataset="somDutyInsertDataSet" onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width:15%">身份证号码：</td>
								<td class="FieldInput" style="width:21%"><label  field="idCard"/></td>
								<td class="FieldLabel" style="width:14%">姓名：</td>
								<td class="FieldInput" style="width:17%"><label  field="name"/></td>
								<td class="FieldLabel" style="width:14%">曾用名：</td>
								<td class="FieldInput" style="width:19%"><label  field="aliasName"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">性别：</td>
								<td class="FieldInput"><label  field="sex" dataset="sexSelect"/></td>
								<td class="FieldLabel">出生年月：</td>
								<td class="FieldInput"><label  field="birthday"/></td>
								<td class="FieldLabel">年龄：</td>
								<td class="FieldInput"><label id="peopleAge" name='年龄'/></td>
							</tr>
							<tr>
								<td class="FieldLabel">政治面貌：</td>
								<td class="FieldInput"><label  field="politics" dataset="politicsSelect"/></td>
								<td class="FieldLabel">民族：</td>
								<td class="FieldInput" colspan="3"><label  field="folk" dataset="folkSelect"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">家庭住址：</td>
								<td class="FieldInput" colspan="3"><label  field="adds"/></td>
								<td class="FieldLabel">户口所在地：</td>
								<td class="FieldInput"><label  field="populace"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">邮编：</td>
								<td class="FieldInput"><label  field="postCode"/></td>
								<td class="FieldLabel">电话：</td>
								<td class="FieldInput"><label  field="phone"/></td>
								<td class="FieldLabel">专/兼职：</td>
								<td class="FieldInput"><label  field="ifFulltime" dataset="ifFulltimeSelect"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">工作单位：</td>
								<td class="FieldInput" colspan="3"><label  field="workName"/></td>
								<td class="FieldLabel">工作单位职务：</td>
								<td class="FieldInput"><label  field="workDuties"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">社团职务：</td>
								<td class="FieldInput"><label  field="sorgDuties" dataset="sorgDutiesSelect"/></td>
								<td class="FieldLabel">任职开始日期：</td>
								<td class="FieldInput"><label  field="startDate"/></td>
								<td class="FieldLabel">任职结束日期：</td>
								<td class="FieldInput"><label  field="endDate"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">是否党政机关领导干部：</td>
								<td class="FieldInput"><label  field="ifPartyLeader" dataset="comm_yesorno" /></td>
								<td class="FieldLabel">批准机关：</td>
								<td class="FieldInput"><label  field="promiseOrgan"/></td>
								<td class="FieldLabel">批准文号：</td>
								<td class="FieldInput"><label  field="promiseCode"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">其他社会职务：</td>
								<td class="FieldInput" colspan="5"><textarea rows="3" field="otherDuties" name='"其他社会职务"' style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;"  readonly></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel">本人所在单位人事部门审查意见：</td>
								<td class="FieldInput" colspan="5"><textarea rows="2" name='"所在单位人事部门审查意见"' readonly="readonly" field="workOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" ></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel">审查工作单位：</td>
								<td class="FieldInput" colspan="3"><label  field="workName"/></td>
								<td class="FieldLabel">审查日期：</td>
								<td class="FieldInput"><label  field="workCheckDate"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">备注：</td>
								<td class="FieldInput" colspan="5"><textarea rows="2" name='"备注"' field="note" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;"  readonly="readonly"></textarea></td>
							</tr>
						</table>
					</form>
				</next:Html>
			</next:Panel>
			<next:EditGridPanel id="somResumeGrid" dataset="somResumeInsertDataSet" stripeRows="true" title="本人简历" width="770" height="85%" autoScroll="true">
						<next:TopBar>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
						</next:TopBar>
						<next:Columns>
							<next:RowNumberColumn/>
							<next:Column header="内码" field="id" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
							<next:Column header="开始年月" field="startDate" width="10%" editable="false"><next:TextField/></next:Column>
							<next:Column header="结束年月" field="endDate" width="10%" editable="false"><next:TextField/></next:Column>
							<next:Column header="在何地区何单位" field="workOrgan" width="45%" editable="false"><next:TextField/></next:Column>
							<next:Column header="任（兼）何职" field="duty" width="20%" editable="false"><next:TextField/></next:Column>
						</next:Columns>
						<next:BottomBar>
							<next:PagingToolBar dataset="somResumeInsertDataSet"/>
						</next:BottomBar>
			</next:EditGridPanel>
			<next:EditGridPanel id="uploadPeopleGrid" title="法律要件" stripeRows="true" dataset="somPeopleElectronicDataSet" width="770" height="85%" autoScroll="true">
				<next:TopBar>
					<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn />
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="档案目录名" field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect">
						<next:TextField />
					</next:Column>
					<next:Column header="附件名称" field="fileName" width="30%" editable="false">
						<next:TextField />
					</next:Column>
					<next:Column header="附件描述" field="fileMess" width="20%" editable="false">
						<next:TextField />
					</next:Column>
					<next:Column header="下载附件" field="" width="10%" editable="false" renderer="clickDownloadPeopleHref">
						<next:TextField />
					</next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somPeopleElectronicDataSet" />
				</next:BottomBar>
			</next:EditGridPanel>
		</next:Tabs>
	</next:TabPanel>
	<next:Buttons>
		<next:ToolButton text="关闭" handler="winClosePeople"></next:ToolButton>
	</next:Buttons>
</next:Window>
<next:Window id="downloadWin" title="附件列表" closeAction="hide" height="400" width="740"modal="true">
	<next:EditGridPanel id="downloadGrid" width="727" stripeRows="true" height="369" dataset="downloadDataSet" >
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="winClosedownload"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn/>
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="电子档案ID" field="electronicId" editable="false" hidden="true"><next:TextField /></next:Column>
			<next:Column header="档案目录名"  field="catalogCode" width="280" editable="false" dataset="cataLogCodeSelect" ><next:TextField /></next:Column>
			<next:Column header="附件名称" field="fileName" width="190" editable="false" renderer="winDownloadHref"><next:TextField /></next:Column>
			<next:Column header="附件描述" field="fileMess" width="190" editable="false"><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="downloadDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
<next:Window id="forchoseIssuePeople" closeAction="hide" title="填写领证信息" width="500"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="填写领证信息"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="detail" handler="buttonForFetch"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeForFetch"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:15%"><label>领证人：</label></td>
					<td class="FieldInput"style="width:15%"><input type="text" id="fetchPeople"/></td>
					<td class="FieldLabel" style="width:15%"><label>领证日期：</label></td>
					<td class="FieldInput"style="width:15%"><input type="text" id="fetchDate"  style="width:100%" format="Y-m-d" onclick="WdatePicker();" ></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:15%"><label>领证人联系电话：</label></td>
					<td class="FieldInput"style="width:15%" colspan="3"><input type="text" id="fetchPhone"/></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<next:Window id="forPrint" closeAction="hide" title="打印证书" width="500"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="打印证书"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="detail" handler="forCertType"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="winCloseCert"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:15%"><label>登记证号：</label></td>
					<td class="FieldInput"style="width:15%"><input type="text" id="sorgCode"  style="width:100%"></td>
					<td class="FieldLabel" style="width:15%"><label>登记日期：</label></td>
					<td class="FieldInput"style="width:15%"><input type="text" id="regDate"  style="width:100%" format="Y-m-d" onclick="WdatePicker();"></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:15%"><label>组织机构代码：</label></td>
					<td class="FieldInput"style="width:15%" colspan="3"><input id="organCode" name="组织机构代码" style="width:100%" ></textarea></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:15%"><label>选择证书类型：</label></td>
					<td class="FieldInput"style="width:15%"><select id="certType" ><option dataset="certTypeSelect" ></option></select></td>
					<td class="FieldLabel" style="width:15%"><label>发证日期：</label></td>
					<td class="FieldInput"style="width:15%"><input type="text" id="PrintDate"  style="width:100%" format="Y-m-d" onclick="WdatePicker();" ></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:15%"><label>有效期限起：</label></td>
					<td class="FieldInput"style="width:15%"><input type="text" id="beginDate"  style="width:100%" format="Y-m-d" onclick="WdatePicker();" ></td>
					<td class="FieldLabel" style="width:15%"><label>有效期限止：</label></td>
					<td class="FieldInput"style="width:15%"><input type="text" id="endDate"  style="width:100%" format="Y-m-d" onclick="WdatePicker();" ></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:15%"><label>业务范围：</label></td>
					<td class="FieldInput" style="width:15%" colspan="3"><textarea  rows="12" id="business"  style="width:100%" ></textarea></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:15%"><label>发证原因描述：</label></td>
					<td class="FieldInput" style="width:15%" colspan="3"><textarea  rows="2" id="issueReasonDesc"  style="width:100%" ></textarea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<jsp:include page="../../../comm/party/somPartyMemberDetail.jsp" flush="true"/>
<jsp:include page="../../../comm/upload/uploadWindow.jsp" flush="true"/>
<jsp:include page="../../../comm/upload/partyUpload.jsp" flush="true"/>
</body>
</html>