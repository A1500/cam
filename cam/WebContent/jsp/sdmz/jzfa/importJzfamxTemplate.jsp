<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<Excel:tablelist filename="救助方案明细模板">
	<Excel:table sheetname="救助方案明细模板">
		<Excel:tr>
			<Excel:td colspan="7" align="center" ><Excel:font size="15">救助方案明细模板</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="7">一条救助方案对应的明细信息</Excel:td>
		</Excel:tr>
		<Excel:tr height="50" >
			<Excel:td  align="center" width="100">受助人/单位名称</Excel:td>			
			<Excel:td  align="center" width="100">受助对象身份证号</Excel:td>
			<Excel:td  align="center" width="100">救助方向</Excel:td>
			<Excel:td  align="center" width="100">受助类型</Excel:td>
			<Excel:td  align="center" width="100">受助日期</Excel:td>
			<Excel:td  align="center" width="100">救助资金现金金额</Excel:td>
			<Excel:td  align="center" width="100">救助物品名称</Excel:td>
			<Excel:td  align="center" width="100">救助物品数量</Excel:td>
			<Excel:td  align="center" width="100">救助物品折价金额</Excel:td>
			<Excel:td  align="center" width="100">合计金额</Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

