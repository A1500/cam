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
			var familyCardNo='<%=request.getParameter("familyCardNo")%>';
			var nameValue='<%=request.getParameter("nameValue")%>';
			var parentPage='<%=request.getParameter("parentPage")%>';
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
	
<!-- 家庭性质 -->
	<model:dataset id="familyTypeDS" enumName="FAMILY_TYPE" autoLoad="true"  global="true"></model:dataset>	
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
		<next:ToolBarItem text="家庭详细信息" iconCls="detail" handler="detail_esurey"></next:ToolBarItem>	
		<next:ToolBarItem text="核对结果详情" iconCls="detail" handler="check_detail"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="yes"  handler="okButton"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return"  handler="returnButton"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
	     <next:RowNumberColumn width="20"/>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="name" header="户主姓名" field="FAMILY_NAME" width="150" align="center">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="idCard" header="身份证号" field="FAMILY_CARD_NO" width="180" align="center">
			<next:TextField />
		</next:Column>
		<next:Column field="DOMICILE_TYPE" header="家庭性质" dataset="familyTypeDS" width="100" align="center" >
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column header="身份证号" field="FAMILY_CARD_NO" width="180" align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="属地" field="FAMILY_ADDRESS_NAME" width="180"  align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="人口数量" field="PEOPLE_NUM" width="90" align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="家庭年总收入" field="YEAR_INCOME" width="100" align="right" renderer="formatNum">
			<next:TextField />
		</next:Column>
		<next:Column header="家庭年人均收入" field="YEAR_AVERAGE_INCOME" width="100"align="right" renderer="formatNum">
			<next:TextField />
		</next:Column>
		<next:Column header="家庭月总收入" field="MONTH_INCOME" width="100"align="right" renderer="formatNum">
			<next:TextField />
		</next:Column>
		<next:Column header="家庭月人均收入" field="MONTH_AVERAGE_INCOME" width="100"align="right" renderer="formatNum">
			<next:TextField />
		</next:Column>
		<next:Column id="surveyDate" header="发起核对日期" field="SURVEY_DATE" width="120" align="center">
			<next:TextField />
		</next:Column>
		<next:Column id="curActivity" header="当前环节" field="CUR_ACTIVITY" width="100"   dataset="curDS" align="center">
			<next:TextField />
		</next:Column>
		<next:Column id="curState" header="当前环节状态" field="CUR_STATE" width="100" dataset="curStatusDS" align="center">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
			<next:PagingToolBar dataset="esureySurveyDS" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>