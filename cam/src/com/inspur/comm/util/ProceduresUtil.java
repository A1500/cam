package com.inspur.comm.util;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Types;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.sql.DataSource;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.Field;
import org.loushang.next.data.FieldSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.core.ResultReader;
import org.loushang.persistent.jdbc.core.SqlParameter;
import org.loushang.persistent.jdbc.object.Procedure;


public class ProceduresUtil {
	
	private Proc procduce = null;
	/**
	 * map的key值对应表
	 * map_key：procedureName：存储过程名称
	 * map_key：NumberOfResultSet：结果集的个数（null默认为"1"）
	 * map_key：parameterNum：参数个数
	 * map_key：parameterName_?：参数名（后缀"_"后跟数字从1开始）
	 * map_key：parameterType_?：参数类型（后缀"_"后跟数字从1开始，null默认为"Types.VARCHAR"）
	 * map_key：parameterValue_?：参数值（后缀"_"后跟数字从1开始）
	 * @param map
	 */
	public Proc init(DataSource dataSource,Map map) {
		if (procduce == null) {
			procduce = new Proc(dataSource,map);
		}
		return procduce;
	}
	public static class Proc extends Procedure {
		public Proc(DataSource ds,Map map) {
			super(ds, (String)map.get("procedureName"));
			// 声明参数
			for (int i = 1; i <= (Integer)map.get("parameterNum"); i++) {
				declareParameter(new SqlParameter((String)map.get("parameterName_"+i),(Integer)map.get("parameterType_"+i)!=null?(Integer)map.get("parameterType_"+i):Types.VARCHAR));
			}
			// 声明结果集的个数
			setNumberOfResultSet(map.get("NumberOfResultSet")!=null?((Integer)map.get("NumberOfResultSet")).intValue():1);
			compile();
		}

		public Map call(final Map<String,Object> map) {
			Map in = new HashMap();
			// 设置入参的值，key要和声明参数的名称一致
			for (int i = 1; i <= (Integer)map.get("parameterNum"); i++) {
				in.put(map.get("parameterName_"+i), map.get("parameterValue_"+i));
			}
			Map ret = new HashMap();
			if(map.get("NumberOfResultSet")!=null && ((Integer)map.get("NumberOfResultSet")).intValue()==0){
				ret = execute(in);
			}else{
				ResultReader resultReader = new ResultReaderImpl() {
					protected Object mapRow(ResultSet rs, int rowNum) throws SQLException {
						Record record = new Record();
						ResultSetMetaData rsmd = rs.getMetaData();  
					    int columnCount = rsmd.getColumnCount();  
					    // 输出列名  
					    for (int i=1; i<=columnCount; i++){  
					        record.set(rsmd.getColumnName(i), rs.getObject(rsmd.getColumnName(i)));
					    }   
						return record;
					}
				};
				ResultReader[] readerA = new ResultReader[] { resultReader };
				ret = execute(in, readerA);
				ret.put("results", resultReader.getResults());
			}
			return ret;
		}
	}
	/**
	 * 
	 * @param ds
	 * @return
	 */
	public static DataSet fixDataSet(DataSet ds){
		FieldSet fs = new FieldSet();
		if (ds.getCount()>0) {
			Iterator<String> it = ds.getRecord(0).keys();
			while(it.hasNext()){
				String key = it.next();
				Field field = new Field();
				field.setName(key);
				fs.add(field);
			}
		}
		ds.setFieldSet(fs);
		return ds;
	}
}
