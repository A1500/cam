
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>发放明细列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="samReleaseDetail.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript">
		    var releaseId='<%=request.getParameter("releaseId")%>';
		    var assistanceType='<%=request.getParameter("assistanceType")%>';
		    var releaseDate='<%=request.getParameter("releaseDate")%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="releaseDetailListDs" cmd="com.inspur.cams.drel.funds.release.cmd.SamReleaseDetailQueryCmd" global="true" pageSize="15">
		<model:record fromBean="com.inspur.cams.drel.funds.release.data.SamReleaseDetail"></model:record>
	</model:dataset>
	<model:dataset id="bankDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
        <model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
        <model:params>
            <model:param name="dic" value='DIC_BANK'></model:param>
        </model:params>
    </model:dataset>
</model:datasets>

<next:GridPanel id="editGridPanel" name="samreleasedetailGrid" width="100%" stripeRows="true" height="400" dataset="releaseDetailListDs">
    <next:TopBar>
        <next:ToolBarItem symbol="->"></next:ToolBarItem>
        <next:ToolBarItem iconCls="yes"  text="确定" handler="confirmReleaseSummary"/>
        <next:ToolBarItem iconCls="disable"  text="关闭" handler="colseWin"/>
    </next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="detailId" header="DETAIL_ID" field="detailId" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="familyId" header="FAMILY_ID" field="familyId" hidden="true" >
			<next:TextField  />
		</next:Column>
		<next:Column id="domicileName" header="地区" field="domicileName" width="120" align="center" >
            <next:TextField  />
        </next:Column>
		<next:Column id="name" header="姓名" field="name" width="90"  align="center">
			<next:TextField  />
		</next:Column>
		<next:Column id="idCard" header="身份证号码" field="idCard" width="200"  align="center">
			<next:TextField  />
		</next:Column>
		<next:Column id="assistancePeopleNum" header="保障人数" field="assistancePeopleNum" width="90" align="right" >
			<next:NumberField  />
		</next:Column>
		<next:Column id="releaseMonSum" header="发放合计(元)" field="releaseMonSum" width="90"  renderer="formatMoney"  align="right">
            <next:NumberField  />
        </next:Column>
		<next:Column id="baseMon" header="补贴金(元)" field="baseMon" width="90"  renderer="formatMoney"  align="right">
			<next:NumberField  />
		</next:Column>
		
		<next:Column id="accountName" header="账户名称" field="accountName" width="90"  align="center">
            <next:TextField  />
        </next:Column>
		<next:Column id="bank" header="开户银行" field="bank" width="90" dataset="bankDs" align="center">
			<next:TextField  />
		</next:Column>
		<next:Column id="accountNumber" header="账号" field="accountNumber" width="90"  align="center">
			<next:TextField  />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="releaseDetailListDs"/>
	</next:BottomBar>
	
</next:GridPanel>
</body>
</html>
