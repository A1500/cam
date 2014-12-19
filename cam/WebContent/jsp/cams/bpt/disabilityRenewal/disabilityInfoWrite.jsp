<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>残疾军人换证</title>
<next:ScriptManager />
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var renewalFlag='<%=request.getParameter("renewalFlag")%>';
			var changeContent= '<%=java.net.URLDecoder.decode(request.getParameter("changeContent")==null?"":request.getParameter("changeContent"), "UTF-8")%>';
		
			
			
		</script>
<script type="text/javascript" src="disabilityInfoWrite.js"></script>
</head>
<body>
<model:datasets>
	<!-- 人员信息 -->
	<model:dataset id="BaseinfoPeopleDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" global="true" method="queryPeopleInfo">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
		</model:record>
	</model:dataset>
</model:datasets>

<next:Panel height="100%"  bodyStyle="width:100%" width="100%" autoScroll="false">

	
	<next:TabPanel>
		<next:Tabs>
			<next:Panel title="残疾军人证信息写入" height="100%"  bodyStyle="width:100%" width="100%" autoScroll="false">
				<next:Panel title="民政部信息写入" autoHeight="true" width="100%"  autoScroll="true" id="peopleTabPanel" >
					<next:Html>
						    <object id="demo" classid="clsid:6A7B0AE2-8378-42b9-9EBF-422C2917D834" codebase="../comm/UhfEncypt.cab" WIDTH="0" HEIGHT="0"> </object>
						<form id="BaseinfoPeopleForm" method="post"  
							 dataset="BaseinfoPeopleDataSet" onsubmit="return false" width="100%"
							style="padding: 5px;" class="L5form">
						<table border="0" width="98%"  style="margin:0 auto; ">
							<tr>
								<td class="FieldLabel" >姓名：</td>
								<td class="FieldInput" ><input type="text" readonly="readonly"
									id="name" name="name" field="name" title="姓名"  />&nbsp;&nbsp;&nbsp;&nbsp;
									<button onclick="Fun_WriteEpcWithCipher()">写入证书</button>
								</td>
								
							</tr>
							
							<tr>
								<td class="FieldLabel"  nowrap >身份证件号码：</td>
								<td class="FieldInput" ><input type="text" id='idCard' readonly="readonly"
									name="idCard" field="idCard" title="身份证件号码" style="width:135" maxlength="18" />
								</td>
							
								
							</tr>
							
							<tr>
								<td class="FieldLabel" >信息：</td>
								<td class="FieldInput" >
								<textarea rows="7" cols="50" name="TaShow"  readonly="readonly" id="TaShow"></textarea>
								</td>
								
							</tr>
							<input type="hidden" name="TbTid" id="TbTid" size=40 > 
						  </table>
						</form>
						
					</next:Html>
				</next:Panel>
				<next:Panel title="铁道部信息写入" autoHeight="true" width="100%"  autoScroll="true" id="tieTabPanel1">
					<next:Html>
						<OBJECT
							  id=KsTag
							  classid="clsid:A33DE0DA-2094-402F-8C20-B5229E57E831"
							  codebase="../comm/KsTag.cab"
							  width=0
							  height=0
							  align=center
							  hspace=0
							  vspace=0
						>
						</OBJECT>
						<fieldset>
						<form id="BaseinfoPeopleForm" method="post"  
							 dataset="BaseinfoPeopleDataSet" onsubmit="return false" width="100%"
							style="padding: 5px;" class="L5form">
						<table border="0" width="98%"  style="margin:0 auto; ">
							<tr>
								<td class="FieldLabel" >姓名：</td>
								<td class="FieldInput" ><input type="text" readonly="readonly"
									id="tlname" name="name" field="name" title="姓名"  />&nbsp;&nbsp;&nbsp;&nbsp;
									<button onclick="WriteCard()">写入证书</button>
								</td>
								
							</tr>
							
							<tr>
								<td class="FieldLabel"  nowrap >身份证件号码：</td>
								<td class="FieldInput" ><input type="text" id='tlidCard' readonly="readonly"
									name="idCard" field="idCard" title="身份证件号码" style="width:135" maxlength="18" />
								</td>
							
								
							</tr>
							
							<tr>
								<td class="FieldLabel" >信息：</td>
								<td class="FieldInput" >
								<textarea rows="7" cols="50" name="TaShow"  readonly="readonly" id="tlTaShow"></textarea>
								</td>
								
							</tr>
							<input type="hidden" name="tlTbTid" id="tlTbTid" size=40 > 
						  </table>
						</form>
						</fieldset>
					</next:Html>
				</next:Panel>
			</next:Panel>
			<next:Panel id="pirntcertTabPanel" title="打印证书" autoHeight="true" autoScroll="true" width="100%">
				<next:Html>
					<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value=""/>
					<input type="hidden" id="scaconfPath" value="reguIdentiApp/reguIdentiAppPrintDao"/>
					<input type="hidden" id="objectType" name="printQuery" queryData="queryData" value="" />
					<input type="hidden" id="printYear" name="printMark" printMark="printMark" value="" />
					<input type="hidden" id="printMonth" name="printMark" printMark="printMark" value="" />
					<input type="hidden" id="changeContent" name="printMark" printMark="printMark" value="" />
					<input type="hidden" id="docPath" printMark="printMark" value="" />
					<input type="hidden" id="bptQueryPathServiceType" value=""/>
				</next:Html>
			</next:Panel>

		</next:Tabs>
	</next:TabPanel>

</next:Panel>


</body>
</html>
