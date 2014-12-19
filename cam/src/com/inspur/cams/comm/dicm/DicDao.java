package com.inspur.cams.comm.dicm;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.comm.dicm.IDicDao;
import com.inspur.cams.comm.dicm.DicBean;
import com.inspur.cams.comm.util.StrUtil;

/**
 * 字典表dao实现类
 * @author shgtch
 * @date 2011-5-14
 */
public class DicDao extends EntityDao<DicBean> implements IDicDao {
	
	private static String DIC_KEY = "CODE";
	private static String DIC_VALUE = "NAME";

	public DicDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class<DicBean> getEntityClass() {
		return DicBean.class;
	}

	public DataSet getDicMapList(ParameterSet pset) {
		String dic = StrUtil.n2b((String) pset.getParameter("dic"));
		String value = StrUtil.n2b((String) pset.getParameter("value"));
		String text = StrUtil.n2b((String) pset.getParameter("text"));
		String sort = StrUtil.n2b((String) pset.getParameter("sort"));
		String includeCode = StrUtil.n2b((String) pset.getParameter("includeCode"));
		String filterSql = StrUtil.n2b((String) pset.getParameter("filterSql"));
		String type = StrUtil.n2b((String) pset.getParameter("type"));
		String itemType = StrUtil.n2b((String) pset.getParameter("itemType"));
		String assistanceTypeCode = StrUtil.n2b((String) pset.getParameter("assistanceTypeCode"));
		
		String likeText = StrUtil.n2b((String) pset.getParameter("text@like"));
		
		if (value == null || value.equals("")) {
			value = DIC_KEY;
		}
		if (text == null || text.equals("")) {
			text = DIC_VALUE;
		}
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT ");
		sql.append(value);
		sql.append(" CODE ,");
		sql.append(text);
		sql.append(" NAME FROM ");
		sql.append(dic);
		sql.append(" WHERE 1=1 ");
		
		if(!"".equals(likeText)){
			sql.append(" AND ");
			sql.append(text);
			sql.append(" like '");
			sql.append("%"+likeText+"%'");
		}
		
		if(!"".equals(includeCode)){
			sql.append(" AND ");
			sql.append(value);
			sql.append(" IN ");
			sql.append("('"+includeCode.replaceAll(",", "','")+"')");
		}
		if(!"".equals(assistanceTypeCode)){
			sql.append(" AND ");
			sql.append(value);
			sql.append(" NOT IN ");
			sql.append("('"+assistanceTypeCode.replaceAll(",", "','")+"')");
		}
		if(!"".equals(filterSql)){
			sql.append(" AND ");
			sql.append(filterSql);
		}
		if (type != null && !"".equals(type)) {
			sql.append(" AND ");
			sql.append(" TYPE =");
			sql.append(type);
		}
		if (itemType != null && !"".equals(itemType)) {
			sql.append(" AND ");
			sql.append(" ITEM_TYPE =");
			sql.append(itemType);
		}
		if (sort != null && !"".equals(sort)) {
			sql.append(" ORDER BY ");
			sql.append(sort);
		}
		List<Map> list = executeQuery(sql.toString());
		DataSet ds = new DataSet();
		for (int i = 0; i < list.size(); i++) {
			Map map = (Map) list.get(i);
			DicBean dicBean = new DicBean();
			dicBean.setValue((String) map.get(DIC_KEY));
			dicBean.setText((String) map.get(DIC_VALUE));
			ds.addRecord(dicBean);
		}
		return ds;
	}
	public DataSet queryType() {
		StringBuffer sql = new StringBuffer();
		sql.append("select code, type, type_name, name from dic_health where code = type");
		List<Map> list = executeQuery(sql.toString());
		DataSet ds = new DataSet();
		for (int i = 0; i<list.size(); i++) {
			Map map = (Map) list.get(i);
			DicBean dicBean = new DicBean();
			dicBean.setValue((String) map.get(DIC_KEY));
			dicBean.setText((String) map.get(DIC_VALUE));
			ds.addRecord(dicBean);
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
		String tabName = StrUtil.n2b(tableName);
		String valueField = StrUtil.n2b(key);
		textField = key.toUpperCase();
		valueField = valueField.toUpperCase();
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
	/**
	 * 字典中根据key值获取对应的显示值
	 * @param tableName 表名
	 * @param key key转换为大写+"DM"为字典中的key
	 * @param keyV key值
	 * @return
	 */
	public String getValueByValue(String tableName, String key, String keyV) {
		String textField = "";
		String tabName = StrUtil.n2b(tableName);
		String valueField = StrUtil.n2b(key);
		textField = key.toUpperCase();
		valueField = valueField.toUpperCase();
		StringBuffer sql = new StringBuffer();
		sql.append("select ").append(textField).append(" from ").append(tabName)
				.append(" where ").append(" CODE").append("=?");
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
	/**
	 * 通过字典表特定字段的值，获取指定字段的值
	 * @param dic 表名
	 * @param PrimaryKey  特定字段的名称
 	 * @param PrimaryKeyValue 特定字段的值
	 * @param queryField	指定字段的名称
	 * @return 指定字段的值
	 */
	@SuppressWarnings("unchecked")
	public String getTextValueFromDic(String dic, String primaryKey, String primaryKeyValue, String queryField) {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT ");
		sql.append(queryField);
		sql.append(" FROM ");
		sql.append(dic);
		sql.append(" WHERE 1=1 AND ");
		sql.append(primaryKey);
		sql.append(" = ?");
		List typeList = new ArrayList();
		List argsList = new ArrayList();
		typeList.add(Types.VARCHAR);
		argsList.add(primaryKeyValue);
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds=this.executeDataset(sql.toString(), types, args,true);
		if(ds != null) {
			if(ds.getCount() != 0) {
				Record rec = ds.getRecord(0);
				String value = rec.get(queryField).toString();
				return value;
			}
		}
		return "";
	}
}
