<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.drel.comm.RoleCmp" %>
<html>
<head>
<%
	String nameValue="";
	
	String name="";
	if(RoleCmp.getIfRoleName("城市低保复查受理")){
		if("".equals(name)){
			name="受理";
			nameValue="accept";
		}else{
			name=name+",受理";
			nameValue=nameValue+",accept";
		}
	}
	if(RoleCmp.getIfRoleName("城市低保复查审核")){
		if("".equals(name)){
			name="审核";
			nameValue="check";
		}else{
			name=name+",审核";
			nameValue=nameValue+",check";
		}
	}
	if(RoleCmp.getIfRoleName("城市低保复查审批")){
		if("".equals(name)){
			name="审批";
			nameValue="audit";
		}else{
			name=name+",审批";
			nameValue=nameValue+",audit";
		}
	}
%>
<title>新申请结束</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
    <%
    String organArea=BspUtil.getCorpOrgan().getOrganCode();
	String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
    %>
	var organArea='<%=organArea%>';
	var organName='<%=organName%>';
	var nameValue='<%=nameValue%>';
	function init(){
		query();
		document.getElementById("lrdwmc").value=organName;
		document.getElementById("lrdwId").value=organArea;
	}
//明细
function detailHref(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:detail(\''+record.get("APPLY_ID")+'\',\''+record.get("FAMILY_ID")+'\')">'+value+'</a>';
}

function detail(applyId,FAMILY_ID){
			var width = screen.width-100;
		    var height = screen.height-140;
			 var url="../../../comm/samCityResidentsFamilyDetail.jsp?treatmentId="+""+"&assistanceType="+"01"+"&applyId="+applyId+"&ischange=1";
			window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
	//打印
	function print(){
	
	}
	//查询
	function query(){
		var lrdwId=document.getElementById("lrdwId").value;
	    if(""==lrdwId){
	    	lrdwId=organArea;
	    }
		var regDateStart=document.getElementById("regDateStart").value;
		var regDateEnd=document.getElementById("regDateEnd").value;
		var familyName=document.getElementById("familyName").value;
		var idCard=document.getElementById("idCard").value;
		var mysetwhere="FAMILY_NAME:"+familyName+"&FAMILY_CARD_NO:"+idCard+"&DOMICILE_CODE:"+lrdwId+"&APPLY_DATE:"+regDateStart+"-"+regDateEnd;
		applyDataSet.setParameter("mysetwhere",mysetwhere);
		applyDataSet.load();
		noReclick(applyDataSet,"queryId");
		if (regDateStart > regDateEnd) {
			alert("开始日期不能大于结束日期，请重新输入！");
			regDateStart.focus();
			return false;
	     }
	}
	/**
	 * 选择属地行政区划窗口
	 */
	function func_ForDomicileSelect() {
		var revalue = window.showModalDialog(
				L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
						+ organArea + "&organName="
						+ escape(encodeURIComponent(organName)), "",
				"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if (revalue != "" && revalue != undefined) {
			var list = revalue.split(";");
			document.getElementById("lrdwId").value = list[0];
			document.getElementById("lrdwmc").value = list[1];
		}
	}
	//获取当前时间
	function getCurrent(){
		
		return (new Date()).getTime();
	}
	
	function newApply(){
		//alert("跳转到录入界面");
		var width = screen.width-100;
	    var height = screen.height-140;
		var url='samCityChangeInsert.jsp?method=insert&applyId=&name=accept&hrefFlg='+getCurrent();
		window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	}
	
	function showRecheck(){
		var grid = L5.getCmp('YiBanGridPanel');
		var sm = grid.getSelectionModel();
		var records=sm.getSelections();
		if(records&&records.length==1){
			var applyId = records[0].get("APPLY_ID");
			
			var width = 1000;
		    var height = 200;
			var url='samApplyDetail.jsp?applyId='+applyId;
			window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
		}else{
			L5.Msg.alert("提示","请选择一条记录！");
		}
	}
	
	function handle(){
		//alert("变更");
		var grid = L5.getCmp('YiBanGridPanel');
		var sm = grid.getSelectionModel();
		var records=sm.getSelections();
		if(records&&records.length==1){
			var familyCardNo = records[0].get("FAMILY_CARD_NO");
			
			familyDataSet.setParameter("FAMILY_CARD_NO", familyCardNo);
			familyDataSet.load(true);
			applyChangeDataSet.removeAll();
			var command = new L5.Command("com.inspur.cams.drel.application.city.cmd.SamCityChangeCmd");
			command.setParameter("applyRecord", applyChangeDataSet.newRecord());
		    command.setParameter("familyRecord", familyDataSet.getCurrent());
		    command.setParameter("surveyRecord", SurveyDataset.newRecord( {"activityId": "check"}));
		    command.setParameter("noticeRecord", NoticeDataset.newRecord( {"activityId": "check"}));
		    command.execute("insertChangeFromRecheck");
		    if(!command.error){
		    	alert("执行成功");
		    	query();
		    }else{
		    	alert("执行失败！"+command.error);
		    }
		}else{
			L5.Msg.alert("提示","请选择一条记录！");
		}
	}
	
	function batchHandle(){
		//alert("批量变更");
		var grid = L5.getCmp('YiBanGridPanel');
		var sm = grid.getSelectionModel();
		var records=sm.getSelections();
		var familyIds = "";
		if(records&&records.length>0){
			for(var i=0;i<records.length;i++){
				familyIds+=records[i].get("FAMILY_CARD_NO");
				if(i<records.length-1){
					familyIds+=";";
				}
			}	
			var command = new L5.Command("com.inspur.cams.drel.application.city.cmd.SamCityChangeCmd");
		    command.setParameter("familyIds", familyIds);
		    command.execute("batchInsertChangeFromRecheck");
		    if(!command.error){	
		    	alert("批量登记执行成功！");
		    	query();
		    	//applyDataSet.load();
		    }else{
		    	alert("执行失败！"+command.error);
		    }
		}else{
			L5.Msg.alert("提示","请选择至少一条记录！");
		}
		
	}
</script>
</head>
<body>

<model:datasets>
	<!-- 业务信息 -->
	<model:dataset id="applyDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" method="queryRecheckToChange" global="true"  >
		<model:record>
			<model:field name="RESULT_REASON" type="string" />
		</model:record>
		<model:params>
			<model:param name="processTypeRC" value='reCheckCity'></model:param>
			<model:param name="processTypeCH" value='reCheckCity'></model:param>
			<model:param name="actDefName" value='<%=name%>'></model:param>
			<model:param name="applyType" value='013'></model:param>
			
		</model:params>
	</model:dataset>
	
	<!-- 业务信息 -->
	<model:dataset id="applyChangeDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" global="true"  >
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyInfo">
		</model:record>
	</model:dataset>
	<!-- 家庭基本信息 -->
	<model:dataset id="familyDataSet" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoFamilyQueryCmd" global="true"  >
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily">
		</model:record>
	</model:dataset>
	<!-- 审核入户调查 -->
	<model:dataset id="SurveyDataset"
		cmd="com.inspur.cams.drel.sam.cmd.SamApplySurveyQueryCmd"
		global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplySurvey">
		</model:record>		
	</model:dataset>
	<!-- 审核公示结果 -->
	<model:dataset id="NoticeDataset"
		cmd="com.inspur.cams.drel.sam.cmd.SamApplyNoticeQueryCmd"
		global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyNotice">			
		</model:record>		
	</model:dataset>
	<!-- 意见 -->
	<model:dataset id="opinionDataSet" enumName="SAM_OPINION_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 变更事项 -->
    <model:dataset id="samChangeItemDs" enumName="SAM_CHANGE_ITEM" autoLoad="true" global="true"></model:dataset>
	<!-- 复查结果 -->
    <model:dataset id="samRecheckResultDs" enumName="SAM.RECHECK.RESULT" autoLoad="true" global="true"></model:dataset>
	
</model:datasets>
			<next:Panel width="100%" height="100%">
				<next:Panel name="form" width="100%" border="0">
					<next:Html>
						<fieldset><legend>查询条件 </legend>
							<div>
								<form class="L5form">
								<table width="100%">
									<tr>
									 	<td class="FieldLabel" style="width:10%">地区</td>
						                <td class="FieldInput" style="width:20%">
						                	<input type="text" id="lrdwmcquery" readonly name="lrdwmc" id="lrdwmc" value="<%=organName%>" style='width:80%'/>
											<input type="text" style="display: none;"  name="lrdwId" id="lrdwId" value="<%=BspUtil.getCorpOrgan().getOrganCode()%>"/>
											<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="func_ForDomicileSelect()" />
						               </td>
						               <td class="FieldLabel" style="width:10%">户主姓名</td>
						                <td class="FieldInput" style="width:20%">
						                	<input type="text"  id="familyName" style='width:80%' maxlength="30"/>
						                </td>
						                <td class="FieldLabel" style="width:10%">身份证号码</td>
						                <td class="FieldInput" style="width:20%">
						                	<input type="text" id="idCard" style="width:80%" maxlength="18"/>
						                </td>
						            </tr>
									<tr>
									 <td class="FieldLabel" style="width:10%">登记日期</td>
						             <td class="FieldInput" style="width:20%" colspan="3"><input type="text" id="regDateStart"  format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style = "padding-right:20px;background:url('<%= SkinUtils.getImage(request, "default/rl.gif ") %> ') no-repeat scroll right center transparent; "/>
						                	~<input type="text" id="regDateEnd" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style = "padding-right:20px;background:url('<%= SkinUtils.getImage(request, "default/rl.gif ") %> ') no-repeat scroll right center transparent; "/></td>
						             <td class="FieldButton" style="width:10%" colspan="2">
						                <button style="width:100" id="queryId" onclick="query();">查询</button>
						                &nbsp; &nbsp; &nbsp; &nbsp;
						                <button type="reset" style="width:100">重置</button></td>
									</tr>
								</table>
							</form>
							</div>
						</fieldset>
					</next:Html>
				</next:Panel>
				 <next:GridPanel  clickToSelectedForChkSM="true" id="YiBanGridPanel" dataset="applyDataSet" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
					<next:TopBar>
						<next:ToolBarItem text="复查待变更列表信息"></next:ToolBarItem>			
						<next:ToolBarItem symbol="->"></next:ToolBarItem>	
						<next:ToolBarItem iconCls="detail"  text="查看复查信息" handler="showRecheck" tooltip="查看复查信息"/>
						<next:ToolBarItem iconCls="detail"  text="登记" handler="handle" tooltip="通过复查结果开始变更业务"/>
						<next:ToolBarItem iconCls="detail"  text="批量登记" handler="batchHandle" tooltip="通过复查结果开始批量变更业务"/>
						
					</next:TopBar>
					<next:Columns>
		   				<next:RowNumberColumn/>
		    			<next:CheckBoxColumn></next:CheckBoxColumn>
						<next:Column  header="社区（村）" field="DOMICILE_NAME"  width="200"  ></next:Column>							
				        <next:Column header="户主姓名" field="FAMILY_NAME" width="150"   ></next:Column>
			        	<next:Column header="身份证号码" field="FAMILY_CARD_NO" width="150" ></next:Column>
						<next:Column header="低保证号" field="CARD_NO" width="130" align="center"></next:Column>
						<next:Column header="复查转变更原因" field="APPLY_DATE" width="130" align="center"></next:Column>
						
						<%-- <next:Column header="变更事项" field="CHANGE_ITEM" width="150" dataset="samChangeItemDs"></next:Column> --%>
						<next:Column header="登记日期" field="APPLY_DATE" width="150" ></next:Column>
						<next:Column header="结束原因" field="CUR_OPINION" width="150" ></next:Column>
						<next:Column header="结束时间" field="FINISH_TIME" width="150" ></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="applyDataSet" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>

</body>

</html>