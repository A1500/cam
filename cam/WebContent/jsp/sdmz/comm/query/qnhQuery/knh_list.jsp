<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.sdmz.comm.util.BspUtil"%>
<%
	 //String organArea = BspUtil.getCorpOrgan().getCorpOrganId();
	String organArea = BspUtil.getCorpOrgan().getOrganCode().substring(0,6);
	String organArea1 = BspUtil.getCorpOrgan().getOrganCode();
	String sign=null;
	if(organArea1.substring(4,12).equals("00000000"))
	{
		organArea1=organArea1.substring(0,4);
		sign="1";
	}
%>
<html>
	<head>
		<title>困难户查询信息列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="knh_list.js"></script>
		<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ygms/MultiSimpleGridHelp.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>		
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
			var organArea = "<%=organArea%>";
			var organArea1 = "<%=organArea1%>";
			var organArea2 = "<%=organArea%>"+"000000";
			var sign = "<%=sign%>";
		</script>
	</head>
<body>
<model:datasets>
	<!-- 列表的dataset -->
	<model:dataset id="ds" cmd="com.inspur.sdmz.comm.query.knhQuery.cmd.knhQueryCmd" global="true" autoLoad="false" pageSize="15">
		
	</model:dataset>
	<!-- 家庭信息明细 -->
	<model:dataset id="singleDs" cmd="com.inspur.sdmz.jtxx.cmd.YgjzJtxxQueryCommand" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.sdmz.jtxx.data.BaseinfoFamily"></model:record>
	</model:dataset>
	<!-- 行政区划 -->
	<model:dataset id="DmXzqhDataSetQu" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 街道区划 -->
	<model:dataset id="DmXzqhDataSetStreet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="xzqhDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 村委区划 -->
	<model:dataset id="DmXzqhDataSetVillage" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="jzlxDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean">
		</model:record>
		<model:params>
			<model:param name="dic" value='DIC_ASSITANCE_TYPE_EXT'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="jzlsDs" cmd="com.inspur.sdmz.jzfa.cmd.DetailQueryCmd" global="true" autoLoad="fasle">
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Detail">
		</model:record>
	</model:dataset>
	<!-- 数据统计的dataset -->
    <model:dataset id="zhcxJtxxNumDs" cmd="com.inspur.sdmz.comm.query.knhQuery.cmd.knhQueryCmd" global="true" autoLoad="false" method="getJtxxNum">
		<model:record fromBean="com.inspur.sdmz.jtxx.data.BaseinfoFamily"></model:record>
	</model:dataset>
</model:datasets>

<next:Panel  name="form" width="99%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this)" /> </legend>
		<div>
			<form style="width: 99%; height: 100%;" class="L5form">
				<table  border="1" style="width:99%;table-layout:fixed;" >
					<tr >
						<td class="FieldLabel" nowrap="nowrap" width="10%">姓名:</td>
						<td class="FieldInput" width="18%"><input type="text"  id="hzxmquery" maxlength="25" class="TextEditor" title="户主姓名"  /></td>	
						<td class="FieldLabel" nowrap="nowrap" width="10%">户主身份证:</td>
						<td class="FieldInput" width="18%"><input type="text"  id="sfzhquery" maxlength="18" class="TextEditor" title="户主身份证" /></td>	
						<td class="FieldLabel" nowrap="nowrap" width="10%">审核状态:</td>
						<td class="FieldInput" width="18%">
							<select id="shbzquery">
								<option value="">全部</option>
								<option value="0">转更正</option>
								<option value="1">未审核</option>
								<option value="2">审核未通过</option>
								<option value="3">审核通过</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap" width="5%">区:</td>
						<td class="FieldInput" width="17%">
							<select id="quQuery"  onchange="getDzStreet()">
								<option  dataset="DmXzqhDataSetQu"></option>
							</select>
						</td>	
						<td class="FieldLabel" nowrap="nowrap" width="5%">街镇:</td>
						<td class="FieldInput" width="17%">
							<select id="dzZhenquery" onchange="getDzCun()">
								<option dataset="DmXzqhDataSetStreet"></option>
							</select>
						</td>	
						<td class="FieldLabel" nowrap="nowrap" width="5%">村居:</td>
						<td class="FieldInput" width="17%">
							<select id="dzCunquery">
								<option dataset="DmXzqhDataSetVillage"></option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap" width="5%">查询方式:</td>
						<td class="FieldInput" width="17%">
							<select id="queryMode" onchange="directOrder()">
								<option value="mr" selected="selected">请选择……</option>
								<option value="sm">按照查询条目数</option>
								<option value="QZ">按照排名起止</option>
								<option value="dz">按地址排序</option>
							</select>							
						</td>						
						<td class="FieldLabel" nowrap="nowrap" width="10%">救助类型:</td>
						<td class="FieldInput"  nowrap="nowrap" colspan="2">
							<input type="text" id="jzlxDisplay" style="width:90%" readOnly="true" ondblclick="displayDbClick('jzlxDisplay','jzlxquery')" />
							<img src="<%=SkinUtils.getImage(request, "l5/help.gif")%>" style="cursor:hand" onclick="mutiHelp('jzlxDs','jzlxDisplay','jzlxquery')"/>
							<input type="hidden" id="jzlxquery">
						</td>
						<td class="FieldInput">
							<button onclick="query()"  >查 询</button> &nbsp&nbsp
							<button type="reset">重 置</button>
						</td>
					</tr>
					<tr id="directSpan">
						<td class="FieldLabel" nowrap="nowrap" width="5%">查询条目数:</td>
						<td class="FieldInput" width="17%">
							<input type="text"  id="smquery" />
						</td>
						<td class="FieldLabel" nowrap="nowrap" width="5%">综合得分排序:</td>
						<td class="FieldInput" width="17%">
							<select id="direct" >
								<option value="desc">从高到低</option>
								<option value="asc">从低到高</option>
							</select>							
						</td>						
						<td class="FieldLabel"></td>
						<td class="FieldInput"></td>
					</tr>
					<tr id="QZSpan">				
						<td class="FieldLabel">排名起止:</td>
						<td class="FieldInput">
							<input type="text" id="orderQ" style="width:60" maxlength="9" />-----<input type="text" id="orderZ" style="width:60" maxlength="9" />					
						</td>
						<td class="FieldLabel" nowrap="nowrap" width="5%">综合得分排序:</td>
						<td class="FieldInput" width="17%">
							<select id="direct" >
								<option value="desc">从高到低</option>
								<option value="asc">从低到高</option>
							</select>							
						</td>	
						<td class="FieldLabel"></td>
						<td class="FieldInput"></td>								
					</tr>					
				</table>
			</form>
		</div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="ygjzjtxxGrid" name="ygjzjtxxGrid" width="99%" deferRowRender="false" columnLines="true" bodyBorder="true" notSelectFirstRow="true" height="300" dataset="ds" title="阳光救助家庭信息">
	<next:TopBar>
	<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="导出Excel" iconCls="add" handler="forExcel" ></next:ToolBarItem>
	</next:TopBar>
	<next:Columns >
	    <next:RowNumberColumn header="排名" width="40"/>
		<next:Column id="jtid" header="家庭ID" field="JTID" hidden="true" align="center" width="90" >
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="HZXM" header="户主姓名" field="HZXM" width="90" align="center" >
			<next:TextField  />
		</next:Column>
		<next:Column id="MEMBER_NAME" header="家庭成员" field="JTCY" width="200" align="left">
			<next:TextField  />
		</next:Column>
		<next:Column id="RK_SL" header="人口数量" field="RK_SL" width="60" align="right">
			<next:TextField  />
		</next:Column>		
		<next:Column id="JZLX" header="救助类型" field="JZLX" renderer="jzlxRenderer" width="160" align="left" >
			<next:TextField  />
		</next:Column>
		<next:Column id="ADDRESS" header="家庭地址" field="JTDZ" width="220" align="left">
			<next:TextField  />
		</next:Column>
		<next:Column id="JZZS_ZH" header="综合得分" field="JZZS_ZH" width="60" align="center">
			<next:TextField  />
		</next:Column>
		<next:Column id="SHBZ" header="审核标识" field="CHECK_FLAG" renderer="shbzRenderer" width="120" align="center">
			<next:TextField  />
		</next:Column>
		<next:Column id="SFZH" header="身份证号" field="SFZH" hidden="true" width="80" align="center">
			<next:TextField  />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
<next:Panel   width="99%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;">
			<next:Html>
				<fieldset style="overflow:visible;" class="GroupBox">
					<legend class="GroupBoxTitle">数据统计</legend>
					<div>
						<form onsubmit="return false;" dataset="zhcxJtxxNumDs">
							<table border="0" width="70%">
								<tr>
									<td class="FieldLabel" width="20%">困难家庭户数:</td>
									<td class="FieldInput" width="25%"><label id="hsnum" name="hsnum" field="HSNUM" /></td>
									<td class="FieldLabel" width="20%">困难家庭成员人数:</td>
									<td class="FieldInput" width="25%" ><label  id="rsnum" name="rsnum" field="RSNUM" /></td>
								</tr>
							</table>
						</form>
					</div>
				</fieldset>
			</next:Html>
 </next:Panel>
<next:Window id="knh_detail" title="困难家庭信息" width="640" height="350" closeAction="hide" modal="true" resizable="true" autoScroll="true">	
	<next:Panel>
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="closeWin"></next:ToolBarItem>
		</next:TopBar>	
	<next:FitLayout>
		<next:TabPanel activeTab="0" border="false" >
			<next:Tabs>
				<next:Panel title="家庭信息明细" collapsible="false" animCollapse="true" autoScroll="false">
					<next:Html>
						<form id="detailForm" name="detailForm" dataset="singleDs" class="L5form">
							<table border="0" width="100%">
								<tr>
									<td class="FieldLabel" style="width: 10%" nowrap>姓名:</td>
									<td class="FieldInput" style="width: 25%">
										<input type="text" name="hzxm" field="familyName" readonly="true" styleClass="txtReadOnly">
									</td>
									<td class="FieldLabel" style="width: 10%" nowrap>身份证号:</td>
									<td class="FieldInput" style="width: 25%">
										<input type="text" name="sfzh" field="familyCardNo" readonly="true"/>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 10%" nowrap>人口数量:</td>
									<td class="FieldInput" style="width: 25%">
										<input type="text" name="rkSl" field="peopleNum" readonly="true"/>
									</td>
									<td class="FieldLabel" style="width: 10%" nowrap>地址_省:</td>
									<td class="FieldInput" style="width: 25%">
										<input type="text" name="dzSheng" field="province" readonly="true" styleClass="txtReadOnly">
									</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 10%" nowrap>地址_市:</td>
									<td class="FieldInput" style="width: 25%">
										<input type="text" name="dzShi" field="city" readonly="true" renderer="beforeshow"/>
									</td>
									<td class="FieldLabel" style="width: 10%" nowrap>地址_县（市、区）:</td>
									<td class="FieldInput" style="width: 25%">
										<input type="text" name="dzXian" field="county" readonly="true" renderer="beforeshow"/>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 10%" nowrap>地址_镇:</td>
									<td class="FieldInput" style="width: 25%">
										<input type="text" name="dzZhen" field="town" readonly="true" renderer="beforeshow"/>
									</td>
									<td class="FieldLabel" style="width: 10%" nowrap>地址_村（居）:</td>
									<td class="FieldInput" style="width: 25%">
										<input type="text" name="dzCun" field="village" readonly="true" renderer="beforeshow"/>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 10%" nowrap>地址_门牌号:</td>
									<td class="FieldInput" style="width: 25%">
										<input type="text" name="dzMph" field="address" readonly="true"/>
									</td>
									<td class="FieldLabel" style="width: 10%" nowrap>联系电话_宅电:</td>
									<td class="FieldInput" style="width: 25%">
										<input type="text" name="dhhm" field="familyPhone" readonly="true"/>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 10%" nowrap>联系电话_手机:</td>
									<td class="FieldInput" style="width: 25%">
										<input type="text" name="sjhm" field="familyMobile" readonly="true"/>
									</td>
									<td class="FieldLabel" style="width: 10%" nowrap>联系电话_其他:</td>
									<td class="FieldInput" style="width: 25%">
										<input type="text" name="qt" field="familyOtherPhone" readonly="true"/>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 10%" nowrap>家庭年总收入:</td>
									<td class="FieldInput" style="width: 25%">
										<input type="text" name="nzsrJe" field="yearIncome" readonly="true"/>
									</td>
									<td class="FieldLabel" style="width: 10%" nowrap>家庭年人均收入:</td>
									<td class="FieldInput" style="width: 25%">
										<input type="text" name="nrjsrJe" field="yearAverageIncome" readonly="true"/>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 10%" nowrap>家庭月总收入:</td>
									<td class="FieldInput" style="width: 25%">
										<input type="text" name="yzsrJe" field="monthIncome" readonly="true"/>
									</td>
									<td class="FieldLabel" style="width: 10%" nowrap>家庭月人居收入:</td>
									<td class="FieldInput" style="width: 25%">
										<input type="text" name="yrjsrJe" field="monthAverageIncome" readonly="true"/>
									</td>
								</tr>
							</table>
						</form>
					</next:Html>
				</next:Panel>
				<next:GridPanel id="winGrid" name="winGrid" width="100%" deferRowRender="false" columnLines="true" bodyBorder="true" notSelectFirstRow="true" height="95%" dataset="jzlsDs" title="受助历史信息">
					<next:Columns >
					    <next:RowNumberColumn width="30"/>
						<next:Column id="szdxlxdm" header="受助对象类型" field="assistedType" width="120" renderer="szdxlxdmRenderer" align="center">
							<next:TextField  />
						</next:Column>
						<next:Column id="jzrq" header="救助日期" field="assitanceDate" width="90" align="right" >
							<next:TextField  />
						</next:Column>
						<next:Column id="jzzjhjJe" header="救助资金合计金额" field="totalFund" width="140" align="right">
							<next:TextField  />
						</next:Column>
						<next:Column id="lrdwmc" header="录入单位名称" field="regOrgName" width="160" align="right" >
							<next:TextField  />
						</next:Column>
					</next:Columns>
				</next:GridPanel>
			</next:Tabs>
		</next:TabPanel>
	</next:FitLayout>
	</next:Panel>
</next:Window>
</body>
</html>