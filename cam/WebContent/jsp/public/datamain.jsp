<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>

<html>
<head>
</head>

<body topmargin="10px" bgcolor="#eff7ff">
<DIV class=HdrProps>
<TABLE class=Form>
	<COLGROUP>
		<COL width="20%">
		<COL width="80%">
	</COLGROUP>
	<TBODY>
		<TR class=Section>
			<TH colSpan=2><%=res.get("BSPOTHER.INIT_DB")%></TH>
		</TR>
	</TBODY>
</TABLE>
</DIV>

<hr>
<FORM style="MARGIN-TOP: 0px" name=frmMain method=post	action="initing.jsp">
	<div>
	<BUTTON class=btn id=btnClear accessKey=R name=btnClear type=reset><%=res.get("BSPOTHER.RESET")%></BUTTON>
	<BR>
	<hr>
	<TABLE class=Form>
		<COLGROUP>
			<COL width="50%">
			<COL width="50%">
		</COLGROUP>
		<TBODY>
			<TR class=Separator>
				<TD class=sep1 colSpan=2 align="center"><%=res.get("BSPOTHER.USE_CONFIG_CONNECT_DB")%><BR>
				<HR>
				</TD>
			</TR>
			<tr>
				<td class=Field>
				<BUTTON class=btn id=btnSave3 accessKey=S name=btnSave3 type=button
					onClick="OnSubmit31()"><%=res.get("BSPOTHER.INIT_DATA")%></BUTTON>
				</td>
				<td class=Field>
				<BUTTON class=btn id=btnSave33 accessKey=S name=btnSave33 type=button
					onClick="OnSubmit32()"><%=res.get("BSPOTHER.CUSTOM_SQL_EXECUTE")%></BUTTON>
				</td>
			</tr>
		</TBODY>
	</TABLE>
	</div>

	<br>
	<hr>
	<TABLE class=Form>
		<COLGROUP>
			<COL width="20%">
			<COL width="80%">
		</COLGROUP>
		<TBODY>
			<TR class=Separator>
				<TD class=sep1 colSpan=2 align="center"><%=res.get("BSPOTHER.DIRECT_CONNECT_DB")%><BR>
				<HR>
				</TD>
			</TR>
			<tr>
				<td><%=res.get("BSPOTHER.DB_TYPE")%></td>
				<td class=Field><select name=dbtype>
					<option value="1">SqlServer</option>
					<option value="2">Oracle</option>
					<option value="3" selected>IBM_db2<%=res.get("BSPOTHER.INSTALL_CLIENT")%></option>
					<option value="4">IBM_db2_type4<%=res.get("BSPOTHER.UNINSTALL_CLIENT")%></option>
					<option value="jndi"><%=res.get("BSPOTHER.USE_JNDI_CONNECTION")%></option>
					<option value="dataSource"><%=res.get("BSPOTHER.USE_CONFIG_CONNECT_DB")%></option>
				</select></td>
			</tr>
			<tr>
				<td><%=res.get("SYS.DATABASESERVER")%>IP</td>
				<td class=Field><input accesskey=Z name=dbserver maxlength="20"
					value="127.0.0.1"></td>
			</tr>
			<tr>
				<td><%=res.get("SYS.DATABASENAME")%></td>
				<td class=Field><input accesskey=Z name=dbname maxlength="20"
					value="loushang"></td>
			</tr>
			<tr>
				<td><%=res.get("SYS.USERNAME")%></td>
				<td class=Field><input accesskey=Z name=username maxlength="20"
					value="sa"></td>
			</tr>
			<tr>
				<td><%=res.get("SYS.PASSWORD")%></td>
				<td class=Field><input accesskey=Z type=password name=password
					maxlength="20" value=""></td>
			</tr>
			<tr>
				<td><%=res.get("BSPOTHER.USE_NOW_DB")%></td>
				<td class=Field>
				<BUTTON class=btn id=btnSave1 accessKey=S name=btnSave1 type=button
					onClick="OnSubmit11()"><%=res.get("BSPOTHER.START_CREATE_INIT_DATA")%></BUTTON>
				&nbsp;
				<BUTTON class=btn id=btnSave11 accessKey=S name=btnSave11 type=button
					onClick="OnSubmit12()"><%=res.get("BSPOTHER.CONNECT_DB_EXECUTE_SQL")%></BUTTON>
				</td>
			</tr>
		</TBODY>
	</TABLE>

	<hr>
	<TABLE class=Form>
		<COLGROUP>
			<COL width="20%">
			<COL width="80%">
		</COLGROUP>
		<TBODY>
			<TR class=Separator>
				<TD class=sep1 colSpan=2 align="center">JNDI<BR>
				<HR>
				</TD>
			</TR>
			<tr>
				<td><%=res.get("BSPOTHER.JNDI_TYPE")%></td>
				<td class=Field><select name=jndiType>
					<option value="1" selected>&nbsp;Websphere,Weblogic&nbsp;</option>
					<option value="2">&nbsp;Tomcat&nbsp;</option>
				</select></td>
			</tr>
			<tr>
				<td><%=res.get("BSPOTHER.JNDI_NAME")%></td>
				<td class=Field><input accesskey=Z name=jndiName maxlength="20"
					value=""></td>
			</tr>
			<tr>
				<td><%=res.get("BSPOTHER.USE_JNDI_CONNECTION")%></td>
				<td class=Field>
				<BUTTON class=btn id=btnSave2 accessKey=S name=btnSave2 type=button
					onClick="OnSubmit21()"><%=res.get("BSPOTHER.START_CREATE_INIT_DATA")%></BUTTON>
				&nbsp;&nbsp;
	
				<BUTTON class=btn id=btnSave22 accessKey=S name=btnSave22 type=button
					onClick="OnSubmit22()"><%=res.get("BSPOTHER.CONNECT_DB_EXECUTE_SQL")%></BUTTON>
				</td>
			</tr>
		</TBODY>
	</TABLE>
</FORM>

<div><font color=red size=2> </font></div>
<HR>
	<!--
	<FONT SIZE="3" COLOR="#3333FF">
	<%=res.get("BSPOTHER.USE_NOTE")%><BR>
	<%=res.get("BSPOTHER.HINTS1")%><BR>
	<%=res.get("BSPOTHER.HINTS2")%><BR>
	<%=res.get("BSPOTHER.HINTS3")%><BR>
	<%=res.get("BSPOTHER.HINTS4")%> <BR>
	<%=res.get("BSPOTHER.HINTS5")%><BR>
	<%=res.get("BSPOTHER.HINTS6")%><BR>
	<%=res.get("BSPOTHER.HINTS7")%><BR>
	<%=res.get("BSPOTHER.HINTS8")%><BR>
	<%=res.get("BSPOTHER.HINTS9")%><BR>
	<%=res.get("BSPOTHER.HINTS10")%><BR>
	<%=res.get("BSPOTHER.HINTS11")%><BR>
	<%=res.get("BSPOTHER.HINTS12")%><BR>
	<%=res.get("BSPOTHER.HINTS13")%>	
	</FONT>  -->
<HR>
<script language="javascript">
	function check(){
		var dbserver= document.frmMain.dbserver.value;
	
		if(dbserver==""){
			alert('<%=res.get("BSPOTHER.CHECK1")%>');
			return false;
		}
			
		var username= document.frmMain.username.value;
		
		if(username==""){
			alert('<%=res.get("BSPOTHER.CHECK2")%>');
			return false;
		}
		var dbname= document.frmMain.dbname.value;
		if(dbname==""){
			alert('<%=res.get("BSPOTHER.CHECK3")%>');
			return false;
		}
		
		var dbtype= document.frmMain.dbtype;
		if(dbtype.value=="jndi"){	
			alert('<%=res.get("BSPOTHER.CHECK4")%>');
			dbtype.select();
			dbtype.focus();
			return false;
		}
		return true;
	}
	
	function check2(){
		var jndiName= document.frmMain.jndiName.value;
		
		if(jndiName==""){
			alert('<%=res.get("BSPOTHER.CHECK5")%>');
			return false;
		}
		 return true;
	}
	function diableButton(){
		document.frmMain.btnSave1.disabled = true;
		document.frmMain.btnSave11.disabled = true;
		document.frmMain.btnSave2.disabled = true;
		document.frmMain.btnSave22.disabled = true;
		document.frmMain.btnSave3.disabled = true;
		document.frmMain.btnSave33.disabled = true;
	}
	
	function OnSubmit11(){
		if(!check()) 
			return;
	    diableButton();
		document.frmMain.submit();
	}
	
	function OnSubmit21(){
		if(!check2()) return;
		var dbtype=document.frmMain.dbtype;		
		dbtype.value="jndi";
		diableButton();
		document.frmMain.submit();
	}
	
	function OnSubmit31(){	
		var dbtype=document.frmMain.dbtype;	
		dbtype.value="dataSource";			
		diableButton();
		document.frmMain.submit();
	}
	function OnSubmit12(){
		if(!check()) return;
		document.frmMain.action="loadsql.jsp";
	    diableButton();
		document.frmMain.submit();
	}
	
	function OnSubmit22(){
		if(!check2()) return;
		var dbtype=document.frmMain.dbtype;
		document.frmMain.action="loadsql.jsp";		
		dbtype.value="jndi";
		diableButton();
		document.frmMain.submit();
	}
	function OnSubmit32(){	
		var dbtype=document.frmMain.dbtype;		
		document.frmMain.action="loadsql.jsp";
		dbtype.value="dataSource";
		diableButton();
		document.frmMain.submit();
	}
</script>
</body>
</html>