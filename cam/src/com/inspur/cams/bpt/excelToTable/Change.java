package com.inspur.cams.bpt.excelToTable;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.Set;

import org.loushang.next.data.DataSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.persistent.util.domain.BaseJdbcDao;

public class Change extends BaseJdbcDao{
	private String field;
	private Map enumsmap;
	String[] a = { "", "", ""};//第三个为转换字段类型参数
	Object[] b =new Object[3];
	public Change(String field,Map enumsmap) {
		super();
		this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
		this.field = field;
		this.enumsmap=enumsmap;
	}
	@Override
	protected void initDao() {
		// TODO Auto-generated method stub
		
	}
	/**
	 * 转换插入的数据类型
	 * @param type
	 * @return
	 */
	public Object[] returnType(String type){
		b[0]=type;
		b[1]=field;
		b[2]="type";
		return b;
		
	}
	/**
	 * 用枚举反向转换代码
	 * @param enumName枚举名称
	 * @param fieldname字段名称 如;名字
	 * @return "0,错误信息" 或"1" 1：男，2：女
	 */
	public String[] returnCode(String enumName,String fieldname,String len){
		if(field!=null&&!"".equals(field)&&enumsmap.containsKey(enumName)){
			String enumsValue=(String)enumsmap.get(enumName);
			String[] s=enumsValue.split(",");
			for (String v : s) {
				String[] f=v.split(":");
				if(field.equals(f[1])){
					a[0] = "1";
					a[1] = f[0].trim();
					//转换完校验长度
					String[] msg = lengthOf(a[1],len,fieldname);
					/*if(msg[0]=="0"){
						a[0] = "0";
						a[1] = fieldname+"长度过长!";
					}*/
					break;
				}
			}
			if("".equals(a[0])){
				a[0] = "0";
				a[1] = fieldname+"转换失败";
			}
			return a;
		}else if(field==null||"".equals(field)){
			a[0] = "1";
			return a;
		} else {
			a[0] = "0";
			a[1] = fieldname+"转换失败";
			return a;
		}
	}
	/**
	 * 日期转换
	 * @return
	 */
	public  String[] rDate(String name){
		if(field!=null&&!"".equals(field)){
			SimpleDateFormat ft= null;
			if (field.matches("^[1-9][0-9]{3}\\-((0[1-9])|(1[012])|[1-9])\\-((0[1-9])|([12][0-9])|(3[01])|[1-9])$")) {
				ft = new SimpleDateFormat("yyyy-MM-dd");
			} else if(field.matches("^[1-9][0-9]{3}/((0[1-9])|(1[012])|[1-9])/((0[1-9])|([12][0-9])|(3[01])|[1-9])$")){
				ft = new SimpleDateFormat("yyyy/MM/dd");
			}else if(field.matches("^((0[1-9])|([12][0-9])|(3[01])|[1-9])/((0[1-9])|(1[012])|[1-9])/[1-9][0-9]{3}$")){
				ft = new SimpleDateFormat("dd/MM/yyyy");
			}else{
				a[0] = "0";
				a[1] = name+"转换失败,格式不对！";
				return a;
			}

			Date dd;
			try {
				dd=ft.parse(field);
			
				SimpleDateFormat ft1 = new SimpleDateFormat("yyyy-MM-dd");
				
				a[0] = "1";
				a[1] = ft1.format(dd);
				return a;
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				logger.error("Excel_Error",e);
				return a;
			}
		}else{
			a[0] = "1";
			return a;
		}
		 
	}

	/**
	 * 查找字典反向转换代码
	 * @param tableName字典表名
	 * @param code字典代码
	 * @param name代码名称
	 * @param fieldname字段名称 如;名字
	 * @return "0,错误信息" 或"1" 1：男，2：女
	 */
	public  String[] rCodeByDic(String tableName,String code,String name,String fieldname,String len){
		if(field!=null&&!"".equals(field)){
			StringBuffer sql= new StringBuffer();
			sql.append("select t.").append(code).append(" from ").append(tableName)
				.append(" t where t.").append(name).append("='").append(field).append("'");
			DataSet ds =super.executeDataset(sql.toString(), true);
			if(ds.getCount()==1){
				String c=(String)ds.getRecord(0).get(code);
				a[0] = "1";
				a[1] = c.trim();
				//转换完校验长度
				String[] msg = lengthOf(a[1],len,fieldname);
				/*if(msg[0]=="0"){
					a[0] = "0";
					a[1] = fieldname+"长度过长!";
				}*/
				return a;
			}else {
				a[0] = "0";
				a[1] = fieldname+"转换失败";
				return a;
			}
		}else {
			a[0] = "1";
			return a;
		}
	}
	/*public static void main(String arg[]){
		Change a = new Change("2010/02/05",null);
		String[] s=a.rDate("aaaa");
		System.out.println(s[1]);
		String str = "1979/2/4";
		if (str.matches("^[1-9][0-9]{3}/((0[1-9])|(1[012])|[1-9])/((0[1-9])|([12][0-9])|(3[01])|[1-9])$")) {
			System.out.println(str);
		} else {
			System.out.println("输入错误");
		}
	}*/
	/**
	 * 校验长度
	 * 
	 */
	public String[] lengthOf(String refield,String len,String fieldName ){
		if(field!=null&&!"".equals(field)){
			byte[] buff=refield.getBytes();
			int f=buff.length;
			int l= Integer.parseInt(len);
			if(f>l){
				a[0]="0";
				a[1]=fieldName+"长度过长!";
				return a; 
			}else{
				a[0]="1";
				a[1]=refield;
				return a;
			}
		}else{
			a[0]="1";
			a[1]="";
			return a;
		}
		
	}
}
