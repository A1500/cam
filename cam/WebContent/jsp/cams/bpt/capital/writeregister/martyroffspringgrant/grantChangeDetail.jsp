<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>老烈士(平反)子女生活补助金变更明细</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
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
		    var registerId='<%=request.getParameter("registerId")%>';
		</script>
	</head>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptCapitalDetailQueryCommand" global="true" pageSize="500" method="queryYearDataSet" isGroup="true">
		<model:record fromBean="com.inspur.cams.bpt.capital.data.BptCapitalDetail"></model:record>
	</model:dataset>
	<!-- 优抚对象类别-->
	<model:dataset id="objectds" enumName="OBJECT.TYPE.PART" autoLoad="true" global="true"></model:dataset>
	<!-- 发放类别 -->
	<model:dataset id="GrantTypeDataset" enumName="GRANTTYPE.FLAG" autoLoad="true" global="true"></model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 孤老标志-->
	<model:dataset id="dsLoneFlag" enumName="COMM.YESORNO" autoLoad="true"></model:dataset>  
</model:datasets>
<body>
<next:GridPanel id="GridPanel" name="bptcapitaldetailGrid" width="100%" stripeRows="true" height="100%" dataset="ds" enableHdMenu="true" enableColumnHide="true" enableColumnMove="true" enableScollGridView="true">
	<next:GroupingView></next:GroupingView>
	<next:Columns>
	    <next:RowNumberColumn width="40" header="序号"/>
		<next:Column id="domicileName" header="户籍地" field="domicileName" width="230" editable="false"></next:Column>
		<next:Column id="name" header="姓名" field="name" width="50" sortable="true" editable="false"></next:Column>
		<next:Column id="idCord" header="身份证号" field="idCord" width="135" sortable="true" editable="false"></next:Column>
		<next:Column id="accountCode" header="银行帐号" field="accountCode" width="170" sortable="true" editable="false"></next:Column>
		<next:Column id="credentialsNo" header="定期抚恤证编号" field="credentialsNo" width="120" sortable="true" editable="false"></next:Column>
		<next:Column id="objectType" header="优抚对象类别" field="objectType" width="130" dataset="objectds" sortable="true" editable="false"></next:Column>
		<next:Column id="changeState" header="发放类别" field="changeState" width="130" dataset="GrantTypeDataset" sortable="true" editable="false"></next:Column>
		<next:Column id="domicileType" header="户籍类别" field="domicileType" width="80" dataset="DomicileDataset" sortable="true" editable="false"></next:Column>
		<next:Column id="oldLonelyFlag" header="是否孤老" field="oldLonelyFlag" width="60" dataset="dsLoneFlag" sortable="true" editable="false"></next:Column>
		<next:Column id="grantStaMon" header="省标准" hidden="true" field="grantStaMon" renderer="formatNum(this)" width="80" align="right" editable="false">
		</next:Column>
		<next:Column id="grantMonths" header="发放月数" field="grantMonths" width="80" align="right" editable="false">
		</next:Column>
		<next:Column id="grantMon" header="发放金额" field="grantMon" renderer="formatNum(this)" width="80" align="right" editable="false">
		</next:Column>
		
		<next:Column id="otherSubsidyOne" header="地方补贴" field="otherSubsidyOne" renderer="formatNum(this)" width="80" align="right" editable="false">
		</next:Column>
		
		<next:Column id="grantMonSum" header="发放资金总额" field="grantMonSum" renderer="formatNum(this)" width="80" align="right" editable="false">
		</next:Column>
		<next:Column id="note" header="备注" field="note" width="200" editable="false">
		</next:Column>
	  </next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
<script type="text/javascript">
function init(){
	var ds = L5.DatasetMgr.lookup("ds");
	ds.setParameter("REGISTER_ID",registerId);
	ds.setParameter("CHANGE_STATE@!=","2");	
	ds.load();
}
</script>
</html>
