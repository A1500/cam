package com.inspur.cams.bpt.excelToTable.dao;

import java.sql.Types;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.persistent.util.domain.BaseJdbcDao;

/**
 * 查询插入到make表中的信息
 * @author xu lian dong
 *
 */
public class MessageDao extends BaseJdbcDao {

	public MessageDao(){
		this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
	}
	@Override
	protected void initDao() {
		// TODO Auto-generated method stub
	}
	
	/**
	 * 根据用户名查询make表中信息
	 * @param makeTable
	 * @param organCode为 用户名
	 * @return
	 */
	public DataSet queryMarkDatabyUser(String makeTable,String user){
		List<Integer> typelist = new ArrayList<Integer>();
		List<Object> objlist = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();

		sql.append("select *\n");
		sql.append("         from ");
		sql.append(makeTable);
		sql.append("  t    where  \n"); 
		if (user!=null && !user.equals("")) {
			sql.append("     t.organ_code=?  ");
			typelist.add(Types.VARCHAR);
			objlist.add(user);
		}
		Integer[] kk=(Integer[])typelist.toArray(new Integer[typelist.size()]);
		int[] t= integerArraytoint(kk);
		String[] o =(String[])objlist.toArray(new String[objlist.size()]);
		return this.executeDataset(sql.toString(), t, o,true);
	}
	/**
	 * 查询make表信息
	 * @param makeTable
	 * @param organCode
	 * @return
	 */
	public DataSet queryErrData(ParameterSet pset){
		String organCode=(String)pset.getParameter("organCode");
		String makeTable=(String)pset.getParameter("makeTable");
/*		String domicileCode=(String)pset.getParameter("domicileCode");
		String name=(String)pset.getParameter("name");
		String idCard=(String)pset.getParameter("idCard");
		String isInDB=(String)pset.getParameter("isInDB");
		String isVailidate=(String)pset.getParameter("isVailidate");
		String isRepeat=(String)pset.getParameter("isRepeat");*/
		String errExpFlag = (String)pset.getParameter("expErrFlag");
		int start = getDsStart(pset);
		int limit = getDsLimit(pset);
		
		List<Integer> typelist = new ArrayList<Integer>();
		List<Object> objlist = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();

		sql.append("select\n");
		sql.append("          t.ID,\n"); 
		sql.append("          t.NAME,\n"); 
		sql.append("          t.SEX,\n"); 
		sql.append("          t.DOMICILE_CODE,\n"); 
		sql.append("          t.NATION,\n"); 
		sql.append("          t.ID_CARD,\n"); 
		sql.append("          t.TEL_MOBILE,\n"); 
		sql.append("          t.ERROR_MESSAGE,\n"); 
		sql.append("          C.FULL_NAME DOMICILE,\n"); 
		sql.append("          (case t.VALIDATE_FLAG when '0' then '验证通过' when'1' then'验证失败' when'01' then'重复数据' when'11' then'重复数据' end) as VALIDATE_FLAG,\n"); 
		sql.append("          (case t.COMMIT_FLAG when '0' then '否' when'1' then'是' end) as COMMIT_FLAG,t.row_num\n"); 
		sql.append("         from ");

		sql.append(makeTable);
		sql.append(" t ,DIC_CITY C where t.DOMICILE_CODE = C.ID(+) and t.ERROR_MESSAGE is not null");
		/*if(domicileCode!=null&&!"".endsWith(domicileCode)){
			sql.append(" and t.ORGAN_CODE=?");
			typelist.add(Types.VARCHAR);
			objlist.add(domicileCode);
		}else{
			if (!organCode.substring(0, 2).equals("00") && organCode.substring(2, 4).equals("00")) {
				sql.append(" and SUBSTR(ORGAN_CODE,1,2)=?");// 省局
				typelist.add(Types.VARCHAR);
				objlist.add(organCode.substring(0, 2));
			}else if(!organCode.substring(2, 4).equals("00")&&organCode.substring(4, 6).equals("00")){
				sql.append(" and SUBSTR(ORGAN_CODE,1,4)=?");//市局
				typelist.add(Types.VARCHAR);
				objlist.add(organCode.substring(0, 4));
			}else{
				sql.append(" and SUBSTR(ORGAN_CODE,1,6)=?");//区县
				typelist.add(Types.VARCHAR);
				objlist.add(organCode.substring(0, 6));
			}
			
		}*/
		if(organCode!=null&&!"".equals(organCode)){
			sql.append(" and t.ORGAN_CODE=?");
			typelist.add(Types.VARCHAR);
			objlist.add(organCode);
		}
		/*if(name!=null&&!"".equals(name)){
			sql.append(" and t.NAME=?");
			typelist.add(Types.VARCHAR);
			objlist.add(name);
		}
		if(idCard!=null&&!"".equals(idCard)){
			sql.append(" and t.ID_CARD=?");
			typelist.add(Types.VARCHAR);
			objlist.add(idCard);
		}
		if(isInDB!=null&&!"".equals(isInDB)){
			sql.append(" and t.COMMIT_FLAG=?");
			typelist.add(Types.VARCHAR);
			objlist.add(isInDB);
		}
		if(isVailidate!=null&&!"".equals(isVailidate)){
			
			
			if("1".equals(isVailidate)){
				sql.append(" and t.VALIDATE_FLAG='0'");
			}else if("0".equals(isVailidate)){
				sql.append(" and t.VALIDATE_FLAG='1'");
			}
		}
		if(isRepeat!=null&&!"".equals(isRepeat)){
			
			if("1".equals(isRepeat)){
				sql.append(" and (t.VALIDATE_FLAG='01' or t.VALIDATE_FLAG='11')");
			}else if("0".equals(isRepeat)){
				sql.append(" and t.VALIDATE_FLAG!='01' and t.VALIDATE_FLAG!='11'");
			}
			
		}*/
		sql.append(" order by CAST( t.row_num AS int) ASC ");
		Integer[] kk=(Integer[])typelist.toArray(new Integer[typelist.size()]);
		int[] t= integerArraytoint(kk);
		String[] o =(String[])objlist.toArray(new String[objlist.size()]);
		DataSet ds = new DataSet();
		if("1".equals(errExpFlag)){
			ds = this.executeDataset(sql.toString(), t, o,true);
		}else{
			ds = this.executeDataset(sql.toString(), t, o,start,limit,true);
		}
		return ds;
	}
	/**
	 * 查询错误更新后信息
	 * @param makeTable
	 * @param organCode
	 * @return
	 */
	/*public DataSet queryErrUpdateData(String makeTable,String organCode){
		StringBuffer sql = new StringBuffer("select t.*,C.FULL_NAME DOMICILE, from ").append(makeTable)
			.append(" t where t.VALIDATE_FLAG='0' and t.COMMIT_FLAG='0' ")
			.append(" and t.ORGAN_CODE='").append(organCode).append("'");
		
		return super.executeDataset(sql.toString(), true);
	}*/
	/**
	 * 查询重复信息
	 * @param makeTable
	 * @param organCode
	 * @return
	 */
	public DataSet queryRepeatData(String makeTable,String organCode){
		StringBuffer sql = new StringBuffer("select t.* from ").append(makeTable)
			.append(" t where (t.VALIDATE_FLAG='11' or t.VALIDATE_FLAG='01') and t.COMMIT_FLAG='0' ")
			.append(" and t.ORGAN_CODE='").append(organCode).append("'");
		return this.executeDataset(sql.toString(), true);
	}
	
	/**
	 * 根据id查询校验错误的数据
	 * @param makeTable
	 * @param organCode
	 * @param id
	 * @return
	 */
	public DataSet queryErrUpdate(String makeTable,String organCode,String id){
		StringBuffer sql = new StringBuffer("select t.* ,C.FULL_NAME DOMICILE,D.FULL_NAME APANAGE from ").append(makeTable)
		.append(" t ,DIC_CITY C,DIC_CITY D where t.DOMICILE_CODE = C.ID AND t.APANAGE_CODE = D.ID  ")
		.append(" and t.ORGAN_CODE='").append(organCode).append("' and t.id='").append(id).append("'");
		return this.executeDataset(sql.toString(), true);
	}
	/**
	 * 查询dic_city中是否有该行政区划
	 * @param organCode
	 * @return
	 */
	public DataSet queryDomicile(String organCode){
		StringBuffer sql = new StringBuffer("select t.name from dic_city t where ")
		.append(" t.id='").append(organCode).append("'");
		return this.executeDataset(sql.toString(), true);
	}
	/**
	 * 根据id查询校验错误的数据
	 * @param makeTable
	 * @param organCode
	 * @param id
	 * @return
	 */
	public DataSet queryErrUpdateById(String makeTable,String id){
		StringBuffer sql = new StringBuffer("select t.* ,C.FULL_NAME DOMICILE,D.FULL_NAME APANAGE from ").append(makeTable)
		.append(" t ,DIC_CITY C,DIC_CITY D where t.DOMICILE_CODE = C.ID AND t.APANAGE_CODE = D.ID  ")
		.append(" and t.id='").append(id).append("'");
		return this.executeDataset(sql.toString(), true);
	}
	/**判定是否有重复
	 * 查询身份证号
	 * @param idCard
	 * @return
	 */
	public DataSet querySameIdcard(String idCard){
		StringBuffer sql = new StringBuffer(
				"select  t.disability_flag,t.war_flag,t.dependant_flag,t.demobilized_flag ,t.retired_flag,t.martyr_offspring_flag  from baseinfo_people t where t.id_card=? " 
		);
		int[] type= new int[1];
		Object[] obj= new Object[1];
		type[0]=Types.VARCHAR; 
		obj[0]=idCard; 
		return this.executeDataset(sql.toString(), type,obj,true);
		
	}
	/**
	 * 更新make表提交COMMIT_FLAG标志为提交1
	 * @param makeTable
	 * @param id
	 * @return
	 */
	public int updateMakeFlag(String makeTable,String id){
		StringBuffer sql = new StringBuffer("update ").append(makeTable)
			.append(" t set t.COMMIT_FLAG='1' where t.id=?");
		return this.executeUpdate(sql.toString(), new int[]{Types.VARCHAR}, new Object[]{id});
	}
	/**
	 * 更新伤残make表
	 * @param ds
	 * @return
	 */
	public int updateDisabilityMakeTable(String makeTable, Record r){
		if(r!=null){
			List<Integer> typelist = new ArrayList<Integer>();
			List<Object> objlist = new ArrayList<Object>();
			StringBuffer sql = new StringBuffer("update  " ).append(makeTable).append(" t set ");
			StringBuffer sql1 = new StringBuffer();
			Map map=r.getData();
			Set<Entry> set =map.entrySet();
			int f=0;
			for (Iterator iterator = set.iterator(); iterator.hasNext();) {
				Entry e = (Entry) iterator.next();
				char c=e.getKey().toString().charAt(0);
				String key="";
				if(Character.isLowerCase(c)){
					char[] ch =e.getKey().toString().toCharArray();
					StringBuffer k=new StringBuffer();
					for (char d : ch) {
						
						if(Character.isUpperCase(d))
							k.append("_").append(d);
						else
							k.append(d);
					}
					key =k.toString().toUpperCase();
					if("APANAGE_NAME".equals(key)){
						continue;
					}else if("DOMICILE_NAME".equals(key)){
						continue;
					}else if("VALIDATE_FLAG".equals(key)){
						typelist.add(Types.VARCHAR);
						objlist.add("0");
					}else if("ERROR_MESSAGE".equals(key)){
						typelist.add(Types.VARCHAR);
						objlist.add("");
					}else if("ID".equals(key)){
						sql1.append(" where t.id='").append(e.getValue()).append("'");
						continue;
					}else{
						typelist.add(Types.VARCHAR);
						objlist.add(e.getValue());
					}
					if(f==0){
						sql.append(" t."+key+"=? ");
						f=1;
					}else{
						sql.append(" ,t."+key+"=? ");
					}
				}else
					continue;
				
			}
			sql.append(sql1);
			Integer[] kk=(Integer[])typelist.toArray(new Integer[typelist.size()]);
			int[] t= integerArraytoint(kk);
			String[] o =(String[])objlist.toArray(new String[objlist.size()]);
			return this.executeUpdate(sql.toString(), t, o);
		}
		
	return -1;
	}
	
	public boolean idCardIsSame(String idcard){
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT ID_CARD FROM BASEINFO_PEOPLE B WHERE B.ID_CARD = ?");

		DataSet ds=this.executeDataset(sql.toString(), new int[]{Types.VARCHAR}, new Object[]{idcard}, true);
		if(ds.getCount()>0)
			return true;
		else 
			return false;
	}
	/**
	 * Integer[]转换为int[]
	 * @param ir
	 * @return
	 */
	public int[] integerArraytoint(Integer[] ir){
		int[] i=new int[ir.length];
		for (int j=0;j<ir.length;j++) {
			i[j]=ir[j].intValue();
		}
		return i;
	}
	public void deleteById (String makeTable,String id){
		StringBuffer sql = new StringBuffer("delete  from ").append(makeTable).append(" b where b.id=?");
		this.executeUpdate(sql.toString(), new int[]{Types.VARCHAR}, new Object[]{id});
	}
	/*public DataSet queryBaseinfoByIdcode(String idcard){
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM BASEINFO_PEOPLE B WHERE B.ID_CARD = ?");
		DataSet ds=this.executeDataset(sql.toString(), new int[]{Types.VARCHAR}, new Object[]{idcard}, true);
		return ds;
	}*/
	
	
	private int getDsStart(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageStart();
		}
		int start = 0;
		if("0".equals(excelType)) {  //导出当前页
			Integer startExcel = (java.lang.Integer) pset.getParameter("startExcel");
			if(startExcel!=null) {
				start = startExcel.intValue();
			}
		}
		return start;
	}
	private int getDsLimit(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageLimit();
		}
		int limit = ((java.lang.Integer) pset.getParameter("limitExcel")).intValue();
		return limit>1000?1000:limit;
	}
}
