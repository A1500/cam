<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>经费发放</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
		<script type="text/javascript">
			var peopleId ='<%=request.getParameter("peopleId")%>';
		</script>
	</head>
<body>
<model:datasets>
	<!--经费发放 -->
	<model:dataset id="dsGrantFund" cmd="com.inspur.cams.bpt.manage.cmd.BptCapitalSummaryQueryCommand" global="true" method="queryFundingGrant">
		<model:record fromBean="com.inspur.cams.bpt.capital.data.BptCapitalSummary">
		   <model:field name="objectType" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 优抚对象类型 -->
	<model:dataset id="ObjectTypeDataset" enumName="OBJECT.TYPE.PART" autoLoad="true" global="true"></model:dataset>
	<!-- 经费代码 -->
	<model:dataset id="grantFundsEnum" enumName="GRANTFUNDS.CODE"  autoLoad="true" global="true"></model:dataset>
	<!-- 发放类型 -->
	<model:dataset id="GrantType" enumName="CAPITAL.REGTYPE"  autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;">
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"/> </legend>
				<div>
					<form style="width: 95%; height: 100%;" class="L5form" onsubmit="return false;">
						<table border="1" width="100%">
							<tr>
								<td class="FieldLabel" nowrap="nowrap">年度：</td>
								<td class="FieldInput"><input type="text" id="belongYear" class="TextEditor" title="年度" maxlength="4" onkeydown="fnTrapKD(event);" onblur="changeGrant(this)"/></td>	
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="GridPanel" name="GridPanel" width="100%" stripeRows="true" height="100%" title="经费发放" notSelectFirstRow="true" dataset="dsGrantFund" hasSum="true">
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45" />
	    <next:Column id="registerType" header="发放类别" field="registerType" width="170" dataset="GrantType">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="objectType" header="优抚对象类别" field="objectType" width="150" dataset="ObjectTypeDataset">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="grantDate" header="发放日期" field="grantDate" width="85">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="startDate" header="发放时间起" field="startDate" width="85" >
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="endDate" header="发放时间止" field="endDate" width="85">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="grantMonSum" header="发放金额" field="grantMonSum" renderer="formatNum(this)" width="115" summaryType="sum">
			<next:ExtendConfig>
				summaryRenderer : sumRender
			</next:ExtendConfig>
			<next:NumberField></next:NumberField>
		</next:Column>
	</next:Columns>
</next:GridPanel>
</body>
<script type="text/javascript">
	function init(){
			var currentYear = getCurYear();
			document.getElementById("belongYear").value = currentYear;
			var dsGrantFund = L5.DatasetMgr.lookup("dsGrantFund");
			dsGrantFund.setParameter("peopleId",peopleId);
			dsGrantFund.setParameter("currentYear",currentYear);
			dsGrantFund.load();
	}
	//获得当前年度 
	function getCurYear(){
		var date=new Date();
		var year=""+date.getFullYear();
		return year;
	}
	
	function fnTrapKD(event,a,b,c){                //网页内按下回车触发
	    if(event.keyCode==13)
	    {
	        var changYear = document.getElementById("belongYear").value;
			if(changYear.match("^2[0-9]{3}$")){
				var dsGrantFund = L5.DatasetMgr.lookup("dsGrantFund");
				dsGrantFund.setParameter("peopleId",peopleId);
				dsGrantFund.setParameter("currentYear",changYear);
				dsGrantFund.load();
			}else{
				L5.Msg.alert("提示","请输入正确年度！");
				return false;
			} 
	    }
	}	
	function changeGrant(a){
		var changYear = document.getElementById("belongYear").value;
		if(changYear.match("^2[0-9]{3}$")){
			var dsGrantFund = L5.DatasetMgr.lookup("dsGrantFund");
			dsGrantFund.setParameter("peopleId",peopleId);
			dsGrantFund.setParameter("currentYear",changYear);
			dsGrantFund.load();
		}else{
			L5.Msg.alert("提示","请输入正确年度！");
			return false;
		}
	}
	//计算总的金额
	function sumRender(value){
		if(value==undefined){
			return "";
		}else{
			value = formatNum(value);
			return value;
		}
	}
</script>
</html>