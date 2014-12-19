package com.inspur.cams.comm.informUtil;


import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.persistent.jdbc.object.MappingSqlQuery;
import org.loushang.persistent.jdbc.object.SqlUpdate;
/**
 * @功能：需要连接数据库进行特殊操作的情况。
 */

public class InformDBUtil {
	private static Log log = LogFactory.getLog(InformDBUtil.class);

	// 获取当前系统的数据源(L5方式)
	public static DataSource getDataSource() {
		DataSource returnDataSource = DataSourceFactory.defaultFactory.getDataSource("dataSource");
		return returnDataSource;
	}

	// 获取交换系统的数据源(L5方式)
	public static DataSource getDataSourceMiddle() {
		DataSource returnDataSource = DataSourceFactory.defaultFactory.getDataSource("dataSourceMiddle");
		//System.out.println("获取到的数据源始："+returnDataSource);
		return returnDataSource;
	}

	/**
	 * @功能:根据传入的参数去做对应的查询，将查出的数据保存在List中。
	 * @备注：
	 * @date:2009-11-07
	 * @param sql
	 * @return list
	 */
	@SuppressWarnings("unchecked")
	public static List getQueryData(String sql) {
		MyMappingQuery mmq = new MyMappingQuery(getDataSourceMiddle(), sql);
		@SuppressWarnings("unused")
		List<HashMap> list = mmq.execute();
		return mmq.execute();
	}

	/**
	 * @功能:根据传入的参数去做对应的查询，将查出的数据保存在List中。
	 * @备注：
	 * @date:2009-11-07
	 * @param sql
	 * @return list
	 */
	@SuppressWarnings("unchecked")
	public static List getQueryResult(String sql) {
		MyMappingQuery mmq = new MyMappingQuery(getDataSource(), sql);
		return mmq.execute();
	}


	/**
	 * 检验表中是否存在数据
	 *
	 * @param tabname
	 *            表名称
	 * @return boolean true 存在数据 false 不存在数据
	 */
	public static boolean checkExist(String tableName) {
		log.info("DBUtil - checkExist- start");
        StringBuffer sb = new StringBuffer(" SELECT 'isExist' FROM ");
        sb.append(tableName);
		String sql = sb.toString();
		return checkExistBySql(sql);

	}

	/**
	 * 检验表中是否存在数据
	 *
	 * @param tabname
	 *            表名称
	 * @param idColName
	 *            id列名称
	 * @param idVal
	 *            id值
	 * @return boolean true 存在数据 false 不存在数据
	 */
	public static boolean checkExist(String tableName, String idColName,
			String idVal) {
		//log.info("DBUtil - checkExist - start");
        StringBuffer sb = new StringBuffer(" SELECT 'isExist' FROM ");
        sb.append(tableName);
        sb.append(" WHERE ");
        sb.append(idColName);
        sb.append(" = '");
        sb.append(idVal);
        sb.append("'");
		String sql = sb.toString();
		return checkExistBySql(sql);
	}

	/**
	 * 检验表中是否存在数据
	 *
	 * @param sql
	 *            查询sql
	 * @return boolean true 存在数据 false 不存在数据
	 */
	@SuppressWarnings("unchecked")
	private static boolean checkExistBySql(String sql) {
		MyMappingQuery mmq = new MyMappingQuery(getDataSource(), sql);
		List list = mmq.execute();
		if (list != null && list.size() > 0)
			return true;
		else
			return false;

	}
	/**
	 * 获取表中的最大主键
	 *
	 * @param sql
	 *            查询sql
	 * @return String
	 */
	@SuppressWarnings({ "unused", "unused", "unchecked", "unchecked" })
	public static String getMaxId(String columnsName,String tableName) {
		String sql = "select max("+columnsName+") as "+columnsName+" from "+tableName;
		MyMappingQuery mmq = new MyMappingQuery(getDataSource(), sql);
		List<HashMap> list = mmq.execute();
        if(list!=null&&list.get(0).get(columnsName.toUpperCase())!=null){
          return list.get(0).get(columnsName.toUpperCase()).toString();
        }else{
        return "0";
        }
	}

	// 记录查询内部类
	protected static class MyMappingQuery extends MappingSqlQuery {
		protected MyMappingQuery(DataSource ds, String sql) {
			super(ds, sql);
			compile();
		}

		/**
		 * @param rs
		 * @param rowNum
		 * @return
		 * @throws SQLException
		 */
		@SuppressWarnings({ "unchecked", "unchecked", "unchecked" })
		public Object mapRow(ResultSet rs, int rowNum) throws SQLException {

			HashMap map = new HashMap();
			ResultSetMetaData rmd = rs.getMetaData();
			String colname;
			for (int i = 1; i < rmd.getColumnCount() + 1; i++) {
				int type = rmd.getColumnType(i);
				colname = rmd.getColumnName(i);
				if (type == 1 || type == 12) {
					map.put(colname, rs.getString(colname));
				} else {
					map.put(colname, rs.getBigDecimal(colname));
				}
			}
			return map;
		}

		/**
		 * @param id
		 * @return
		 */
		@SuppressWarnings({ "unchecked", "unchecked" })
		public List load() {
			List vs = this.execute();
			return vs;
		}
	}
	protected static class DataDelete extends SqlUpdate {
        protected DataDelete(DataSource ds,String deleteSql){
            super(ds, deleteSql);
        }
        /**
         * @param  flowId
         * @return
         */
        public int delete(  ) {
            Object[] objs = new Object[] {  };
            return update(objs);
        }
    }

	/**
	 *
	 * @功能:根据传入的参数去做对应的查询，将查出的数据保存在List中。
	 * @备注：
	 * @author:ShiYubo
	 * @date:2006-3-23 14:47:12
	 * @param sql
	 * @return list
	 */
	public static int deleteData(String sql) {
		DataDelete dd = new DataDelete(getDataSource(), sql);
		int i = dd.delete();
		return i;
	}

	/**
	 * 功能：根据一个条件更新表中的字段
	 * @param columnName 更新的字段名
	 * @param columnValue 更新字段的值
	 * @param tableName 业务表名称
	 * @param whereColumnName 条件字段名
	 * @param whereColumnValue 条件字段值
	 * @return
	 */

	public static void updateTableInfo(String columnName, String columnValue,
			String tableName, String whereColumnName, String whereColumnValue) {

		SqlUpdate updateInfo = new SqlUpdate();
		StringBuffer updateInfoSql = new StringBuffer();
		updateInfoSql.append(" UPDATE ");
		updateInfoSql.append(tableName);
		updateInfoSql.append(" SET ");
		updateInfoSql.append(columnName);
		updateInfoSql.append(" = '");
		updateInfoSql.append(columnValue);
		updateInfoSql.append("' WHERE ");
		updateInfoSql.append(whereColumnName);
		updateInfoSql.append(" = '");
		updateInfoSql.append(whereColumnValue);
		updateInfoSql.append("'");
		updateInfo.setDataSource(getDataSource());
		updateInfo.setSql(updateInfoSql.toString());
		updateInfo.compile();
		updateInfo.update();
	}

	/**
	 * 功能：执行更新
	 * @param updSQl 被更新的SQl
	 * @param whereColumnName 条件字段名
	 * @param whereColumnValue 条件字段值
	 * @return
	 */
	public static void doUpdateSQL(String updateSql) {
		SqlUpdate update = new SqlUpdate();
		if("".equals(updateSql)||updateSql==null){
			return;
		}
		update.setDataSource(getDataSource());
		update.setSql(updateSql);
		update.compile();
		update.update();
	}

}
