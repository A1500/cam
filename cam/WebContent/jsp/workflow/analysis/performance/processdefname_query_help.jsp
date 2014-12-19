<%@ taglib uri="/tags/web-flex" prefix="flex"%>
<%@ taglib uri="/tags/web-i18n" prefix="web"%> 
<%@ taglib uri="/tags/web-html" prefix="html"%>
<%@ taglib uri="/tags/web-widgets" prefix="widgets"%>
<%@ taglib uri="/tags/web-tab" prefix="tab"%>
<%@ taglib uri="/tags/web-loushang" prefix="loushang"%>
<%@ taglib uri="/tags/loushang-bsp" prefix="bsp"%>

<%@ page import="org.loushang.waf.ResourcesFactory"%>
<%@ page import="org.loushang.web.taglib.util.skin.SkinUtils"%>
<%@ page import="org.loushang.web.taglib.grid.flex.*"%>	
<%@ page import="org.loushang.web.taglib.util.Global"%>
<%@ page import="org.loushang.bsp.permit.context.GetBspInfo"%>

<HTML>
<HEAD>
<TITLE><%=ResourcesFactory.getString("WF_PROCESS_TYPE.Help")%></TITLE>
<link rel="stylesheet" type="text/css" href="<loushang:ui css='skin.css'/>">
<link rel="stylesheet" type="text/css" href="<loushang:ui css='flexgrid.css'/>">
<web:js src="loushangfunction.js"/>
<web:js src="inching.js"/>
<web:js src="grid.js"/>
<web:js src="tab.js"/>
<web:js src="flexgrid.js"/>
</HEAD>
<%
String typename_search=(String)request.getAttribute("type_nameSearch");
if(typename_search==null)typename_search="";
String style="";
String chaxunact="";
String clearButton=request.getParameter("clearButton");
if(clearButton!=null&&clearButton.trim().equals("true"))
{
   style="display:none";
   chaxunact="processDefNameQueryHelp.cmd?clearsearch=true&clearButton=true";
}
else 
{
  style="display:";
  chaxunact="processDefNameQueryHelp.cmd?clearsearch=true";
}
%>
<BODY topmargin="10px">
<html:form name="frmList" action="processDefNameQueryHelp.cmd">
<fieldset class="FieldsetCss"><legend><%=ResourcesFactory.getString("COMMON.SEARCH_CONDITION")%></legend>
<table id="tblSearch">
	<flex:search>
		<tr>
	    <td nowrap><%=ResourcesFactory.getString("WorkFlow.SearchHelpName")%>:</td>
	    <td><flex:searchText name="procDefnameSearch" searchName="WF_PROCESS_DEF.NAME" 
	    	value="<%=typename_search %>"
	    	dataType="java.lang.String" 
	    	operSymbol="=" size="15">
	    	</flex:searchText>
	    </td>
	    <td><flex:searchImg name="chaxun"  action='<%=chaxunact%>' image="search.gif"/></td>
		</tr>
	</flex:search>
</table>
</fieldset>
<flex:flexgrid name="grid" height="260" action="" isSubmit="true" >
				<flex:radioCol caption='<%=ResourcesFactory.getString("COMMON.CHOOSE")%>'  width="50" property="id" name="primaryKey" sortName="WF_PROCESS_DEF.ID" canSort="false"></flex:radioCol>
				<flex:flexCol caption='<%=ResourcesFactory.getString("WorkFlow.ProcessName")%>' width="200" property="name" sortName="WF_PROCESS_DEF.NAME" canSort="true"></flex:flexCol>
				<flex:flexCol caption='<%=ResourcesFactory.getString("WorkFlow.CreateTime")%>'  width="150" property="createTime" sortName="WF_PROCESS_DEF.CREATE_TIME" canSort="true"></flex:flexCol>
</flex:flexgrid>
<flex:pagePolit action="processDefNameQueryHelp.cmd" pageSize="10"></flex:pagePolit>
<div align=center>
<table width=170><tr>
<td><html:button name="btnClose" value='<%=ResourcesFactory.getString("COMMON.OK")%>' onclick="doConfirm()"></html:button>&nbsp;&nbsp;
<html:button name="btnClose" value='<%=ResourcesFactory.getString("WorkFlow.Close")%>'onclick="doClose()"></html:button>&nbsp;&nbsp;
<html:button name="btnCancel" style='<%=style%>' onclick="doCancel()" value='<%=ResourcesFactory.getString("COMMON.CLEAR")%>'></html:button></tr></table></div>
</html:form>
<script language="javascript">
grid.show();
grid.setSumText("");

function doConfirm(){
	 if(!getSelect()) return;
     var row=grid.getCurrentLine();
	 var result=new Array();
	 
	 result[0]=grid.getCellValue(row,1);
	 result[1]=grid.getCellValue(row,2);
	 result[2]=grid.getCellValue(row,3);
	
	parent.returnValue = result;
	parent.close();
}

function doCancel(){
	var result=new Array();
	 
	 result[0]="";
	 result[1]="";
	 result[2]="";
	parent.returnValue=result;
	parent.close();
}

function doClose(){
	parent.close();
}

function getSelect(){
	if(grid.getCurrentLine()==null){
		alert('<%=ResourcesFactory.getString("COMMON.SELECT_A_RECORD")%>');
		return false;
	}
	return true;
}
</script>


</BODY>
</HTML>
