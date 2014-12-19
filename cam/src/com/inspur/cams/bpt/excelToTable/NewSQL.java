package com.inspur.cams.bpt.excelToTable;

import java.sql.Types;
import java.util.List;

import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.next.data.DataSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.persistent.util.domain.BaseJdbcDao;

import com.inspur.cams.bpt.excelToTable.data.ToTable;
import com.inspur.cams.bpt.excelToTable.data.ToTableField;

/**
 * 组件sql语句
 * @author Administrator
 *
 */
public class NewSQL extends BaseJdbcDao{
	
	private String tempTableName;
	private String makeTableName;
	private String tableName;
	private String vailClass;
	private String changeClass;
	private ToTable toTable;
	ReadXML readXML = new ReadXML();
	public NewSQL(ToTable toTable) {
		super();
		this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
		this.toTable = toTable;
	}
	@Override
	protected void initDao() {
		// TODO Auto-generated method stub
		
	} 
	/**
	 * 清除临时表sql
	 * @return String
	 */
	public  String deleTempTable() {
		makeTableName=toTable.getMakeTableName();
		StringBuffer sql = new StringBuffer(
				"delete from  "+makeTableName 
		);
		sql.append(" where organ_code='");
		sql.append(GetBspInfo.getBspInfo().getUserId());
		sql.append("'");
		return sql.toString();
	}
	/**
	 * 向临时表插入数据sql
	 * @return
	 */
	/*public  String insertTempTable() {
		tempTableName=toTable.getTempTableName();
		StringBuffer sql = new StringBuffer("insert into ").append(
				tempTableName).append(" ( ");
		StringBuffer sql1 = new StringBuffer(" values (");
		List<ToTableField> fieldlist= toTable.getFieldList();
		for (int j = 0; j < fieldlist.size(); j++) {
			if (j < fieldlist.size() - 1) {
				sql.append(fieldlist.get(j).getFieldName()+",");
				sql1.append(" ?, ");
			} else {
				sql.append(fieldlist.get(j).getFieldName()+") ");
				sql1.append(" ?)");
			}
			
		}
		sql.append(sql1);
		return sql.toString();
		
	}*/
	/**
	 * 删除转换表与业务表相同的数据sql
	 * @return
	 */
	/*public String deleMakeData() {
		makeTableName=toTable.getMakeTableName();
		tableName=toTable.getTableName();
		StringBuffer sql = new StringBuffer("delete from ")
			.append(makeTableName)
			.append(" where organ_code = ?")
			.append(" and  id_card in(select id_card from ")
			.append(tableName)
			.append(" where organ_code =")
			.append("?")
			.append(")");
		return sql.toString();
	}*/
	/**
	 * 查看是否与业务表中重复sql
	 * @return
	 */
	/*public String queryIsSameData() {
		StringBuffer sql = new StringBuffer(
				"select id_card from baseinfo_people b where b.id_card=? " 
		);
		return sql.toString();
	}*/
	/**
	 * 查询临时表sql
	 * @return String
	 */
	public  String queryTempTable() {
		tempTableName=toTable.getTempTableName();
		String sql = "select * from " + toTable.getTempTableName() + " where organ_code=?";
		return sql;
	}
	/**
	 * 向临时表插入数据sql
	 * @return
	 */
	public  String insertMakeTable(String organ_code) {
		String sql=queryTempTable();
		int[] type = new int[1];
		Object[] obj = new Object[1];
		type[0]=Types.VARCHAR;
		obj[0]=organ_code;
		//DataSet ds=super.executeDataset(sql, type, obj,true);
		
		String makeTableName=toTable.getMakeTableName();
		StringBuffer insertsql = new StringBuffer("insert into ").append(
				makeTableName).append(" ( ");
		StringBuffer sql1 = new StringBuffer(" values (");
		
		List<ToTableField> fieldlist= toTable.getFieldList();
		for (int j = 0; j < fieldlist.size(); j++) {
			String key=(String)fieldlist.get(j).getFieldName();
			insertsql.append(key.toUpperCase()+", ");
			sql1.append("?, ");
			
		}
		insertsql.append("ERROR_MESSAGE,COMMIT_FLAG,VALIDATE_FLAG ,ID,row_num)");
		sql1.append("?, ?, ?, ?,?)");
		insertsql.append(sql1);
		return insertsql.toString();
		
	}
	public boolean makeIsHave (String makeTable,String idCard){
		StringBuffer sql = new StringBuffer("Select *  from ").append(makeTable).append(" b where b.id_card=?");
		DataSet ds=this.executeDataset(sql.toString(), new int[]{Types.VARCHAR}, new Object[]{idCard},true);
		if(ds.getCount()>0){
			return true;
		}else {
			return false;
		}
	}
	public static void main(String[] args) { 
		/*NewSQL demo = new NewSQL("e:/1.xml"); 
    	System.out.println(demo.deleTempTable());
    	System.out.println(demo.insertTempTable());
    	System.out.println(demo.deleMakeData());*/
		
		
    	
    }
	
	
}
