package com.inspur.cams.comm.workflow.taskinfo.util;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class QueryConditionUtil {
	
	public void buildConditonSqlAndParam(QueryCondition queryCondition,List typeList,List argsList,StringBuffer sql){
		sql.append(" AND ");
		sql.append(queryCondition.getConditionName());
		sql.append(" "+queryCondition.getConditionOprationSymbol());
		sql.append(" ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(queryCondition.getConditionValue()); 
	}
	/**
	 * 组装自定义查询条件的sql
	 * @param mysetwhere
	 * @param typeList
	 * @param argsList
	 * @param sql
	 */
	public void buildAllConditionSql(String mysetwhere,List typeList,List argsList,StringBuffer sql){
		List<QueryCondition> list = parseQueryCondition(mysetwhere);
		for(int i = 0;i<list.size();i++){
			buildConditonSqlAndParam(list.get(i),typeList,argsList,sql);
		}
	}
	/**
	 * 解析自定义查询条件所传过来的字符串
	 * @param mysetwhere 自定义查询条件 形式如：String@oprationSymbol:value&String@oprationSymbol:value 
	 * @return List<QueryCondition>
	 */
	public List<QueryCondition> parseQueryCondition(String mysetwhere){
		List<QueryCondition> list = new ArrayList();
		String[] mysetwheres=mysetwhere.split("&");
		for(int i=0;i<mysetwheres.length;i++){
			QueryCondition queryCondition = new QueryCondition();
			String oneQueryCondition=mysetwheres[i];
			String[] oneQueryConditions = oneQueryCondition.split(":");
			//:以前的部分，包含name@opr
			String oneQueryConditionsPrefix = oneQueryConditions[0];
			//:以后的部分，包含value
			String oneQueryConditionsSuffix = oneQueryConditions[1];
			queryCondition.setConditionValue(oneQueryConditionsSuffix);
			String[] oneQueryConditionsPrefixs = oneQueryConditionsPrefix.split("@");
			//如果没有@分割，则默认为=
			if(oneQueryConditionsPrefixs.length>1){
				queryCondition.setConditionName(oneQueryConditionsPrefixs[0]);
				queryCondition.setConditionOprationSymbol(oneQueryConditionsPrefixs[1]);
			}else{
				queryCondition.setConditionName(oneQueryConditionsPrefix);
				queryCondition.setConditionOprationSymbol("=");
			}
			list.add(queryCondition);
		}
		return list;
	}
	/**
	 * 解析select后需要显示的字段字符串，组装成前缀（如T.）.TASK_CODE形式
	 * @param showColum
	 * @param prefix
	 * @return
	 */
	public String parseShowColum(String showColum,String prefix){
		String[] showColums = showColum.split(",");
		String parsedShowColum = "";
		for(int i = 0;i<showColums.length;i++){
			parsedShowColum+=prefix+"."+showColums[i];
			if(i!=showColums.length-1){
				parsedShowColum+=",";
			}
		}
		return parsedShowColum;
	}
	
	
	public class QueryCondition{
		private  String conditionOprationSymbol = "=";;
		private  String conditionName = "";
		private  String conditionValue = "";
		public String getConditionName() {
			return conditionName;
		}
		public void setConditionName(String conditionName) {
			this.conditionName = conditionName;
		}
		public String getConditionValue() {
			return conditionValue;
		}
		public void setConditionValue(String conditionValue) {
			this.conditionValue = conditionValue;
		}
		public String getConditionOprationSymbol() {
			return conditionOprationSymbol;
		}
		public void setConditionOprationSymbol(String conditionOprationSymbol) {
			this.conditionOprationSymbol = conditionOprationSymbol;
		}
	}
}
