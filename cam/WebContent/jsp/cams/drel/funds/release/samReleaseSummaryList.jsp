<%@page import="com.inspur.cams.comm.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>资金发放名册</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="samReleaseSummaryList.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"DatePicker.js")%>'></script>
        <script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script language="javascript">
			var organId = '<%=BspUtil.getEmpOrganId()%>';
			var assistanceType = '<%=request.getParameter("assistanceType") %>';
		    <%
		    String organArea=BspUtil.getCorpOrgan().getOrganCode();
			String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
		    %>
			var organArea='<%=organArea%>';
			var organName='<%=organName%>';
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
     <!-- 发放名册列表 -->
	<model:dataset id="releaseSummaryListDs" cmd="com.inspur.cams.drel.funds.release.cmd.SamReleaseSummaryQueryCmd" global="true" sortField="releaseDate" pageSize="15">
		<model:record fromBean="com.inspur.cams.drel.funds.release.data.SamReleaseSummary">
        	<model:field name="releaseTime"/></model:record>
	</model:dataset>
	<model:dataset id="releaseSummaryCheckDs" cmd="com.inspur.cams.drel.funds.release.cmd.SamReleaseSummaryQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.funds.release.data.SamReleaseSummary">
        	<model:field name="releaseTime"/></model:record>
	</model:dataset>
     <!-- 发放名册列表 -->
	<model:dataset id="releaseSummaryExcelDs" cmd="com.inspur.cams.drel.funds.release.cmd.SamReleaseSummaryQueryCmd" pageAble="false" >
		<model:record fromBean="com.inspur.cams.drel.funds.release.data.SamReleaseSummary"></model:record>
	</model:dataset>
	<!-- 发放名册 -->
    <model:dataset id="releaseSummaryDs" cmd="com.inspur.cams.drel.funds.release.cmd.SamReleaseSummaryQueryCmd" global="true">
        <model:record fromBean="com.inspur.cams.drel.funds.release.data.SamReleaseSummary">
        	<model:field name="releaseDate" rule="require"/>
        	<model:field name="releaseAreaName" rule="require"/>
        	<model:field name="releaseWay" rule="require"/>
        	</model:record>
    </model:dataset>
    <!-- 发放明细列表 -->
	<model:dataset id="releaseDetailListDs" cmd="com.inspur.cams.drel.funds.release.cmd.SamReleaseDetailQueryCmd" global="true">
        <model:record fromBean="com.inspur.cams.drel.funds.release.data.SamReleaseDetail"></model:record>
    </model:dataset>
	<!-- 救助类别 -->
    <model:dataset id="assistanceTypeDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
        <model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
        <model:params>
            <model:param name="dic" value='DIC_ASSITANCE_TYPE'></model:param>
        </model:params>
    </model:dataset>
    <!-- 发放类型 -->
    <model:dataset id="releaseTypeDs" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
        <model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
        <model:params>
            <model:param name="dicType" value="RELEASE_TYPE"></model:param>
        </model:params>
    </model:dataset>
    <!-- 发放方式 -->
    <model:dataset id="releaseWayDs" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
        <model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
        <model:params>
            <model:param name="dicType" value="RELEASE_WAY"></model:param>
        </model:params>
    </model:dataset>
     <!-- 发放方式 -->
    <model:dataset id="releaseStatusDs" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
        <model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
        <model:params>
            <model:param name="dicType" value="RELEASE_STATUS"></model:param>
        </model:params>
    </model:dataset>
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
					<form style="width: 100%; height: 100%;" class="L5form" id="queryForm">
						<table  border="1" width="100%" >
							<tr >
							    <td class="FieldLabel">地区</td>
                                <td class="FieldInput">
                                   <input type="text"  id="releaseAreaName" class="TextEditor" title="地区" readonly="readonly" />
                                   <input type="hidden"  id="releaseAreaCode" class="TextEditor" />
                                </td>    
								<td class="FieldLabel" style="display: none;">发放方式</td>
                                <td class="FieldInput"style="display: none;">
                                    <select id="releaseWay" field="releaseWay"  >
                                        <option dataset="releaseWayDs"/>
                                    </select>
                                </td>
								<td class="FieldLabel">发放年月</td>
								<td class="FieldInput"><input type="text"  id="releaseDate" style="padding-right:20px;background:url('<%= SkinUtils.getImage(request, "default/rl.gif ") %> ') no-repeat scroll right center transparent;" onclick="setmonth(releaseDate)" >
								                             
						                                                          </input></td>	
								
								<td class="FieldButton" ><button onclick="query()" id="queryBtn">查 询</button>&nbsp;&nbsp;<button onclick="resetQ()">重 置</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="samreleasesummaryGrid" notSelectFirstRow="true" clickToSelectedForChkSM="true" title="发放名册列表" width="100%"  stripeRows="true" height="100%" dataset="releaseSummaryListDs" >
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="登记名册" iconCls="add" handler="insert" id="inserButton"/>
		<next:ToolBarItem text="维护名册" iconCls="edit" handler="editDetail" id="editButton"/>
		<next:ToolBarItem text="确认名册" iconCls="select" handler="confirm" id="confirmButton"/>
        <next:ToolBarItem iconCls="chart"  text="导出Excel" handler="exportSummaryRelease" hidden="true" />
		<next:ToolBarItem text="删除" iconCls="remove" handler="del" id="delButton"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="releaseId" header="RELEASE_ID" field="releaseId" hidden="true" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="releaseAreaName" header="地区" field="releaseAreaName" width="150" align="center">
			<next:TextField  />
		</next:Column>
		<next:Column id="releaseDate" header="发放年月" field="releaseDate" width="100"  align="center" renderer="detailRender" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="releaseDate" header="发放区间" field="releaseTime" width="120"  renderer="getReleaseTime" align="center" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="releaseFamilySum" header="发放总户数" field="releaseFamilySum" width="100" align="right">
			<next:NumberField  />
		</next:Column>
		<next:Column id="releasePeopleNum" header="发放总人数" field="releasePeopleNum" width="100" align="right">
            <next:NumberField  />
        </next:Column>
        <next:Column id="releaseFundSum" header="发放总额（元）" field="releaseFundSum" width="120"  renderer="formatMoney" align="right">
            <next:NumberField allowBlank="false" />
        </next:Column>
        <next:Column id="baseMonSum" header="保障金总额（元）" field="baseMonSum" width="120"  renderer="formatMoney" align="right">
            <next:NumberField allowBlank="false" />
        </next:Column>
         <next:Column id="classMonSum" header="分类施保金总额（元）" field="classMonSum" width="150"  renderer="formatMoney" align="right">
            <next:NumberField allowBlank="false" />
        </next:Column>
		<next:Column id="releaseWay" header="发放方式" field="releaseWay" width="100" dataset="releaseWayDs" align="center" hidden="true">
			<next:NumberField  />
		</next:Column>
		<next:Column id="releaseStatus" header="状态" field="releaseStatus" width="120" dataset="releaseStatusDs" align="center">
			<next:TextField allowBlank="false" />
		</next:Column>
	
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="releaseSummaryListDs"/>
	</next:BottomBar>
</next:GridPanel>

<next:Window id="releaseSummaryWin" title="登记名册" closeAction="hide"  width="540" modal="true">
    <next:TopBar>
        <next:ToolBarItem symbol="->"></next:ToolBarItem>
        <next:ToolBarItem iconCls="save" text="确定" handler="save" ></next:ToolBarItem>
        <next:ToolBarItem iconCls="return" text="关闭" handler="closeWin"></next:ToolBarItem>
    </next:TopBar>
    <next:Html>
        <form dataset="releaseSummaryDs"  onsubmit="return false"  class="L5form">
            <table width='100%'>
                <tr>
                    <td class="FieldLabel" id="valueLabel" style="width:100;">地区</td>
                    <td class="FieldInput" style="width:35%">
                        <input type="text" name="地区"  field="releaseAreaName" readonly="readonly" style="width:85%"/>
                    <font color=red>*</font></td>
                    <td class="FieldLabel" style="width:100;display: none;">发放方式</td>
                    <td class="FieldInput"style="width:35%;display: none;">
                        <label field="releaseWay" name="发放方式"  dataset="releaseWayDs"></label>
                    </td>
                    <td class="FieldLabel"  style="width:100;">发放年月</td>
                    <td class="FieldInput" style="width:35%;">
                        <input type="text" name="发放日期"  field="releaseDate" onclick="setmonth(this)"  readonly/>
                        <font color=red>*</font>
                    </td>
                 </tr>
                 <tr>
                    <td class="FieldLabel" style="width:100;display: none;">发放日期区间</td>
                    <td class="FieldInput" colspan="5" style="display: none;">
                        <input type="text" name="发放日期区间起"  field="releaseBeginDate" format="Y-m" onclick="LoushangDate(this)" readonly/>
                        至
                        <input type="text" name="发放日期区间止"  field="releaseEndDate" format="Y-m" onclick="LoushangDate(this)" readonly/>
                        <span style="color:red">*</span>
                    </td>
                </tr>
            </table>
        </form>
   </next:Html>
</next:Window>



</body>
</html>
