package com.inspur.cams.fis.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.fis.base.dao.IFisResourceRuleDao;
import com.inspur.cams.fis.base.data.FisResourceRule;

/**
 * @Path com.inspur.cams.fis.base.dao.jdbc.FisResourceRuleDao
 * @Description: TODO 殡葬业务资源级别规则定义表dao实现
 * @author wangziming
 * @date 2011-11-15
 */
public class FisResourceRuleDao extends EntityDao<FisResourceRule> implements IFisResourceRuleDao {

	public FisResourceRuleDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return FisResourceRule.class;
	}

	public DataSet queryRuleList(ParameterSet pset) {
		String paramLevel = (String) pset.getParameter("parentLevel");
		StringBuffer sql = new StringBuffer("");
		sql.append("SELECT R.RULE_ID RULE_ID ,R.PARENT_LEVEL PARENT_LEVEL,C.LEVEL_NAME LEVEL_NAME,C.RESOURCE_TYPE RESOURCE_TYPE,C.TYPE_NAME TYPE_NAME ");
		sql.append("  FROM FIS_RESOURCE_RULE R, (SELECT T.TYPE_NAME TYPE_NAME, T.RESOURCE_TYPE RESOURCE_TYPE,");
		sql.append(" L.LEVEL_ID LEVEL_ID,L.LEVEL_NAME LEVEL_NAME FROM FIS_RESOURCE_TYPE T,FIS_RESOURCE_LEVEL L ");
		sql.append(" WHERE T.IF_LEVEL = '1' AND T.RESOURCE_TYPE=L.RESOURCE_TYPE) C WHERE 1=1 ");

		if (!"".equals(paramLevel) && paramLevel != null) {
			sql.append("  AND R.PARENT_LEVEL=?");
		}
		sql.append(" AND R.PARENT_LEVEL = C.LEVEL_ID ORDER BY C.RESOURCE_TYPE DESC,R.PARENT_LEVEL ASC");
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		if (!"".equals(paramLevel) && paramLevel != null) {
			list = executeQuery(sql.toString(), new int[] { Types.VARCHAR }, new Object[] { paramLevel });
		} else {
			list = executeQuery(sql.toString());
		}
		ArrayList<Record> arrRecList = new ArrayList<Record>();
		HashMap map = new HashMap();
		StringBuffer strBuffer = new StringBuffer("");
		for (int i = 0; i < list.size(); i++) {
			FisResourceRule bean = new FisResourceRule();
			Record rec = new Record(bean);
			map = (HashMap) list.get(i);
			String parentLevel = (String) map.get("PARENT_LEVEL");
			String ruleId = (String) map.get("RULE_ID");
			String parentName = (String) map.get("LEVEL_NAME");
			String resourceType = (String) map.get("RESOURCE_TYPE");
			String typeName = (String) map.get("TYPE_NAME");
			if (strBuffer.indexOf(parentLevel + ",") >= 0) {
				continue;
			} else {
				strBuffer.append(parentLevel).append(",");
			}
			String childSql = "SELECT R.CHILDREN_LEVEL CHILDREN_LEVEL, L.LEVEL_NAME LEVEL_NAME  FROM FIS_RESOURCE_RULE R, FIS_RESOURCE_LEVEL L WHERE 1=1   AND R.PARENT_LEVEL=? AND R.CHILDREN_LEVEL = L.LEVEL_ID";
			List<Map<String, String>> childList = executeQuery(childSql, new int[] { Types.VARCHAR }, new Object[] { parentLevel });
			String childrenName = "";
			String childrenLevel = "";
			for (int j = 0; j < childList.size(); j++) {
				HashMap childMap = (HashMap) childList.get(j);
				childrenLevel = childrenLevel + (String) childMap.get("CHILDREN_LEVEL") + ",";
				childrenName = childrenName + (String) childMap.get("LEVEL_NAME") + ",";
			}
			if (childrenLevel.length() > 0) {
				childrenLevel = childrenLevel.substring(0, childrenLevel.length() - 1);
				childrenName = childrenName.substring(0, childrenName.length() - 1);
			}
			rec.set("ruleId", ruleId);
			rec.set("parentLevel", parentLevel);
			rec.set("parentName", parentName);
			rec.set("childrenLevel", childrenLevel);
			rec.set("childrenName", childrenName);
			rec.set("resourceType", resourceType);
			rec.set("typeName", typeName);

			arrRecList.add(rec);

		}

		DataSet ds = new DataSet();
		ds.getRecordSet().addAll(arrRecList);
		ds.setTotalCount(arrRecList.size());
		return ds;
	}

	/**
	 * 根据父级别删除记录
	 */
	public void deleteByParentLevel(String parentLevel) {
		String sql = "DELETE FROM FIS_RESOURCE_RULE WHERE PARENT_LEVEL=?";
		this.executeUpdate(sql, new int[] { Types.VARCHAR }, new Object[] { parentLevel });
	}
}
