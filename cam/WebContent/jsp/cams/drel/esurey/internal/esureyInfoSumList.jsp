<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil" %>
<html>
	<head>
		<title>城乡居民家庭经济状况汇总审核</title>
		<next:ScriptManager/>
<script type="text/javascript">
			var jtids='<%=request.getParameter("id")%>';
			var organCode='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
			var organId='<%=BspUtil.getCorpOrgan().getOrganId()%>';
			var checkOrg='<%=BspUtil.getCorpOrgan().getOrganName()%>';
		</script>
		<script type="text/javascript" src="esureyInfoSumList.js"></script>		
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script language="javascript">
	 	 //查询条件打开合并函数
			 function collapse(element){
				var fieldsetParent=L5.get(element).findParent("fieldset");
				if(element.expand==null||element.expand==true){	
					fieldsetParent.getElementsByTagName("div")[0].style.display="none";
					element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';	
					element.expand=false;
				}else{
					fieldsetParent.getElementsByTagName("div")[0].style.display="";
					element.src = "<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>";				
					element.expand =true;
				}
			}
		</script>

	</head>
	
<body>
<model:datasets>
	<!--经济核对_核对流水信息-->
	<model:dataset id="esureySurveyDS" global="true" method="queryForEsureyList"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureySurveyQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureySurvey"></model:record>
	</model:dataset>
	<!--经济核对_外部单位填报信息的dataset-->
    <model:dataset id="EsureyFeedbackDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFeedbackQueryCmd">
      <model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyFeedback"></model:record>
	</model:dataset>
	<!--经济核对_外部单位填报信息的dataset-->
    <model:dataset id="EsureyFeedbackDS1" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFeedbackQueryCmd">
      <model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyFeedback"></model:record>
	</model:dataset>
	<model:dataset id="chfDS" enumName="CHECK.FLG" autoLoad="true" global="true"></model:dataset>
	<!-- 审核标识 -->
	<model:dataset id="checkFlagDataset" enumName="CHECK_FLAG" autoLoad="true" global="true"></model:dataset>
	
	<!-- 提交状态 -->
	<model:dataset id="checkFlgDataset" enumName="CHECK.FLG.SUM"
		autoLoad="true" global="true"></model:dataset>
	<!-- 当前环节 -->
	<model:dataset id="curDS" enumName="ESUREY.CUR_ACTIVITY" autoLoad="true" global="true"></model:dataset>
	<!-- 当前环节状态 -->
	<model:dataset id="curStatusDS" enumName="CUR_STATUS" autoLoad="true" global="true"></model:dataset>
</model:datasets>
  <next:Panel name="esurey_info" width="100%"  >
	<next:Html>
	<fieldset >
		<legend>查询条件
		<img class="GroupBoxExpandButton" src=<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%> onclick="collapse(this);"/>										
		</legend>
			<div>
				<form  class="L5form">
						<table width="100%" >
							<tr>
								<td class="FieldLabel" width="15%"><label>户主姓名:</label></td>
								<td class="FieldInput" width="15%"><input type="text"  id="qName" maxlength="15"/></td>					
								<td class="FieldLabel" width="15%"><label>身份证号:</label></td>
								<td class="FieldInput" width="35%"><input type="text"  id="qIdCard"  maxlength="18" style="width: 80%"/></td>		
								<td class="FieldButton" ><button onclick="query();">查 询</button> </td>	
								<td class="FieldButton" ><button type="reset">重 置</button> </td>							    
							</tr>
						</table>
					</form>
				</div>	
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="esurey_Grid" name="esurey_Grid"   dataset="esureySurveyDS"  stripeRows="true"  width="100%" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="城乡居民家庭经济状况申报列表"></next:ToolBarItem>	  
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="汇总审核" iconCls="edit"  handler="see_summary"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
	     <next:RowNumberColumn width="20"/>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="name" header="户主姓名" field="FAMILY_NAME" width="10%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="idCard" header="身份证号" field="FAMILY_CARD_NO" width="20%">
			<next:TextField />
		</next:Column>
		<next:Column id="surveyDate" header="发起核对日期" field="SURVEY_DATE" width="15%">
			<next:TextField />
		</next:Column>
		<next:Column field="CHECK_IN" header="外部单位提交情况" width="20%" renderer="seeExtOrgCheckIn">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column id="curActivity" header="当前环节" field="CUR_ACTIVITY" width="10%"   dataset="curDS">
			<next:TextField />
		</next:Column>
		<next:Column id="curState" header="当前环节状态" field="CUR_STATE" width="14.5%" dataset="curStatusDS">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
			<next:PagingToolBar dataset="esureySurveyDS" />
	</next:BottomBar>
</next:GridPanel>
</body>
	
<next:Window id="feedbackDetailWin" height="320" width="550" closeAction="hide">
	<next:GridPanel id="editGridPanel" name="samesureyfeedbackGrid" width="100%" stripeRows="true" height="300" dataset="EsureyFeedbackDS1" title="经济核对外部单位未填报信息">
		<next:Columns>
		    <next:RowNumberColumn width="30"/>
		    <next:CheckBoxColumn></next:CheckBoxColumn>
		
			<next:Column id="name" header="姓名" field="name" width="8%" >
				<next:TextField allowBlank="false" />
			</next:Column>
		
			<next:Column id="idCard" header="身份证件号码" field="idCard" width="20%" >
				<next:TextField allowBlank="false" />
			</next:Column>
		
			<next:Column id="checkOrg" header="核对单位名称" field="checkOrg" width="15%" >
				<next:TextField  />
			</next:Column>
		
			<next:Column id="checkTime" header="核对日期" field="checkTime" width="10%" >
				<next:TextField  />
			</next:Column>
			
			<next:Column id="checkFlg" header="提交状态" field="checkFlg" dataset="checkFlgDataset" width="10%" >
				<next:TextField allowBlank="false"  />
			</next:Column>
		
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="EsureyFeedbackDS1"/>
		</next:BottomBar>
	</next:GridPanel>
</next:Window>		
</html>