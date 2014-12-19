<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src="samSureyQueryList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script language="javascript">
	
	var organId='<%=BspUtil.getCorpOrganId()%>';
    var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
    var organName='<%=BspUtil.getCorpOrgan().getOrganName()%>';
    var userId='<%=BspUtil.getEmpOrgan().getOrganId()%>';
    var userName='<%=BspUtil.getEmpOrgan().getOrganName()%>';
     
	 //查询条件打开合并函数
	function collapse(element){
	var fieldsetParent=L5.get(element).findParent("fieldset");
	if(element.expand==null||element.expand==true){
		fieldsetParent.getElementsByTagName("div")[0].style.display="none";
		element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
		element.expand=false;
	}else{
		fieldsetParent.getElementsByTagName("div")[0].style.display="";
		element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
			element.expand =true;
		}
	}	
</script>
</head>
<body>
<!--设置dataset-->
<model:datasets>
		<!--属地-->
	<model:dataset id="domicileDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!--低保核对_外部单位填报信息的dataset-->
	<model:dataset id="samSureyWfDataset" cmd="com.inspur.cams.drel.surey.comm.cmd.SamSureyWfQueryCmd" global="true" pageSize="10" method="queryWfHisAndResult">
	</model:dataset>
	<!-- 核对项目 -->
	<model:dataset id="assistanceTypeDS" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value="SURVEY_ASSISTANCE_TYPE"></model:param>
		</model:params>
	</model:dataset>
	<!-- 核对结果 -->
	<model:dataset id="surveyResultDS" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value="SURVEY_ASSISTANCE_TYPE"></model:param>
		</model:params>
	</model:dataset>
	<!-- 环节意见 -->
	<model:dataset id="opinionCodeDS" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value="SURVEY_OPINION_CODE"></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<!--业务查询-->
<next:Panel name="form" width="100%" border="0"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox">
			<legend class="GroupBoxTitle">查询条件 
				<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this)" /> 
			</legend>
			<div>
			<form style="width: 100%; height: 100%;" class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel">姓名:</td>
					<td class="FieldInput"><input type="text" id="name" maxlength="15" class="TextEditor" /></td>
					<td class="FieldLabel">身份证号:</td>
					<td class="FieldInput"><input type="text" id="idCard" maxlength="18"  style="width: 80%" field="身份证号" class="TextEditor" /></td>
					<td class="FieldButton">
						<button onclick="query()">查 询</button>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel">核对项目:</td>
					<td class="FieldInput">
						<select id="assistanceType">
							<option dataset="assistanceTypeDS"></option>
						</select>
					</td>
					<td class="FieldLabel">环节意见:</td>
					<td class="FieldInput">
						<select id="opinionCode">
							<option dataset="opinionCodeDS"></option>
						</select>
					</td>
					<td class="FieldButton">
						<button onclick="reset()">重 置</button>
					</td>
				</tr>
			</table>
			</form>
			</div>
		</fieldset>
	</next:Html>
</next:Panel>

<!--业务查询明细-->
<next:GridPanel id="gridPanel" name="gridPanel" width="100%" stripeRows="true" height="100%" dataset="samSureyWfDataset" notSelectFirstRow="true" title="待办人员列表">
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:Column header="申请流程名称" field="APPLY_TITLE" width="15%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="姓名" field="NAME" width="10%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="身份证件号码" field="ID_CARD" width="15%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="户籍县（市、区）地址" field="DOMICILE_CODE" dataset="domicileDataset" width="16%">
			<next:TextField />
		</next:Column>
		<next:Column header="居住县（市、区）地址" field="APANAGE_CODE" dataset="domicileDataset" width="16%">
			<next:TextField />
		</next:Column>
		<next:Column header="申请日期" field="APPLY_DATE" width="10%">
			<next:TextField allowBlank="false" />
		</next:Column>		
		<next:Column header="核对项目" field="ASSISTANCE_TYPE" dataset="assistanceTypeDS" width="10%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="环节意见" field="OPINION_CODE" dataset="opinionCodeDS" width="10%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="环节开始时间" field="CUR_ACTIVITY_ST" width="15%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="环节结束时间" field="CUR_ACTIVITY_ET" width="15%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="环节核对结果" field="SURVEY_RESULT" dataset="surveyResultDS" width="10%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="低保证发证机关/低收入认定单位" field="SIGN_ORGAN" width="18%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="低保证发证时间/低收入认定时间" field="SIGN_DATE" width="18%">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="samSureyWfDataset" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>