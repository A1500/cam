package com.inspur.cams.comm.dicm.dao.jdbc;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.comm.dicm.DicBean;
import com.inspur.cams.comm.dicm.dao.IDicDetailsDao;
import com.inspur.cams.comm.dicm.data.DicDetails;


/**
 * 字典详细信息dao
 * @author luguosui
 * @date 2011-8-31
 */
public class DicDetailsDao extends EntityDao<DicDetails> implements IDicDetailsDao {
	/**姓名*/
	private String name;

	@Override
	protected Class getEntityClass() {
		return DicDetails.class;
	}

	/**
	 * 页面显示字典表时调用查询方法
	 * @param pset
	 * @return
	 */
	public DataSet queryForDic(ParameterSet pset){
		String dicType = (String)pset.getParameter("dicType");
		String order = (String)pset.getParameter("order");
		String filterSql = (String)pset.getParameter("filterSql");
		StringBuffer sql = new StringBuffer();
		sql.append(" select a.code,a.name \n");
		sql.append("  from dic_details a \n");
		sql.append("  where a.dic_type='"+dicType+"'  \n");
		sql.append("  and flag='1' \n");
		if(StringUtils.isNotEmpty(filterSql)){
			sql.append(" AND ");
			sql.append(filterSql);
		}
		sql.append("  order by order_num ");
		if(StringUtils.isNotEmpty(order)){
			sql.append(order+"  \n");
			
		}else{
			sql.append("\n");
		}
		List<Map> list = executeQuery(sql.toString());
		List<Record> recordList = new ArrayList<Record>();
		DataSet ds = new DataSet();
		for(int i=0;i<list.size();i++){
			Map map = (Map) list.get(i);
			DicBean dicBean = new DicBean();
			dicBean.setValue((String) map.get("CODE"));
			dicBean.setText((String) map.get("NAME"));
			ds.addRecord(dicBean);
		}
		return ds;
	}
	/**
	 * 页面显示字典表时调用查询方法（通用）
	 * @param pset
	 * @return
	 */
	public DataSet queryForGeneralDic(ParameterSet pset){
		//作为字典表的表名
		String dicName = (String)pset.getParameter("dic");
		//字典表的名称
		String value = (String)pset.getParameter("text");
		//字典表的代码值
		String code = (String)pset.getParameter("value");
		//扩展sql
		String filterSql = (String)pset.getParameter("filterSql");
		
		StringBuffer sql=new StringBuffer();
		
		sql.append(" select "+value+","+code+"   \n");
		sql.append(" from "+dicName+"  \n");
		sql.append(" where 1=1 \n");
		if(StringUtils.isNotEmpty(filterSql)){
			sql.append(" AND ");
			sql.append(filterSql);
		}

		List<Map> list = executeQuery(sql.toString());
		List<Record> recordList = new ArrayList<Record>();
		DataSet ds = new DataSet();
		for(int i=0;i<list.size();i++){
			Map map = (Map) list.get(i);
			DicBean dicBean = new DicBean();
			dicBean.setValue((String) map.get(value));
			dicBean.setText((String) map.get(code));
			ds.addRecord(dicBean);
		}
		return ds;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
