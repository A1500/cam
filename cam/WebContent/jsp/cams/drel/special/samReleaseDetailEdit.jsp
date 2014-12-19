
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
	<head>
		<title>维护名册</title>
		<script type="text/javascript">
		    var releaseId='<%=request.getParameter("releaseId")%>';
		    var assistanceType='<%=request.getParameter("assistanceType")%>';
		    var releaseDate='<%=request.getParameter("releaseDate")%>';
		    <%
		    String organArea=BspUtil.getCorpOrgan().getOrganCode();
			String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
		    %>
			var organArea='<%=organArea%>';
			var organName='<%=organName%>';
		</script>
		<next:ScriptManager/>
		<script type="text/javascript" src="samReleaseDetailEdit.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
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
	<model:dataset id="releaseDetailListDS" cmd="com.inspur.cams.drel.funds.release.cmd.SamReleaseDetailQueryCmd" global="true" pageSize="15">
		<model:record fromBean="com.inspur.cams.drel.funds.release.data.SamReleaseDetail"></model:record>
	</model:dataset>
	<!-- 专项救助项目 -->
	<model:dataset id="specialAssistanceItemDs"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SAM_SPECIAL_ASSISTANCE_ITEM'></model:param>
			<model:param name="value" value='ITEM_CODE'></model:param>
			<model:param name="text" value='ITEM_NAME'></model:param>
		</model:params>
	</model:dataset>
    <!-- 发放方式 -->
    <model:dataset id="releaseWayDs" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
        <model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
        <model:params>
            <model:param name="dicType" value="RELEASE_WAY"></model:param>
        </model:params>
    </model:dataset>
	<model:dataset id="releaseDetailExcelDs" cmd="com.inspur.cams.drel.funds.release.cmd.SamReleaseDetailQueryCmd" global="true" pageAble="false">
		<model:record fromBean="com.inspur.cams.drel.funds.release.data.SamReleaseDetail"></model:record>
	</model:dataset>
	<!-- 救助类别 -->
    <model:dataset id="assistanceTypeDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
        <model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
        <model:params>
            <model:param name="dic" value='DIC_ASSITANCE_TYPE'></model:param>
			<model:param name="includeCode" value='01,02,03,11'></model:param>
        </model:params>
    </model:dataset>
	<!-- 发放名册 -->
    <model:dataset id="releaseSummaryDs" cmd="com.inspur.cams.drel.funds.release.cmd.SamReleaseSummaryQueryCmd" global="true">
        <model:record fromBean="com.inspur.cams.drel.funds.release.data.SamReleaseSummary">
        </model:record>
    </model:dataset>
	<!-- 发放对象 -->
	<model:dataset id="releaseTargetDS" enumName="SAM.RELEASE.TARGET" autoLoad="true" global="true">
	</model:dataset>
	<model:dataset id="releaseDetailDs" cmd="com.inspur.cams.drel.funds.release.cmd.SamReleaseDetailQueryCmd" global="true" pageSize="15">
		<model:record fromBean="com.inspur.cams.drel.funds.release.data.SamReleaseDetail"></model:record>
	</model:dataset>
	<model:dataset id="bankDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
        <model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
        <model:params>
            <model:param name="dic" value='DIC_BANK'></model:param>
        </model:params>
    </model:dataset>
	<!-- 救助类型 -->
	<model:dataset id="AssistanceDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_assitance_Type'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
			<model:param name="includeCode" value='01,02,03'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" border="0">
	<next:Html>	
		<fieldset>
			<legend>查询条件
				<img class="GroupBoxExpandButton" src=<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%> onclick="collapse(this)" />
			</legend>
			<div>
				<form class="L5form" id="queryForm">
					<table width="100%" >
						<tr>
					    	<td class="FieldLabel" nowrap="nowrap" width="8%">地区</td>
					        <td class="FieldInput" width="25%">
					        	<input type="text" id="domicileName" style="width: 175"
									readonly="readonly" /><img
									src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
									style="cursor: hand" onclick="func_ForDomicileSelect()"/>
								<input type="text" id="domicileCode" name="carCode" style="display: none"/>
					        </td>
					    	<td class="FieldLabel" nowrap="nowrap" width="8%">户主姓名</td>
					        <td class="FieldInput" width="25%">
					        	<input type="text" name="familyName" id="familyName"/>
					        </td>
							<td class="FieldButton" width="8%">
								<button onclick="query()">查 询</button>
							</td>
					    </tr>
					    <tr>
					        <td class="FieldLabel" nowrap="nowrap" width="8%">身份证号码</td>
					        <td class="FieldInput" width="25%">
					        	<input type="text" name="familyCardNo" id="familyCardNo" style="width: 175"/>
					        </td>
					        <td class="FieldLabel" nowrap="nowrap" width="8%">救助对象类别</td>
					        <td class="FieldInput" width="25%">
					        	<select name="assistanceType" id="assistanceType" disabled="disabled">
					        		<option dataset="AssistanceDataset"></option>
					        	</select>
					        </td>
					        <td nowrap="nowrap" class="FieldButton" width="8%">
								<button onclick="resetQ()">重 置</button>
						    </td>
					     </tr>
					</table>
				</form>
			</div>
		</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel" name="samreleasedetailGrid" width="100%" stripeRows="true" height="400"  notSelectFirstRow="true" clickToSelectedForChkSM="true" dataset="releaseDetailListDS">
    <next:TopBar>
        <next:ToolBarItem symbol="->"></next:ToolBarItem>
        <next:ToolBarItem iconCls="add" text="增加" handler="insert"/>
        <next:ToolBarItem iconCls="edit" text="修改" handler="editDetail"/>
        <next:ToolBarItem iconCls="remove" text="删除" handler="del"/>
        <next:ToolBarItem iconCls="chart"  text="导出CSV" handler="exportDetail"/>
        <next:ToolBarItem iconCls="disable"  text="关闭" handler="colseWin"/>
    </next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="domicileName" header="地区" field="domicileName" width="120"  align="center">
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
		<next:Column id="releaseMonSum" header="补贴金(元)" field="releaseMonSum" width="90"  renderer="formatMoney"  align="right">
            <next:NumberField  />
        </next:Column>
		
		<next:Column id="accountName" header="账户名称" field="accountName" width="90"  align="center">
            <next:TextField  />
        </next:Column>
		<next:Column id="bank" header="开户银行" field="bank" width="120" dataset="bankDs" align="center">
			<next:TextField  />
		</next:Column>
		<next:Column id="accountNumber" header="账号" field="accountNumber" width="180"  align="center">
			<next:TextField  />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="releaseDetailListDS"/>
	</next:BottomBar>
	
</next:GridPanel>
</body>

<next:Window id="releaseDetailWin" title="专项补贴明细" closeAction="hide"  width="740" modal="true">
    <next:TopBar>
        <next:ToolBarItem symbol="->"></next:ToolBarItem>
        <next:ToolBarItem iconCls="save" text="确定" handler="saveReleaseDetail" ></next:ToolBarItem>
        <next:ToolBarItem iconCls="return" text="关闭" handler="closeReleaseDetailWin"></next:ToolBarItem>
    </next:TopBar>
    <next:Html>
        <form dataset="releaseDetailDs"  onsubmit="return false"  class="L5form">
            <table width='100%'>
                <tr>
                    <td class="FieldLabel" id="valueLabel" style="width:15%">姓名:</td>
                    <td class="FieldInput" style="width:15%">
                        <label type="text"  field="name" style="width:85%"></label>
                  </td>
                    <td class="FieldLabel" id="valueLabel" style="width:15%">身份证号:</td>
                    <td class="FieldInput" style="width:15%">
                        <label type="text"   field="idCard"style="width:85%"></label></td>
            
                </tr>
                <tr>
                    <td class="FieldLabel" style="width:15%">救助对象类别:</td>
                    <td class="FieldInput" style="width:15%">
                        <label field="assistanceType" name="救助对象类别" style="width:85%" dataset="assistanceTypeDs"/></label>
                    </td>
                    <td class="FieldLabel" style="width:15%">救助金（元）:</td>
                    <td class="FieldInput" style="width:15%">
                        <input type="text" name="救助金" id="releaseMonSum" field="releaseMonSum" style="width:85%"/>
                        <span style="color:red">*</span>
                    </td>
                </tr>
            </table>
        </form>
   </next:Html>
</next:Window>
</html>
