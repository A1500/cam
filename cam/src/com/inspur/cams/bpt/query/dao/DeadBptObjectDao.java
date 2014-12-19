package com.inspur.cams.bpt.query.dao;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;

/**
 * @description: 关联殡葬系统查询已死亡未处理(享受待遇)的优抚对象信息
 * @author 
 *
 */
public class DeadBptObjectDao extends EntityDao<BaseinfoPeople> {
	
	@Override
	protected Class<BaseinfoPeople> getEntityClass() {
		return BaseinfoPeople.class;
	}
	
	public DataSet queryDeadBptObject(ParameterSet pset){
		int start = pset.getPageStart();
		int limit = pset.getPageLimit();
		DataSet ds = new DataSet();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		String organCode = (String) pset.getParameter("organCode");
		String objectType = (String) pset.getParameter("objectType");
		String queryType = (String) pset.getParameter("queryType");
		String time = (String) pset.getParameter("time");
		StringBuffer sql = new  StringBuffer();

		sql.append("SELECT t.people_id,t.dead_id, \n");
		sql.append("             t.family_id, \n"); 
		sql.append("             t.full_name, \n"); 
		sql.append("             t.name, \n"); 
		sql.append("             t.id_card, \n"); 
		sql.append("             t.sex, \n"); 
		sql.append("             t.nation, \n"); 
		sql.append("             t.object_state, \n"); 
		sql.append("             t.object_type, \n"); 
		sql.append("             t.death_date, \n"); 
		sql.append("             t.cremation_time, \n"); 
		sql.append("             t.funeral_name \n"); 
		sql.append("        FROM bpt_dead_collect t \n"); 
		sql.append("       WHERE t.object_state = '2'");

		if("organCode".equals(queryType)&&organCode != null && !organCode.equals("")&&objectType != null && !objectType.equals("") ){
			if("sc".equals(objectType)){
				sql.append("and t.object_type in ('11','12','13','14','15')");
			}else if("ss".equals(objectType)){
				sql.append("and t.object_type in ('21','22','23')");
			}else if("zx".equals(objectType)){
				sql.append("and t.object_type ='41'");
			}else if("db".equals(objectType)){
				sql.append("and t.object_type ='42'");
			}else if("cz".equals(objectType)){
				sql.append("and t.object_type ='51'");
			}else if("cs".equals(objectType)){
				sql.append("and t.object_type ='61'");
			}else if("ls".equals(objectType)){
				sql.append("and t.object_type ='81'");
			}else if("ll".equals(objectType)){
				sql.append("and t.object_type ='B1'");
			}
			
			if (!organCode.substring(0, 2).equals("00")
						&& organCode.substring(2, 4).equals("00")) {
				sql.append(" AND  SUBSTR(t.domicile_code,1,2)=?");// 省局
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 2));
			} else if (!organCode.substring(2, 4).equals("00")
					&& organCode.substring(4, 6).equals("00")) {
				sql.append(" AND SUBSTR(t.domicile_code,1,4)=?");// 市局
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 4));
			} else {
				sql.append(" AND SUBSTR(t.domicile_code,1,6)=?");// 区县
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 6));
			}
			sql.append(" order by t.death_date asc");
		}else if("month".equals(queryType) ){
			if("three".equals(time)){
				sql.append(" and  to_date(t.death_date, 'yyyy-mm-dd') between add_months（sysdate,-3) and add_months（sysdate,-0) and instr(t.domicile_code,?)=1 ");
			}else if("six".equals(time)){
				sql.append("and  to_date(t.death_date, 'yyyy-mm-dd') between add_months（sysdate,-6) and add_months（sysdate,-3) and instr(t.domicile_code,?)=1");
			}else if("nine".equals(time)){
				sql.append("and  to_date(t.death_date, 'yyyy-mm-dd') between add_months（sysdate,-9) and add_months（sysdate,-6) and instr(t.domicile_code,?)=1");
			}else if("year".equals(time)){
				sql.append("and  to_date(t.death_date, 'yyyy-mm-dd') between add_months（sysdate,-12) and add_months（sysdate,-9) and instr(t.domicile_code,?)=1");
			}else if("thanyear".equals(time)){
				sql.append("and  to_date(t.death_date, 'yyyy-mm-dd')<add_months（sysdate，-12) and instr(t.domicile_code,?)=1 ");
			}
			if("370000000000".equals(organCode)){
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 2));
			}else if(organCode != null && !organCode.equals("")&&"00000000".equals(organCode.substring(4, 12))){
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 4));
			}else {
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 6));
			}
		}
		if(typeList.size() != 0 && argsList.size()!= 0) {
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++) {
				types[i]=(Integer)(typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(),types,args,start,limit, true);
		} else {
			ds = this.executeDataset(sql.toString(),start,limit, true);
		}
		return ds;
	}
	public DataSet queryDeadBptObjectByMonth(ParameterSet pset){
		DataSet ds = new DataSet();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
 		String organCode = (String) pset.getParameter("organCode");
		StringBuffer sql = new StringBuffer();
		sql.append("select  d3.d3num ,d6.d6num,d9.d9num,d12.d12num,ds.dsnum   from \n");
		sql.append("(SELECT count(t.people_id) d3num FROM BPT_DEAD_COLLECT t \n"); 
		sql.append("   where to_date(t.death_date, 'yyyy-mm-dd') between \n"); 
		sql.append("   add_months（sysdate,-3) and add_months（sysdate,-0) and instr(t.domicile_code,?)=1 \n"); 
		sql.append(") d3,(SELECT count(t.people_id) d6num FROM BPT_DEAD_COLLECT t \n"); 
		sql.append("   where to_date(t.death_date, 'yyyy-mm-dd') between \n"); 
		sql.append("   add_months（sysdate,-6) and  add_months（sysdate,-3) and instr(t.domicile_code,?)=1 \n"); 
		sql.append(") d6,(SELECT count(t.people_id) d9num FROM BPT_DEAD_COLLECT t \n"); 
		sql.append("    where to_date(t.death_date, 'yyyy-mm-dd') between \n"); 
		sql.append("     add_months（sysdate,-9) and add_months（sysdate,-6) and instr(t.domicile_code,?)=1 \n"); 
		sql.append(") d9,(SELECT count(t.people_id) d12num FROM BPT_DEAD_COLLECT t \n"); 
		sql.append("    where to_date(t.death_date, 'yyyy-mm-dd') between \n"); 
		sql.append("     add_months（sysdate,-12) and add_months（sysdate,-9) and instr(t.domicile_code,?)=1 \n"); 
		sql.append(") d12,(SELECT count(t.people_id) dsnum FROM BPT_DEAD_COLLECT t \n"); 
		sql.append("    where to_date(t.death_date, 'yyyy-mm-dd')<add_months（sysdate，-12) and instr(t.domicile_code,?)=1      ) ds");
		if("370000000000".equals(organCode)){
			for(int i=0;i<5;i++){
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 2));
			}
		}else if(organCode != null && !organCode.equals("")&&"00000000".equals(organCode.substring(4, 12))){
			for(int i=0;i<5;i++){
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 4));
			}
		}else {
			for(int i=0;i<5;i++){
				typeList.add(Types.VARCHAR);
				argsList.add(organCode.substring(0, 6));
			}
		}
		if(typeList.size() != 0 && argsList.size()!= 0) {
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++) {
				types[i]=(Integer)(typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(),types,args, true);
		} 
		return ds;
	}
	public DataSet queryDeadBptObjectByOrgan(ParameterSet pset){
		DataSet ds = new DataSet();
    	List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
 		String organCode = (String) pset.getParameter("dim");
		StringBuffer sql = new StringBuffer();
		if("370000000000".equals(organCode)){
			sql.append("select  ORGAN_CODE, c.name as ORGAN_NAME,DISABILITY , DEPENDANT,DEMOBILIED,DEMOBILIZEDILLNESS, WAR,TESTED,SOLDIER, MARTYR from V_BPT_DEAD_OBJECT t ,dic_city c where c.id=t.ORGAN_CODE and substr(t.ORGAN_CODE,5,8)='00000000' order by  t.ORGAN_CODE\n");
			ds = this.executeDataset(sql.toString(), true);
		}else if(organCode != null && !organCode.equals("")&&"00000000".equals(organCode.substring(4, 12))){
			sql.append("select  ORGAN_CODE, c.name as ORGAN_NAME,DISABILITY , DEPENDANT,DEMOBILIED,DEMOBILIZEDILLNESS, WAR,TESTED,SOLDIER, MARTYR from V_BPT_DEAD_OBJECT t ,dic_city c where c.id=t.ORGAN_CODE and instr(t.ORGAN_CODE,?)=1 order by  t.ORGAN_CODE");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode.substring(0, 4));
			if(typeList.size() != 0 && argsList.size()!= 0) {
				int[] types = new int[typeList.size()];
				for(int i=0;i<typeList.size();i++) {
					types[i]=(Integer)(typeList.get(i));
				}
				Object[] args = argsList.toArray(new Object[argsList.size()]);
				ds = this.executeDataset(sql.toString(),types,args, true);
			} 
		}else {
			sql.append("select  ORGAN_CODE, c.name as ORGAN_NAME,DISABILITY , DEPENDANT,DEMOBILIED,DEMOBILIZEDILLNESS, WAR,TESTED,SOLDIER, MARTYR from V_BPT_DEAD_OBJECT t ,dic_city c where c.id=t.ORGAN_CODE and instr(t.ORGAN_CODE,?)=1 order by  t.ORGAN_CODE");
			if (organCode != null && !organCode.equals("")) {
				typeList.add(Types.VARCHAR);
				argsList.add(organCode);
			}
			if(typeList.size() != 0 && argsList.size()!= 0) {
				int[] types = new int[typeList.size()];
				for(int i=0;i<typeList.size();i++) {
					types[i]=(Integer)(typeList.get(i));
				}
				Object[] args = argsList.toArray(new Object[argsList.size()]);
				ds = this.executeDataset(sql.toString(),types,args, true);
			} 
		}
		//sql.append("select ORGAN_CODE, c.name as ORGAN_NAME,DISABILITY , DEPENDANT,DEMOBILIED,DEMOBILIZEDILLNESS, WAR,TESTED,SOLDIER, MARTYR from V_BPT_DEAD_OBJECT t ,dic_city c where c.id=t.ORGAN_CODE and substr(t.ORGAN_CODE,5,8)='00000000' \n");
		//ds = this.executeDataset(sql.toString(), true);
		return ds;
	}
}