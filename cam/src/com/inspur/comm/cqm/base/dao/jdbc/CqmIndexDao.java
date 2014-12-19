package com.inspur.comm.cqm.base.dao.jdbc;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.comm.cqm.base.dao.ICqmIndexDao;
import com.inspur.comm.cqm.base.data.CqmIndex;
import com.inspur.comm.cqm.base.data.ReportRow;

/**
 * 自定义统计报表指标表dao
 * @author shgtch
 * @date 2012-03-16
 */
public class CqmIndexDao extends EntityDao<CqmIndex> implements ICqmIndexDao {

	@Override
	public Class<CqmIndex> getEntityClass() {
		return CqmIndex.class;
	}

	/**
	 * 获取指标的条数
	 * @param indexDataSql
	 * @return
	 */
	public BigDecimal getIndexRowNum(CqmIndex cqmIndex,String organCode) {
		StringBuffer sql = new StringBuffer();
		String  xzqh = null;
		sql.append("select count(*) n from (select * from ( ");
		sql.append(cqmIndex.getIndexLogicFilter()+")");
		if(cqmIndex.getIndexLogicFilter().contains("dic_city")){
			sql.append(" where "+cqmIndex.getIndexCode()+" like ? ");
			if (organCode.endsWith("0000000000")){
				xzqh=organCode.substring(0, 2)+"%";
			}else if(organCode.endsWith("00000000")){
				xzqh=organCode.substring(0, 4)+"%";
			}else {
				xzqh=organCode.substring(0, 6)+"%";
			}
		}
		sql.append(")");
		List<Map> list;
		if(xzqh!=null){
			 list = executeQuery(sql.toString(),new int[]{Types.VARCHAR},new Object[]{xzqh});
		}else{
			 list = executeQuery(sql.toString());
		}
		if (list.size() > 0) {
			Map map = list.get(0);
			return (BigDecimal) map.get("N");
		}
		return BigDecimal.ZERO;
	}

	/**
	 * 查询 指标代码
	 * @param pset
	 * @return
	 */
	public List getIndexData(String indexDataSql) {
		return executeQuery(indexDataSql);
	}

	/**
	 * 获取字典
	 * @param pset
	 * @return
	 */
	public DataSet getDic(ParameterSet pset) {
		String indexId = (String) pset.get("indexId");
		CqmIndex cqmIndex = this.get(indexId);
		StringBuffer sql = new StringBuffer();
		sql.append("select ");
		sql.append(cqmIndex.getIndexCode());
		sql.append(" code,");
		sql.append(cqmIndex.getIndexName());
		sql.append(" name from (");
		sql.append(cqmIndex.getIndexLogicFilter());
		sql.append(")");

		List<Map> list = executeQuery(sql.toString());
		DataSet ds = new DataSet();
		for (int i = 0; i < list.size(); i++) {
			Map<String, String> map = list.get(i);
			ReportRow reportRow = new ReportRow();
			reportRow.setCode(map.get("CODE"));
			reportRow.setName(map.get("NAME"));
			ds.addRecord(reportRow);
		}
		return ds;
	}

}