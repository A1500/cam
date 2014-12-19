package com.inspur.sdmz.dicm.dao.jdbc;

import java.sql.Types;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.sdmz.dicm.dao.IDmDao;
import com.inspur.sdmz.dicm.data.DmBean;

/**
 * @title:DmHzgxDao
 * @description:
 * @author:
 * @since:2011-04-30
 * @version:1.0
 */
public class DmDao extends EntityDao<DmBean> implements IDmDao {

	public DmDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return DmBean.class;
	}

	public DataSet getDicMapList(ParameterSet pset) {
		String tableName = n2b((String) pset.getParameter("tableName"));
		String valueField = n2b((String) pset.getParameter("valueField"));
		String textField = n2b((String) pset.getParameter("textField"));
		String filterSql = n2b((String) pset.getParameter("filterSql"));
		String sortBySql = n2b((String) pset.getParameter("sortBySql"));
		if(valueField.equals("")){
			valueField = tableName.replaceFirst("DM_","").toUpperCase()+"DM";
		}
		if(textField.equals("")){
			textField = tableName.replaceFirst("DM_","").toUpperCase()+"MC";
		}
		StringBuffer sql = new StringBuffer();
		sql.append("select ").append(valueField).append(",").append(textField)
				.append(" from " + tableName);
		if(!"".equals(filterSql)){
			sql.append(" where ").append(filterSql);
		}
		if(!"".equals(sortBySql)){
			sql.append(" order by ").append(sortBySql);
		}
		List<Map> list = this.executeQuery(sql.toString());
		DataSet ds = new DataSet();
		for (int i = 0; i < list.size(); i++) {
			Map map = (Map) list.get(i);
			DmBean dm = new DmBean();
			dm.setValue((String) map.get(valueField));
			dm.setText((String) map.get(textField));
			ds.addRecord(dm);
		}
		return ds;
	}
	
	/**
	 * 字典中根据key值获取对应的显示值
	 * @param tableName 表名
	 * @param key key转换为大写+"DM"为字典中的key
	 * @param keyV key值
	 * @return
	 */
	public String getValueByKey(String tableName, String key, String keyV) {
		String textField = "";
		String tabName = n2b(tableName);
		String valueField = n2b(key);
		textField = key.toUpperCase()+"MC";
		valueField = valueField.toUpperCase()+"DM";
		StringBuffer sql = new StringBuffer();
		sql.append("select ").append(textField).append(" from ").append(tabName)
				.append(" where ").append(valueField).append("=?");
		DataSet ds = this.executeDataset(sql.toString(), new int[]{Types.VARCHAR}, new Object[]{keyV}, true);
		if(ds != null) {
			if(ds.getCount() != 0) {
				Record rec = ds.getRecord(0);
				String textFieldV = rec.get(textField).toString();
				return textFieldV;
			}
		}
		return "";
		
	}
	
	private String n2b(String str){
		return str == null ? "" : str.trim();
	}
}
