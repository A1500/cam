<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var struId = '<%=BspUtil.getStruId()%>';
   var organCode = '<%=BspUtil.getOrganCode()%>';
</script>
<html>
	<head>
		<title>义务兵家庭优待金发放列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src="compulsoryGrantList.js"></script>
		<script language="javascript">
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
<model:datasets>
	<model:dataset id="CompulsoryGrantDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptCompulsoryDetailsQueryCommand" method="queryCompulsoryGrantList" global="true">
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 是否进藏、进疆 -->
	<model:dataset id="composedPort" enumName="COMM.YESORNO" global="true" autoLoad="true"></model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
	<!-- 开户银行 -->
	<model:dataset id="bank" enumName="BANK.CODE" global="true" autoLoad="true"></model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 95%; height: 100%;" class="L5form">
						<table  border="1" width="100%">
							<tr>
								<td class="FieldLabel" nowrap="nowrap">所属机构：</td>
								<td class="FieldInput"><input type="text"  id="domicileName" class="TextEditor" title="属地行政区划" onclick="forHelp()" />
													   <input type="hidden"  id="domicileCode" class="TextEditor" title="属地行政区划"  /></td>
								<td class="FieldLabel">姓名：</td>
								<td class="FieldInput"><input type="text"  id="name" class="TextEditor" title="姓名"  /></td>	
								<td class="FieldLabel" nowrap="nowrap">身份证件号码：</td>
								<td class="FieldInput"><input type="text"  id="idCard" class="TextEditor" title="身份证件号码"/></td>
								<td class="FieldLabel">所属年度：</td>
								<td class="FieldInput"><input type="text"  id="belongYear" onclick="LoushangDate(this)" format="Y" class="TextEditor" title="入伍时间"/></td>
							</tr>
							<tr>	
								<td class="FieldLabel">户籍类别：</td>
								<td class="FieldInput">
									<select id="domicileType"> 
											<option dataset="DomicileDataset" ></option>
									</select>
								</td>
								<td class="FieldLabel" nowrap>进藏 进疆：</td>
								<td class="FieldInput"><select name="composedPortrait" title="进藏 进疆">
									<option dataset="composedPort"></option>
								</select> <font color="red">*</font></td>
								<td class="FieldLabel" colspan="4" style="text-align:left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button id="queryButton" onclick="query()">查 询</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button onclick="reset()">重 置</button></td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="bptcompulsorydetailsGrid" width="100%" stripeRows="true" height="100%" dataset="CompulsoryGrantDataSet" title="义务兵优待金发放" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"/>
		<next:ToolBarItem text="查看" iconCls="detail" handler="detail"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	    <next:Column id="regDetailId" header="名册名细ID" field="REG_DETAIL_ID" width="190" hidden="true"></next:Column> 
	    <next:Column id="peopleId" header="人员ID" field="PEOPLE_ID" width="190" hidden="true"></next:Column>
		<next:Column id="domicileName" header="户籍地" field="DOMICILENAME" width="190" ></next:Column>
		<next:Column id="belongYear" header="所属年度" field="BELONG_YEAR" width="90" ></next:Column>
		<next:Column id="name" header="姓名" field="NAME" width="90"></next:Column>
		<next:Column id="idCard" header="身份证号" field="ID_CARD" width="135"></next:Column>
		<next:Column id="accountCode" header="银行帐号" field="ACCOUNT_CODE" width="90"></next:Column>
		<next:Column id="conscriptDate" header="入伍时间" field="CONSCRIPT_DATE" width="90"></next:Column>
		<next:Column id="domicileType" header="户口性质" field="DOMICILE_TYPE" width="90" dataset="DomicileDataset"></next:Column>
		<next:Column id="grantMon" header="优待金额" field="GRANT_MON" width="90"></next:Column>
		<next:Column id="inTibetAdditional" header="进藏（进疆）增发" field="IN_TIBET_ADDITIONAL" width="120"></next:Column>
		<next:Column id="meritAdditional" header="立功增发" field="MERIT_ADDITIONAL" width="90"></next:Column>
		<next:Column id="otherAdditional" header="其他增发" field="OTHER_ADDITIONAL" width="90"></next:Column>
		<next:Column id="receiveName" header="领款人姓名" field="RECEIVE_NAME" width="90"></next:Column>
		<next:Column id="total" header="合计" field="TOTAL" width="90"></next:Column>
		<next:Column id="grantNumber" header="发放次数" field="GRANT_NUMBER" width="90"></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="CompulsoryGrantDataSet"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
